Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579442F5082
	for <virtualization@lists.linux.dev>; Wed,  2 Jul 2025 16:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751474456; cv=none; b=haks1LvhSilrA4XKfF28WHpJHFb7MdYTPyLnEtuBi1iAzQPBB5LQXPzyMTaJbKZ1cYSM5iMBEjuoSqPyMDUxdx/f1HcaCG9RP2HFg00+q3IYLCmYLgF44BWbFU9ETKm7I2IopwnDDmUXdYS0/4hG+hYaMCW6zyLqHA5uddt1C1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751474456; c=relaxed/simple;
	bh=3GK1ycy0hQOJv/ORyYe46/AezZlfuxduyUJ3kxm9gpE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=dk2WVpeLfZiLwy4Vq4rxV8rXKBqWR4iopPsTT2qI4ZX+h/rtFF0HBwZhxZyNwWq54gZoE74z+McTdrpdUhWXUsDoj0MOGmP8xmNFssfEiwDfUXsSWFuCL5aNdIHoWHo6kX4vrOWVszX3GsP6aKr74nG6WxeLh+b9a9ChMPelrew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZNj/P2Fs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZNj/P2Fs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751474449;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DxX5SXQow8cTQNbRkntUDQ1P4SHS3PGAaksdc4s5nHk=;
	b=ZNj/P2Fsdu2q4N03nQZkULr0r8K0gmRFBZYkQUpL86QVXLRl5+bFHjZQD4CAXul6IAsKdg
	bmnD7A93BlI8eD8y0HGzhcAmTNG+ZZSo0ZmS1PkFWx7kOLgToBJ3kVPBIHfaPupfV6jfDa
	ITW0SktSFscyZnNg8pSWBikjQ+guJkc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-d8EXRHnkMmOJT3mv_1daqw-1; Wed, 02 Jul 2025 12:40:48 -0400
X-MC-Unique: d8EXRHnkMmOJT3mv_1daqw-1
X-Mimecast-MFC-AGG-ID: d8EXRHnkMmOJT3mv_1daqw_1751474447
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-451d2037f1eso26919625e9.0
        for <virtualization@lists.linux.dev>; Wed, 02 Jul 2025 09:40:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751474447; x=1752079247;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DxX5SXQow8cTQNbRkntUDQ1P4SHS3PGAaksdc4s5nHk=;
        b=UhGI7sSf7zURtrMYTGcW51WSgBWQ1K9QcmZiQo9hH8Sxgtq1cE9VYFWpJev+SYlwp8
         FdQGA2Q2Hav4fUCFX9YBiutKjFIU0zKSRBE0JY+o+cOUsLf37BtECRHOM2Imgrpshz1Q
         tjTEOp/o0vpOw5OqT7ql8K8ZBEH8f94yCVYIosiuD7xaUHh8yaDppwaCqZbdyBC3EvhY
         PujbnHYw6Lx07aK/zbLvNNLcRRvTpOLUC+LaIP/FiWrqb5KE/sgrY50g4fNSBNcKFUyw
         fJTNMlpOqp63Y1+Au65513Cwh9yPCdBbAlJqVoI6e+8piKmfZOTN/19iokfDxMKm02Gi
         k5lQ==
X-Forwarded-Encrypted: i=1; AJvYcCXEPz1R80SF2SJZFd5Vhk0E56phhDddbU2xbHYh/RnUPsmvqCTImBJ8D2K/nsUdSA2P0ihuQTzH02D3EjK2xA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyc5PS6jJQOweSmjjS5QbAQhwiBy3jpyFPN0k3oX3jPzicmLRcq
	hsDM/NatfpzY83hlRkhbAwTGM4Houd83kofCmNsHJqF5LRmS/VH9GTtfyW8wJIcrFHOxszj3fj1
	Y5LFNJxz/swJJo0sN/RskLEpTri7BfHpZXTS3GSpkuhtts/Oj7pg+LxLdTs3LgLvCyUBK
