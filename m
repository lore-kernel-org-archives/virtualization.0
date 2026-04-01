Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDB038D68F
	for <virtualization@lists.linux.dev>; Wed,  1 Apr 2026 08:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775031681; cv=none; b=RNAitvvNZjliTXkflTA89EBBe/ziJfToE87XrPCRFNdlnD9+SLq9XJUpmJb824+HHqQwO+V4DwDtAQ6teQyilHnqky+aJgE1cdlvMVfkQhg5qCfHouvU8M+47FZuZwNM6skljRJ0PDFOouVSXh3CdIyjqqN9Aw7XkPpXTlvLc88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775031681; c=relaxed/simple;
	bh=B5Tle2fRi76KfDMCO8D4EC6UyhUw+743wpGBNKtB0iM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=jj+VuVmjb4an+UBJ+vJLMkMZY9FRGfaS6QsqIIcqG+6Dv55ZatRtPq+gCvTDrSZVkPe4faba6v9Zku69A6zFJaKJrs66VQETI46ToVTkvJRPgqtgYN69wXtY7jXQ9oA05Bh424ex+y7CUXmj3ofByYrPmLouiTmvb7yqm62mmaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hubbP+T3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hubbP+T3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775031678;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1+9bEHS3jmAexwoYuhPYmzlkbcIU24Gjv5E3vES6Edw=;
	b=hubbP+T3DqH6VmwgNZNLMgRo/DMlAsz6jqpH6AtxboKZDyt3jJwKbkMoA+G/i4y0xn6oDw
	fVh7Rwcmwb50/3G7m7fyk+4QnR5uPlodfOF0PKoSRWtegAkmLtxtNirCNbzYeDG2QdWnNY
	wY+2ow1/EZdIzJd8xIbbvhrpuo+emF8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-367-RpVe97D1P1aagmDqGOMCYQ-1; Wed, 01 Apr 2026 04:21:17 -0400
X-MC-Unique: RpVe97D1P1aagmDqGOMCYQ-1
X-Mimecast-MFC-AGG-ID: RpVe97D1P1aagmDqGOMCYQ_1775031676
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4853b5b0fafso80701425e9.3
        for <virtualization@lists.linux.dev>; Wed, 01 Apr 2026 01:21:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775031676; x=1775636476;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1+9bEHS3jmAexwoYuhPYmzlkbcIU24Gjv5E3vES6Edw=;
        b=VY19iD2PmoIXCAZi9z51J4/7r1Xrrb9slCqIn+QaGLPDl/tV4br2IRHLeAlliKrsLZ
         pnetLyDq/AREvDYFNhMBA77nRZLRGj/sq2LpwyAbhTk9GeJrxNJ942H22PEgGM3+I86S
         oJzqMuJzm9tdZHlc4FN10hkRGtH0nJmOIVwWGigbXm7w6PJTt+H8pqusjm7Vg7fqJ545
         q2Y6CdXFwIA60xFyEIs0IG5tZZHmXFyXVFuQnTC09tLdzaiJfgHHl5yQxhJ2g0UQ0aVS
         8WhQ6rGR57v2AL+kvCCy+YRhvIIVjsnaIJDJz4K3d5MFkd9HC26mcqubTd8I3Q+kuyja
         dUHA==
X-Forwarded-Encrypted: i=1; AJvYcCWizQMwSwVKbEqc4MUOXvvf44plfzcWN6akQoJdPVPdTQpazbu1yezhHZZ4V98eVdwW5Dp1yPk18y4SSMrqrg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwEra3Na/OpFeONzNUP+v7T12/WscJe9aRYwNJSL8V59GE0aGCr
	hlm5j75aDl/74/VttqhNI6lnENskPajdeYKO6FbXH1wVQTXZ1sKT3i6guxsxDgHQnnMAEvYVI9U
	Mh65NhVxgnl84kAH++1O7DkfpIBlNBayzKgyutsqPp2YXdyMlRayqIS05sLIUFrETaguGG27VDo
	cw
X-Gm-Gg: ATEYQzz4065nhJLRXW3Aa/9nAgfN8Lrpu6zIMy2PQ8xH/g5DQC9+7pUFUbWk8UfNAH/
	dTLMfoJNiFQ+aGdZC1zgYPKOUXTzc3jOaFKw+RXg4mY3kti1hpYxYQLcpoE8pVTXbgb946nqbjO
	PGZr02TvdHQYwyLAcP8rSsB75tFpIg9tbCwyL8rm+kx3dGpZGQrZ3Xt/fi3PFAHn357zfnHc7jf
	cr1VRh6dvIJgemfkEJ/nO2kPwXzwYrIXm4MDTniWVdl3VTWHEvGV92Nd2fYmds3/kDzgBwl/VSb
	Gmi819gYnvMOCxH+hiybfymZ5Oq/kiSruZ6IvC4DZPCdh59juCJWoaK5CKAYc1gpnJzeEeZxD0p
	ivNceQX+1gY4ZCLjJ
X-Received: by 2002:a05:600c:468b:b0:480:1d0b:2d32 with SMTP id 5b1f17b1804b1-4888356275bmr40333145e9.12.1775031675928;
        Wed, 01 Apr 2026 01:21:15 -0700 (PDT)
