Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCED23F403
	for <virtualization@lists.linux.dev>; Tue, 15 Jul 2025 10:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752573619; cv=none; b=IAqISbBBVzk0C7Mb7BzeLm1S8G4qrX53NuClwzkScT/Co+cAFmFqoq3eSa6NAL717IHuPKTOO9BKkOdV24N3OqEC864ozlrc+QvteSD+PaW69Yr2X96NK/qvpxWrrxc6XlEFNqTdSDGqKA0mdBOIJorNOOYy4DJiqQTu++eMcaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752573619; c=relaxed/simple;
	bh=rRERNh5u97l8jzE7gjjtUkUOQ2wslT8sARlamjvPlzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=PbPAY38Y1NdjVukqkjeJ8tp4mUfP1JdsW5pWyiW+kbv6bhAOFUJPIPGnoUEoWXz+wjfMBxWVgHqEHcA9K93pCBgtRMkNZ5u+oFM1qzd2GKh3JpL1BenImG1vyx8vzJ8iUiWO9/IXIrXjwizLNihrXQN8KGqCoAuOlhm12IZBMCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cXD6Wngr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cXD6Wngr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752573617;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eg250cy9VjDoGFF4U99qUNkf2wzs6t/xzPjF1cEnzC0=;
	b=cXD6Wngry8BCYMtWQz4BOCIFmpJPpSOgjN432hNQMCMJ3Odtn3YjDeB1OyQbtqvl86rhcG
	audzJXvvnji75WR+fiS/qzSRGgFGSQvPo+WFfarTwBz5GpBPuWMSvHjWjDtDg5XK4YVD06
	VHlEh2jqxSo0IWc4UpA7mJq6TmUwzmY=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-190-CqSQ4yGNP4G5lnsI-CoDoQ-1; Tue, 15 Jul 2025 06:00:15 -0400
X-MC-Unique: CqSQ4yGNP4G5lnsI-CoDoQ-1
X-Mimecast-MFC-AGG-ID: CqSQ4yGNP4G5lnsI-CoDoQ_1752573615
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b31f4a9f67cso6567424a12.1
        for <virtualization@lists.linux.dev>; Tue, 15 Jul 2025 03:00:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752573614; x=1753178414;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eg250cy9VjDoGFF4U99qUNkf2wzs6t/xzPjF1cEnzC0=;
        b=kczcPGmVET7PCdV6g6fUCLc6C8Xbecx7wGvIG3Mv+90pXFg9c3dx812Q//KELe1ibD
         xHnTkWm71AgEMkXAACg0Y91JyI73oDTO2DKtJxfak7iEuTKHzRAZEcA3609m3Ivc2ysA
         dWPKx34gdUJlNGskcGr73VOQY94bQh3en+xocuD9vtTqG1LDG0laVeRRtfm+ljghv/1N
         vRb2cGocC6vXBbQRv+aC1zBJdd9q1Lf/qH8yKD5793grWAFH9jMYGaAZhul4cK8rr0uG
         iV+oQGGSjPYj/ZW84PlhHBSxxpM8opEEkW0VBY9ghugZVHmbFkrQLwopAsCIIW3efwP4
         KyOw==
X-Forwarded-Encrypted: i=1; AJvYcCUsiGlJhvbrd1tWaaCckt+SZS1Epwkpk2yYHvP835HHQpxnHE1O3gA7/9hfJv3jL9X9ZXhUYs6w9ES8tA7z8w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyq6IVDFii0NvpMnMNkFBG10sT9pqUZsBSpQC0CXt7B1p2ymiAH
	oXPCBfQSBXGi137A4Qo8ic3gEEPhNJgCqAN0bSOJqSQ4TRxR/ioIR6av1Ykm2FmC6P8vI0awrMY
	1Qk+AhLPbBRq/JLwp1m6FTleBpE+n3kScoYRvsCytL+PupZ4qdmmo6Go+ste+7ctSVcGr
X-Gm-Gg: ASbGncsajd+zOfvoBxxO0mQswk/CPDRIQLCMM8lqboqlTt6aU9Z6Y3pMnXo6k93X3GT
	NF1v5wqgwtM2dUarzhGrQ8z2Dwp/bMe5xfnzwd4KALM2ZzFl5dwQm3VOcMjSkbiMUIfyb2uMizw
	qF3lfLipOb40XTsqRkKXLUlksTzXq8OjnZtoVFHnJPSG2hICg4TPnKMsmOqtKL4qQyDpjdh07u2
	qeUwIsoaycax2CEVa9ES1IzozQDT0QFDy69JTNmpqeFDpJgRbAoqAFFJ7hvDE+/cgQuhZ7GPZbH
	a0G2+JkOP2yqly7bFV5aveRB1Xt5Fq4pxyRvGI8M9Q==
X-Received: by 2002:a05:6a21:10b:b0:220:7e77:f4f7 with SMTP id adf61e73a8af0-23137e8e30fmr24760148637.25.1752573614293;
        Tue, 15 Jul 2025 03:00:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYvHM5d2dKS5rNDI58T5AWqkvB1O86ZZsm91t+LrcuzX6CBDe/JvvwAbp/DEJ1Rc6rvUY8UQ==
