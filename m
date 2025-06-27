Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DEAF1DDC1E
	for <virtualization@lists.linux.dev>; Fri, 27 Jun 2025 10:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751021163; cv=none; b=QTySIWZdTO+P856UPh7Ibwk02jM9Ah9IrTol4jJF4HB8djSQEPPb3cKKvERmaR3RpaixVErKXe+sT4qItL2o54mfEJpeEbOFVkCwBXt+6i0Ng9VL0OVJP8Leo38zUaJephinHn3UB+M9U0eM1N9/Z8OKf94Xo+pkKxO0ZdVEHt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751021163; c=relaxed/simple;
	bh=C/KPQHq3boiOOyYKseJ6EOxKOV9EYDs3Tr/NHsprnp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=YBonWMprfCkWnMNH9pj6386pheV3g7g+R7eaB/1iD95XU8vEZbV5FbhsBZMqqzZPwJc+AsfmpHpXNGpaqS+vdDOrtE33ATIYS3vDjmHNbAsdSwIyk3APaS+ABK49hOLMfkepKZcLm7aW0K4eh6vC3v9VJvbK8JOsXq8sT2zgNgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PhGApyq7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PhGApyq7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751021160;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YSDcmP32HC6SX+QgiXKA8vD52iRXQVrx4HQM4vYbyFY=;
	b=PhGApyq7szUccR7I6uUqvWNx5TkQJx2tT9xtBVSm7slL4CvX5qcY9gNoI13/SrZo8Lnh/8
	9AIm3uSvqDYKa7HRjzLSd6EA0hg9IFl6ObsT6RRhPqepJ0+JXfO408LAoOhLdbTbtadHrL
	W7QT+Fla75WdaMH3hMepNv/wkoXMK/c=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-540-dsjuHGsKMmKebI_CTE789Q-1; Fri, 27 Jun 2025 06:45:58 -0400
X-MC-Unique: dsjuHGsKMmKebI_CTE789Q-1
X-Mimecast-MFC-AGG-ID: dsjuHGsKMmKebI_CTE789Q_1751021158
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-23692793178so18265155ad.0
        for <virtualization@lists.linux.dev>; Fri, 27 Jun 2025 03:45:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751021157; x=1751625957;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YSDcmP32HC6SX+QgiXKA8vD52iRXQVrx4HQM4vYbyFY=;
        b=mc4L02yG3/96dX4w+0VHFejDsntOorW8Y6wrUTyjXdoy4ed7GMz74s6/HtXFIsrI64
         znG0eWMV2WxV496Ytrmc0eCfeOWkenBcawYmz4QOpZtx5DUHFSOwC/MMa+MGssO/ho8l
         LlIWwhu3WBuFZYJWxOG4CW+1d4ra1rzu8KkEjx1npqaURV7K641S6icvL3vZN3VUgOfL
         7oIc6oNLTd2WEMpsnP9yZ91pbf2ipI8aqHwC2pmSjUfMIgoB4SsrFAU9SYdrlEhV+39I
         fSpDSDJd3A3uvo/p16Qhwk+AjYJDf75SrSvb4vUJ6MZFI2XXUsUpQsYB2Bh7rZjB1sd5
         xbqA==
X-Forwarded-Encrypted: i=1; AJvYcCUweNXIP3MEXL7FPfDN2sQcX41ghFBa+SPc2r64tnVIooVaeVLCzahGCG1ifx0szhZtY4fBgdPXastFXIom+g==@lists.linux.dev
X-Gm-Message-State: AOJu0YxCLuUKMKXnPAqWFCfhhP63jCvt59g3nsFxjsFkYlI7UoDlz+0H
	+rC/i3v7k26DZNv8jn1NeJpl1SVCL5kr6E7+cJuZAZge3HRYXUKZR5v391l9mtVzBbGxT8EFipN
	Fn2Jg6wsaWKZKwLC7yJP7zQdIiQ3TwCBGzo5YGJepwABKDrBkhzcVdsB11WdrZjNcJj9F
X-Gm-Gg: ASbGncuLyxEjWY2Od7G7gWNykjDHRhZxrCjfVTGdTDxZUH0ElGmn0NJ9zMYOO1HCVif
	nW90avUz/eGb662m/FWwO4/Hylx5yj+dCUNoLegIVrwa4h1G/szAJ2yQU4F6ax4+Axzt5d7i/U6
	kyomNpujFzayrh6PpWmUUgYwuXc3n3cUIhoxB4xu70pC9/pIee9pPeDkjexTFo1elF1qd3g6lvy
	AwShU4c2bmpeXdIMfYsDPJET5AHozBM7bLhi7iHrDH2LR0ozySEA++3iMcPFHxcwceecyxQGFU1
	NmTYnt10ch3XCSzAhlrqTL2+mmg=
X-Received: by 2002:a17:902:ec89:b0:234:8a4a:adad with SMTP id d9443c01a7336-23ac46824a1mr44957035ad.26.1751021157502;
        Fri, 27 Jun 2025 03:45:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOGh1U+3l3EMdNMKJOF70Cr/LIagjk6D2LvbwdUk5eDdvnFLkug9LJltGUvympGN5YEPfRCQ==
