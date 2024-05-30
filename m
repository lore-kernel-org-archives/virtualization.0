Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5053DDA0
	for <virtualization@lists.linux.dev>; Thu, 30 May 2024 06:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717049413; cv=none; b=Jzo77uWWOwb74aZ+ScMochAhbjSlwKXfLuTVF/AEiUJZ0r/OjMeqyvMHRsR5/YqpTcy6CpJfteagaDBShKMMmAbpXo0/BcG4WPp1uEyxbwoyRZUGcKVpSx7fLbvpvecZgW6vMF/tqAFMoFhNfOutUhYLwWsU0kolrb5AYsGgMmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717049413; c=relaxed/simple;
	bh=yP9Y3KRiTvMWKu3gxpiZVwRahe3Bt6bczvW1WWNe54A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=c0B3zouZ8baNE01Ut9EfCStXeULuNBq65p829i/e32lEdmQ+x+fLweUst+3QySfCjjk5VzhgvIbLZ1Wf6GtbAPjH5db98MgmWFJ0rUee3Q3d2XWyetToGoR+r+2pQ0sNZSnupjSrzH2y9xlNKtMtAghYZkC8WG3xBgaKXmS3fqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HoebgYGB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HoebgYGB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717049410;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ShPq/rZDg0QngIclP+9hv0sjxOwB+M97w7spUmjwwy0=;
	b=HoebgYGBxlWflDRNdcSx0VauuHltvACyH0KAP6+eeP32eVEYA3JRL7yEOI27jBaDmiU6PA
	Qpxg2KN2Tb/ye1O5V1puFDPM2cdc+JGY3WzGkWRb+wKhjbn9QUnyz6kfNDX5+PxrJkWWM+
	cB7+8ldzLrUJ96ewkcRj7yQwk/FpQAE=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-GtblTD9iPJe2fYAGIpd96A-1; Thu, 30 May 2024 02:10:08 -0400
X-MC-Unique: GtblTD9iPJe2fYAGIpd96A-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-579d67917b9so425608a12.1
        for <virtualization@lists.linux.dev>; Wed, 29 May 2024 23:10:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717049407; x=1717654207;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ShPq/rZDg0QngIclP+9hv0sjxOwB+M97w7spUmjwwy0=;
        b=fICcHyUBgbvd13eTM2AJz2FDydzvcjENVOCajoFfips1gr/DmzXMU6Jg1BMAr4fAp4
         MXMDuu2uizx5ILjJMRJt15jspB/Afv1dHH7ZCnIedhbJCOhs3pR5SeNUnmfIJxJb+SmL
         pG7RRq8kHjn8xj6LnCo1vPWSaAQ5Fh3MqGgZ98lRvQVoY3SyxCaM63zuUbfsfO5bKia3
         12uPki+JmtvIl5ed9kbkVFDOi47DHQBfqM0y9OeYrfkBhQ18N4QIFhKW/Rb0cpdXZ2iO
         +d1HgCiLeBW7tacBQNf7xgxa0esVcOjY0peIuyoumOSF/Bqt7yjCpV0gGWPmBs3qchmr
         RCxg==
X-Forwarded-Encrypted: i=1; AJvYcCV/ZNufRrh0vcz1YRhamarS0ZqNNB8vK55MWHVX39t7snjjmzD7dMEVC4bROkN1+UZd+qVCM+xtY9Cl6aZWgWhOpwlhdWP6NLjDL8EE2pw=
X-Gm-Message-State: AOJu0YyT1AvTtO9Sr1yhBnziMNF+rFg+o1hTjRwgqn8NVKoOFXeyZwat
	d1Ze08+5ZdTkNCp3qBwrRRLUIQnTbiwtmlWUX113YZxOhfKuK8nqicFvYqq1axhXcQ37iK+SOKi
	7EirzTwz/5/+iLNtB4QGZ1hO62rBW4IRqgZZiocDhU4rullYKN7MAM8LZr9Fepdht
X-Received: by 2002:a50:99d5:0:b0:578:62f7:2881 with SMTP id 4fb4d7f45d1cf-57a193fd230mr677863a12.0.1717049407356;
        Wed, 29 May 2024 23:10:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEh3yx8ajC6dqkpsRhAU4hikCNWT/SG2J1Gi5RJ/WmLD97+UWJPaCgBhGTelxANjPRoZwTQHg==
X-Received: by 2002:a50:99d5:0:b0:578:62f7:2881 with SMTP id 4fb4d7f45d1cf-57a193fd230mr677832a12.0.1717049406703;
        Wed, 29 May 2024 23:10:06 -0700 (PDT)