X-Received: by 2002:a05:6a21:10b:b0:220:7e77:f4f7 with SMTP id adf61e73a8af0-23137e8e30fmr24760031637.25.1752573613623;
        Tue, 15 Jul 2025 03:00:13 -0700 (PDT)
Received: from sgarzare-redhat ([5.179.142.44])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3bbe581a16sm11645042a12.28.2025.07.15.03.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 03:00:12 -0700 (PDT)
Date: Tue, 15 Jul 2025 12:00:05 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, Keir Fraser <keirf@google.com>, 
	Steven Moreland <smoreland@google.com>, Frederick Mayle <fmayle@google.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	netdev@vger.kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH v3 7/9] vhost/vsock: Allocate nonlinear SKBs for handling
 large receive buffers
Message-ID: <y5o3b47vimlbzuojy2d5hscewa7ywres7c4yml5zldfvpsjby7@cbi7wfpksu2z>
References: <20250714152103.6949-1-will@kernel.org>
 <20250714152103.6949-8-will@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250714152103.6949-8-will@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: p6R5X1_5pf1V1P1PwAPBRYMMZnLjpcq335D1Y99HmIs_1752573615
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Mon, Jul 14, 2025 at 04:21:01PM +0100, Will Deacon wrote:
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
>fragments. Finally, add a debug warning if virtio_vsock_skb_rx_put() is
>ever called on an SKB with a non-zero length, as this would be
>destructive for the nonlinear case.
>
>Signed-off-by: Will Deacon <will@kernel.org>
>---
> drivers/vhost/vsock.c        |  8 +++-----
> include/linux/virtio_vsock.h | 40 +++++++++++++++++++++++++++++-------
> 2 files changed, 36 insertions(+), 12 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>index 24b7547b05a6..0679a706ebc0 100644
>--- a/drivers/vhost/vsock.c
>+++ b/drivers/vhost/vsock.c
>@@ -349,7 +349,7 @@ vhost_vsock_alloc_skb(struct vhost_virtqueue *vq,
> 		return NULL;
>
> 	/* len contains both payload and hdr */
>-	skb = virtio_vsock_alloc_linear_skb(len, GFP_KERNEL);
>+	skb = virtio_vsock_alloc_skb(len, GFP_KERNEL);
> 	if (!skb)
> 		return NULL;
>
>@@ -378,10 +378,8 @@ vhost_vsock_alloc_skb(struct vhost_virtqueue *vq,
>
> 	virtio_vsock_skb_rx_put(skb, payload_len);
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
>index 36dd0cd55368..fa5934ea9c81 100644
>--- a/include/linux/virtio_vsock.h
>+++ b/include/linux/virtio_vsock.h
>@@ -49,20 +49,46 @@ static inline void virtio_vsock_skb_clear_tap_delivered(struct sk_buff *skb)
>
> static inline void virtio_vsock_skb_rx_put(struct sk_buff *skb, u32 len)
> {
>-	skb_put(skb, len);
>+	DEBUG_NET_WARN_ON_ONCE(skb->len);
>+
>+	if (skb_is_nonlinear(skb))
>+		skb->len = len;
>+	else
>+		skb_put(skb, len);
>+}
>+
>+static inline struct sk_buff *
>+__virtio_vsock_alloc_skb_with_frags(unsigned int header_len,
>+				    unsigned int data_len,
>+				    gfp_t mask)
>+{
>+	struct sk_buff *skb;
>+	int err;
>+
>+	skb = alloc_skb_with_frags(header_len, data_len,
>+				   PAGE_ALLOC_COSTLY_ORDER, &err, mask);
>+	if (!skb)
>+		return NULL;
>+
>+	skb_reserve(skb, VIRTIO_VSOCK_SKB_HEADROOM);
>+	skb->data_len = data_len;
>+	return skb;
> }
>
> static inline struct sk_buff *
> virtio_vsock_alloc_linear_skb(unsigned int size, gfp_t mask)
> {
>-	struct sk_buff *skb;
>+	return __virtio_vsock_alloc_skb_with_frags(size, 0, mask);
>+}
>
>-	skb = alloc_skb(size, mask);
>-	if (!skb)
>-		return NULL;
>+static inline struct sk_buff *virtio_vsock_alloc_skb(unsigned int size, gfp_t mask)
>+{
>+	if (size <= SKB_WITH_OVERHEAD(PAGE_SIZE << PAGE_ALLOC_COSTLY_ORDER))
>+		return virtio_vsock_alloc_linear_skb(size, mask);
>
>-	skb_reserve(skb, VIRTIO_VSOCK_SKB_HEADROOM);
>-	return skb;
>+	size -= VIRTIO_VSOCK_SKB_HEADROOM;
>+	return __virtio_vsock_alloc_skb_with_frags(VIRTIO_VSOCK_SKB_HEADROOM,
>+						   size, mask);
> }
>
> static inline void
>-- 
>2.50.0.727.gbf7dc18ff4-goog
>

