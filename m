Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED3436827C
	for <virtualization@lists.linux.dev>; Wed, 19 Nov 2025 16:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763571126; cv=none; b=kEgi2zKWINpOiMHoZeKyDCcxOjMOFIIg94g/whamwhABhuaUm+93hiIqYhgOm7/1SVLl8UlV3S04Trc6kkAQ6IT2YoaNvfizRiOVE16cAVGJ61CtKvhTSuokwBb7ZXMGkB1pxSsF8E39KVdYF/4bt3EPNI8RBqgbzXbN5azhR/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763571126; c=relaxed/simple;
	bh=4ioazr+rErlQAmgFmhcgugwx4ST9WMu2Co1jE6pk2p8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=O45Rjfjjp6hAWhTe7s/tYB3un4qkAqphT3cpUM/oIDNx4zmH7LOYWWvYcNuSSHddVPjz0sPBt/bNOZS4fyiY9i6fxs7NrZz0GdnvJ8L2OnOQJUcja2WbuTea+IU7pkDWlUu5Vm5PBNCxZuAKLTL7yTy48uA+K+nWmT4HGKm9mvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iMMUe6L7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iMMUe6L7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763571123;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uGDdV1wZzMygZPXUS+BFjZbrrq0xn6nPN5Vu0ZlXeto=;
	b=iMMUe6L7Z8Gt9BQpUqlpF01jO/5Ys3vXbcXJUHd8/cW1svteDkyFDOvycbEoVCf6PXQ2yL
	Aqdg2eYuemOREjUn6HSugHkE/CRMzuLBXiwVhJIMxYif/dAE2TBFiUztOCdqrN4XEdk4RM
	mzoL5p1+r/3epNgpqvMZXMv0GOgGPS0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-480-AJU8BRZmPQWboJgl8sq05w-1; Wed, 19 Nov 2025 11:52:02 -0500
X-MC-Unique: AJU8BRZmPQWboJgl8sq05w-1
X-Mimecast-MFC-AGG-ID: AJU8BRZmPQWboJgl8sq05w_1763571121
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-47797caba11so21855655e9.3
        for <virtualization@lists.linux.dev>; Wed, 19 Nov 2025 08:52:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763571121; x=1764175921;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uGDdV1wZzMygZPXUS+BFjZbrrq0xn6nPN5Vu0ZlXeto=;
        b=JVPbg5lDtcEeFmygLp55Gvs0wpP60j/z1SD2pB2/YiEJHHtqeaBiQk0FK1h2Xwp9VE
         +ctYGMbwXocp1jInUNFMxbNvKFE8CW5MqDIGF+hIppbrfFCrsi1s9rGkYDdhhljwGkoE
         mYgcQ9oLNmNr8x4u7iObFgcrrB5bsITYVdqbabNhb6iet84+HjheNK7J/qt0yXJrn0bV
         NcMYnILBmQpgU8Z4ZmxuZg5AHd3F+9+C2VUKcYGaM+3dKPlNDDhGzRHDxEtDGo31PomI
         eRRDcGDHW70Wa0RcoLanYezU4V7ODqZbBUJCxLgjnkGCZokXzF4YAO59RLVg7vq+u199
         Pk7g==
X-Forwarded-Encrypted: i=1; AJvYcCVZad2kwhsaEKfYS1Z+pyPx7NLVQHPXWwtcvmg+N0ZEEd5+lMwTXKiXHvNhAHNiYkKiuHAIPq4Qfpe5x+Bimw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyjyCHGegJOlq7+v5vxG9w/xricCgD8it4ju+uW94MoUArTxeXY
	EluIcif3woyj4XWkrS0ivlKJra1nwHyLREq8FD/pSROlSz4GxGWD9kNd9bD3GUWVTsZFArJUaV4
	ixoUZzMr5r50GQBDrfIwoFYwsp9T1yf4WadGYDHWJ1xQgXJeq0a6jFeit1Kt3liHM+NYB
