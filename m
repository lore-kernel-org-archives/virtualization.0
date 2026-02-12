Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635EC3B19F
	for <virtualization@lists.linux.dev>; Thu, 12 Feb 2026 14:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770907259; cv=none; b=DXRDra+Db+H+O4m3wpJ7rNr9J5RCSyVfY9LTdyyaBpE+2/mDCi5faoFIXBs0d2miFkqtR+z+voSgvXDfvWF69v6VjdOs90pn2eW5/0ZpygPG2meXaSYv/3EGWGLPPYUrSYnGGj3vqzg6EfBPgBmjHxoLSqkDyQk71NXSs3KJTMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770907259; c=relaxed/simple;
	bh=MV+loLSfbym18ym6CF0ldD6FyGE5WQufzZjWV/GujiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=TEG1x4lzc+ldcnOm3Hj1V2GDljoRobVxcq+iVS3va7pS2lwi/pnS2z6cRIZv0ufrd1ixmUTJxCgvqjxe3A9h6dX6j4TGqfXeJyUYbxmS/zpQXdtBcDoFm1uXe1jEi3p6sQJZl2vcY+s/1KT6Q6FlTeqZAdrS+Fc8PPS2oBJvkHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MLoAGlKb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MLoAGlKb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770907257;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uDKQzbGUuJRbgtDN0hG7BvdewQ/ExGQehaybklKCcDA=;
	b=MLoAGlKbfo/xXSs89VRXpTQrzs9zwgpmtjzZj8YyXBzTfnsCfeCvUBGTMrRhHkQblDr8Bp
	lt5blVSGwZIT2Qo9qLiLTwTesE/pdh+cJ0kDZMoRVssBFxXhmHqm/oRfsQ5oaB+qDa0v6G
	z4rCAPdHmVGsUgYfbuWPr3dB8xnvsmI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-221-TmJlL2CpMXCxYI6Bzhl4MA-1; Thu, 12 Feb 2026 09:40:55 -0500
X-MC-Unique: TmJlL2CpMXCxYI6Bzhl4MA-1
X-Mimecast-MFC-AGG-ID: TmJlL2CpMXCxYI6Bzhl4MA_1770907254
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-482ef3af991so11802155e9.0
        for <virtualization@lists.linux.dev>; Thu, 12 Feb 2026 06:40:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770907254; x=1771512054;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uDKQzbGUuJRbgtDN0hG7BvdewQ/ExGQehaybklKCcDA=;
        b=ad3M4ILvaCD3dPqY4yxYdFJbBsn2Q+MCiMZKO0C4Y86vpISj8LFuQFGwVtq5kE91MM
         2Hw6Vkx8d6gFIg7HiNTFxpTvynSxmgwpQG+sZTVOTrqC+i7rmyBB0MNTcReq8V4S9j6V
         v7I0LLi8BaIkdU0stJ/NQc9wY1IaP6dg6mpSUmVbN+rf+u4Qk+Ahc5vDZNt9nrWY07xS
         ehK+baMgsrO0GxdNmOpLVYq7M0Lx9JujGRUrXQHe3kMJWZiux42ThPw8u85juvxlUksU
         Gb8v4M80hMCu+BXUVPZCRCIlZQty3DAgdcgfuHu0yAZjKfEUDVkel0HqEfJquELajpDQ
         4zyg==
X-Forwarded-Encrypted: i=1; AJvYcCU/ADo8sRrUVC6pYk1Lud2hKaQ9oJ+x8vIaKQ8js+6/9sqH6lZPj0MKRkfuKo7JC7fxv7W96Vc+i/QSwA4Ipw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwOTFjGPQFrYOT7A77vnzOfrZ49m95nHGMKui4nS/75/xdZMH0y
	YE7eDF5VxrGDQ1P/QVdfobX71Pjxs2GdVnstXxQkjuUiYoe9njdFOZ6dHCYnMTgTO9ZTrkgwgM/
	tLzatFXG9lCk5+SCsXqbNMNT1JQlHsnYSSIendBxRcjZPGIli+6R/rgLzDR3Fl/MVbaao
X-Gm-Gg: AZuq6aL9WmDzgzr1ZyUFpnILYkQt4iIzyAv6YgwtUXoYb6xGqSoo5/j51EnFHf17MGB
	BBJkVNm2Nl5MthpFbQR7Tp9i3waACxLlbTmC/N3a4WyVYASJH48xyS7ORjqXRk0npRzMgS/rjzG
	OTYObHpbMxm1UH/6c96BA+RVqqjY3QOmAMWTUfult1aX+SbxtbZUSSbJZ4ksHUnq1WtWxGPPB/D
	MP5/kEYtuR9BzCi9rsbi9KglXKTfpnhhQJIWntPKrBzfVm+d94V4f/TUotGs6krWRJl2srqPakm
	ILJ7rjoXdeG9+SDp19/v/wZqmOZrKHgJvyX4xPJnNzXDVGzsexqsr/RYV5S2zcLGpXvqVMDoKs/
	riNrUxQ2wOQO4rNa1FPalwvbYoVxd4Y3XQ8SRnmOprdOOsw==
