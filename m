Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF731448ED
	for <virtualization@lists.linux.dev>; Mon,  5 Aug 2024 05:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722837154; cv=none; b=qxHXMQ5mGYsQPvIbgB7bSc7OD5UX4faH3j5EDi3uuWTDXSESIpjzFH4nqVgLJV81cMChG6Frc5urD3Pzd6bxEXu0xqwbuTwJvMkO5LFJUZ7xfCQGzdA10YoxT07fLOYBWqapvtXs9YvwgsQPHU1shy368hQcK0k1ruaF+FyvFbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722837154; c=relaxed/simple;
	bh=D4mZImU22arsEREEh+abHrXNb7bqP3pmKWJaqmOKv8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=GFfln++8TpL6kePYsReUYKLbwKUBlqr61w78KRbm9vsRCzOq15M6mZjLoPgD/wcAXE5D+OVNzBHD753amuLA0XsSN1cgYqHDQHoZUXNPlacOzbdyXUzS5lW5TdgqbOi4de3XdbiraRpovk+I3TwgHB2B0t4z9RKCxxhujIqHrUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pl6/TGPV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pl6/TGPV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722837151;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yY3ZlmNQoxZJfnobrEKSrd91AZgKABUVpX64d54Ifn0=;
	b=Pl6/TGPV4KmCkD2MAMyNKrsXvoMjILXnbTs1QFxyNlCF8+Vu5zwY0TwgNtAW6xmaIKPsUG
	pNv40E2OWeup76CL92OW1HGdpuuV8EGOZdY66Qj6PteuFypUul4uSJplhigKVIYtONzvYH
	C46bfH6/Fx49gIawL7ijVtv3fhu6NtI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-dcp2fc8XNMeV2iGkY8VtdQ-1; Mon, 05 Aug 2024 01:52:29 -0400
X-MC-Unique: dcp2fc8XNMeV2iGkY8VtdQ-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-368665a3fdfso5226701f8f.1
        for <virtualization@lists.linux.dev>; Sun, 04 Aug 2024 22:52:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722837149; x=1723441949;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yY3ZlmNQoxZJfnobrEKSrd91AZgKABUVpX64d54Ifn0=;
        b=PZV0RlvBFxeTnK9LK2R4QTfJfIjpqr+4X81cZMHZ+oA/NVKDpzGvrhESOIhXZYHHRM
         ko0IviCf9TizWNMmnNPG92WjrC14btUW+KKlyBt5WwciNqq0kU2qNSVurRuYYmJ9HQsu
         bNRG9fWuccj9POjiLalssIRSG4aV7fFLyWAdtv2rXmb4kkF3b+TWN57PcvM+GbfZa4M9
         mMgT9WycUKQ6BtpRmnRDfqMrAtb+jOV+yPiijPNQt9G0Wd8K3dkvdpkNBmkYx/YUUmfp
         vA6HjuDYJ+8y57YExnoEsAQJy9osuHQvEkzzJEmJ2Gfn4f5Fek7r3MXFvBpP7zc4cRnl
         AbzQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5HnXb076jvoGR+6zfYx/0hLz4tKNgRhG1/n4Bsxg2EGAFTT2qOhbp0GHSYy49XQaWW8dAQ6gjnLAHQwAtHSu8L1xRqM3kqBN1qZWkd1s=
X-Gm-Message-State: AOJu0Yy8SFZCmWLpNXaH2U24ZmxBoVyZm/XPL9mAt+b14tLT22yC2VoI
	oJ9JaWH7d0SSiPBiO8uKIJ2U6ZpJIGbcC9yZhAhlTYbaFVLsR2AdjdbVVJsWd+bed5aAgmoEHcC
	AHdd0xrPr4VN6VxIUQoLf6V7moJfaoAb1oRe0JcwkojuiPYr/5o2eeLRBFktc6EC9
X-Received: by 2002:adf:f18a:0:b0:362:4ce:2171 with SMTP id ffacd0b85a97d-36bbc1657f1mr6624198f8f.52.1722837148680;
        Sun, 04 Aug 2024 22:52:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFEkym7lde2/Fw8MPIUxZ0ooZX0XQmN1ihWR9EClWvK4Q2zQn1BAchxK9PqJ2C/S7CY9LK4Pw==
X-Received: by 2002:adf:f18a:0:b0:362:4ce:2171 with SMTP id ffacd0b85a97d-36bbc1657f1mr6624175f8f.52.1722837147834;
        Sun, 04 Aug 2024 22:52:27 -0700 (PDT)
