Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44C621B9C5
	for <virtualization@lists.linux.dev>; Tue, 30 Dec 2025 10:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767089755; cv=none; b=UtJ8lEV5JHo8vOxm1ujTl9R5wP/fpkxRFQj3JjbV9ePT9NEds4ig/wbfyE8DXGt8mcPe7lSwOlEgVwi0Rdfm0PWPZV505W3KxP2XA1wvGAPMtfyjBXlSeKGQ0/K1GqoumR9oJccX35jG1dplx/Lg3RZ5HJwDU78K39Zo4LqIZeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767089755; c=relaxed/simple;
	bh=D8i5fx1UC1/6nmNgw58hQGeu+7fSwjalMhDNBy/e6FI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Tz5iyuWIP5KycX3ZXx3FyVOsfncVJyyaUZn2Ug8aujbm2xXgTAlJsOtNQ3Y96QA+vAwaQBM4mimtL2/CegfzmXaGePiOcmK9SEbcrGwYzAybrh0bP/4HzTggduYjcpUEeIbPQxMCwYBcoa544TK3ZHRgJ1RaNdFAx/zuSLUt3eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gSkCZylG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gSkCZylG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767089752;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HL5OM1OGVzMUVxTMh8EvcAcQ4aesQjltxTtrn5MVxlA=;
	b=gSkCZylG1ZqrEKBJfUt0mD8o0Umh+yupxPCi7dKfALjqGCXRXnGluwo4loO0pcZ+ZWLgZp
	wvZDtEPeWlzEcQyMiaEYQYQ5S+OAD9B6MEInBBOcm08JEDjR8WWqSsYF2/yTlFUUzFp07m
	P87jgHtjMxzGKFEE0gfDSFLt/aP76vk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-112-q0z8V2ohPjChxXCAr1ty6A-1; Tue, 30 Dec 2025 05:15:51 -0500
X-MC-Unique: q0z8V2ohPjChxXCAr1ty6A-1
X-Mimecast-MFC-AGG-ID: q0z8V2ohPjChxXCAr1ty6A_1767089750
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-477a1e2b372so77920245e9.2
        for <virtualization@lists.linux.dev>; Tue, 30 Dec 2025 02:15:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767089750; x=1767694550;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HL5OM1OGVzMUVxTMh8EvcAcQ4aesQjltxTtrn5MVxlA=;
        b=IFP+nONXpy/8AUSQ9OSJaRDi8it+W8iFgTKGFLEQzV0ldnaz4XEgBEJjKstNirSqKE
         WysgJKDu3CxpGIoZc2P1N+h67TDPTiR5lKgCVGqhTxd6a/giPm4p2CPGms4zc5FWayVo
         7XeYUpTCUximZ873jIVK+p4wY3TFDUBYhB2SI4pBFbZvRiLYDCt8xIPfuWdtSQVo0rr3
         iTK0eBssnjJnHI+KlC5HocsZeO6Ri/LcYCQ/hpTP4K8OxvWNbqrN0V5wYYYK+Zl6DTv9
         8Re7UrBAVs0J2w2EA16yJI76mOkHw8SlxARP2xj561GjUe4DHozL50jvVvFZ6Q8xOAox
         BldA==
X-Forwarded-Encrypted: i=1; AJvYcCXok+uGnw11d3XkAE7LI7hEjzXveGAc/UyzSS1fvUW8ILlh4bp2bA76gRJCGP7tufOQt7yc2vxWB2uqdM0pOg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxbmbTaLYK559egZi2iarOoiB4H5EtyJiBjD8ic4Wz18MR1ONM7
	N3PZIBnutAX+9nsWBHdI7Ww8RaGMbnsC47/Y4TQCo7N/+1AzKH0D81YAvyZr8oLIZ4bFsGBBojD
	H3M+ahy2bhezvLD9DzNPp0lm8rhvqhSXu2aZCTL9E17PMrFCgVtcpO1+nPT4AzEMxArwW
