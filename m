Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C89838F233
	for <virtualization@lists.linux.dev>; Wed, 25 Feb 2026 10:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772013839; cv=none; b=mDbrPKjTny+XMWX7Ca7LMu3mCZbq5/2VmT5+l0wTQDqsX5ID0PS9BGkJmgHx21G/iUHxGlgGOSrX9dEE0NwdyO+giEmPxsNGRHZLgvdj1vc2FqUCH7ZcBFrjE+EaQgMwbDYBiARBXeY5ah+mV9osNnzLTbmQc/SkjRtmQQBkntk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772013839; c=relaxed/simple;
	bh=MlGwjzWpXwzqj1theVwJR7UUQV7kxnwLCrbDJttd5R4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=HvMgeNiB8wdUXJarn52ghO19aHLkYR01jWemQtjfXr2805OrZRnKYxonJfHloxpD7cFjUcxBMVSpDvnEwK2Buh61JSgzJFxtQz5MBv3n641KVql1y/GYvAl946JdOWY8kZx5Tm/uffvM3Tmh3zK4uddV+nh2+vNC0DcNlCIwWvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aqSFo7u3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aqSFo7u3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772013837;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pdDT+ULPxR7vs0Kn+FgSJEXLQt+Ky2Cw9evRXmYJ0ZA=;
	b=aqSFo7u3TPDOhVRiJEOHdInGecH73KkpYWLQhACNv6pTOshgNzf2sL/Ej0JkfGd1HzlvRM
	k/VsZdZ7o6GF650vXaC0WRVw9uQrAjjE5U7/Myn/NlbYE6u6vS6IfR490DsaUOtI2Anfos
	E2r/MRnxo1OINGwKxHPqK1rTDm2x6zU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-468-tUPsKTvhN2KWjlj2oe4MFQ-1; Wed, 25 Feb 2026 05:03:56 -0500
X-MC-Unique: tUPsKTvhN2KWjlj2oe4MFQ-1
X-Mimecast-MFC-AGG-ID: tUPsKTvhN2KWjlj2oe4MFQ_1772013835
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-483a2db68caso50520705e9.0
        for <virtualization@lists.linux.dev>; Wed, 25 Feb 2026 02:03:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772013835; x=1772618635;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pdDT+ULPxR7vs0Kn+FgSJEXLQt+Ky2Cw9evRXmYJ0ZA=;
        b=CQyVbB94ydETTwwCXKiEHeGeX5bNglFpwu0+oQVrGcqI9paB8BY8Pnf2dWR0FSGU/J
         8T7lWmjU7hsm95ACEriBNMdNh6ahNMNDQfg4YARw+2ZX5RnJYY7xkasXhfDEfllvSe8l
         /PhXqpTQacUYDVXqiMVFUlpcn74GJKiKEmAkOXseyZuAf7D4MqPE/A2I7GRm6C66oglC
         LIZcYmQbvHNxv5es1T5twCOAYEdJx4XtO+CC//2ITCguNuKsOk7O/dZeQtK3XiweYwMl
         az4W5BshcBhMnm5aibPokxK8Pn0KYIW85cQI8pWqm5djutOXW6+dYYmm73J5s2nSCvBI
         93ng==
X-Forwarded-Encrypted: i=1; AJvYcCXzhewWvlxX/vHAJp1G7v+UT0A27aE8dVcRr+nx2fi2NpUCZblpnnVd72mn/IS79vn1HTpBK4lV2d6E9LymCA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwAq8N5sECKC3PzEwuwBSo0sjOt0cLF7PivvAU33EoV2rLAbQL7
	MPlXaOpGsXx2+SJ5DRY/UCDwj4m3L0LN0c8sCrH+olEVwM52HTqy+PHbtGQlreYse+7lfLz5dIK
	Yl3opIsm8LHro6bYSXRuirPToDoCxHQrn2NOb6NZUJx5jQVlLdVruRGqQ/w3qpCHxBXrv
X-Gm-Gg: ATEYQzwYq6j+nP5LLTqpRIx8yj6gVBIQ7pv9hD1kP7Rnp+ytUViToNR819M8kG14BYd
	m6ZVRbUmAxTEUPHQGRcuHCNi8mXKbIRmO9HtsKqqv6tqXi2P8APQW4lg4ig6UNtbifyoqrfjBPB
	48vQ02/ubt0NlabAFPm8xf6mjoqCCmni43QXbzeCy2gQ1R1KVzyGghxqVL8EVJUHzy4O4poA5A7
	wmx9awOWov3ViaYI8ohSpvCBTZNW4QCFEjrIq84LQ/ZeOjzQpFmZNYZYtnLSaAuAx5o6VB9D/I4
	PRI+AbzC8LGPDHhy4wMWq/G1vzIEsmQrnYuuv39ZQH8UB4lfIQ6uk/xh8RY+qZ0NKypxzljR0qX
	gnBaY8t5w+sNUjE1lUGnV0HZjCUzcoITyMnPQRaeo0ffETw==
X-Received: by 2002:a05:600c:8b66:b0:483:6f7c:19f4 with SMTP id 5b1f17b1804b1-483a95ed6f3mr232787355e9.30.1772013834435;
        Wed, 25 Feb 2026 02:03:54 -0800 (PST)
X-Received: by 2002:a05:600c:8b66:b0:483:6f7c:19f4 with SMTP id 5b1f17b1804b1-483a95ed6f3mr232786485e9.30.1772013833899;
        Wed, 25 Feb 2026 02:03:53 -0800 (PST)