X-Gm-Gg: ASbGncvOgVCx11o/5D3SnYi+EoDIKj9Nd/YxB3YfntuuHlQ0ybDCMQzcxZ42LUV9qtJ
	URG1zG3TRRWKme0VjF/WdCn52D93Frk8yRtkPRprNEMlyQpdAM2axBWtVXnlJ2vnMF0vpT2iQ0D
	Fmj7yH5l9CRd+0m65KDXeFpyXQysrmBXRV3Ta/ZtWA1XW1t0VDqsCVGtG7xZInZa0iymNGmalEF
	gNJi19buKDHPIFkysFZ0KtNNar9RZlpT7UjGF6TY2rNN5VWE/52ZQIUS/7pR+DwnH/7GoTlRfdf
	NyStSh6Aixw6uANWpLyeGxe9jxncOXWTBgH6DUT25/IIIlmNxuhIPGIapYP3PXsZj+0Fyl9YTj6
	jVA1jNa8IM2zc/nBCt3W2X2PmGTVGhg==
X-Received: by 2002:a05:600c:1f88:b0:475:dd8d:2f52 with SMTP id 5b1f17b1804b1-4778fea7579mr172318445e9.32.1763571120721;
        Wed, 19 Nov 2025 08:52:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFkCnAWqylPnRvfnAU1+MUgF93xF234J4nNqKzo6llZD/6bIaoJV/mwKhcnyL5kC1Q0Nvad2w==
X-Received: by 2002:a05:600c:1f88:b0:475:dd8d:2f52 with SMTP id 5b1f17b1804b1-4778fea7579mr172318205e9.32.1763571120251;
        Wed, 19 Nov 2025 08:52:00 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477b0ffef34sm57829355e9.2.2025.11.19.08.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 08:51:59 -0800 (PST)
Date: Wed, 19 Nov 2025 11:51:56 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dan Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
	virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, jgg@ziepe.ca, kevin.tian@intel.com,
	kuba@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com
Subject: Re: [PATCH net-next v11 09/12] virtio_net: Implement IPv4 ethtool
 flow rules
Message-ID: <20251119115113-mutt-send-email-mst@kernel.org>
References: <20251118143903.958844-1-danielj@nvidia.com>
 <20251118143903.958844-10-danielj@nvidia.com>
 <20251118161734-mutt-send-email-mst@kernel.org>
 <20251119041745-mutt-send-email-mst@kernel.org>
 <103955ba-baa7-4b0b-8b9b-f3824ad54b4d@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <103955ba-baa7-4b0b-8b9b-f3824ad54b4d@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: pWyGg8LmIYAn1Z5lNogbjgsb7d1XjSlyCIwuAgstdgc_1763571121
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 19, 2025 at 10:33:31AM -0600, Dan Jurgens wrote:
> On 11/19/25 3:18 AM, Michael S. Tsirkin wrote:
> > On Tue, Nov 18, 2025 at 04:31:09PM -0500, Michael S. Tsirkin wrote:
> >>> +static int setup_ip_key_mask(struct virtio_net_ff_selector *selector,
> >>> +			     u8 *key,
> >>> +			     const struct ethtool_rx_flow_spec *fs)
> >>> +{
> >>> +	struct iphdr *v4_m = (struct iphdr *)&selector->mask;
> >>> +	struct iphdr *v4_k = (struct iphdr *)key;
> >>> +
> >>> +	selector->type = VIRTIO_NET_FF_MASK_TYPE_IPV4;
> >>> +	selector->length = sizeof(struct iphdr);
> >>> +
> >>> +	if (fs->h_u.usr_ip4_spec.l4_4_bytes ||
> >>> +	    fs->h_u.usr_ip4_spec.tos ||
> >>> +	    fs->h_u.usr_ip4_spec.ip_ver != ETH_RX_NFC_IP4)
> >>> +		return -EOPNOTSUPP;
> >>
> >> So include/uapi/linux/ethtool.h says:
> >>
> >>  * struct ethtool_usrip4_spec - general flow specification for IPv4
> >>  * @ip4src: Source host
> >>  * @ip4dst: Destination host
> >>  * @l4_4_bytes: First 4 bytes of transport (layer 4) header
> >>  * @tos: Type-of-service
> >>  * @ip_ver: Value must be %ETH_RX_NFC_IP4; mask must be 0
> >>  * @proto: Transport protocol number; mask must be 0
> >>
> >> I guess this ETH_RX_NFC_IP4 check validates that userspace follows this
> >> documentation? But then shouldn't you check the mask
> >> as well? and mask for proto?
> >>
> >>
> >>
> > 
> > in fact, what if e.g. tos is 0 but mask is non-zero? should not
> > this be rejected, too?
> > 
> 
> Actually the tos check should be removed, there's no guidance it should
> be 0, like the other fields. Our hardware doesn't support it, but this
> will be caught in validate_classifier_selectors.

same question for l4_4_bytes then.

-- 
MST