X-Received: by 2002:a05:600c:468b:b0:480:1d0b:2d32 with SMTP id 5b1f17b1804b1-4888356275bmr40332415e9.12.1775031675320;
        Wed, 01 Apr 2026 01:21:15 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1525:da00:3ac2:1a22:72ff:4256])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e7e9728sm101815975e9.1.2026.04.01.01.21.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 01:21:14 -0700 (PDT)
Date: Wed, 1 Apr 2026 04:21:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Srujana Challa <schalla@marvell.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev,
	pabeni@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, ndabilpuram@marvell.com, kshankar@marvell.com,
	stable@vger.kernel.org
Subject: Re: [PATCH net,v5] virtio_net: clamp rss_max_key_size to
 NETDEV_RSS_KEY_LEN
Message-ID: <20260401042105-mutt-send-email-mst@kernel.org>
References: <20260326142344.1171317-1-schalla@marvell.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260326142344.1171317-1-schalla@marvell.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: gK0JKo5KVOuJAWezB3KqV_DgE07ELJYxiqpdCNW9egk_1775031676
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 26, 2026 at 07:53:44PM +0530, Srujana Challa wrote:
> rss_max_key_size in the virtio spec is the maximum key size supported by
> the device, not a mandatory size the driver must use. Also the value 40
> is a spec minimum, not a spec maximum.
> 
> The current code rejects RSS and can fail probe when the device reports a
> larger rss_max_key_size than the driver buffer limit. Instead, clamp the
> effective key length to min(device rss_max_key_size, NETDEV_RSS_KEY_LEN)
> and keep RSS enabled.
> 
> This keeps probe working on devices that advertise larger maximum key sizes
> while respecting the netdev RSS key buffer size limit.
> 
> Fixes: 3f7d9c1964fc ("virtio_net: Add hash_key_length check")
> Cc: stable@vger.kernel.org
> Signed-off-by: Srujana Challa <schalla@marvell.com>


Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
> v3:
> - Moved RSS key validation checks to virtnet_validate.
> - Add fixes: tag and CC -stable
> v4:
> - Use NETDEV_RSS_KEY_LEN instead of type_max for the maximum rss key size.
> v5:
> - Interpret rss_max_key_size as a maximum and clamp it to NETDEV_RSS_KEY_LEN.
> - Do not disable RSS/HASH_REPORT when device rss_max_key_size exceeds NETDEV_RSS_KEY_LEN.
> - Drop the separate patch that replaced the runtime check with BUILD_BUG_ON.
> 
>  drivers/net/virtio_net.c | 20 +++++++++-----------
>  1 file changed, 9 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 022f60728721..b241c8dbb4e1 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -373,8 +373,6 @@ struct receive_queue {
>  	struct xdp_buff **xsk_buffs;
>  };
>  
> -#define VIRTIO_NET_RSS_MAX_KEY_SIZE     40
> -
>  /* Control VQ buffers: protected by the rtnl lock */
>  struct control_buf {
>  	struct virtio_net_ctrl_hdr hdr;
> @@ -478,7 +476,7 @@ struct virtnet_info {
>  
>  	/* Must be last as it ends in a flexible-array member. */
>  	TRAILING_OVERLAP(struct virtio_net_rss_config_trailer, rss_trailer, hash_key_data,
> -		u8 rss_hash_key_data[VIRTIO_NET_RSS_MAX_KEY_SIZE];
> +		u8 rss_hash_key_data[NETDEV_RSS_KEY_LEN];
>  	);
>  };
>  static_assert(offsetof(struct virtnet_info, rss_trailer.hash_key_data) ==
> @@ -6717,6 +6715,7 @@ static int virtnet_probe(struct virtio_device *vdev)
>  	struct virtnet_info *vi;
>  	u16 max_queue_pairs;
>  	int mtu = 0;
> +	u16 key_sz;
>  
>  	/* Find if host supports multiqueue/rss virtio_net device */
>  	max_queue_pairs = 1;
> @@ -6851,14 +6850,13 @@ static int virtnet_probe(struct virtio_device *vdev)
>  	}
>  
>  	if (vi->has_rss || vi->has_rss_hash_report) {
> -		vi->rss_key_size =
> -			virtio_cread8(vdev, offsetof(struct virtio_net_config, rss_max_key_size));
> -		if (vi->rss_key_size > VIRTIO_NET_RSS_MAX_KEY_SIZE) {
> -			dev_err(&vdev->dev, "rss_max_key_size=%u exceeds the limit %u.\n",
> -				vi->rss_key_size, VIRTIO_NET_RSS_MAX_KEY_SIZE);
> -			err = -EINVAL;
> -			goto free;
> -		}
> +		key_sz = virtio_cread8(vdev, offsetof(struct virtio_net_config, rss_max_key_size));
> +
> +		vi->rss_key_size = min_t(u16, key_sz, NETDEV_RSS_KEY_LEN);
> +		if (key_sz > vi->rss_key_size)
> +			dev_warn(&vdev->dev,
> +				 "rss_max_key_size=%u exceeds driver limit %u, clamping\n",
> +				 key_sz, vi->rss_key_size);
>  
>  		vi->rss_hash_types_supported =
>  		    virtio_cread32(vdev, offsetof(struct virtio_net_config, supported_hash_types));
> -- 
> 2.25.1