X-Gm-Gg: ASbGncubqjTDmJnbpXvhtynTmhRGACBPvN9txdZF3CgZwAWtOOg+RIIyoYbh94YaMKi
	Hl0ntVyx2pvaeWp/+A5Ijm6BfNr1iGSp57x+Lf027ueVxklDplxLTWF71qT0DDnMdZGp1YerDI/
	icdLVdvExoV+tBt/KRzYhAP0YZ5sm0dMt27joFOfkQHDWo4wgJTr8Bna40CjtbqjdvWc+bS1Ca2
	rdFNG34n0ybc4ITAIk3njwXzIFHm40qzfR4guF6/DgrlkEmjIraBW+a2W5i+PF09AWa2CUQSC6b
	GMsQRXKnBqu456SRi57AQODI/qo=
X-Received: by 2002:a05:6000:2dc1:b0:3a4:f6ba:51da with SMTP id ffacd0b85a97d-3b1fea8ef71mr3497621f8f.15.1751474446690;
        Wed, 02 Jul 2025 09:40:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPi3384hIJUmYDYO2pgwjdEGaDjqPoPnERpOL82BtRro5gn96IZO94uo7p9t+UDNHVK/P2qg==
X-Received: by 2002:a05:6000:2dc1:b0:3a4:f6ba:51da with SMTP id ffacd0b85a97d-3b1fea8ef71mr3497589f8f.15.1751474446109;
        Wed, 02 Jul 2025 09:40:46 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.161.84])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a892e52bbfsm16674212f8f.65.2025.07.02.09.40.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 09:40:45 -0700 (PDT)
Date: Wed, 2 Jul 2025 18:40:17 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, Keir Fraser <keirf@google.com>, 
	Steven Moreland <smoreland@google.com>, Frederick Mayle <fmayle@google.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	netdev@vger.kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH v2 5/8] vsock/virtio: Add vsock helper for linear SKB
 allocation
Message-ID: <vaq3g5wtt657w532itcpdwsvf742cglvuckiqcyueg7y72wtko@yg7swar2xnwh>
References: <20250701164507.14883-1-will@kernel.org>
 <20250701164507.14883-6-will@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250701164507.14883-6-will@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ixhyHmZ9XoYAzfy6TBjn8ltcwNAQ1-MiWPtXZjr8vXc_1751474447
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Tue, Jul 01, 2025 at 05:45:04PM +0100, Will Deacon wrote:
>In preparation for nonlinear allocations for large SKBs, introduce a
>new virtio_vsock_alloc_linear_skb() helper to return linear SKBs
>unconditionally and switch all callers over to this new interface for
>now.
>
>No functional change.
>
>Signed-off-by: Will Deacon <will@kernel.org>
>---
> drivers/vhost/vsock.c                   | 2 +-
> include/linux/virtio_vsock.h            | 6 ++++++
> net/vmw_vsock/virtio_transport.c        | 2 +-
> net/vmw_vsock/virtio_transport_common.c | 2 +-
> 4 files changed, 9 insertions(+), 3 deletions(-)
>
>diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>index 66a0f060770e..b13f6be452ba 100644
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
>index 1b5731186095..6d4a933c895a 100644
>--- a/include/linux/virtio_vsock.h
>+++ b/include/linux/virtio_vsock.h
>@@ -70,6 +70,12 @@ static inline struct sk_buff *virtio_vsock_alloc_skb(unsigned int size, gfp_t ma
> 	return skb;
> }
>
>+static inline struct sk_buff *
>+virtio_vsock_alloc_linear_skb(unsigned int size, gfp_t mask)
>+{
>+	return virtio_vsock_alloc_skb(size, mask);

Why not just renaming virtio_vsock_alloc_skb in this patch?

In that way we are sure when building this patch we don't leave any 
"old" virtio_vsock_alloc_skb() around.

Thanks,
Stefano

>+}
>+
> static inline void
> virtio_vsock_skb_queue_head(struct sk_buff_head *list, struct sk_buff *skb)
> {
>diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>index 3daba06ed499..2959db0404ed 100644
>--- a/net/vmw_vsock/virtio_transport.c
>+++ b/net/vmw_vsock/virtio_transport.c
>@@ -321,7 +321,7 @@ static void virtio_vsock_rx_fill(struct virtio_vsock *vsock)
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