Received: from redhat.com (IGLD-80-230-79-166.inter.net.il. [80.230.79.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd6f19f5sm143757215e9.1.2026.02.25.02.03.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 02:03:53 -0800 (PST)
Date: Wed, 25 Feb 2026 05:03:50 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Srujana Challa <schalla@marvell.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev,
	pabeni@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, ndabilpuram@marvell.com, kshankar@marvell.com,
	stable@vger.kernel.org
Subject: Re: [PATCH net,v4,1/2] virtio_net: Improve RSS key size validation
 and use NETDEV_RSS_KEY_LEN
Message-ID: <20260225050154-mutt-send-email-mst@kernel.org>
References: <20260224065850.962826-1-schalla@marvell.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260224065850.962826-1-schalla@marvell.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: d0B0-5jhv32KP-MV-QDhrNzJQF5y1TitdHmBiLQrLkM_1772013835
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 24, 2026 at 12:28:49PM +0530, Srujana Challa wrote:
> Replace hardcoded RSS max key size limit with NETDEV_RSS_KEY_LEN to
> align with kernel's standard RSS key length. Add validation for RSS
> key size against spec minimum (40 bytes) and driver maximum. When
> validation fails, gracefully disable RSS features and continue
> initialization rather than failing completely.
> 
> Cc: stable@vger.kernel.org
> Fixes: 3f7d9c1964fc ("virtio_net: Add hash_key_length check")
> Signed-off-by: Srujana Challa <schalla@marvell.com>

--- should come here before changelog.

> v3:
> - Moved RSS key validation checks to virtnet_validate.
> - Add fixes: tag and CC -stable
> v4:
> - Use NETDEV_RSS_KEY_LEN instead of type_max for the maximum rss key size.
> ---
>  drivers/net/virtio_net.c | 34 ++++++++++++++++++++++++----------
>  1 file changed, 24 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index db88dcaefb20..eeefe8abc122 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -381,8 +381,6 @@ struct receive_queue {
>  	struct xdp_buff **xsk_buffs;
>  };
>  
> -#define VIRTIO_NET_RSS_MAX_KEY_SIZE     40
> -
>  /* Control VQ buffers: protected by the rtnl lock */
>  struct control_buf {
>  	struct virtio_net_ctrl_hdr hdr;
> @@ -486,7 +484,7 @@ struct virtnet_info {
>  
>  	/* Must be last as it ends in a flexible-array member. */
>  	TRAILING_OVERLAP(struct virtio_net_rss_config_trailer, rss_trailer, hash_key_data,
> -		u8 rss_hash_key_data[VIRTIO_NET_RSS_MAX_KEY_SIZE];
> +		u8 rss_hash_key_data[NETDEV_RSS_KEY_LEN];
>  	);
>  };
>  static_assert(offsetof(struct virtnet_info, rss_trailer.hash_key_data) ==
> @@ -6627,6 +6625,29 @@ static int virtnet_validate(struct virtio_device *vdev)
>  		__virtio_clear_bit(vdev, VIRTIO_NET_F_STANDBY);
>  	}
>  
> +	if (virtio_has_feature(vdev, VIRTIO_NET_F_RSS) ||
> +	    virtio_has_feature(vdev, VIRTIO_NET_F_HASH_REPORT)) {
> +		u8 key_sz = virtio_cread8(vdev,
> +					  offsetof(struct virtio_net_config,
> +						   rss_max_key_size));
> +		/* Spec requires at least 40 bytes */
> +#define VIRTIO_NET_RSS_MIN_KEY_SIZE 40
> +		if (key_sz < VIRTIO_NET_RSS_MIN_KEY_SIZE) {
> +			dev_warn(&vdev->dev,
> +				 "rss_max_key_size=%u is less than spec minimum %u, disabling RSS\n",
> +				 key_sz, VIRTIO_NET_RSS_MIN_KEY_SIZE);
> +			__virtio_clear_bit(vdev, VIRTIO_NET_F_RSS);
> +			__virtio_clear_bit(vdev, VIRTIO_NET_F_HASH_REPORT);
> +		}
> +		if (key_sz > NETDEV_RSS_KEY_LEN) {
> +			dev_warn(&vdev->dev,
> +				 "rss_max_key_size=%u exceeds driver limit %u, disabling RSS\n",
> +				 key_sz, NETDEV_RSS_KEY_LEN);
> +			__virtio_clear_bit(vdev, VIRTIO_NET_F_RSS);
> +			__virtio_clear_bit(vdev, VIRTIO_NET_F_HASH_REPORT);

you flipped the logic here and it makes no sense now.

Did you test this path?


So if device is powerful and supports a very big key size then...
we disable the feature? how does this make sense?


> +		}
> +	}
> +
>  	return 0;
>  }
>  
> @@ -6839,13 +6860,6 @@ static int virtnet_probe(struct virtio_device *vdev)
>  	if (vi->has_rss || vi->has_rss_hash_report) {
>  		vi->rss_key_size =
>  			virtio_cread8(vdev, offsetof(struct virtio_net_config, rss_max_key_size));
> -		if (vi->rss_key_size > VIRTIO_NET_RSS_MAX_KEY_SIZE) {
> -			dev_err(&vdev->dev, "rss_max_key_size=%u exceeds the limit %u.\n",
> -				vi->rss_key_size, VIRTIO_NET_RSS_MAX_KEY_SIZE);
> -			err = -EINVAL;
> -			goto free;
> -		}
> -
>  		vi->rss_hash_types_supported =
>  		    virtio_cread32(vdev, offsetof(struct virtio_net_config, supported_hash_types));
>  		vi->rss_hash_types_supported &=
> -- 
> 2.25.1