Received: from redhat.com ([2.55.191.38])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-579c2026406sm6538802a12.37.2024.05.29.23.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 23:10:06 -0700 (PDT)
Date: Thu, 30 May 2024 02:10:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Venkat Venkatsubra <venkat.x.venkatsubra@oracle.com>,
	Gia-Khanh Nguyen <gia-khanh.nguyen@oracle.com>
Subject: Re: [PATCH net-next V2] virtio-net: synchronize operstate with admin
 state on up/down
Message-ID: <20240530020531-mutt-send-email-mst@kernel.org>
References: <20240530032055.8036-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240530032055.8036-1-jasowang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 30, 2024 at 11:20:55AM +0800, Jason Wang wrote:
> This patch synchronize operstate with admin state per RFC2863.
> 
> This is done by trying to toggle the carrier upon open/close and
> synchronize with the config change work. This allows propagate status
> correctly to stacked devices like:
> 
> ip link add link enp0s3 macvlan0 type macvlan
> ip link set link enp0s3 down
> ip link show
> 
> Before this patch:
> 
> 3: enp0s3: <BROADCAST,MULTICAST> mtu 1500 qdisc pfifo_fast state DOWN mode DEFAULT group default qlen 1000
>     link/ether 00:00:05:00:00:09 brd ff:ff:ff:ff:ff:ff
> ......
> 5: macvlan0@enp0s3: <BROADCAST,MULTICAST,UP,LOWER_UP,M-DOWN> mtu 1500 qdisc noqueue state UP mode DEFAULT group default qlen 1000
>     link/ether b2:a9:c5:04:da:53 brd ff:ff:ff:ff:ff:ff
> 
> After this patch:
> 
> 3: enp0s3: <BROADCAST,MULTICAST> mtu 1500 qdisc pfifo_fast state DOWN mode DEFAULT group default qlen 1000
>     link/ether 00:00:05:00:00:09 brd ff:ff:ff:ff:ff:ff
> ...
> 5: macvlan0@enp0s3: <NO-CARRIER,BROADCAST,MULTICAST,UP,M-DOWN> mtu 1500 qdisc noqueue state LOWERLAYERDOWN mode DEFAULT group default qlen 1000
>     link/ether b2:a9:c5:04:da:53 brd ff:ff:ff:ff:ff:ff
> 
> Cc: Venkat Venkatsubra <venkat.x.venkatsubra@oracle.com>
> Cc: Gia-Khanh Nguyen <gia-khanh.nguyen@oracle.com>
> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
> Changes since V1:
> - rebase
> - add ack/review tags





