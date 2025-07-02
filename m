Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB3BBA2E
	for <virtualization@lists.linux.dev>; Wed,  2 Jul 2025 16:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751475078; cv=none; b=G9IC6On4el0lP4GetqSyk5OEq36p1xX6uU/3XNEU72lQncgiObt3MvQuTe5KckCH1Ulo81lwcbmv8lU9khDDkF3IZPiUGsR5ArBBxWstgShrfXkb2J4T15q1hiyVa10Wm6MjojXZSQ/A8P9+fP5dmK3GdtK9ML3Ex9uEKnkmhyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751475078; c=relaxed/simple;
	bh=vb//Qo24WW6S8QPbUQgG5ByNtX4L0YdqgqXP0MjGKWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=NTOf004dL4Rsuhj5fZ96iini4ArsXIp38TgA4YkwViq1L+QL5Wy1mCRTOppHkItK1gObd0rr+VZysBc39KPBCsY29RMx6025oG6a1ZHkYC5vIz2cWl2a/nbKdE4vyLZdb1GF+wah6DmdLl+C+1iA1Pfkkkze4sVn+m24X1sA0jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=blHLxU37; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="blHLxU37"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751475075;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xpfWH72ogCTg47ecP2Ua5CQ85Iecj8xXO5x3bBkcgCk=;
	b=blHLxU37YUFkI3bg7H+naGM0VC+IgvyqR60WyGZH4VR1Nyh9YiXXWDVFQ+CoRQWAI05Elh
	ckInTcB8OywNTOnEMrfkgockwoFfMQ/mWBOUpODo7bhMnm+U0KqEJBlyWabj8AzfqPrNAe
	PKcdSpG4efiivslS99RhQYUfcuLffkc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-sERgH559OLWsWVBw95LKIQ-1; Wed, 02 Jul 2025 12:51:14 -0400
X-MC-Unique: sERgH559OLWsWVBw95LKIQ-1
X-Mimecast-MFC-AGG-ID: sERgH559OLWsWVBw95LKIQ_1751475073
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a4e713e05bso2346414f8f.3
        for <virtualization@lists.linux.dev>; Wed, 02 Jul 2025 09:51:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751475073; x=1752079873;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xpfWH72ogCTg47ecP2Ua5CQ85Iecj8xXO5x3bBkcgCk=;
        b=N5a1uH1Wp5w5TAsYcVou8c4tMOV36K7aMKwFoV2wgde3qGTF1S7Xh/X9GZGYykehUc
         N/utHHxqAa8bt2QoeYlmsBqXMGp7L3wYIEkwehSjmyl2tLsFiGQOK85koRS45tcG2MZD
         7MqbbIG7S3ciovxE1RH/aDib1Vhv0q7XeUGu7pHzuuaYf2Egkvk1QHejbAtsRhHSNv+N
         4ruI/3/YyvAnlQjFzKM77ZvlXmQHGjYcF3P1F9Y1WV3c50Wh8ZPpoKwAdjxjqOU51hmc
         DknsqSgnQKaIh9dQvE2cBbq3tJLUmBMhZ9PB8R5YvBr0H0XxRnFdLleuAwRwz2msXP7I
         QOIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEqOde0cKPzLafJU+9zRuZaCp/8r7mHMc3YfvyzzuZX5N8WdC8AswS648Oi4Ypi2fwVWPOrzskzjdXnejgCA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzocTm4lp8r5/f9/lo/GepLqFuvEa87EnFlbl91MHHbxxmOgYzT
	Gqs1kr7Fe1uhItXPV6JJ0cuDbNmf3zRxoB/K7x3uI2/jvRoJ2UrijvJ+iyNYnuKX5SKJR8wCKmM
	RmkFKJgIcb4gXcmKxGOtA30xY649glkey3yn3N6Gm7+cPVGmI2WgbCvq4/FOU5bS33Wew