X-Received: by 2002:a05:600c:4d06:b0:47e:e7de:7c41 with SMTP id 5b1f17b1804b1-483660306b6mr26987445e9.16.1770907254316;
        Thu, 12 Feb 2026 06:40:54 -0800 (PST)
X-Received: by 2002:a05:600c:4d06:b0:47e:e7de:7c41 with SMTP id 5b1f17b1804b1-483660306b6mr26986955e9.16.1770907253657;
        Thu, 12 Feb 2026 06:40:53 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4835ba1670fsm77265075e9.4.2026.02.12.06.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 06:40:53 -0800 (PST)
Date: Thu, 12 Feb 2026 09:40:49 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Srujana Challa <schalla@marvell.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev,
	pabeni@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, ndabilpuram@marvell.com, kshankar@marvell.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v3,net] virtio_net: Improve RSS key size validation
Message-ID: <20260212093707-mutt-send-email-mst@kernel.org>
References: <20260212130340.3540415-1-schalla@marvell.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260212130340.3540415-1-schalla@marvell.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 45vrBo5CFzqnq73triOwMzIN_Q6sFFElzmdUVusPCBI_1770907254
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 12, 2026 at 06:33:40PM +0530, Srujana Challa wrote:
> Replace hardcoded RSS max key size limit with a type based definition.
> Add validation for RSS key size against spec minimum (40 bytes). When
> validation fails, gracefully disable RSS features and continue
> initialization rather than failing completely.
> 
> Cc: stable@vger.kernel.org
> Fixes: 3f7d9c1964fc ("virtio_net: Add hash_key_length check")
> Signed-off-by: Srujana Challa <schalla@marvell.com>
> 
> v3:
> - Moved RSS key validation checks to virtnet_validate.
> - Add fixes: tag and CC -stable
> ---
>  drivers/net/virtio_net.c | 29 +++++++++++++++++++++--------
>  1 file changed, 21 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index db88dcaefb20..e61cea50dcab 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -381,7 +381,9 @@ struct receive_queue {
>  	struct xdp_buff **xsk_buffs;
>  };
>  
> -#define VIRTIO_NET_RSS_MAX_KEY_SIZE     40
> +#define VIRTIO_NET_RSS_MAX_KEY_SIZE \
> +	(type_max(((struct virtio_net_config *)0)->rss_max_key_size) + 1)

+1 here really unintuitive.
It does not look like it's still used, though?


> +#define VIRTIO_NET_RSS_MIN_KEY_SIZE 40
>  
>  /* Control VQ buffers: protected by the rtnl lock */
>  struct control_buf {
> @@ -6627,6 +6629,24 @@ static int virtnet_validate(struct virtio_device *vdev)
>  		__virtio_clear_bit(vdev, VIRTIO_NET_F_STANDBY);
>  	}
>  
> +	if (virtio_has_feature(vdev, VIRTIO_NET_F_RSS) ||
> +	    virtio_has_feature(vdev, VIRTIO_NET_F_HASH_REPORT)) {
> +		u8 key_sz = virtio_cread8(vdev,
> +					  offsetof(struct virtio_net_config,
> +						   rss_max_key_size));
> +		/* Spec requires at least 40 bytes */

move the define here then?

> +		if (key_sz < VIRTIO_NET_RSS_MIN_KEY_SIZE) {
> +			dev_warn(&vdev->dev,
> +				 "rss_max_key_size=%u is less than spec minimum %u, disabling RSS\n",
> +				 key_sz, VIRTIO_NET_RSS_MIN_KEY_SIZE);
> +			if (virtio_has_feature(vdev, VIRTIO_NET_F_RSS))
> +				__virtio_clear_bit(vdev, VIRTIO_NET_F_RSS);
> +			if (virtio_has_feature(vdev, VIRTIO_NET_F_HASH_REPORT))
> +				__virtio_clear_bit(vdev,
> +						   VIRTIO_NET_F_HASH_REPORT);


why not clear them unconditionally?

> +		}
> +	}
> +
>  	return 0;
>  }
>  
> @@ -6839,13 +6859,6 @@ static int virtnet_probe(struct virtio_device *vdev)
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