X-Received: by 2002:a17:902:ec89:b0:234:8a4a:adad with SMTP id d9443c01a7336-23ac46824a1mr44956715ad.26.1751021157113;
        Fri, 27 Jun 2025 03:45:57 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.150.33])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb2f2569sm14469255ad.64.2025.06.27.03.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 03:45:56 -0700 (PDT)
Date: Fri, 27 Jun 2025 12:45:45 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, Keir Fraser <keirf@google.com>, 
	Steven Moreland <smoreland@google.com>, Frederick Mayle <fmayle@google.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	netdev@vger.kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH 3/5] vhost/vsock: Allocate nonlinear SKBs for handling
 large receive buffers
Message-ID: <orht2imwke5xhnmeewxrbey3xbn2ivjzujksqnrtfe3cjtgrg2@6ls6dyexnkvc>
References: <20250625131543.5155-1-will@kernel.org>
 <20250625131543.5155-4-will@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250625131543.5155-4-will@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: f5slvtGipVL13p373z9yvIb3uz4Ze2XGoxUdJEc_S2k_1751021158
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Wed, Jun 25, 2025 at 02:15:41PM +0100, Will Deacon wrote:
>When receiving a packet from a guest, vhost_vsock_handle_tx_kick()
>calls vhost_vsock_alloc_skb() to allocate and fill an SKB with the
>receive data. Unfortunately, these are always linear allocations and can
>therefore result in significant pressure on kmalloc() considering that
>the maximum packet size (VIRTIO_VSOCK_MAX_PKT_BUF_SIZE +
>VIRTIO_VSOCK_SKB_HEADROOM) is a little over 64KiB, resulting in a 128KiB
>allocation for each packet.
>
>Rework the vsock SKB allocation so that, for sizes with page order
>greater than PAGE_ALLOC_COSTLY_ORDER, a nonlinear SKB is allocated
>instead with the packet header in the SKB and the receive data in the
>fragments.
>
>Signed-off-by: Will Deacon <will@kernel.org>
>---
> drivers/vhost/vsock.c        | 15 +++++++++------
> include/linux/virtio_vsock.h | 31 +++++++++++++++++++++++++------
> 2 files changed, 34 insertions(+), 12 deletions(-)
>
>diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>index 66a0f060770e..cfa4e1bcf367 100644
>--- a/drivers/vhost/vsock.c
>+++ b/drivers/vhost/vsock.c
>@@ -344,11 +344,16 @@ vhost_vsock_alloc_skb(struct vhost_virtqueue *vq,
>
> 	len = iov_length(vq->iov, out);
>
>-	if (len > VIRTIO_VSOCK_MAX_PKT_BUF_SIZE + VIRTIO_VSOCK_SKB_HEADROOM)
>+	if (len < VIRTIO_VSOCK_SKB_HEADROOM ||

Why moving this check here?

>+	    len > VIRTIO_VSOCK_MAX_PKT_BUF_SIZE + VIRTIO_VSOCK_SKB_HEADROOM)
> 		return NULL;
>
> 	/* len contains both payload and hdr */
>-	skb = virtio_vsock_alloc_skb(len, GFP_KERNEL);
>+	if (len > SKB_WITH_OVERHEAD(PAGE_SIZE << PAGE_ALLOC_COSTLY_ORDER))
>+		skb = virtio_vsock_alloc_skb_with_frags(len, GFP_KERNEL);
>+	else
>+		skb = virtio_vsock_alloc_skb(len, GFP_KERNEL);

Can we do this directly in virtio_vsock_alloc_skb() so we don't need
to duplicate code on virtio/vhost code?

>+
> 	if (!skb)
> 		return NULL;
>
>@@ -377,10 +382,8 @@ vhost_vsock_alloc_skb(struct vhost_virtqueue *vq,
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
>index 67ffb64325ef..8f9fa1cab32a 100644
>--- a/include/linux/virtio_vsock.h
>+++ b/include/linux/virtio_vsock.h
>@@ -51,27 +51,46 @@ static inline void virtio_vsock_skb_rx_put(struct sk_buff *skb)
> {
> 	u32 len;
>
>+	DEBUG_NET_WARN_ON_ONCE(skb->len);

Should we mention in the commit message?

> 	len = le32_to_cpu(virtio_vsock_hdr(skb)->len);
>
>-	if (len > 0)

Why removing this check?

Thanks,
Stefano

>+	if (skb_is_nonlinear(skb))
>+		skb->len = len;
>+	else
> 		skb_put(skb, len);
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
>+static inline struct sk_buff *
>+virtio_vsock_alloc_skb_with_frags(unsigned int size, gfp_t mask)
>+{
>+	size -= VIRTIO_VSOCK_SKB_HEADROOM;
>+	return __virtio_vsock_alloc_skb_with_frags(VIRTIO_VSOCK_SKB_HEADROOM,
>+						   size, mask);
>+}
>+
>+static inline struct sk_buff *virtio_vsock_alloc_skb(unsigned int size, gfp_t mask)
>+{
>+	return __virtio_vsock_alloc_skb_with_frags(size, 0, mask);
>+}
>+
> static inline void
> virtio_vsock_skb_queue_head(struct sk_buff_head *list, struct sk_buff *skb)
> {
>-- 
>2.50.0.714.g196bf9f422-goog
>
>

