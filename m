Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8453C16C86D
	for <virtualization@lists.linux.dev>; Wed, 31 Jul 2024 21:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722461166; cv=none; b=jz6H4lY7oIPhxEQconmVT086v3N4uIMTsOi4Utf60OpqSXWLjCRXBzdLDZk5rN9hfA20cvw2/69drqapB/s1R3zovc832SsU29F58GeSN9NTUxfnGvzcKOP1Vd4dwQUl1gBm8vSvOJRJw0Njeb/JGVt/A6+H3aVyOULQLnAXbsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722461166; c=relaxed/simple;
	bh=wJqZinwQDfOcdmnW4ZL4CO1V5KkxCLaHjUfw+VxoVJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=GuRne9X+tBDFtUSazoq68tFLjeXp08XXJu4kQckqPZmDb2Bksnhj0bBN/qEyw5GIDaXsYTpjptxgqUUWaTA7WteNUSeA21/H8np8AfYTCDog4UTjkiqZo1UeCRxN2g8jycRdr2qFkECkZOPSGNvcinqJ55G369h8oXV4HWnl1j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IK4H1uez; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IK4H1uez"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722461163;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7TRUxYTLzYZ5rhCTZsxQPqbtc51PlpFIcUNUImpU7Vc=;
	b=IK4H1uezeJciTRTYE3jDt2c/B2wnOF0NpeaD2okCOHdwFWdNJRaFO9fSMt2RA2oNIE+0uO
	bxF68zcmUT6zdETlz2FFDT3d87DXmN+DQmqPoP+Y1SNhN1r0gxstvWa4ICAqsJiK4WJvgo
	NEeVdP0ExJ633f0NR7lnf1loNrTUpu0=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-_xNGlpJTMcGCgR_EW9wJsg-1; Wed, 31 Jul 2024 17:26:01 -0400
X-MC-Unique: _xNGlpJTMcGCgR_EW9wJsg-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2f0276170f9so57106371fa.2
        for <virtualization@lists.linux.dev>; Wed, 31 Jul 2024 14:26:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722461160; x=1723065960;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7TRUxYTLzYZ5rhCTZsxQPqbtc51PlpFIcUNUImpU7Vc=;
        b=VU73uMCci0VZ6kTSSS40KHfZwu5YFuOphq80KZFFGPf7bVA2AR5JTwPX2zDTR3H8zg
         OYQhPECWqQ6AR/eEcSq6F+sOHUvo1+Q7RmpDEH49OhFtntmkdebfreCj834lW/sjQsFP
         M61hrICWC6JpwI+cnq+uqaKorbIVhgkh4NLNiYR2P3974lBUmv5sHBs+xN6EV6dIneA9
         T6oE2plSQodv3zr43kp75BOVTsOBZOcbDNR9x6uooo7Rp/JFvLH/Mk0aYcAKpcizDRYU
         xM2KxjtkVG8Jw2ZkSz98FOeOY+hA6xDw9cPYFpg+nUNwYAq8S4UNYrHdzEmHDIVPJf6v
         yFzA==
X-Forwarded-Encrypted: i=1; AJvYcCUMOdW0b6Wav7COERTEn691/yygAl6n3zqEp/7DCJIhuETZLwWU8ZOUgeMgp4g8wEawNAf0cKyImnSDBLvPX3n5T9jz6N/Ne6yo/F2elTs=
X-Gm-Message-State: AOJu0YzsP4FJnBqiTRsaVEfK0V5QBbxPznvVWWTnljGz8zREc1CwJxqM
	8cF576wjbob2fRnuQ7I3fjBIwMKw8HEpw/Z6QfKFu+XW8/9i8l6QAZXk9JEaHCY0xv5m+hnh2aq
	lKmZDcEG+AlIFDQ08h8AHbplLTTqssz1Fmgv9PhKUJAbXKUeT3LxUiW7k746VHyg8
X-Received: by 2002:a2e:380b:0:b0:2ef:2443:ac8c with SMTP id 38308e7fff4ca-2f1533ab1ddmr3483101fa.31.1722461159395;
        Wed, 31 Jul 2024 14:25:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHIXn3AhsXUgtbnPlhnFXcqTpzKMkzJeCcf1n2YR70oWJ6bCl6GOib1rUPlhXEQ2MUOewM2VQ==
