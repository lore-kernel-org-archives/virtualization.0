Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E062E6CBC
	for <virtualization@lists.linux.dev>; Tue, 30 Dec 2025 10:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767089785; cv=none; b=nz7s6nbbMKkfH9h22ABYZiP/g5pR/e+Evm6gxVg3anSSuynta2T1KrdwO/5nXw2I3pYMLm2s4YfktdDBZKUT9I587mmrcorC7MTtzGnYK4Uoc5LlH9TLGNW+Y4Y0riqEqpixefDY/EGGLQ/YJwlo5A12UMFm5DCeMYi7A1hHXZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767089785; c=relaxed/simple;
	bh=RzxSFhz+bpkLtGdr/5qvrDQOf7DHug0oDxHEj4NfN04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=u+uOypMptarLQSFW7ZScWKnwUmXlXg4BZtPDfcDxLMIw7kZfkL1OXB6Vakw6geAuNFKspOoj2i7OtFZRUX5IvLd9AnDHl864tqlMql83iUelzVPXoxBDzM0UG+RmqJxEBj3gYDhfPq/AlYpQ5e8GF1RkCjIohpIk2QqlPAKlw7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SKUfZxXJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SKUfZxXJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767089780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qjCbMizY1BaJF5yBWOLXV7DyUl9vbunxYIEFqfWmhYA=;
	b=SKUfZxXJi+ojfSTOjzHmp9otli4X0roBO/+d8GRGMHkl+4LUKaIM7c/yfQV/iq4Fudaqiy
	UGpk8UZAI74UkEAFk1R3bKIjZcBB1VKbFKI4gm4j4qlY/Zdvl6B2xJKJ3xzyb0XOGzJ35o
	DIRUZpVXXqdkDEHbZ2K9yV+mfXjDy0U=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-436-OwW-bTE2PCiNJbt21Y3sTA-1; Tue, 30 Dec 2025 05:16:19 -0500
X-MC-Unique: OwW-bTE2PCiNJbt21Y3sTA-1
X-Mimecast-MFC-AGG-ID: OwW-bTE2PCiNJbt21Y3sTA_1767089779
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-477964c22e0so70032655e9.0
        for <virtualization@lists.linux.dev>; Tue, 30 Dec 2025 02:16:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767089778; x=1767694578;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qjCbMizY1BaJF5yBWOLXV7DyUl9vbunxYIEFqfWmhYA=;
        b=qeN3Qg/iKlQ6YvX1lilNaWLL3nR1v0dZHuAVtXzlKN2mzUw0wnyNE+w2uYIapPVjcX
         PLcQ0h/iam/nQIvKlQqB0KKDhVLyznW1/wTTXscIiRSEYVKobByKTjvpzyRHV2TyILDn
         TXu409Im4c6D+PSVPZbX6czoHxmLcDB21vdOTrOj67cxrliTHTY6/YfRQAKjxl3eqEZY
         0gvj+JpARsPE4L1UjGQjMzpRoLcMZNjNkT2QlQsOQw9IeCFc+IJQ+6l5Iwi+OQte4uLI
         PwZQzBMd0lG3/mYb7OHYUoURlAaeQI4XH6n1ZPtNkTTg1lMHcJ+M1B/KtxI29PmkNWIo
         GBcg==
X-Forwarded-Encrypted: i=1; AJvYcCXEYXNWKTqkmZHCYt8Xicch/EIBIT2sNhnCTpLxzOEdLFw0UKi9CHVwWv9Zik4Hrw4t7QkCuQN3Alp7vjf1QQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyduwD3BcjXKe7jP0oTE8HWLWfUf94m7XMVwf3HMykRdae1clYw
	WJyBYJngVzdkzzbQUg/1bjBvm3aHIquFdxMMJ+CbEa0Qn9KHV718ZJ4ZCOh51I0FT+EGpxMpvZ2
	IX70eybJMx43qRIVRBGcDmz7FL/0zQLXqk0gEOrUK20b6D1eZSEgqOfLrr2Ya54lax+W4