> ---
>  drivers/net/virtio_net.c | 94 +++++++++++++++++++++++++++-------------
>  1 file changed, 63 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 4a802c0ea2cb..69e4ae353c51 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -433,6 +433,12 @@ struct virtnet_info {
>  	/* The lock to synchronize the access to refill_enabled */
>  	spinlock_t refill_lock;
>  
> +	/* Is config change enabled? */
> +	bool config_change_enabled;
> +
> +	/* The lock to synchronize the access to config_change_enabled */
> +	spinlock_t config_change_lock;
> +
>  	/* Work struct for config space updates */
>  	struct work_struct config_work;
>  


But we already have dev->config_lock and dev->config_enabled.

And it actually works better - instead of discarding config
change events it defers them until enabled.



> @@ -623,6 +629,20 @@ static void disable_delayed_refill(struct virtnet_info *vi)
>  	spin_unlock_bh(&vi->refill_lock);
>  }
>  
> +static void enable_config_change(struct virtnet_info *vi)
> +{
> +	spin_lock_irq(&vi->config_change_lock);
> +	vi->config_change_enabled = true;
> +	spin_unlock_irq(&vi->config_change_lock);
> +}
> +
> +static void disable_config_change(struct virtnet_info *vi)
> +{
> +	spin_lock_irq(&vi->config_change_lock);
> +	vi->config_change_enabled = false;
> +	spin_unlock_irq(&vi->config_change_lock);
> +}
> +
>  static void enable_rx_mode_work(struct virtnet_info *vi)
>  {
>  	rtnl_lock();
> @@ -2421,6 +2441,25 @@ static int virtnet_enable_queue_pair(struct virtnet_info *vi, int qp_index)
>  	return err;
>  }
>  
> +static void virtnet_update_settings(struct virtnet_info *vi)
> +{
> +	u32 speed;
> +	u8 duplex;
> +
> +	if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_SPEED_DUPLEX))
> +		return;
> +
> +	virtio_cread_le(vi->vdev, struct virtio_net_config, speed, &speed);
> +
> +	if (ethtool_validate_speed(speed))
> +		vi->speed = speed;
> +
> +	virtio_cread_le(vi->vdev, struct virtio_net_config, duplex, &duplex);
> +
> +	if (ethtool_validate_duplex(duplex))
> +		vi->duplex = duplex;
> +}
> +
>  static int virtnet_open(struct net_device *dev)
>  {
>  	struct virtnet_info *vi = netdev_priv(dev);
> @@ -2439,6 +2478,18 @@ static int virtnet_open(struct net_device *dev)
>  			goto err_enable_qp;
>  	}
>  
> +	/* Assume link up if device can't report link status,
> +	   otherwise get link status from config. */
> +	netif_carrier_off(dev);
> +	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_STATUS)) {
> +		enable_config_change(vi);
> +		schedule_work(&vi->config_work);
> +	} else {
> +		vi->status = VIRTIO_NET_S_LINK_UP;
> +		virtnet_update_settings(vi);
> +		netif_carrier_on(dev);
> +	}
> +
>  	return 0;
>  
>  err_enable_qp:
> @@ -2875,12 +2926,19 @@ static int virtnet_close(struct net_device *dev)
>  	disable_delayed_refill(vi);
>  	/* Make sure refill_work doesn't re-enable napi! */
>  	cancel_delayed_work_sync(&vi->refill);
> +	/* Make sure config notification doesn't schedule config work */
> +	disable_config_change(vi);
> +	/* Make sure status updating is cancelled */
> +	cancel_work_sync(&vi->config_work);
>  
>  	for (i = 0; i < vi->max_queue_pairs; i++) {
>  		virtnet_disable_queue_pair(vi, i);
>  		cancel_work_sync(&vi->rq[i].dim.work);
>  	}
>  
> +	vi->status &= ~VIRTIO_NET_S_LINK_UP;
> +	netif_carrier_off(dev);
> +
>  	return 0;
>  }
>  
> @@ -4583,25 +4641,6 @@ static void virtnet_init_settings(struct net_device *dev)
>  	vi->duplex = DUPLEX_UNKNOWN;
>  }
>  
> -static void virtnet_update_settings(struct virtnet_info *vi)
> -{
> -	u32 speed;
> -	u8 duplex;
> -
> -	if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_SPEED_DUPLEX))
> -		return;
> -
> -	virtio_cread_le(vi->vdev, struct virtio_net_config, speed, &speed);
> -
> -	if (ethtool_validate_speed(speed))
> -		vi->speed = speed;
> -
> -	virtio_cread_le(vi->vdev, struct virtio_net_config, duplex, &duplex);
> -
> -	if (ethtool_validate_duplex(duplex))
> -		vi->duplex = duplex;
> -}
> -
>  static u32 virtnet_get_rxfh_key_size(struct net_device *dev)
>  {
>  	return ((struct virtnet_info *)netdev_priv(dev))->rss_key_size;
> @@ -5163,7 +5202,10 @@ static void virtnet_config_changed(struct virtio_device *vdev)
>  {
>  	struct virtnet_info *vi = vdev->priv;
>  
> -	schedule_work(&vi->config_work);
> +	spin_lock_irq(&vi->config_change_lock);
> +	if (vi->config_change_enabled)
> +		schedule_work(&vi->config_work);
> +	spin_unlock_irq(&vi->config_change_lock);
>  }
>  
>  static void virtnet_free_queues(struct virtnet_info *vi)
> @@ -5706,6 +5748,7 @@ static int virtnet_probe(struct virtio_device *vdev)
>  	INIT_WORK(&vi->config_work, virtnet_config_changed_work);
>  	INIT_WORK(&vi->rx_mode_work, virtnet_rx_mode_work);
>  	spin_lock_init(&vi->refill_lock);
> +	spin_lock_init(&vi->config_change_lock);
>  
>  	if (virtio_has_feature(vdev, VIRTIO_NET_F_MRG_RXBUF)) {
>  		vi->mergeable_rx_bufs = true;
> @@ -5901,17 +5944,6 @@ static int virtnet_probe(struct virtio_device *vdev)
>  		goto free_unregister_netdev;
>  	}
>  
> -	/* Assume link up if device can't report link status,
> -	   otherwise get link status from config. */
> -	netif_carrier_off(dev);
> -	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_STATUS)) {
> -		schedule_work(&vi->config_work);
> -	} else {
> -		vi->status = VIRTIO_NET_S_LINK_UP;
> -		virtnet_update_settings(vi);
> -		netif_carrier_on(dev);
> -	}
> -
>  	for (i = 0; i < ARRAY_SIZE(guest_offloads); i++)
>  		if (virtio_has_feature(vi->vdev, guest_offloads[i]))
>  			set_bit(guest_offloads[i], &vi->guest_offloads);
> -- 
> 2.42.0