X-Gm-Gg: ASbGncvwibDMk0PIGIp8spHGleQ7waKzXm+LVIlePjTpOAiSQBRmO87V1a7hkB4pBxC
	N4FhWQcnE0M0ERgCYxJSbC4H9Rlekc+X2FCr6gRKG4Y83QD87I8s1rWz+pMjfHZCDpQqjRFHgy/
	xVgvPcldXEJNWQEBDszktU5r+gbN/Epr08PwNmp9cifmxSJoE8vG27asq+qumTcck9gmSoVdv6T
	nsd+DFlMY8ni8a2ny3EYWpCqu/NYMyHU2rBnbMs9MHQJt4kYrj0m21ib8j/g/Bw1Xj48yuO56BJ
	+2X4QRXuzXrzZjhUchSOPcfHuCo=
X-Received: by 2002:a05:6000:1acc:b0:3a5:3a03:79c1 with SMTP id ffacd0b85a97d-3b2015e2547mr3077865f8f.48.1751475072815;
        Wed, 02 Jul 2025 09:51:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGvxMRKysuQdHGrGs7w7B21ZCIsLANcSN4jMzO65KTRNFi6asbCS0Y0iZ5KuPAG39RZBqRDZg==
X-Received: by 2002:a05:6000:1acc:b0:3a5:3a03:79c1 with SMTP id ffacd0b85a97d-3b2015e2547mr3077832f8f.48.1751475072278;
        Wed, 02 Jul 2025 09:51:12 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.161.84])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a88c80b516sm16110429f8f.41.2025.07.02.09.51.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 09:51:11 -0700 (PDT)
Date: Wed, 2 Jul 2025 18:50:59 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, Keir Fraser <keirf@google.com>, 
	Steven Moreland <smoreland@google.com>, Frederick Mayle <fmayle@google.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	netdev@vger.kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH v2 6/8] vhost/vsock: Allocate nonlinear SKBs for handling
 large receive buffers
