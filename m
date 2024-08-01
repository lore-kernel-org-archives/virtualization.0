Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6D01EB487
	for <virtualization@lists.linux.dev>; Thu,  1 Aug 2024 06:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722492373; cv=none; b=Eued1A7iuloTnFY/I6A9FNnaXYIv46gQA45YuNV0rbsqAqwY1eamFLdIecBXOlmsmYMHoQkjH0K7SD5wdb3wT/Z/ERKR5BAWM+HZwWXdHWiPLO1hq/TvgIztDUoKf9r3CD++TGVHyr5B+5z+Nzm/vmhs6XcmhkR6wroPHHPLFes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722492373; c=relaxed/simple;
	bh=MoJr4mGPo2emWOdduc6Ewmz4RQQEWee+Ztqd4CfE9Nc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=QQz9q8MHuUbUT4865l5RudTRgCTxbt68g10EvwUEyhABuUi0aeIAQUuirphHtXsra4d9fdiUHZWw/x65uLkArbm2fjOW/JKM/DQIUN/dCj2fx4tDd4E3aFZJKkGRRmEQ+TncGSZ936P3SRcKchNZ+FWov/TpcGjaodqGxr5f0tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NTJY9YdF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NTJY9YdF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722492370;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oXvVrXEs7imKq8lxNZGkuvPb2Qi8cRn244ngd84DYZs=;
	b=NTJY9YdFaOiyQZGBlw1E0jIkJq0R0PjYgLcR3cMG0AG9VWnzLmYkEFPXOGR0i/pDjRDwM7
	/u7gBIFu82q61a6OF6VidOtxpYjaUBXklc3cJvKZWot7pWZdSvjknofplZdcjMO7QvrLFx
	hr7vDOkFymUC5xIEQdobAzEnJuxyv+0=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-282-ct7ACkozOvGMXFs5wckMBA-1; Thu, 01 Aug 2024 02:06:09 -0400
X-MC-Unique: ct7ACkozOvGMXFs5wckMBA-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2ef3157ae4cso68672741fa.2
        for <virtualization@lists.linux.dev>; Wed, 31 Jul 2024 23:06:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722492367; x=1723097167;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oXvVrXEs7imKq8lxNZGkuvPb2Qi8cRn244ngd84DYZs=;
        b=hz+s3og65BlpEGr0+qlLu2hf6EiYK/XiNMsyKAx9iAfyW6g5hZIMFolu4S/L7SmXZW
         /b0tsXOnRBK64lgudTtVNK3OyN2R4BJM3Idd9tsB6ARMPJlkZHH36UBXqwY8f6+NY9VE
         eUMVLl7eXfrO6n+FNKiy5VH4eHUC0fODOsqc9kH5Ga4mN+k0olOCjbCKoTa2bAsLPlvD
         0FeZXBWMAj7PK3XudjA4+reeDhTaXNWUqjhf5ucCcfF3COMkols/5Np0Gooie/wqZyRa
         z7R6WDBwWjpN0fbfAI3zLNVvRwXBI2dfsP9iuFYn1MyLYFCOXzXYq0h8OItQ0z3ac8+I
         9LwQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/bEhSyDbSrGIf6MM6RSIOPWt0CzILl6Fe6dCRhvcAyQU5AaKMeJPZk5Qhqh68slMeHHfH5Kq0T4l6i209Ovsvvw/as1dABAFce8uotzw=
X-Gm-Message-State: AOJu0YzwKQmt7e0okbdSvx3KFXeTRZqC+W8Pmh+guQu3SyqX2rgIMVb0
	ABcBqs7Y/F2zdKpHtdfD41AVU89BbLZd3nPmPNMLIvpTlOvm2exVkIMCzrhqzfxizQ/C6JX7x2w
	g+vE0AV8bX9iTvMJLjms+9ax8O9vk7KJVA1LkgRFYpZa7fVhdciulhwaUrz5ZLluh
X-Received: by 2002:a2e:9e44:0:b0:2ef:32bb:5368 with SMTP id 38308e7fff4ca-2f1530ea1e2mr11451371fa.11.1722492367213;
        Wed, 31 Jul 2024 23:06:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHM9ZyKL75V6GO6PtO5RhoimbEdBrF+GHnf8Kpa6aPVDLn3MkQr2Rf9oSzR7icep3N5IacJHQ==
X-Received: by 2002:a2e:9e44:0:b0:2ef:32bb:5368 with SMTP id 38308e7fff4ca-2f1530ea1e2mr11450881fa.11.1722492366305;
        Wed, 31 Jul 2024 23:06:06 -0700 (PDT)
Received: from redhat.com ([2.55.14.19])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acad41027sm845472466b.122.2024.07.31.23.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 23:06:04 -0700 (PDT)
Date: Thu, 1 Aug 2024 02:05:54 -0400
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
Message-ID: <20240801015914-mutt-send-email-mst@kernel.org>
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
> +	virtio_config_driver_disable(vi->vdev);
> +	/* Make sure status updating is cancelled */
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
> +	virtio_config_driver_disable(vi->vdev);
> +	/* Make sure status updating work is done */

Wait a second, how can anything run here, this is probe,
config change callbacks are never invoked at all.

> +	cancel_work_sync(&vi->config_work);
> +


this is pointless, too.

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
> +		   disabled. */

What "this"? pls explain what this does: get config data from
device.

Actually not because it was disabled. probe can poke at
config with impunity no change callbacks trigger during probe.

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

