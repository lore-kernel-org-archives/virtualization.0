Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7FA136E38
	for <virtualization@lists.linux.dev>; Mon, 24 Jun 2024 10:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719223657; cv=none; b=cYDC1c5HE3M6rLZ0NXAmLqE6dcxj8Wbs7GuT39+JXnRgJldPdOZe7aYCP2J6n8OjIc61Cy2duQxbg39dDj/S4wfTlqd/wfxaJo4abIqxekK428b0z4ZxgV+mUX8EHg5sIuqKWRQSWFDCnf0C83WaXUTyK0YJFWR3QyEkzJ9WS0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719223657; c=relaxed/simple;
	bh=qZBRGilMKY9LGITmZuONivNiMHs1W/RJjv10JJMT2dk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=JnCh+X1DhqFx1GoeXa5x7yxbOox5cSZplC6twRj7CLecvLju9n2ymCmJ87MqNc8NR1nGW5gvYMDBHgZHckqiXZrkR58SwNgQ+RSBdht05nlgcT9tSqVcyXTzlNZYHFs31ZyeH4T874swMxu+laAgMc3MTuUnIm6HXeLVHDxLFE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R0HT8kE4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R0HT8kE4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719223655;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fklOGOO9cJHP9Qob/bXEoQb0rMVPt/uaqDR+wdkxpUY=;
	b=R0HT8kE4jA7pMucCrCrOJBoMc+QkgUXzE7TDl2iz23HYw66bU0Y6kLc3AuCtniQeHmQPYb
	jANFABtpoB03kOWud5FUFqkVogHrMk481cGiFb57/hORpgRnToBFw8m4I+TGBBRpwbvHv4
	4RZP/PtKt/WPyEZSRbFKx00PIie3Yks=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-135-6pR-wobLP2qq0g5oZCJQ9A-1; Mon, 24 Jun 2024 06:07:33 -0400
X-MC-Unique: 6pR-wobLP2qq0g5oZCJQ9A-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4248fa5daacso5920715e9.0
        for <virtualization@lists.linux.dev>; Mon, 24 Jun 2024 03:07:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719223652; x=1719828452;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fklOGOO9cJHP9Qob/bXEoQb0rMVPt/uaqDR+wdkxpUY=;
        b=lTynIm0zBHUp1kSQg4hC7dcK+Rg2DccXfpYkOhpVnrkAW6GMxqSPIFA5cHFVfIA4Ci
         JqS12HUH2saJnfJdTvW5XC40uTzdeLKyGlDEgHou34iyYBL6zSK1h6+XF1e9wxWTut0q
         Pb70z+kx2Rl3pcDBhf5R0hSrIM/Ybc1AeJQ7qc+S5FQpoSFe7z7pxzqRyk27HVFvR5KB
         VTxzS1WhtzlQrYQQ4Qaqz3dBOozjOu90AwgAm+TciCcwpzhYx+fJKqZPE6hlHmoEIXK4
         9LMhGxTLc+Laloa7YK00pxTetjl6Oc8hThBHcu41JPrv3f+UFYgSr8txX+DnA87k6TvI
         WN4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVSxv9CDs4LOO6ds1CpU5YwO81FbwQHinholUnCN2YuV0il/SRjywEY4W64Czvdd+TwFegadQbfKdyZDdLtyEBcXzJ/nTy2HpFDoIAjkH4=
X-Gm-Message-State: AOJu0YyfeeIUegTvrhZe4XXyB/205MOJlNkxtXSNbcnndQ0Swfpg4l0j
	2hX1dVNKBCyzYWloolt/Eha7WKQHz5kHxlT4TUYJzoepObBjfeQMRrArVNFgun3wXDQEch8tJ8v
	rL/YKCjRwJ8V87Gb9giKfI/qrg4HqFQ7Vmwm5ekEhe/CcZGVzmLpAyAAeytR+2IlX
X-Received: by 2002:a05:600c:5686:b0:421:7aa1:435 with SMTP id 5b1f17b1804b1-4248cc58a4bmr27488535e9.25.1719223652361;
        Mon, 24 Jun 2024 03:07:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFTv7W1i0TowXG1OQ6QdGl4ZCCaxHKlLZlZENXc69YybgThQbJhuSRiNsB1KXThYVx9ees4kw==
X-Received: by 2002:a05:600c:5686:b0:421:7aa1:435 with SMTP id 5b1f17b1804b1-4248cc58a4bmr27488195e9.25.1719223651548;
        Mon, 24 Jun 2024 03:07:31 -0700 (PDT)
Received: from redhat.com ([2.52.146.100])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3663a8c8f07sm9608746f8f.110.2024.06.24.03.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 03:07:31 -0700 (PDT)
Date: Mon, 24 Jun 2024 06:07:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, venkat.x.venkatsubra@oracle.com,
	gia-khanh.nguyen@oracle.com
Subject: Re: [PATCH V2 3/3] virtio-net: synchronize operstate with admin
 state on up/down
Message-ID: <20240624060057-mutt-send-email-mst@kernel.org>
References: <20240624024523.34272-1-jasowang@redhat.com>
 <20240624024523.34272-4-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240624024523.34272-4-jasowang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 24, 2024 at 10:45:23AM +0800, Jason Wang wrote:
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
>  drivers/net/virtio_net.c | 72 +++++++++++++++++++++++-----------------
>  1 file changed, 42 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index b1f8b720733e..eff3ad3d6bcc 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -2468,6 +2468,25 @@ static int virtnet_enable_queue_pair(struct virtnet_info *vi, int qp_index)
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
> @@ -2486,6 +2505,22 @@ static int virtnet_open(struct net_device *dev)
>  			goto err_enable_qp;
>  	}
>  
> +	/* Assume link up if device can't report link status,
> +	   otherwise get link status from config. */
> +	netif_carrier_off(dev);
> +	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_STATUS)) {
> +		virtio_config_enable(vi->vdev);
> +		/* We are not sure if config interrupt is disabled by
> +		 * core or not, so we can't schedule config_work by
> +		 * ourselves.
> +		 */

This comment confuses more than it explains.
You seem to be arguing about some alternative design
you had in mind, but readers don't have it in mind.


Please just explain what this does and why.
For what: something like "Trigger re-read of config - same
as we'd do if config changed".

Now, please do what you don't do here: explain the why:


why do we want all these VM
exits on each open/close as opposed to once on probe and later on
config changed interrupt.


> +		virtio_config_changed(vi->vdev);
> +	} else {
> +		vi->status = VIRTIO_NET_S_LINK_UP;
> +		virtnet_update_settings(vi);
> +		netif_carrier_on(dev);
> +	}
> +
>  	return 0;
>  
>  err_enable_qp:
> @@ -2928,12 +2963,19 @@ static int virtnet_close(struct net_device *dev)
>  	disable_delayed_refill(vi);
>  	/* Make sure refill_work doesn't re-enable napi! */
>  	cancel_delayed_work_sync(&vi->refill);
> +	/* Make sure config notification doesn't schedule config work */
> +	virtio_config_disable(vi->vdev);
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
> @@ -4632,25 +4674,6 @@ static void virtnet_init_settings(struct net_device *dev)
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
> @@ -5958,17 +5981,6 @@ static int virtnet_probe(struct virtio_device *vdev)
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

