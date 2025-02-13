Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCDDC207E1F
	for <virtualization@lists.linux-foundation.org>; Thu, 13 Feb 2025 07:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739431134; cv=none; b=TwPoDO+rbsn1VY9vLt3PDMl3lPxe+z7K73VPR4eeSpSFGI5fNzGuA5LUYY2dEZgI8zqSFTSqJTLn8xWwCW8rWEfFn4CUPjw6I0rkDwl1oIZZRSKha8mIGlv49mDGxRDu2UTjZrVMjfRGPsIvx+gzqv4veKnyoa/aHCympKrNnro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739431134; c=relaxed/simple;
	bh=ChdgDERxAxY49dY+v2WN3IknGnz2iHnVVF3p+KAYzZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ccUkdXTi4yzWT5ElEliFVg2Jf/vSyGn93iscQLN48LwH8WnLNujmMQCdAkudi+Gie0zEt1YsptBy8dbdfCV9Ev0QwQF7Ebnvi6ThmTV4UdDwkk3jf7lNNjzMzNJzTfgzjnb56pYOg9xW965EElXcwGIXGY+QGjul9+98GbTBFQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IoWpDHqd; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IoWpDHqd"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4C7F3837A1
	for <virtualization@lists.linux-foundation.org>; Thu, 13 Feb 2025 07:18:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.793
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8H5GFnPt0Y6P for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Feb 2025 07:18:51 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 5A7158378C
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5A7158378C
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IoWpDHqd
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5A7158378C
	for <virtualization@lists.linux-foundation.org>; Thu, 13 Feb 2025 07:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739431129;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b2mPsKeDzh/gxf+lp5u5vn3UpATZaOjxGN8wZ5/rHhc=;
	b=IoWpDHqdfrkBB/f/Ad0+8tYwBRdptrZCYTZ21t9Kt/ucrkYOqfPFjtDL74aaKoO5H1pE5B
	HHs3ekEyacsVr6HYh4k39/7voNJkUWcAS02ARWrJcSuKkUYUt/hNH2+ciJelzbYJQu7GG3
	lmFd5bOW/7OB9cvdvKldnZ6+MTi/GOk=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-170-FlwBBmJDP4u4BWaOavdxDA-1; Thu, 13 Feb 2025 02:18:47 -0500
X-MC-Unique: FlwBBmJDP4u4BWaOavdxDA-1
X-Mimecast-MFC-AGG-ID: FlwBBmJDP4u4BWaOavdxDA_1739431127
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5d9fb24f87bso493139a12.0
        for <virtualization@lists.linux-foundation.org>; Wed, 12 Feb 2025 23:18:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739431126; x=1740035926;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b2mPsKeDzh/gxf+lp5u5vn3UpATZaOjxGN8wZ5/rHhc=;
        b=Y93llQxdscKeaD+JiKNbgLM+LNDDBbhavNvzJsn5+0NHb1B8rMTmpaBrck3kMYbywR
         jv2w4yYZ0sfrxU5PNO9AYeBRR7FRklc+xNPnMqgMbTGNMztb+KLvBFf33p+UzOKL3Bxo
         XdwJphcA6vr1PEnnvheUuekWKvA7f2PdlV3UI0fVhyeW7/8HNP8PsGCrGmj2z0ie/9Z3
         jY6UAmS5ZxVUMyBNquQ19MAG8NWffkp4dUZT7pHXul/DOqLnk7zd4OC7ANQsGJW2BBTG
         VRBPpbTSn0v6dFHveGd+8ip2yHdkJywBKUFLY3H1gDh8tkQZLf3/f4v6xlEAhbb67X/O
         iR1A==
X-Forwarded-Encrypted: i=1; AJvYcCXojdva9OgRb8DOh+5neEWrxE3+Y5uokIPeJTzEioHTi9g+9E8pSNJVG1FNMq2MEvI9ecvUlW8W73/saTp1pw==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yw7IHXpziJum4l72tQzljp9RC5P2CMl67q6OsqBrblLnvSoo+QH
	7AJc6g7EmMxccatPIsbEbbooZVFNP+5+SrPwvwUlDwEDmy7wd/Dk3Bt8iLk0riGv4/j9O5r9Jf4
	vyGaY0Fv/KcFKlczGa2cMPJaJBcsX6OWeQEvUD9FSweznw3mcIuWQVVz+dUXetm1mVRnA8poVeq
	Vu0wc=
