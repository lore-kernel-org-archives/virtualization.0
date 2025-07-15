Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41C4213E7A
	for <virtualization@lists.linux.dev>; Tue, 15 Jul 2025 09:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752573428; cv=none; b=Krfk5181McOfO6gEU5jw/avq/w9rM971ypF89WbJiE7GMBhkaLiBO3D5+whxzeUFP8vSBQeSXgW9mSYbZKm5YAsNcfqGmCE+sxsmOxmFGc5rT0zWfwaRaXI5PloC7viDTz65v1f/NC7Nlg42atD/IvzTtEF7nj8zxvgpKc5mIhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752573428; c=relaxed/simple;
	bh=GTkmoLyiu/GJjZVIYcBGrKULeDnljvGjgDN6z5K2onc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ip820AvkGz9PbDDWVGgbEg4gP2xrjYgZg/BVPC1f5mVeuFPoxpSrd/vTWTPne6/zbpzVMmuBe3CIZyMqjtv8niDRvGHBHqGiW7FmH6aDhiBoM6XjRB21GLZpWQ+Qjh+g+1/diaFlSmlL9Ce9e/MoVV68a86zJQk0DkApu27JaiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qqs6EJ4o; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qqs6EJ4o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752573425;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EsjnNQfJ6mAkewo+n/SUTwvK6JE8ja4wWBuZ4cMAwJg=;
	b=Qqs6EJ4oef1l+NOcDZgjTRO9PzWFYAyZ+j5wnpLBG6tYXJ0oE+AugHDjXh14qc/QvdO6gM
	O/bXewH3RHyEAjU3hiOd651KBEkdsgFEoE8W1vwe2tzOcK+XMPEI+bRPzE8T91aA3QcZaS
	PiZlj6MKbjtS7iXKgtVUJt7usklKZfc=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-EPZ7aUeBMLC7Axp3dkBjTg-1; Tue, 15 Jul 2025 05:56:59 -0400
X-MC-Unique: EPZ7aUeBMLC7Axp3dkBjTg-1
X-Mimecast-MFC-AGG-ID: EPZ7aUeBMLC7Axp3dkBjTg_1752573419
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7e33d32c501so57345285a.3
        for <virtualization@lists.linux.dev>; Tue, 15 Jul 2025 02:56:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752573419; x=1753178219;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EsjnNQfJ6mAkewo+n/SUTwvK6JE8ja4wWBuZ4cMAwJg=;
        b=PqaqxG/bzxOdkB/UGUxUm+vk6Vjyy8LHcBxyCRFe6MVh5S1oe0bVGG7ETIkIRVuU2M
         cHSQ0NnmpiTlBkjgxr5zogNsHKw4lKyKTjetLQZM84PlhwfQEB7PfJmfKVIooRIUBNfD
         xVijjKHk8Ge3t6XuqwPfbSkwB50jJXhyLY96CDlWxIlzjI8zruOzbtppAh9GtMLN3Ujl
         HN3g/z33QXiABZyIE+U+ynGo1ko/df+RV2xxGyVqeR2EGvMU5K1yRYtZowTjAtS+z47V
         pM6iZ9zwV+9mOc88SgkvjLUqkVXuklpDW7IhQHWKaYtQR3tHfWxprItArRv7ZUVIn9Iw
         cqwg==
X-Forwarded-Encrypted: i=1; AJvYcCUpIvqgGS5beHPBz3D2PRRrws+b/hBZhosH8kzpo4gGv3L10qYIiamvRiLec2dEyMWl8Rea6t5XzuqJppZzZw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz5PKel08W6bYOksOPUSYuLTNUomMTk0CSRyNEOAx08NHRNz9lF
	xpdZXVfFSJuNoeIG0paa3Hb02Iqqz4CSSXLRVhwXh2Kehxri5C0db+AoGpAiHrHOes+AL2UVEnT
	Eyf19Xe1iz6BDr+IlwLSVWEA0vW+Xc5r969dHluifDN0jXFxpIuup27a181GRlTXsRm0YMYvjrY
	KU
X-Gm-Gg: ASbGnctK1NiPU9FMcejw5Nh7ScWRpvDsPPAQfmaI0pCbVKbDNmgPcjRgSqxG9Yb+8pw
	muSNsGjF+nrWDyiDylMVd2qaz91/6aLVmZbDYsJD4QDobsdac/LgJFp/G+Hxdnxfm3lmpizghek
	PdRhr+3LuTQ9J4YICzqIcwrawKcONt/4HbF9dfyM/3YKY2M6j5medBqGdfmnHKkriSjQl8JPHLd
	aVCmuYoJQDG+p866ltQKRBEZ6K5I3VhgkWQJ5g+WxJk3BNEewE8TVvYdVPWV/9v1ioxv8kiGFcR
	6gGLINzQY2Stqi2rlw9K9e2LOR4IsWB0SpmR8MFWlg==
