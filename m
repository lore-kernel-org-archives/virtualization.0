Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBEA2701D9
	for <virtualization@lists.linux.dev>; Fri,  6 Feb 2026 15:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770390173; cv=none; b=nDv8oU++cunuzHofYdNg0H8hxhMV3YblDmQ9HP7v1HqSSPJZbq7TqTpZUZC0CCw1I0o7AzC34+qOEanC6oTbU75T3ADSoqojkeM5bQDyr9fGuvhDc2wXLkErn8C+4lZrnarA0gybKXpG5RjGR79wvg64xFSHvsoWSpUkYUl8aOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770390173; c=relaxed/simple;
	bh=r9JDNy3iLGRFG7x4Aha2CU+4aaIo1+oBQFDu2MLALE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=fVMw9bnQUKJXHrddQB3wVsF3dMSrwjuuLBDWveVvEIX5sKQKjBsWjmwPIfTRHsHGshh2LPK0NR4PoL6juhqvIynw0+F8LgSLKQOy61CpCE8eyAvBTzjvZVsf/oH+gYfk85edxmA4EvKLv1QyDulTogZQON/vsbOMWACR/BPQTLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MvlHaqNp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MvlHaqNp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770390172;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PBtTGnoiFZd7hFZAgWuXiiQbJ1BM906Q9PTZBsz7Exk=;
	b=MvlHaqNp/NnuhcbDQ6z0ogyU3iyVJkGK0I2e3HgC5tX920xGxwrv5+ulk+aF51U8K9E1xS
	MiDSTEUPyABFOi5Ue/JQMalwS2fEACk402im9UB7BApmCX0jjBNXLu/xe8YDBFA5AlVYX2
	Mq3BnMhLtMCuLjSEFEZFioVTBptD79o=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-91uowLf8MTe43Fxpu2xV3Q-1; Fri, 06 Feb 2026 10:02:51 -0500
X-MC-Unique: 91uowLf8MTe43Fxpu2xV3Q-1
X-Mimecast-MFC-AGG-ID: 91uowLf8MTe43Fxpu2xV3Q_1770390170
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-477c49f273fso27636215e9.3
        for <virtualization@lists.linux.dev>; Fri, 06 Feb 2026 07:02:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770390170; x=1770994970;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PBtTGnoiFZd7hFZAgWuXiiQbJ1BM906Q9PTZBsz7Exk=;
        b=Gk+bp7dLQn8/mx1wnufmccAznSVoFgMljajOjqej1shWSfCCrc4l+t1Iy0/NsrT6z7
         RC/dOlfLDOQG6FcnrgKnQJYgMrD0Dv369/6zptBVp9mppspWvy32kX83eZzfpp4N/B2g
         mNbjd3acHZ0fWG4aP8fVNRlQNNF87GVkLPbDbTiH7MTlmWj4NVrBHHjbZ0WtkvvgYlLW
         xPErT5yErrHk6SD3A1JUbu1ccHL14P8ujFHdgls2kQ5og5mE8eY+yqur9FnLZuBpuFE5
         OJ65LzsPNsjofw5bJBY/KKLnewBlVFMZBts25ePovG9BL2L9QiZEddUlIsRoVmnmrv96
         RB0g==
X-Forwarded-Encrypted: i=1; AJvYcCWNfK9rxQ5omP81ExOkBmHNpnXr0UEmm3s0RWfWdIjwBKEm1Ux2t44pPO7HytPqvnOIIGiRO2Q6TjpsE4uYBg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzFDdk45m82ydpWeFuERAO3YXYJUTdJ0TqSzFbxsnwKBSelkYHx
	uex3cb9mh4XM2MZ1IpwMiiW9UKsSV6oPPRyzvaMmHdGjkuGdu/0xgOKjBtzIgDaB+E/ogHr92Pp
	kiouNL57R6+UoBq+n9q2Ijj4us+GpeZXBhPsJJo+jamzSApLVbZJChwPUc+qnPT07TRVr
