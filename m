Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE1F2147EC
	for <virtualization@lists.linux-foundation.org>; Thu,  9 Jan 2025 07:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736407952; cv=none; b=cQxhrw0P8wY+CtfTLyYIZdutMxCOzG3HnqCYp4oOxTOziA4n3MgBqyYstA3CSn8KQAJWlN0NRyzefHKXEidjtoMhfaeUfpF67X/fiAZprlfNcud/7J7VePFXq9+fU57H6u7igVcImkVa1srVi/P/ZTicI4D6fLbXcCQ0O1GbOEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736407952; c=relaxed/simple;
	bh=5UbUHUDUA55r0nK5d8Jha5yrj/zO4cmMTkO+X7Cu5xY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Swf9DW1+OcJp6aTXhwp7/WXLhF2VqldCt5Dk69K5m+yY1Pzu8VGW05pHUkmnfsvmG8RLWQyOfIcvtc9OPB6bku5TuzTBccU1NButFrn/uIqCYVBJpIkHxmbS/CIgmK7xlIWOskdM27wzokUvwqR3cpj2uq5XQLsVaVR4L4R20AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eRUXNw7r; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eRUXNw7r"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 27B75608A0
	for <virtualization@lists.linux-foundation.org>; Thu,  9 Jan 2025 07:32:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.793
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aHW3QHYYE3W5 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Jan 2025 07:32:30 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 305F4605E4
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 305F4605E4
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eRUXNw7r
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 305F4605E4
	for <virtualization@lists.linux-foundation.org>; Thu,  9 Jan 2025 07:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736407948;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JXSR6q6tyKylmweELFbBP+9GVq64q77ZdCgNpskFR5E=;
	b=eRUXNw7rSVjxSZFPKHJu/XNPnO3TVWaRt/sIQMVXy9gHNYWlh4/Qu3s/Ctq0GxdSdY+aTe
	nZIMOu7hDkn3PObCF1zxMbXmsLgFTcnEYFzi/UOc8cQB8Xn/hXrJy6+7Dzg8umEhQb77bk
	0exx33Yq+g1DqvXwOaIVIzPuA2q6mX8=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-20-sy9HRnnvP4qRfPPjnMRroA-1; Thu, 09 Jan 2025 02:32:27 -0500
X-MC-Unique: sy9HRnnvP4qRfPPjnMRroA-1
X-Mimecast-MFC-AGG-ID: sy9HRnnvP4qRfPPjnMRroA
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-aa68b4b957fso58929466b.3
        for <virtualization@lists.linux-foundation.org>; Wed, 08 Jan 2025 23:32:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736407946; x=1737012746;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JXSR6q6tyKylmweELFbBP+9GVq64q77ZdCgNpskFR5E=;
        b=oZ8KEv/4vZNdDAvzidmCM1Hw32Uf/9HI3IND8ddjYeZT0HmHr5I45u16DpbLKmbp37
         LD3HO5THuCmql2llDy/dwC/8cg4A2Xwq6o8FKbZk/6s7WyH3X5N9epLqhVPjUxVRA7OK
         f9q/LBmsyarM3q83bcvjIajxGMTNTJrF9OsviexxWgG1VXbpi+cEt45wZOy6P1o6R0+7
         IBe5nnT0Lg75pt5OyMBIKRmFTjmdedsqgMASwPEAmDYgPD2eTrnYEVT9YgqgYUyQzu4L
         lEXympDQZx0DPiQcrWXDPOfkkI41nIKjn97g1bMOFRiq57N4DC3fDFBpPG50Bjki9JWq
         lyqA==
X-Forwarded-Encrypted: i=1; AJvYcCXxpwWLTLibGCvMZE2WXFXGWOnG1T0pN0CULjRMtygCaLUZG9cR2S/wuqF0Hu4XE3S0y+76dM3lLw9x+1jQlQ==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YwinOVN3zgVBuagWEtPGpb7NoW0TkbPDbOuNnybUWF1Mau6VPm7
	HQzRMsc4JvqzoQO8BAZE08jw8oksqw8C2ZBXbSVD2m2GgpxaJGmwK1kxhUiotvdOPZRH2w89X0g
	u7uQi2O7rDI0HVRE42Gj7nUg51oNjk7a0M+2X3j1XaSWsrVrUhPN56EIVuNCd9jLEp3RIw9lF69
	r6+b4=