Message-ID: <bborsmywroqnwopuadqovhjvdt2fexhwjy2h3higczb7rwojnf@mg5xrk4mgnwx>
References: <20250701164507.14883-1-will@kernel.org>
 <20250701164507.14883-7-will@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250701164507.14883-7-will@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: N9vwBX3q3vZZEJPzKrTkRr1qUqckNSqcxJtrW1851jw_1751475073
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Tue, Jul 01, 2025 at 05:45:05PM +0100, Will Deacon wrote:
>When receiving a packet from a guest, vhost_vsock_handle_tx_kick()
>calls vhost_vsock_alloc_linear_skb() to allocate and fill an SKB with
>the receive data. Unfortunately, these are always linear allocations and
>can therefore result in significant pressure on kmalloc() considering
>that the maximum packet size (VIRTIO_VSOCK_MAX_PKT_BUF_SIZE +
>VIRTIO_VSOCK_SKB_HEADROOM) is a little over 64KiB, resulting in a 128KiB
>allocation for each packet.
>
>Rework the vsock SKB allocation so that, for sizes with page order
>greater than PAGE_ALLOC_COSTLY_ORDER, a nonlinear SKB is allocated
>instead with the packet header in the SKB and the receive data in the
>fragments. Move the VIRTIO_VSOCK_SKB_HEADROOM check out of the
>allocation function and into the single caller that needs it and add a
>debug warning if virtio_vsock_skb_rx_put() is ever called on an SKB with
>a non-zero length, as this would be destructive for the nonlinear case.
>
>Signed-off-by: Will Deacon <will@kernel.org>
>---
> drivers/vhost/vsock.c        | 11 +++++------
> include/linux/virtio_vsock.h | 32 +++++++++++++++++++++++++-------
> 2 files changed, 30 insertions(+), 13 deletions(-)
>
>diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>index b13f6be452ba..f3c2ea1d0ae7 100644
>--- a/drivers/vhost/vsock.c
>+++ b/drivers/vhost/vsock.c
>@@ -344,11 +344,12 @@ vhost_vsock_alloc_skb(struct vhost_virtqueue *vq,
>
> 	len = iov_length(vq->iov, out);
>
>-	if (len > VIRTIO_VSOCK_MAX_PKT_BUF_SIZE + VIRTIO_VSOCK_SKB_HEADROOM)
>+	if (len < VIRTIO_VSOCK_SKB_HEADROOM ||
>+	    len > VIRTIO_VSOCK_MAX_PKT_BUF_SIZE + VIRTIO_VSOCK_SKB_HEADROOM)
> 		return NULL;
>
> 	/* len contains both payload and hdr */
>-	skb = virtio_vsock_alloc_linear_skb(len, GFP_KERNEL);
>+	skb = virtio_vsock_alloc_skb(len, GFP_KERNEL);
> 	if (!skb)
> 		return NULL;
>
>@@ -377,10 +378,8 @@ vhost_vsock_alloc_skb(struct vhost_virtqueue *vq,
>
> 	virtio_vsock_skb_rx_put(skb);
>
>-	nbytes = copy_from_iter(skb->data, payload_len, &iov_iter);
>-	if (nbytes != payload_len) {
>-		vq_err(vq, "Expected %zu byte payload, got %zu bytes\n",
>-		       payload_len, nbytes);
>+	if (skb_copy_datagram_from_iter(skb, 0, &iov_iter, payload_len)) {
>+		vq_err(vq, "Failed to copy %zu byte payload\n", payload_len);
> 		kfree_skb(skb);
> 		return NULL;
> 	}
>diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
>index 6d4a933c895a..ad69668f6b91 100644
>--- a/include/linux/virtio_vsock.h
>+++ b/include/linux/virtio_vsock.h
>@@ -51,29 +51,47 @@ static inline void virtio_vsock_skb_rx_put(struct sk_buff *skb)
> {
> 	u32 len;
>
>+	DEBUG_NET_WARN_ON_ONCE(skb->len);
> 	len = le32_to_cpu(virtio_vsock_hdr(skb)->len);
>-	skb_put(skb, len);
>+
>+	if (skb_is_nonlinear(skb))
>+		skb->len = len;
>+	else
>+		skb_put(skb, len);
> }

>
>-static inline struct sk_buff *virtio_vsock_alloc_skb(unsigned int size, gfp_t mask)
>+static inline struct sk_buff *
>+__virtio_vsock_alloc_skb_with_frags(unsigned int header_len,
>+				    unsigned int data_len,
>+				    gfp_t mask)
> {
> 	struct sk_buff *skb;
>+	int err;
>
>-	if (size < VIRTIO_VSOCK_SKB_HEADROOM)
>-		return NULL;

I would have made this change in a separate patch, but IIUC the only 
other caller is virtio_transport_alloc_skb() where this condition is 
implied, right?

I don't know, maybe we could have one patch where you touch this and 
virtio_vsock_skb_rx_put(), and another where you introduce nonlinear 
allocation for vhost/vsock.  What do you think? (not a strong opinion, 
just worried about doing 2 things in a single patch)

Thanks,
Stefano

>-
>-	skb = alloc_skb(size, mask);
>+	skb = alloc_skb_with_frags(header_len, data_len,
>+				   PAGE_ALLOC_COSTLY_ORDER, &err, mask);
> 	if (!skb)
> 		return NULL;
>
> 	skb_reserve(skb, VIRTIO_VSOCK_SKB_HEADROOM);
>+	skb->data_len = data_len;
> 	return skb;
> }
>
> static inline struct sk_buff *
> virtio_vsock_alloc_linear_skb(unsigned int size, gfp_t mask)
> {
>-	return virtio_vsock_alloc_skb(size, mask);
>+	return __virtio_vsock_alloc_skb_with_frags(size, 0, mask);
>+}
>+
>+static inline struct sk_buff *virtio_vsock_alloc_skb(unsigned int size, gfp_t mask)
>+{
>+	if (size <= SKB_WITH_OVERHEAD(PAGE_SIZE << PAGE_ALLOC_COSTLY_ORDER))
>+		return virtio_vsock_alloc_linear_skb(size, mask);
>+
>+	size -= VIRTIO_VSOCK_SKB_HEADROOM;
>+	return __virtio_vsock_alloc_skb_with_frags(VIRTIO_VSOCK_SKB_HEADROOM,
>+						   size, mask);
> }
>
> static inline void
>-- 
>2.50.0.727.gbf7dc18ff4-goog
>

