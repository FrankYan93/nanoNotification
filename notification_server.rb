require 'bunny'
require 'thread'
require 'json'
require 'sinatra/activerecord'
require_relative './models/notification.rb'
conn = Bunny.new(ENV["RABBITMQ_BIGWIG_URL"],automatically_recover: false)
conn.start

ch = conn.create_channel

class NotificationServer

  def initialize ch
    @ch=ch
  end

  def start(queue_name)
    @q = @ch.queue(queue_name)
    @x = @ch.default_exchange

    @q.subscribe(:block => true) do |delivery_info, properties, payload|
      n = JSON.parse payload
      r = self.class.createNotification(n)

      @x.publish(r.to_json, :routing_key => properties.reply_to, :correlation_id => properties.correlation_id)
    end
  end

  def self.createNotification n
    print n
    puts
    unless Notification.where(user_id: n["user_id"],owner_id: n["owner_id"],tweet_id: n["tweet_id"]).size.zero?
      return
    else
      newNoti=Notification.new
      if n["tweet_id"].nil?
        newNoti.notitype='follow'
        newNoti.content="#{n["username"]} followed you"
      else
        newNoti.notitype='like'
        newNoti.tweet_id=n["tweet_id"]
        newNoti.content="#{n["username"]} liked your tweet"
      end
      newNoti.user_id=n["user_id"]
      newNoti.owner_id=n["owner_id"]
      newNoti.readmark=false
      newNoti.create_time=Time.now

      newNoti.save
    end
  end
end
begin
  server=NotificationServer.new(ch)
  " [x] Awaiting RPC requests"
  server.start("rpc_queue")
rescue Interrupt => _
  ch.close
  conn.close
end
