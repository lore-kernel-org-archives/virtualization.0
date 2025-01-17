Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0A51FAC23
	for <virtualization@lists.linux-foundation.org>; Fri, 17 Jan 2025 09:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737105374; cv=none; b=dodmVfN7hHr6IxklJ4w465sDgBRMA7pn6vqkKFGbBeFfzXHgy7XbBN92ENwRN3CMe37P4awHl71wk2MKYGVYa6JrHaywtkc3L7zDRfVh3tFxs/nAqb76kFKdqOCl5fDqNgJh1JAI6ir5o5+tV0ndXVSI/kATaCjIX2iIx7H39IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737105374; c=relaxed/simple;
	bh=KNi0T2jTKBJeJCB3+aMk/ZCvS0hODas9BOgOIjyUabk=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=SApmB3aWNzLgLeRGCR0jO4x+xZChhbJ/1fqti8A7w1Pe8WKnIlvF/PLAWpWfqAqOO0gqYMO0Ai8a+syN3nXI6TWz7VewZ/EnK89zO8NVyjVLd1HVv9vLLZ+y72pDaySGbgEPG6trVULDRlFVaFKptpiEdDGaMrhcAF17Z0bsuDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O3pTNJ3f; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O3pTNJ3f"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9DBAC60614
	for <virtualization@lists.linux-foundation.org>; Fri, 17 Jan 2025 09:16:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uVsn42b8uqpn for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Jan 2025 09:16:11 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::f2d; helo=mail-qv1-xf2d.google.com; envelope-from=willemdebruijn.kernel@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 10A2D60616
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 10A2D60616
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=O3pTNJ3f
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 10A2D60616
	for <virtualization@lists.linux-foundation.org>; Fri, 17 Jan 2025 09:16:10 +0000 (UTC)
Received: by mail-qv1-xf2d.google.com with SMTP id 6a1803df08f44-6dd1962a75bso17347766d6.3
        for <virtualization@lists.linux-foundation.org>; Fri, 17 Jan 2025 01:16:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737105369; x=1737710169; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pZTgtHN14KI8oTpVLZZm33nZqE+1xPlPrn8gCitpgCg=;
        b=O3pTNJ3fgUlZgaC1BIMI4k03Cbsasen06p0536Xr78nNcpofTlBYvSHIbCpyFWoS3n
         swAwl05wMnkMFW/LIjet9mHiHO2i4xO8oSTdt1F1rhiUaTKLRfPyjjMAH35RmyLcxoUy
         RNJ0fV6S+gvWXNfVqmpqBvPR9EtyaTKZ7wb1jseFL+ao+ipgljDTTKh3rowlEFuUwW1z
         IoynC2+zcs5OmXVtdulfeExGC7RmaqSbJrhRdVBGNy/astWVzZncRW+R2FdnrrzP9Djw
         b4Dq29TzsBWSkYHEP4sfHTryFaEJViK5k8hg0KkuSIpPHRKX4QK4AmZcgjcoUSYNPJZk
         Q3xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737105369; x=1737710169;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pZTgtHN14KI8oTpVLZZm33nZqE+1xPlPrn8gCitpgCg=;
        b=QRNHlLGUyGz1I9KCPxhu76S2K+93uLdE98fuarvCe17uuvzd+EoqwpYZtHZcJIQf/O
         MTLK69auS/oRrHgTy8Ht/H4VPIrGco6ZHtXc8hEj5YTY/bxcSjoLGqI074IGjh4HOUsR
         HcJf0tpeb19d+CJIC37Vx/gyspFVf382gODKCUQHXAjRd6HFU9zIxAATdzY9SMu0GN0T
         X69s/KufYo+ESw6ngtcKjGleR4V4/qfANZgpD2BeOmVbJMuYxHcfZmdlGcNjZ9djQvSd
         ye23849b2Dhs1IUGKFOF8QoQB2IdO0ZsK1Xlb6CH4RF0113Xcq3Q310LdgjxcT6MYn3V
         wFPw==
X-Forwarded-Encrypted: i=1; AJvYcCUjxF3X69vAAhkGU2dPats0C1MoD0yzlAClfnFVIOE05Nmkx5fp73MpoZTma2B25VtyaxU/0/HCKZ4T/vhO2w==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YwpukYLTQcfifPxxK0I8A3Fd2Rwa7ZU2/jh+0+yv52umfCQq+Hr
	nHeLx9f1iB5m4VvHZ8fJowgHrI65liRS8EuyNUUfPE1LAmEkxFFW
X-Gm-Gg: ASbGncv8m2TSVTEaomAg8mBZ9VOv+Rnyu/J+uNW+EOfxaRc8rcPthO0G3kRFgdJey71
	iTb7aFu0K+g9UtbX+hUt49V9KZ8OAFdqVObCbXv45vOyFpOvEqUrbPbGpwMXBDFnUwUx/3KVp+k
	HeGnCIX9xoS9a/7w1+Q5hyJRyvEFwrSLJ/VXDA3VVm8UBgSqTxwGYmyT5stIsuQO2z2SlN3zGf2
	QlneiMgD+00MLvOiC6leSjxcvKshTa2mxFq2BgU1pHvzPRuPJ1YP7wJ/VbvpwrOOVZtWI++dQap
	FrQWhZWUmhrf4klQ12sRr4c3AvQ8
