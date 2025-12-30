Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC35F2F7444
	for <virtualization@lists.linux.dev>; Tue, 30 Dec 2025 10:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767089810; cv=none; b=JOhfJm5EAcUs7rODd0/LaY6guICybLn+paEltac1cvPOJvoQssd7VFerf13phccFpoLPpcv5KsN+eEclHpiW6DEulsIrcpsEr6yDMreDDiS3cc3ifArLVdx+6E2igOKq5V85ymyfeJrZYs1r0NUjGwapx78oaUCPsEZOpqY5tLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767089810; c=relaxed/simple;
	bh=t25qf9RPlFFNCOYEONgor27ZqKrRgzzuNghNz/03y7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=XTZiFIeu0pmxF2WLUlyiu8HYfDSVnMd+tUTWMYDKy7cyZ+8NGyR672Rresp4lsnRDJHmI43APDfxIcVe5/90JGP1J5kqc5HB4RwOYS5gn/zN+rh7Vmb9/0ZL5phb5wmaopBmj9ocHimxwXSUw4e+9zQiMM4tJtTiS0OYNq35yG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q9U2zEPU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q9U2zEPU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767089806;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BWhPgbCVUCKqyPHyev/7ivEXEOB+Fryu/YrpJpGLduY=;
	b=Q9U2zEPULaDpd0Q+BpKJZ9l9z/5jLwEjJn6Co5+nq2V6LoT+u5KH6/zBGnNotw/ksCsB0v
	Cm/gvA7EkW5BMeTqDy29bDbhYLKK1Ui+KwuwVPAh0bQJXFDVe+ihQVTsktSjaRiGwU4hJz
	mZZ57GgkweUS9hsIvTLBnGZm+72sdrM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-4HfYflV3MKCwRJV6MijiIQ-1; Tue, 30 Dec 2025 05:16:42 -0500
X-MC-Unique: 4HfYflV3MKCwRJV6MijiIQ-1
X-Mimecast-MFC-AGG-ID: 4HfYflV3MKCwRJV6MijiIQ_1767089802
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-4325ddc5babso3764319f8f.0
        for <virtualization@lists.linux.dev>; Tue, 30 Dec 2025 02:16:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767089801; x=1767694601;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BWhPgbCVUCKqyPHyev/7ivEXEOB+Fryu/YrpJpGLduY=;
        b=lrxAfmwSXKiJdXZ2enlLVa+8w37Gg9KuwBvGbZOnsDvdfVjT+p5rm+y7MVW35i9hll
         82fpUBY6ZZwVI8XAheXWvtzmlQDtbYBFF5+pxJkLMIGJhgdMKwM7WjGrHFFZqU1jwqVX
         YUQMyhojodWU2kXh/ZsXWj1YX0oWqL4WofwOLES6jGsjsc3Kz57UE8J1UvCxSDYgkOrP
         q2/bbybINHoxyViAHv272cRrjfIW3keZgei9IhgWL0YyeYChosupueHiCfp+HmB6cgAJ
         GW/auuxwHmp1fs69y7ozCWbBZgBz5aT989/dtm8TuNgRAjZfhC1qQLJ28KLlez7Ld2Ys
         7mSw==
X-Forwarded-Encrypted: i=1; AJvYcCWLkKgPxfSzO8JXDH4pjZaSzxaRfCIaIsg2xzVjgTdSDOIHUJUx8rCdE987uuPUf4IselJRK36a3muUdr6Wlg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx1gCDdBByvOzVNB47F7xxe4q2nEORnRlssrG4iaKTUv2UPO7CU
	IBjZ8EcKll+MB5NtI/R3dIG2fxyAV/9rhJnjVdf0fEKMz/E7cN4I+dKJBUIzutXIvQyovkcwQEo
	f+7+L3NBC8/4E4UCapttDvltt5ybR/zPAyBEImUr12rZ5N40hji9XkMk9LlTiHok6KH2k
X-Gm-Gg: AY/fxX7+LcEyAvbczZETn1ki8tGtjFp+9kx0w57gWMsRImM99T3OhLcrkBCo0vV2G4m
	0mGcEQgTvYZwlo8Nz1g6XF/4sGW20HBUce3V8tKxnKmoQy0kYRsJLKw/N8AcnzAX8ftiWeCfuid
	WURHzUZMpC0LMKKTbHVeKf40rQtq9wQqFsUDwETz4ZYPXR5YnbTwBj6kOFuPTz0IXMm7v51jxAy
	SCOaLsEX+Ul5NQIONKw6zw3zCEZ7U1qU4ibqbI4fgoYTCHxix/H+s9cAF0MHsrjN+Waxqsl8uwO
	CVWqxK5cIMBAiltAYaU+h8lQA2kJvZaryY0L5D3Gj90G7JmIPIQYgDX+Lfu0YiulfDDdYie+9Gm
	/BcDbgKULnwpx+uUmx4eSXvcOSWKxlIwU3w==
X-Received: by 2002:a05:600c:a413:b0:46e:53cb:9e7f with SMTP id 5b1f17b1804b1-47d1cec8f39mr297842235e9.18.1767089801410;
        Tue, 30 Dec 2025 02:16:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEf8BCC/QkGwDEfP5RddRZimNY2rmw3JwKmzFqtMOWIF8UhfXRlD/gfjFTVaD3LdsD6J0zJDw==
X-Received: by 2002:a05:600c:a413:b0:46e:53cb:9e7f with SMTP id 5b1f17b1804b1-47d1cec8f39mr297841845e9.18.1767089800959;
        Tue, 30 Dec 2025 02:16:40 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be279c5f8sm610553745e9.9.2025.12.30.02.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 02:16:40 -0800 (PST)
Date: Tue, 30 Dec 2025 05:16:37 -0500
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
Subject: [PATCH RFC 11/13] virtio-rng: fix DMA cacheline alignment for data
 buffer
Message-ID: <b2e350ee2542c5c372b2973fb68d4fee67929d5c.1767089257.git.mst@redhat.com>
References: <cover.1767089257.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1767089257.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ppLMYHmr3YxulFn7WgqdG2P7OuZCagzSDLXlCdVqV8g_1767089802
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Add __dma_from_device_aligned_begin annotation before the data buffer
in struct virtrng_info to ensure proper cacheline alignment on
non-cache-coherent platforms.

The data buffer is used for DMA_FROM_DEVICE via virtqueue_add_inbuf()
and is adjacent to CPU-written fields (data_avail, data_idx). Without
proper alignment, the device writing to the DMA buffer and the CPU
writing to adjacent fields could corrupt each other's data on
platforms where DMA cache maintenance is at cacheline granularity.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/char/hw_random/virtio-rng.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/char/hw_random/virtio-rng.c b/drivers/char/hw_random/virtio-rng.c
index dd998f4fe4f2..fb3c57bee3b1 100644
--- a/drivers/char/hw_random/virtio-rng.c
+++ b/drivers/char/hw_random/virtio-rng.c
@@ -11,6 +11,7 @@
 #include <linux/spinlock.h>
 #include <linux/virtio.h>
 #include <linux/virtio_rng.h>
+#include <linux/dma-mapping.h>
 #include <linux/module.h>
 #include <linux/slab.h>
 
@@ -28,6 +29,7 @@ struct virtrng_info {
 	unsigned int data_avail;
 	unsigned int data_idx;
 	/* minimal size returned by rng_buffer_size() */
+	__dma_from_device_aligned_begin
 #if SMP_CACHE_BYTES < 32
 	u8 data[32];
 #else
-- 
MST