X-Gm-Gg: AZuq6aImml8URRchxOUxkZlqrsmOA7piVP/Jlth8ctUo0cGnG52Y9D3NSv994WN5wsl
	XYpNn4lYaibgCpDBe8k1FHsj3vduVjEp6dTSC9fM88TIGY9Egqi+ME2MxcylPqNt5bB6O+9Sg8T
	84SEMGDKk3s6d4Hoexb7yoRCKq9GwgDzqlr1BRp66zyZA2iLUEmk7+Eb0BBWxH0Q9YO1LsPs6QI
	dA4p+K/m45aBMv2piIeti6QNFZMT2gj7bS7vShYHW3wO6IclGWmxzKCAm/8wPOb5kJVX1WmycPo
	zy+b8BKOh4qYJPHjXVSRZEr86JZya/aN1X9aHPK/0Q3ORwG5lKcfDLJnbZRhB8aCsJA1+nW/5c7
	0mjn4l5KO+R0yMfp1mINndDPAps1pweiHgA==
X-Received: by 2002:a05:600c:474c:b0:482:ef72:5778 with SMTP id 5b1f17b1804b1-483201dc4efmr48039045e9.8.1770390170107;
        Fri, 06 Feb 2026 07:02:50 -0800 (PST)
X-Received: by 2002:a05:600c:474c:b0:482:ef72:5778 with SMTP id 5b1f17b1804b1-483201dc4efmr48038395e9.8.1770390169571;
        Fri, 06 Feb 2026 07:02:49 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48317d299bfsm122985135e9.2.2026.02.06.07.02.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 07:02:48 -0800 (PST)
Date: Fri, 6 Feb 2026 10:02:45 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Srujana Challa <schalla@marvell.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev,
	pabeni@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, ndabilpuram@marvell.com, kshankar@marvell.com
Subject: Re: [PATCH v2 net-next] virtio_net: Improve RSS key size validation
 and use NETDEV_RSS_KEY_LEN
Message-ID: <20260206095859-mutt-send-email-mst@kernel.org>
References: <20260206120154.2548079-1-schalla@marvell.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260206120154.2548079-1-schalla@marvell.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: S07I0O_kM6HZjidX2V8Iphz4VN8JV6D2Vfq08CFDyfQ_1770390170
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 06, 2026 at 05:31:54PM +0530, Srujana Challa wrote:
> Replace hardcoded RSS max key size limit with NETDEV_RSS_KEY_LEN to
> align with kernel's standard RSS key length. Add validation for RSS
> key size against spec minimum (40 bytes) and driver maximum. When
> validation fails, gracefully disable RSS features and continue
> initialization rather than failing completely.
> 
> Signed-off-by: Srujana Challa <schalla@marvell.com>

I'd CC stable on this actually. failing when device is more capable
was a bad idea.
can you add a Fixes: tag, too? Thanks!