Received: from redhat.com ([2a02:14f:17d:dd95:f049:da1a:7ecb:6d9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428e6e03d74sm121895045e9.14.2024.08.04.22.52.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Aug 2024 22:52:27 -0700 (PDT)
Date: Mon, 5 Aug 2024 01:52:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Venkat Venkatsubra <venkat.x.venkatsubra@oracle.com>,
	Gia-Khanh Nguyen <gia-khanh.nguyen@oracle.com>
Subject: Re: [PATCH V5 net-next 3/3] virtio-net: synchronize operstate with
 admin state on up/down
Message-ID: <20240805014422-mutt-send-email-mst@kernel.org>
References: <20240805030242.62390-1-jasowang@redhat.com>
 <20240805030242.62390-4-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240805030242.62390-4-jasowang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 05, 2024 at 11:02:42AM +0800, Jason Wang wrote:
> This patch synchronize operstate with admin state per RFC2863.


synchronizes

> 
> This is done by trying to toggle the carrier upon open/close and
> synchronize with the config change work. This allows propagate status

to propagate

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

Add an empty line here pls.

> Cc: Venkat Venkatsubra <venkat.x.venkatsubra@oracle.com>
> Cc: Gia-Khanh Nguyen <gia-khanh.nguyen@oracle.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/net/virtio_net.c | 78 +++++++++++++++++++++++++---------------
>  1 file changed, 50 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 0383a3e136d6..fc5196ca8d51 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -2885,6 +2885,25 @@ static void virtnet_cancel_dim(struct virtnet_info *vi, struct dim *dim)
>  	net_dim_work_cancel(dim);
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
> @@ -2903,6 +2922,15 @@ static int virtnet_open(struct net_device *dev)
>  			goto err_enable_qp;
>  	}
>  
> +	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_STATUS)) {
> +		if (vi->status & VIRTIO_NET_S_LINK_UP)
> +			netif_carrier_on(vi->dev);
> +		virtio_config_driver_enable(vi->vdev);
> +	} else {
> +		vi->status = VIRTIO_NET_S_LINK_UP;
> +		netif_carrier_on(dev);
> +	}
> +
>  	return 0;
>  
>  err_enable_qp:
> @@ -3381,12 +3409,22 @@ static int virtnet_close(struct net_device *dev)
>  	disable_delayed_refill(vi);
>  	/* Make sure refill_work doesn't re-enable napi! */
>  	cancel_delayed_work_sync(&vi->refill);
> +	/* Prevent the config change callback from changing carrier
> +	 * after close
> +	 */
> +	virtio_config_driver_disable(vi->vdev);
> +	/* Stop getting status/speed updates: we don't care until next
> +	 * open
> +	 */
> +	cancel_work_sync(&vi->config_work);
>  
>  	for (i = 0; i < vi->max_queue_pairs; i++) {
>  		virtnet_disable_queue_pair(vi, i);
>  		virtnet_cancel_dim(vi, &vi->rq[i].dim);
>  	}
>  
> +	netif_carrier_off(dev);
> +
>  	return 0;
>  }
>  
> @@ -5085,25 +5123,6 @@ static void virtnet_init_settings(struct net_device *dev)
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
> @@ -6514,6 +6533,9 @@ static int virtnet_probe(struct virtio_device *vdev)
>  		goto free_failover;
>  	}
>  
> +	/* Disable config change notification until ndo_open. */
> +	virtio_config_driver_disable(vi->vdev);
> +
>  	virtio_device_ready(vdev);
>  
>  	virtnet_set_queues(vi, vi->curr_queue_pairs);
> @@ -6563,25 +6585,25 @@ static int virtnet_probe(struct virtio_device *vdev)
>  		vi->device_stats_cap = le64_to_cpu(v);
>  	}
>  
> -	rtnl_unlock();
> -
> -	err = virtnet_cpu_notif_add(vi);
> -	if (err) {
> -		pr_debug("virtio_net: registering cpu notifier failed\n");
> -		goto free_unregister_netdev;
> -	}
> -
>  	/* Assume link up if device can't report link status,
>  	   otherwise get link status from config. */
>  	netif_carrier_off(dev);
>  	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_STATUS)) {
> -		schedule_work(&vi->config_work);
> +		virtnet_config_changed_work(&vi->config_work);
>  	} else {
>  		vi->status = VIRTIO_NET_S_LINK_UP;
>  		virtnet_update_settings(vi);
>  		netif_carrier_on(dev);
>  	}
>  
> +	rtnl_unlock();


OK I guess you are moving rtnl to make sure this does not
run in parallel with ndo_open/close.
I do, however, wonder whether ndo_set_features
can happen before guest_offloads_capable calculation below.
WDYT?

> +	err = virtnet_cpu_notif_add(vi);
> +	if (err) {
> +		pr_debug("virtio_net: registering cpu notifier failed\n");
> +		goto free_unregister_netdev;
> +	}
> +
>  	for (i = 0; i < ARRAY_SIZE(guest_offloads); i++)
>  		if (virtio_has_feature(vi->vdev, guest_offloads[i]))
>  			set_bit(guest_offloads[i], &vi->guest_offloads);
> -- 
> 2.31.1