X-Google-Smtp-Source: AGHT+IHN8TErnIji3r8Qq5buiozYuzN7Fv/FHh3X7BOlSf/UuB6xpajfD/Tj2rE5wqRrGsGj45mPCA==
X-Received: by 2002:a05:6214:4b0f:b0:6d4:36ff:4356 with SMTP id 6a1803df08f44-6e1b217dc6emr37454886d6.19.1737105368950;
        Fri, 17 Jan 2025 01:16:08 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e1afc0ff47sm9627386d6.29.2025.01.17.01.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 01:16:08 -0800 (PST)
Date: Fri, 17 Jan 2025 04:16:07 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jason Wang <jasowang@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 Shuah Khan <shuah@kernel.org>, 
 linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, 
 kvm@vger.kernel.org, 
 virtualization@lists.linux-foundation.org, 
 linux-kselftest@vger.kernel.org, 
 Yuri Benditovich <yuri.benditovich@daynix.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 Stephen Hemminger <stephen@networkplumber.org>, 
 gur.stavi@huawei.com, 
 devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
Message-ID: <678a1fd7d7c85_3e503c29449@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250116-tun-v3-4-c6b2871e97f7@daynix.com>
References: <20250116-tun-v3-0-c6b2871e97f7@daynix.com>
 <20250116-tun-v3-4-c6b2871e97f7@daynix.com>