X-Received: by 2002:a05:620a:4544:b0:7d3:8ca0:65c6 with SMTP id af79cd13be357-7ddea60f268mr2162300585a.20.1752573418493;
        Tue, 15 Jul 2025 02:56:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFoYyKYcEuilw8G0A/GVrUc5/QquW6KQ2Wasy0gXOfk/DlYj91vAPMPzfdBpSrzjF93b3y3YA==
X-Received: by 2002:a05:620a:4544:b0:7d3:8ca0:65c6 with SMTP id af79cd13be357-7ddea60f268mr2162298885a.20.1752573418062;
        Tue, 15 Jul 2025 02:56:58 -0700 (PDT)
Received: from sgarzare-redhat ([5.179.142.44])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e1ddbde3ffsm283891485a.76.2025.07.15.02.56.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 02:56:57 -0700 (PDT)
Date: Tue, 15 Jul 2025 11:56:51 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, Keir Fraser <keirf@google.com>, 
	Steven Moreland <smoreland@google.com>, Frederick Mayle <fmayle@google.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	netdev@vger.kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH v3 5/9] vsock/virtio: Rename virtio_vsock_alloc_skb()
Message-ID: <6vknr2ruy4cu3kdxdt2zcigm3jyex5ntxqbqnxe4cbf2uci247@6opbwa5o6rk3>
References: <20250714152103.6949-1-will@kernel.org>
 <20250714152103.6949-6-will@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250714152103.6949-6-will@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ILwgH3NGhxF4ghDX_yNIelTi-PHJkbxGcPnc90bkAeQ_1752573419
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Mon, Jul 14, 2025 at 04:20:59PM +0100, Will Deacon wrote:
>In preparation for nonlinear allocations for large SKBs, rename
>virtio_vsock_alloc_skb() to virtio_vsock_alloc_linear_skb() to indicate
>that it returns linear SKBs unconditionally and switch all callers over
>to this new interface for now.
>
>No functional change.
>
>Signed-off-by: Will Deacon <will@kernel.org>
>---
> drivers/vhost/vsock.c                   | 2 +-
> include/linux/virtio_vsock.h            | 3 ++-
> net/vmw_vsock/virtio_transport.c        | 2 +-
> net/vmw_vsock/virtio_transport_common.c | 2 +-
> 4 files changed, 5 insertions(+), 4 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>index 4c4a642945eb..1ad96613680e 100644
>--- a/drivers/vhost/vsock.c
>+++ b/drivers/vhost/vsock.c
>@@ -348,7 +348,7 @@ vhost_vsock_alloc_skb(struct vhost_virtqueue *vq,
> 		return NULL;
>
> 	/* len contains both payload and hdr */
>-	skb = virtio_vsock_alloc_skb(len, GFP_KERNEL);
>+	skb = virtio_vsock_alloc_linear_skb(len, GFP_KERNEL);
> 	if (!skb)
> 		return NULL;
>
>diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
>index 879f1dfa7d3a..4504ea29ff82 100644
>--- a/include/linux/virtio_vsock.h
>+++ b/include/linux/virtio_vsock.h
>@@ -52,7 +52,8 @@ static inline void virtio_vsock_skb_rx_put(struct sk_buff *skb, u32 len)
> 	skb_put(skb, len);
> }
>
>-static inline struct sk_buff *virtio_vsock_alloc_skb(unsigned int size, gfp_t mask)
>+static inline struct sk_buff *
>+virtio_vsock_alloc_linear_skb(unsigned int size, gfp_t mask)
> {
> 	struct sk_buff *skb;
>
>diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>index 5416214ae666..c983fd62e37a 100644
>--- a/net/vmw_vsock/virtio_transport.c
>+++ b/net/vmw_vsock/virtio_transport.c
>@@ -316,7 +316,7 @@ static void virtio_vsock_rx_fill(struct virtio_vsock *vsock)
> 	vq = vsock->vqs[VSOCK_VQ_RX];
>
> 	do {
>-		skb = virtio_vsock_alloc_skb(total_len, GFP_KERNEL);
>+		skb = virtio_vsock_alloc_linear_skb(total_len, GFP_KERNEL);
> 		if (!skb)
> 			break;
>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index 1b5d9896edae..c9eb7f7ac00d 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -261,7 +261,7 @@ static struct sk_buff *virtio_transport_alloc_skb(struct virtio_vsock_pkt_info *
> 	if (!zcopy)
> 		skb_len += payload_len;
>
>-	skb = virtio_vsock_alloc_skb(skb_len, GFP_KERNEL);
>+	skb = virtio_vsock_alloc_linear_skb(skb_len, GFP_KERNEL);
> 	if (!skb)
> 		return NULL;
>
>-- 
>2.50.0.727.gbf7dc18ff4-goog
>