X-Gm-Gg: AY/fxX65CdchftOkK2/MS1dtN2uJRtXVj3PcwM9dh2hWO7utkTZ4SUZGvplk9DNzGjf
	RrxfZBhAG9ZWHddriaXAFaE4Qud9YU9XqaKMWyEH08oBejEOhGkZHtY5aepaKTfOPp5i4Cw+lMT
	zQJ1S1GQgqTo+H2hVU6J2R43t06Q2juKUs6tqmeGohe1tWUPNXonxTDY2QmKU+lSAOEhriN12rV
	DH5SM58pJ+jtA/MQoyk6p+VeCH9KRGCZbMlTFKeHNwe7ZUcbDYh7NPnv5LK+D3ug9fL2nzK1SF3
	LYtZ5DA8ZRFnLC9KFyWGa95/bDpkrNzAw8wBrYTDTus9Cao1hUVEVo+HG+nyToYIkqq2tQEgG3i
	JU0LqmNPEpUiGa+PBr9AVHRlkiVDHzivzWw==
X-Received: by 2002:a05:600c:8b8c:b0:477:af07:dd1c with SMTP id 5b1f17b1804b1-47d195aaf01mr352296895e9.35.1767089749963;
        Tue, 30 Dec 2025 02:15:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGA32W4P8fpeNgmYgRIg4EUZ5pS0m5VtW0uNekoNCHVjCXEfha8FeJZQUcsP4e9hP9jnxKeEQ==
X-Received: by 2002:a05:600c:8b8c:b0:477:af07:dd1c with SMTP id 5b1f17b1804b1-47d195aaf01mr352296575e9.35.1767089749551;
        Tue, 30 Dec 2025 02:15:49 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d193e329asm588350835e9.15.2025.12.30.02.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 02:15:49 -0800 (PST)
Date: Tue, 30 Dec 2025 05:15:46 -0500
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
Subject: [PATCH RFC 01/13] dma-mapping: add __dma_from_device_align_begin/end
Message-ID: <ca12c790f6dee2ca0e24f16c0ebf3591867ddc4a.1767089672.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: i49XVcLXF2s_oDRyPHUXMVBUMHH2Kb5LyOjbz3EgGIs_1767089750
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

When a structure contains a buffer that DMA writes to alongside fields
that the CPU writes to, cache line sharing between the DMA buffer and
CPU-written fields can cause data corruption on non-cache-coherent
platforms.

Add __dma_from_device_aligned_begin/__dma_from_device_aligned_end
annotations to ensure proper alignment to prevent this:

struct my_device {
	spinlock_t lock1;
	__dma_from_device_aligned_begin char dma_buffer1[16];
	char dma_buffer2[16];
	__dma_from_device_aligned_end spinlock_t lock2;
};

When the DMA buffer is the last field in the structure, just
__dma_from_device_aligned_begin is enough - the compiler's struct
padding protects the tail:

struct my_device {
	spinlock_t lock;
	struct mutex mlock;
	__dma_from_device_aligned_begin char dma_buffer1[16];
	char dma_buffer2[16];
};

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/linux/dma-mapping.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index aa36a0d1d9df..47b7de3786a1 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -703,6 +703,16 @@ static inline int dma_get_cache_alignment(void)
 }
 #endif
 
+#ifdef ARCH_HAS_DMA_MINALIGN
+#define ____dma_from_device_aligned __aligned(ARCH_DMA_MINALIGN)
+#else
+#define ____dma_from_device_aligned
+#endif
+/* Apply to the 1st field of the DMA buffer */
+#define __dma_from_device_aligned_begin ____dma_from_device_aligned
+/* Apply to the 1st field beyond the DMA buffer */
+#define __dma_from_device_aligned_end ____dma_from_device_aligned
+
 static inline void *dmam_alloc_coherent(struct device *dev, size_t size,
 		dma_addr_t *dma_handle, gfp_t gfp)
 {
-- 
MST