X-Received: by 2002:a2e:380b:0:b0:2ef:2443:ac8c with SMTP id 38308e7fff4ca-2f1533ab1ddmr3482861fa.31.1722461158392;
        Wed, 31 Jul 2024 14:25:58 -0700 (PDT)
Received: from redhat.com ([2.55.44.248])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ac6377d005sm9105489a12.38.2024.07.31.14.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 14:25:57 -0700 (PDT)
Date: Wed, 31 Jul 2024 17:25:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Venkat Venkatsubra <venkat.x.venkatsubra@oracle.com>,
	Gia-Khanh Nguyen <gia-khanh.nguyen@oracle.com>
Subject: Re: [PATCH V4 net-next 3/3] virtio-net: synchronize operstate with
 admin state on up/down
Message-ID: <20240731172020-mutt-send-email-mst@kernel.org>
References: <20240731025947.23157-1-jasowang@redhat.com>
 <20240731025947.23157-4-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240731025947.23157-4-jasowang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 31, 2024 at 10:59:47AM +0800, Jason Wang wrote:
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
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Changelog?

> ---
>  drivers/net/virtio_net.c | 84 ++++++++++++++++++++++++++--------------
>  1 file changed, 54 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 0383a3e136d6..0cb93261eba1 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -2878,6 +2878,7 @@ static int virtnet_enable_queue_pair(struct virtnet_info *vi, int qp_index)
>  	return err;
>  }
>  
> +
>  static void virtnet_cancel_dim(struct virtnet_info *vi, struct dim *dim)
>  {
>  	if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_VQ_NOTF_COAL))

hmm

> @@ -2885,6 +2886,25 @@ static void virtnet_cancel_dim(struct virtnet_info *vi, struct dim *dim)
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

I already commented on this approach.  This is now invoked on each open,
lots of extra VM exits. No bueno, people are working hard to keep setup
overhead under control. Handle this in the config change interrupt -
your new infrastructure is perfect for this.


>  static int virtnet_open(struct net_device *dev)
>  {
>  	struct virtnet_info *vi = netdev_priv(dev);
> @@ -2903,6 +2923,16 @@ static int virtnet_open(struct net_device *dev)
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
> +		virtnet_update_settings(vi);
> +	}
> +
>  	return 0;
>  
>  err_enable_qp:
> @@ -3381,12 +3411,18 @@ static int virtnet_close(struct net_device *dev)
>  	disable_delayed_refill(vi);
>  	/* Make sure refill_work doesn't re-enable napi! */
>  	cancel_delayed_work_sync(&vi->refill);
> +	/* Make sure config notification doesn't schedule config work */

it's clear what this does even without a comment.
what you should comment on, and do not, is *why*.

> +	virtio_config_driver_disable(vi->vdev);
> +	/* Make sure status updating is cancelled */

same

also what "status updating"? confuses more than this clarifies.

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
> @@ -5085,25 +5121,6 @@ static void virtnet_init_settings(struct net_device *dev)
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
> @@ -6514,6 +6531,11 @@ static int virtnet_probe(struct virtio_device *vdev)
>  		goto free_failover;
>  	}
>  
> +	/* Forbid config change notification until ndo_open. */

notifications

Disable, not forbid.

> +	virtio_config_driver_disable(vi->vdev);
> +	/* Make sure status updating work is done */



> +	cancel_work_sync(&vi->config_work);
> +
>  	virtio_device_ready(vdev);
>  
>  	virtnet_set_queues(vi, vi->curr_queue_pairs);
> @@ -6563,6 +6585,19 @@ static int virtnet_probe(struct virtio_device *vdev)
>  		vi->device_stats_cap = le64_to_cpu(v);
>  	}
>  
> +	/* Assume link up if device can't report link status,
> +           otherwise get link status from config. */
> +        netif_carrier_off(dev);
> +        if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_STATUS)) {
> +		/* This is safe as config notification change has been

config change notification

> +		   disabled. */
> +                virtnet_config_changed_work(&vi->config_work);
> +        } else {
> +                vi->status = VIRTIO_NET_S_LINK_UP;
> +                virtnet_update_settings(vi);
> +                netif_carrier_on(dev);
> +        }
> +
>  	rtnl_unlock();
>  
>  	err = virtnet_cpu_notif_add(vi);
> @@ -6571,17 +6606,6 @@ static int virtnet_probe(struct virtio_device *vdev)
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
> 2.31.1