> ---
>  drivers/net/virtio_net.c | 62 +++++++++++++++++++++++-----------------
>  1 file changed, 36 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index db88dcaefb20..1fa4197dffc3 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -381,7 +381,8 @@ struct receive_queue {
>  	struct xdp_buff **xsk_buffs;
>  };
>  
> -#define VIRTIO_NET_RSS_MAX_KEY_SIZE     40
> +#define VIRTIO_NET_RSS_MAX_KEY_SIZE     NETDEV_RSS_KEY_LEN
> +#define VIRTIO_NET_RSS_MIN_KEY_SIZE     40
>  
>  /* Control VQ buffers: protected by the rtnl lock */
>  struct control_buf {
> @@ -6823,38 +6824,47 @@ static int virtnet_probe(struct virtio_device *vdev)
>  	if (virtio_has_feature(vdev, VIRTIO_NET_F_HASH_REPORT))
>  		vi->has_rss_hash_report = true;
>  
> -	if (virtio_has_feature(vdev, VIRTIO_NET_F_RSS)) {
> +	if (virtio_has_feature(vdev, VIRTIO_NET_F_RSS))
>  		vi->has_rss = true;
>  
> -		vi->rss_indir_table_size =
> -			virtio_cread16(vdev, offsetof(struct virtio_net_config,
> -				rss_max_indirection_table_length));
> -	}
> -	vi->rss_hdr = devm_kzalloc(&vdev->dev, virtnet_rss_hdr_size(vi), GFP_KERNEL);
> -	if (!vi->rss_hdr) {
> -		err = -ENOMEM;
> -		goto free;
> -	}
> -
>  	if (vi->has_rss || vi->has_rss_hash_report) {
>  		vi->rss_key_size =
>  			virtio_cread8(vdev, offsetof(struct virtio_net_config, rss_max_key_size));
> -		if (vi->rss_key_size > VIRTIO_NET_RSS_MAX_KEY_SIZE) {
> -			dev_err(&vdev->dev, "rss_max_key_size=%u exceeds the limit %u.\n",
> -				vi->rss_key_size, VIRTIO_NET_RSS_MAX_KEY_SIZE);
> -			err = -EINVAL;
> -			goto free;
> -		}
>  
> -		vi->rss_hash_types_supported =
> -		    virtio_cread32(vdev, offsetof(struct virtio_net_config, supported_hash_types));
> -		vi->rss_hash_types_supported &=
> -				~(VIRTIO_NET_RSS_HASH_TYPE_IP_EX |
> -				  VIRTIO_NET_RSS_HASH_TYPE_TCP_EX |
> -				  VIRTIO_NET_RSS_HASH_TYPE_UDP_EX);
> +		/* Spec requires at least 40 bytes */
> +		if (vi->rss_key_size < VIRTIO_NET_RSS_MIN_KEY_SIZE) {
> +			dev_warn(&vdev->dev,
> +				 "rss_max_key_size=%u is less than spec minimum %u, disabling RSS\n",
> +				 vi->rss_key_size, VIRTIO_NET_RSS_MIN_KEY_SIZE);
> +			vi->has_rss = false;
> +			vi->has_rss_hash_report = false;
> +		} else if (vi->rss_key_size > VIRTIO_NET_RSS_MAX_KEY_SIZE) {
> +			dev_warn(&vdev->dev,
> +				 "rss_max_key_size=%u exceeds driver limit %u, disabling RSS\n",
> +				 vi->rss_key_size, VIRTIO_NET_RSS_MAX_KEY_SIZE);
> +			vi->has_rss = false;
> +			vi->has_rss_hash_report = false;
> +		} else {
> +			vi->rss_indir_table_size =
> +				virtio_cread16(vdev, offsetof(struct virtio_net_config,
> +							      rss_max_indirection_table_length));
> +			vi->rss_hash_types_supported =
> +			    virtio_cread32(vdev, offsetof(struct virtio_net_config,
> +							  supported_hash_types));
> +			vi->rss_hash_types_supported &=
> +					~(VIRTIO_NET_RSS_HASH_TYPE_IP_EX |
> +					  VIRTIO_NET_RSS_HASH_TYPE_TCP_EX |
> +					  VIRTIO_NET_RSS_HASH_TYPE_UDP_EX);
> +
> +			dev->hw_features |= NETIF_F_RXHASH;
> +			dev->xdp_metadata_ops = &virtnet_xdp_metadata_ops;
> +		}
> +	}
>  
> -		dev->hw_features |= NETIF_F_RXHASH;
> -		dev->xdp_metadata_ops = &virtnet_xdp_metadata_ops;
> +	vi->rss_hdr = devm_kzalloc(&vdev->dev, virtnet_rss_hdr_size(vi), GFP_KERNEL);
> +	if (!vi->rss_hdr) {
> +		err = -ENOMEM;
> +		goto free;
>  	}

I feel these checks belong in virtnet_validate. Then we can disable
features e.g. by clearing VIRTIO_NET_F_RSS and host will have some
visibility that RSS can't be used.



>  
>  	if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO) ||
> -- 
> 2.25.1

