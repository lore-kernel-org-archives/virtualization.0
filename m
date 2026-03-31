Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710063ED12B
	for <virtualization@lists.linux.dev>; Tue, 31 Mar 2026 09:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774948861; cv=none; b=DtBXrYHQiq1PWLR+o6pPC1DaDPcn9g5NDLgzY7EhLQX+K4rQv8/z+EsO5yIQyKskd+ZYjXdmPXxa4mDthMYE6l3ohLMUw3YAgh0KufectkEfzrMqxGMUVrUbUQiCNA9Wh09KOFe9FVZ+GmZte9Pkp5ECV5H9/+Q76kikqYMb96Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774948861; c=relaxed/simple;
	bh=npAzXkJWcAEQdybp4dELF99mAn10Mr9vx71ipcJ4toI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EjZhf2zb75mD+dY1D4Cu8TI538lLfpBCe8tclU/4tRTC6I9ZqKLoHCMpKX6aMHIK7cTQ5J+uSwW3Ihg8AUk0bSNAKMV0OHSpsF5AYnz9Uzh2wNrBZ3r6H4SY+Iy13qP2OLhjW7izejtWq04E2azhSDckQPdeEZ6+OHYwMdH0bgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OliXUjjA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OliXUjjA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774948859;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jEFy+ly0SyOy8YL/S4CPl+fJ88M+Cfc8bAbwXPfI46s=;
	b=OliXUjjAcWm++gSPCUNu0eY4YLK/YrNGZbbKO0fU1R8/Kb9p1JB2Kq7FiW5pRl8BJTLnES
	VpG8soxo/xVKt0SQvsIlswNWAsodQ+ZzfujxWIWE2HBS6aJJcpN68oRpyfoPPOOed6QJ3Q
	OM/DIJSiePkKnBRNIXn2Osf8Vp/0FIw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-340-iK4x1dKqNy-WqzUUFFjgCw-1; Tue, 31 Mar 2026 05:20:55 -0400
X-MC-Unique: iK4x1dKqNy-WqzUUFFjgCw-1
X-Mimecast-MFC-AGG-ID: iK4x1dKqNy-WqzUUFFjgCw_1774948854
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-486f830f4e4so38425055e9.1
        for <virtualization@lists.linux.dev>; Tue, 31 Mar 2026 02:20:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774948854; x=1775553654;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jEFy+ly0SyOy8YL/S4CPl+fJ88M+Cfc8bAbwXPfI46s=;
        b=jiRGKvjVYwF4EKaaytsm7BCUf1nq864BU0LyGMDlAsFrfTsmqqV6g1i523NiYDAJ2F
         +PKybjsEqORzxD1zKs8CUXLr6QToFLOD3bdENFtmFxPyeUpJhD3xSFExGdQOpLhdiI/2
         ufdG+HyLczAZL64f6e9eaZ44L4ntOuk8p+EuahYdM38AmWkyDv7syjtKRGf3U3w0+Y0/
         SXRY8rUzKU46pT0Rl4crkSV2NHWTzzw5i/d+Iuj2Y+tWY+w3fcLx8P4c32HctV3tdkvf
         qM6G1MwCTLBIbF6GJwmRFr4wHad6xeE0MLIhsQjfMeI17kYEjoR7Izdx7Bf8LzokRvWB
         8cxQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKfyuQLU3oYOCXWu0cifIp92ZauPDjgIZd9DhCBi7Fuly1soCRPdb3F1MwZaioZMbZ0wp+9MB5crdOxS1QtA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyleWl95BUsqINoIbyYXC6oBiyPzBkLPvU8Yo0nSsIyj2z5opWU
	xeOg/SpBVhQ9WrMiHAR+gVJ2ZXHZfTak6my/UgFo1b+CLLe23f0I5JtPDdcTZ/XdBo7lWddUvtH
	sqSCW4RjLwuq4ieNiaxGb3FZh9Z592ych7VdHS7w6A92uBy6VZMAwucAeWP3EBAYui64i
X-Gm-Gg: ATEYQzyyoyK6mVj+MwKtH2znq62AjELgvJ6xlhlpUKmXj7U+NADwlWDA9A/iOWV2EHq
	CpWmH+VjG/rAntl9+wJURBG5kqbhtw1/0Gtk3b9G3H6rwd4CMich/1wv/M+cGISPxN54GPvgpWI
	ckWN1gFqZWj6B5LTUxgKsHlu0xSM+toKaiyMgeW+uJC8dFJ9ufC++MPLNsqfwnxOQe3iIr3DUpQ
	y+sW1vFv11i0PgtsXOki4v/xVLss+18i5Muk56skCdWzpaLsbAHTVCdMmlPKt/qeD4j4t3oDpYH
	Efv42C4ObtCg/f0ch2xby1f77NUIf2Q86CAS310T09Sm0k222zj2xZckwLQT0BXO082KakNnt5t
	hR1LF05IDaOEXrrDV6t1sa8WsRn4Vmww04s6cGRc7MRx5c4KnRGHKcxsm
X-Received: by 2002:a05:600c:83c4:b0:47e:e076:c7a5 with SMTP id 5b1f17b1804b1-48727d87b56mr262108795e9.11.1774948854117;
        Tue, 31 Mar 2026 02:20:54 -0700 (PDT)
X-Received: by 2002:a05:600c:83c4:b0:47e:e076:c7a5 with SMTP id 5b1f17b1804b1-48727d87b56mr262108175e9.11.1774948853631;
        Tue, 31 Mar 2026 02:20:53 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.155.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e80148csm23480185e9.5.2026.03.31.02.20.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2026 02:20:52 -0700 (PDT)
Message-ID: <ba027306-e5e0-4d4d-8357-f6080441167d@redhat.com>
Date: Tue, 31 Mar 2026 11:20:51 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net,v5] virtio_net: clamp rss_max_key_size to
 NETDEV_RSS_KEY_LEN
To: Srujana Challa <schalla@marvell.com>, netdev@vger.kernel.org,
 virtualization@lists.linux.dev
Cc: mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
 eperezma@redhat.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, ndabilpuram@marvell.com, kshankar@marvell.com,
 stable@vger.kernel.org
References: <20260326142344.1171317-1-schalla@marvell.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260326142344.1171317-1-schalla@marvell.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: aY4NI-wWEV20F3y0qy2UAF_b4jLbMrCN5NkphkgcKA0_1774948854
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/26/26 3:23 PM, Srujana Challa wrote:
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

NETDEV_RSS_KEY_LEN is 256 and virtio_cread8() returns a u8. The check is
not needed, and the warning will never be printed. I think that the
BUILD_BUG_ON() you used in v4 would be better than the above chunk.

/P