X-Gm-Gg: AY/fxX6LifzR2LyAnVUec2b2NFQMnYMZ3qKsiBW4JrC6zD4XixGdtoLcGQ5hkXzVYu3
	FjfItnOaHiFE2o6cRjhDnm1pd0vLTso8OSIBQPiwNoXWzdGGcnGU+5/ffR555ElNlA8l/DH47vl
	eeyWZpk0Xq89hplAMu5dJO9XQn5x6C51ezjR9fi9XLryaSINvUTD3Og3xKJ0H+8H26eW0wbrxpH
	dp0qnBbr/cKEV5Lsw6LVbhOJzQclth/ba13iXfMqLybyj/bflCmTFGEB23ETK+QMBCBU29SNXny
	q1/bjFLBl42Qdr1qz0b1tWl/qpC8zqnad+Bkr302T/xHV1iKKJIVS49T3jPwJmQ2w0jTuliGuF2
	nbNRnLeI+2lrZRs33XvU71lGSOr+k++SZYw==
X-Received: by 2002:a05:600c:c04b:10b0:47d:333d:99c with SMTP id 5b1f17b1804b1-47d333d09b9mr218755375e9.18.1767089778577;
        Tue, 30 Dec 2025 02:16:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFT+g6nqLgyQkQdYiav+FpD+RF51wbupLPftlD1j+tQDbY3ul4LGHX6uIhkOPdx1xlKUXo8aA==
X-Received: by 2002:a05:600c:c04b:10b0:47d:333d:99c with SMTP id 5b1f17b1804b1-47d333d09b9mr218754935e9.18.1767089778175;
        Tue, 30 Dec 2025 02:16:18 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be3aea77bsm247750305e9.17.2025.12.30.02.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 02:16:17 -0800 (PST)
Date: Tue, 30 Dec 2025 05:16:14 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Cong Wang <xiyou.wangcong@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
	Olivia Mackall <olivia@selenic.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Jason Wang <jasowang@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Petr Tesarik <ptesarik@suse.com>,
	Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-doc@vger.kernel.org, linux-crypto@vger.kernel.org,
	virtualization@lists.linux.dev, linux-scsi@vger.kernel.org,
	iommu@lists.linux.dev, kvm@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH RFC 09/13] virtio_input: fix DMA alignment for evts
Message-ID: <5f57d7dc13920517b3ed3e56d815ad1ba4cf36ce.1767089672.git.mst@redhat.com>
References: <cover.1767089672.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1767089672.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: oOMjO_qqT61zRBpR9rzH-3RCQrI9YUnsGgaa3NW5Z6A_1767089779
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On non-cache-coherent platforms, when a structure contains a buffer
used for DMA alongside fields that the CPU writes to, cacheline sharing
can cause data corruption.

The evts array is used for DMA_FROM_DEVICE operations via
virtqueue_add_inbuf(). The adjacent lock and ready fields are written
by the CPU during normal operation. If these share cachelines with evts,
CPU writes can corrupt DMA data.

Add __dma_from_device_aligned_begin/end annotations to ensure evts is
isolated in its own cachelines.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio_input.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/virtio/virtio_input.c b/drivers/virtio/virtio_input.c
index d0728285b6ce..774494754a99 100644
--- a/drivers/virtio/virtio_input.c
+++ b/drivers/virtio/virtio_input.c
@@ -4,6 +4,7 @@
 #include <linux/virtio_config.h>
 #include <linux/input.h>
 #include <linux/slab.h>
+#include <linux/dma-mapping.h>
 
 #include <uapi/linux/virtio_ids.h>
 #include <uapi/linux/virtio_input.h>
@@ -16,7 +17,9 @@ struct virtio_input {
 	char                       serial[64];
 	char                       phys[64];
 	struct virtqueue           *evt, *sts;
+	__dma_from_device_aligned_begin
 	struct virtio_input_event  evts[64];
+	__dma_from_device_aligned_end
 	spinlock_t                 lock;
 	bool                       ready;
 };
-- 
MST