X-Gm-Gg: ASbGncvaRkgUpLd2hH9cZxq2CYONA1YM+k0HumEZp5BVZiJUh/gkMYfDw/0fgD20QLJ
	VNEniBClzlDAMr3kbstZSYKyX2AM7P1pBuzxl08q3ePr90Ti8Y4JmQou/8Nlm4tVpUM5bxhalLq
	ZbMhYYn1IQ2vkyu9iO8EKPeNXsbg+R9SYl4pKwroX01ez5dj//yL2OtdN80+NhgYZDeUiR3h+ab
	dFOHfu4LMwXga9e4KdgtRhhv8IrzmIZvXxeHkc9dAM5F+NsV98=
X-Received: by 2002:a17:907:3687:b0:aa6:7ab4:4597 with SMTP id a640c23a62f3a-ab2abca77a5mr543842566b.39.1736407945897;
        Wed, 08 Jan 2025 23:32:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEhA9sGH/7wRh3dK4PkGB9iJkH6oEUW3xYeKZu2VsLICT8lcRMG971KDIhNk+uyN4aFtn0oSQ==
X-Received: by 2002:a17:907:3687:b0:aa6:7ab4:4597 with SMTP id a640c23a62f3a-ab2abca77a5mr543838266b.39.1736407945404;
        Wed, 08 Jan 2025 23:32:25 -0800 (PST)
Received: from redhat.com ([2a02:14f:175:d62d:93ef:d7e2:e7da:ed72])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c95b0ab6sm41300766b.155.2025.01.08.23.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 23:32:24 -0800 (PST)
Date: Thu, 9 Jan 2025 02:32:18 -0500
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
Subject: Re: [PATCH v2 3/3] tun: Set num_buffers for virtio 1.0
Message-ID: <20250109023144-mutt-send-email-mst@kernel.org>
References: <20250109-tun-v2-0-388d7d5a287a@daynix.com>
 <20250109-tun-v2-3-388d7d5a287a@daynix.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250109-tun-v2-3-388d7d5a287a@daynix.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Sni1uvW4NpG1_IiI9bCDNtkmCRNS2PnzyNJpRFkru_k_1736407946
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 09, 2025 at 03:58:45PM +0900, Akihiko Odaki wrote:
> The specification says the device MUST set num_buffers to 1 if
> VIRTIO_NET_F_MRG_RXBUF has not been negotiated.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>


How do we know this is v1 and not v0? Confused.