Subject: Re: [PATCH net v3 4/9] tun: Decouple vnet from tun_struct
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Akihiko Odaki wrote:
> Decouple vnet-related functions from tun_struct so that we can reuse
> them for tap in the future.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  drivers/net/tun.c | 53 +++++++++++++++++++++++++++--------------------------
>  1 file changed, 27 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index ec56ac865848..add09dfdada5 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -298,16 +298,16 @@ static bool tun_napi_frags_enabled(const struct tun_file *tfile)
>  	return tfile->napi_frags_enabled;
>  }
>  
> -static inline bool tun_legacy_is_little_endian(struct tun_struct *tun)
> +static inline bool tun_legacy_is_little_endian(unsigned int flags)
>  {
>  	return !(IS_ENABLED(CONFIG_TUN_VNET_CROSS_LE) &&
> -		 (tun->flags & TUN_VNET_BE)) &&
> +		 (flags & TUN_VNET_BE)) &&
>  		virtio_legacy_is_little_endian();
>  }
>  
> -static long tun_get_vnet_be(struct tun_struct *tun, int __user *argp)
> +static long tun_get_vnet_be(unsigned int flags, int __user *argp)
>  {
> -	int be = !!(tun->flags & TUN_VNET_BE);
> +	int be = !!(flags & TUN_VNET_BE);
>  
>  	if (!IS_ENABLED(CONFIG_TUN_VNET_CROSS_LE))
>  		return -EINVAL;
> @@ -318,7 +318,7 @@ static long tun_get_vnet_be(struct tun_struct *tun, int __user *argp)
>  	return 0;
>  }
>  
> -static long tun_set_vnet_be(struct tun_struct *tun, int __user *argp)
> +static long tun_set_vnet_be(unsigned int *flags, int __user *argp)
>  {
>  	int be;
>  
> @@ -329,27 +329,26 @@ static long tun_set_vnet_be(struct tun_struct *tun, int __user *argp)
>  		return -EFAULT;
>  
>  	if (be)
> -		tun->flags |= TUN_VNET_BE;
> +		*flags |= TUN_VNET_BE;
>  	else
> -		tun->flags &= ~TUN_VNET_BE;
> +		*flags &= ~TUN_VNET_BE;
>  
>  	return 0;
>  }
>  
> -static inline bool tun_is_little_endian(struct tun_struct *tun)
> +static inline bool tun_is_little_endian(unsigned int flags)
>  {
> -	return tun->flags & TUN_VNET_LE ||
> -		tun_legacy_is_little_endian(tun);
> +	return flags & TUN_VNET_LE || tun_legacy_is_little_endian(flags);
>  }
>  
> -static inline u16 tun16_to_cpu(struct tun_struct *tun, __virtio16 val)
> +static inline u16 tun16_to_cpu(unsigned int flags, __virtio16 val)
>  {
> -	return __virtio16_to_cpu(tun_is_little_endian(tun), val);
> +	return __virtio16_to_cpu(tun_is_little_endian(flags), val);
>  }
>  
> -static inline __virtio16 cpu_to_tun16(struct tun_struct *tun, u16 val)
> +static inline __virtio16 cpu_to_tun16(unsigned int flags, u16 val)
>  {
> -	return __cpu_to_virtio16(tun_is_little_endian(tun), val);
> +	return __cpu_to_virtio16(tun_is_little_endian(flags), val);
>  }
>  
>  static inline u32 tun_hashfn(u32 rxhash)
> @@ -1764,6 +1763,7 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
>  
>  	if (tun->flags & IFF_VNET_HDR) {
>  		int vnet_hdr_sz = READ_ONCE(tun->vnet_hdr_sz);
> +		int flags = tun->flags;

Here and elsewhere: instead of passing around and repeatedly parsing
flags, have a variable is_little_endian (or is_le)?
>  
>  		if (iov_iter_count(from) < vnet_hdr_sz)
>  			return -EINVAL;
> @@ -1772,12 +1772,12 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
>  			return -EFAULT;
>  
>  		if ((gso.flags & VIRTIO_NET_HDR_F_NEEDS_CSUM) &&
> -		    tun16_to_cpu(tun, gso.csum_start) + tun16_to_cpu(tun, gso.csum_offset) + 2 > tun16_to_cpu(tun, gso.hdr_len))
> -			gso.hdr_len = cpu_to_tun16(tun, tun16_to_cpu(tun, gso.csum_start) + tun16_to_cpu(tun, gso.csum_offset) + 2);
> +		    tun16_to_cpu(flags, gso.csum_start) + tun16_to_cpu(flags, gso.csum_offset) + 2 > tun16_to_cpu(flags, gso.hdr_len))
> +			gso.hdr_len = cpu_to_tun16(flags, tun16_to_cpu(flags, gso.csum_start) + tun16_to_cpu(flags, gso.csum_offset) + 2);
>  
> -		if (tun16_to_cpu(tun, gso.hdr_len) > iov_iter_count(from))
> +		if (tun16_to_cpu(flags, gso.hdr_len) > iov_iter_count(from))
>  			return -EINVAL;
> -		hdr_len = tun16_to_cpu(tun, gso.hdr_len);
> +		hdr_len = tun16_to_cpu(flags, gso.hdr_len);
>  		iov_iter_advance(from, vnet_hdr_sz - sizeof(gso));
>  	}
>  
> @@ -1854,7 +1854,7 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
>  		}
>  	}
>  
> -	if (virtio_net_hdr_to_skb(skb, &gso, tun_is_little_endian(tun))) {
> +	if (virtio_net_hdr_to_skb(skb, &gso, tun_is_little_endian(tun->flags))) {
>  		atomic_long_inc(&tun->rx_frame_errors);
>  		err = -EINVAL;
>  		goto free_skb;
> @@ -2108,23 +2108,24 @@ static ssize_t tun_put_user(struct tun_struct *tun,
>  
>  	if (vnet_hdr_sz) {
>  		struct virtio_net_hdr gso;
> +		int flags = tun->flags;
>  
>  		if (iov_iter_count(iter) < vnet_hdr_sz)
>  			return -EINVAL;
>  
>  		if (virtio_net_hdr_from_skb(skb, &gso,
> -					    tun_is_little_endian(tun), true,
> +					    tun_is_little_endian(flags), true,
>  					    vlan_hlen)) {
>  			struct skb_shared_info *sinfo = skb_shinfo(skb);
>  
>  			if (net_ratelimit()) {
>  				netdev_err(tun->dev, "unexpected GSO type: 0x%x, gso_size %d, hdr_len %d\n",
> -					   sinfo->gso_type, tun16_to_cpu(tun, gso.gso_size),
> -					   tun16_to_cpu(tun, gso.hdr_len));
> +					   sinfo->gso_type, tun16_to_cpu(flags, gso.gso_size),
> +					   tun16_to_cpu(flags, gso.hdr_len));
>  				print_hex_dump(KERN_ERR, "tun: ",
>  					       DUMP_PREFIX_NONE,
>  					       16, 1, skb->head,
> -					       min((int)tun16_to_cpu(tun, gso.hdr_len), 64), true);
> +					       min((int)tun16_to_cpu(flags, gso.hdr_len), 64), true);
>  			}
>  			WARN_ON_ONCE(1);
>  			return -EINVAL;
> @@ -2493,7 +2494,7 @@ static int tun_xdp_one(struct tun_struct *tun,
>  	skb_reserve(skb, xdp->data - xdp->data_hard_start);
>  	skb_put(skb, xdp->data_end - xdp->data);
>  
> -	if (virtio_net_hdr_to_skb(skb, gso, tun_is_little_endian(tun))) {
> +	if (virtio_net_hdr_to_skb(skb, gso, tun_is_little_endian(tun->flags))) {
>  		atomic_long_inc(&tun->rx_frame_errors);
>  		kfree_skb(skb);
>  		ret = -EINVAL;
> @@ -3322,11 +3323,11 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
>  		break;
>  
>  	case TUNGETVNETBE:
> -		ret = tun_get_vnet_be(tun, argp);
> +		ret = tun_get_vnet_be(tun->flags, argp);
>  		break;
>  
>  	case TUNSETVNETBE:
> -		ret = tun_set_vnet_be(tun, argp);
> +		ret = tun_set_vnet_be(&tun->flags, argp);
>  		break;
>  
>  	case TUNATTACHFILTER:
> 
> -- 
> 2.47.1
> 