X-Gm-Gg: ASbGnctejLXH/JmXBAThu42QWenVyp3FBPVu4Fz1W+s/jWuKRpM5M8zd90+WHv7fX8w
	08K9A4ZsBUcZ4nMUEGkxE5XAqLFwV7kIlXLB1B77JLu9RoXfLyBk5OnyXpciIUeCQUyLcwjof1Z
	4l1sqTqdlIiep8KP/uea13wxcOxDG40skpJd5iC23itTk6T0gxpsoBP0LxaDuSl7A8VdzR1prLn
	PyP2H/2CIJFlYH4OBa61a6uJaXUDffr4MNvxCee+71qhsY505xj8AtgMJo1KavaZZcB+rdvkw==
X-Received: by 2002:a05:6402:4316:b0:5d0:cfdd:2ac1 with SMTP id 4fb4d7f45d1cf-5deadd7b874mr6281554a12.6.1739431126515;
        Wed, 12 Feb 2025 23:18:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEW3dzz4GC0XINK0kmKeWK7mkdp+xAoG7xnRiNVKpnkfhaNZCHX7+nWUVopuAQVF8sBoIRGYA==
X-Received: by 2002:a05:6402:4316:b0:5d0:cfdd:2ac1 with SMTP id 4fb4d7f45d1cf-5deadd7b874mr6281534a12.6.1739431126110;
        Wed, 12 Feb 2025 23:18:46 -0800 (PST)
Received: from redhat.com ([2a02:14f:179:fdf4:7340:1015:94e8:5ba3])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dece1c4692sm674233a12.31.2025.02.12.23.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 23:18:45 -0800 (PST)
Date: Thu, 13 Feb 2025 02:18:39 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
	linux-kselftest@vger.kernel.org,
	Yuri Benditovich <yuri.benditovich@daynix.com>,
	Andrew Melnychenko <andrew@daynix.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	gur.stavi@huawei.com, devel@daynix.com
Subject: Re: [PATCH net-next] tun: Pad virtio headers
Message-ID: <20250213020702-mutt-send-email-mst@kernel.org>
References: <20250213-buffers-v1-1-ec4a0821957a@daynix.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250213-buffers-v1-1-ec4a0821957a@daynix.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: hudDeMkHXKDlxzOeNBrVnvZ0aX-7IATcHGmeTSRdHY0_1739431127
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Commit log needs some work.

So my understanding is, this patch does not do much functionally,
but makes adding the hash feature easier. OK.

On Thu, Feb 13, 2025 at 03:54:06PM +0900, Akihiko Odaki wrote:
> tun used to simply advance iov_iter when it needs to pad virtio header,
> which leaves the garbage in the buffer as is. This is especially
> problematic

I think you mean "this will become especially problematic"

> when tun starts to allow enabling the hash reporting
> feature; even if the feature is enabled, the packet may lack a hash
> value and may contain a hole in the virtio header because the packet
> arrived before the feature gets enabled or does not contain the
> header fields to be hashed. If the hole is not filled with zero, it is
> impossible to tell if the packet lacks a hash value.
> 
> In theory, a user of tun can fill the buffer with zero before calling
> read() to avoid such a problem, but leaving the garbage in the buffer is
> awkward anyway so fill the buffer in tun.


What is missing here is description of what the patch does.
I think it is
"Replace advancing the iterator with writing zeros".

There could be performance cost to the dirtying extra cache lines, though.
Could you try checking that please?

I think we should mention the risks of the patch, too.
Maybe:

	Also in theory, a user might have initialized the buffer
	to some non-zero value, expecting tun to skip writing it.
	As this was never a documented feature, this seems unlikely.


> 
> The specification also says the device MUST set num_buffers to 1 when
> the field is present so set it when the specified header size is big
> enough to contain the field.

This part I dislike. tun has no idea what the number of buffers is.
Why 1 specifically?


> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  drivers/net/tap.c      |  2 +-
>  drivers/net/tun.c      |  6 ++++--
>  drivers/net/tun_vnet.h | 14 +++++++++-----
>  3 files changed, 14 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/tap.c b/drivers/net/tap.c
> index 1287e241f4454fb8ec4975bbaded5fbaa88e3cc8..d96009153c316f669e626d95002e5fe8add3a1b2 100644
> --- a/drivers/net/tap.c
> +++ b/drivers/net/tap.c
> @@ -711,7 +711,7 @@ static ssize_t tap_put_user(struct tap_queue *q,
>  	int total;
>  
>  	if (q->flags & IFF_VNET_HDR) {
> -		struct virtio_net_hdr vnet_hdr;
> +		struct virtio_net_hdr_v1 vnet_hdr;
>  
>  		vnet_hdr_len = READ_ONCE(q->vnet_hdr_sz);
>  
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index b14231a743915c2851eaae49d757b763ec4a8841..a3aed7e42c63d8b8f523c0141c7d970ab185178c 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -1987,7 +1987,9 @@ static ssize_t tun_put_user_xdp(struct tun_struct *tun,
>  	ssize_t ret;
>  
>  	if (tun->flags & IFF_VNET_HDR) {
> -		struct virtio_net_hdr gso = { 0 };
> +		struct virtio_net_hdr_v1 gso = {
> +			.num_buffers = cpu_to_tun_vnet16(tun->flags, 1)
> +		};
>  
>  		vnet_hdr_sz = READ_ONCE(tun->vnet_hdr_sz);
>  		ret = tun_vnet_hdr_put(vnet_hdr_sz, iter, &gso);
> @@ -2040,7 +2042,7 @@ static ssize_t tun_put_user(struct tun_struct *tun,
>  	}
>  
>  	if (vnet_hdr_sz) {
> -		struct virtio_net_hdr gso;
> +		struct virtio_net_hdr_v1 gso;
>  
>  		ret = tun_vnet_hdr_from_skb(tun->flags, tun->dev, skb, &gso);
>  		if (ret)
> diff --git a/drivers/net/tun_vnet.h b/drivers/net/tun_vnet.h
> index fd7411c4447ffb180e032fe3e22f6709c30da8e9..b4f406f522728f92266898969831c26a87930f6a 100644
> --- a/drivers/net/tun_vnet.h
> +++ b/drivers/net/tun_vnet.h
> @@ -135,15 +135,17 @@ static inline int tun_vnet_hdr_get(int sz, unsigned int flags,
>  }
>  
>  static inline int tun_vnet_hdr_put(int sz, struct iov_iter *iter,
> -				   const struct virtio_net_hdr *hdr)
> +				   const struct virtio_net_hdr_v1 *hdr)
>  {
> +	int content_sz = MIN(sizeof(*hdr), sz);
> +
>  	if (unlikely(iov_iter_count(iter) < sz))
>  		return -EINVAL;
>  
> -	if (unlikely(copy_to_iter(hdr, sizeof(*hdr), iter) != sizeof(*hdr)))
> +	if (unlikely(copy_to_iter(hdr, content_sz, iter) != content_sz))
>  		return -EFAULT;
>  
> -	iov_iter_advance(iter, sz - sizeof(*hdr));
> +	iov_iter_zero(sz - content_sz, iter);
>  
>  	return 0;
>  }
> @@ -157,11 +159,11 @@ static inline int tun_vnet_hdr_to_skb(unsigned int flags, struct sk_buff *skb,
>  static inline int tun_vnet_hdr_from_skb(unsigned int flags,
>  					const struct net_device *dev,
>  					const struct sk_buff *skb,
> -					struct virtio_net_hdr *hdr)
> +					struct virtio_net_hdr_v1 *hdr)
>  {
>  	int vlan_hlen = skb_vlan_tag_present(skb) ? VLAN_HLEN : 0;
>  
> -	if (virtio_net_hdr_from_skb(skb, hdr,
> +	if (virtio_net_hdr_from_skb(skb, (struct virtio_net_hdr *)hdr,
>  				    tun_vnet_is_little_endian(flags), true,
>  				    vlan_hlen)) {
>  		struct skb_shared_info *sinfo = skb_shinfo(skb);
> @@ -179,6 +181,8 @@ static inline int tun_vnet_hdr_from_skb(unsigned int flags,
>  		return -EINVAL;
>  	}
>  
> +	hdr->num_buffers = cpu_to_tun_vnet16(flags, 1);
> +
>  	return 0;
>  }
>  
> 
> ---
> base-commit: f54eab84fc17ef79b701e29364b7d08ca3a1d2f6
> change-id: 20250116-buffers-96e14bf023fc
> prerequisite-change-id: 20241230-tun-66e10a49b0c7:v6
> prerequisite-patch-id: 871dc5f146fb6b0e3ec8612971a8e8190472c0fb
> prerequisite-patch-id: 2797ed249d32590321f088373d4055ff3f430a0e
> prerequisite-patch-id: ea3370c72d4904e2f0536ec76ba5d26784c0cede
> prerequisite-patch-id: 837e4cf5d6b451424f9b1639455e83a260c4440d
> prerequisite-patch-id: ea701076f57819e844f5a35efe5cbc5712d3080d
> prerequisite-patch-id: 701646fb43ad04cc64dd2bf13c150ccbe6f828ce
> prerequisite-patch-id: 53176dae0c003f5b6c114d43f936cf7140d31bb5
> 
> Best regards,
> -- 
> Akihiko Odaki <akihiko.odaki@daynix.com>