> ---
>  drivers/net/tap.c      |  2 +-
>  drivers/net/tun.c      |  6 ++++--
>  drivers/net/tun_vnet.c | 14 +++++++++-----
>  drivers/net/tun_vnet.h |  4 ++--
>  4 files changed, 16 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/net/tap.c b/drivers/net/tap.c
> index 60804855510b..fe9554ee5b8b 100644
> --- a/drivers/net/tap.c
> +++ b/drivers/net/tap.c
> @@ -713,7 +713,7 @@ static ssize_t tap_put_user(struct tap_queue *q,
>  	int total;
>  
>  	if (q->flags & IFF_VNET_HDR) {
> -		struct virtio_net_hdr vnet_hdr;
> +		struct virtio_net_hdr_v1 vnet_hdr;
>  
>  		vnet_hdr_len = READ_ONCE(q->vnet_hdr_sz);
>  
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index dbf0dee92e93..f211d0580887 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -1991,7 +1991,9 @@ static ssize_t tun_put_user_xdp(struct tun_struct *tun,
>  	size_t total;
>  
>  	if (tun->flags & IFF_VNET_HDR) {
> -		struct virtio_net_hdr gso = { 0 };
> +		struct virtio_net_hdr_v1 gso = {
> +			.num_buffers = __virtio16_to_cpu(true, 1)
> +		};
>  
>  		vnet_hdr_sz = READ_ONCE(tun->vnet_hdr_sz);
>  		ret = tun_vnet_hdr_put(vnet_hdr_sz, iter, &gso);
> @@ -2044,7 +2046,7 @@ static ssize_t tun_put_user(struct tun_struct *tun,
>  	}
>  
>  	if (vnet_hdr_sz) {
> -		struct virtio_net_hdr gso;
> +		struct virtio_net_hdr_v1 gso;
>  
>  		ret = tun_vnet_hdr_from_skb(tun->flags, tun->dev, skb, &gso);
>  		if (ret < 0)
> diff --git a/drivers/net/tun_vnet.c b/drivers/net/tun_vnet.c
> index ffb2186facd3..a7a7989fae56 100644
> --- a/drivers/net/tun_vnet.c
> +++ b/drivers/net/tun_vnet.c
> @@ -130,15 +130,17 @@ int tun_vnet_hdr_get(int sz, unsigned int flags, struct iov_iter *from,
>  EXPORT_SYMBOL_GPL(tun_vnet_hdr_get);
>  
>  int tun_vnet_hdr_put(int sz, struct iov_iter *iter,
> -		     const struct virtio_net_hdr *hdr)
> +		     const struct virtio_net_hdr_v1 *hdr)
>  {
> +	int content_sz = MIN(sizeof(*hdr), sz);
> +
>  	if (iov_iter_count(iter) < sz)
>  		return -EINVAL;
>  
> -	if (copy_to_iter(hdr, sizeof(*hdr), iter) != sizeof(*hdr))
> +	if (copy_to_iter(hdr, content_sz, iter) != content_sz)
>  		return -EFAULT;
>  
> -	if (iov_iter_zero(sz - sizeof(*hdr), iter) != sz - sizeof(*hdr))
> +	if (iov_iter_zero(sz - content_sz, iter) != sz - content_sz)
>  		return -EFAULT;
>  
>  	return 0;
> @@ -154,11 +156,11 @@ EXPORT_SYMBOL_GPL(tun_vnet_hdr_to_skb);
>  
>  int tun_vnet_hdr_from_skb(unsigned int flags, const struct net_device *dev,
>  			  const struct sk_buff *skb,
> -			  struct virtio_net_hdr *hdr)
> +			  struct virtio_net_hdr_v1 *hdr)
>  {
>  	int vlan_hlen = skb_vlan_tag_present(skb) ? VLAN_HLEN : 0;
>  
> -	if (virtio_net_hdr_from_skb(skb, hdr,
> +	if (virtio_net_hdr_from_skb(skb, (struct virtio_net_hdr *)hdr,
>  				    tun_vnet_is_little_endian(flags), true,
>  				    vlan_hlen)) {
>  		struct skb_shared_info *sinfo = skb_shinfo(skb);
> @@ -176,6 +178,8 @@ int tun_vnet_hdr_from_skb(unsigned int flags, const struct net_device *dev,
>  		return -EINVAL;
>  	}
>  
> +	hdr->num_buffers = 1;
> +
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(tun_vnet_hdr_from_skb);
> diff --git a/drivers/net/tun_vnet.h b/drivers/net/tun_vnet.h
> index 2dfdbe92bb24..d8fd94094227 100644
> --- a/drivers/net/tun_vnet.h
> +++ b/drivers/net/tun_vnet.h
> @@ -12,13 +12,13 @@ int tun_vnet_hdr_get(int sz, unsigned int flags, struct iov_iter *from,
>  		     struct virtio_net_hdr *hdr);
>  
>  int tun_vnet_hdr_put(int sz, struct iov_iter *iter,
> -		     const struct virtio_net_hdr *hdr);
> +		     const struct virtio_net_hdr_v1 *hdr);
>  
>  int tun_vnet_hdr_to_skb(unsigned int flags, struct sk_buff *skb,
>  			const struct virtio_net_hdr *hdr);
>  
>  int tun_vnet_hdr_from_skb(unsigned int flags, const struct net_device *dev,
>  			  const struct sk_buff *skb,
> -			  struct virtio_net_hdr *hdr);
> +			  struct virtio_net_hdr_v1 *hdr);
>  
>  #endif /* TUN_VNET_H */
> 
> -- 
> 2.47.1

