Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BF02EC561
	for <virtualization@lists.linux.dev>; Tue, 30 Dec 2025 10:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767089791; cv=none; b=CwEaOV3ZUXfMyF+2k1JNk9WI9IFxHlFkOR4PrfnFPiIBQbWVXLt5T9lozhmmznEnWlwfmykDECzLf41UM1Z6rTqibliQXHhEEKSBeMN5CWDNFczKT6SYxbGnk1qTiIZWhZUqOqqbSB3uDgh0PcuXisEseKaF7vhOHTKfALwgmoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767089791; c=relaxed/simple;
	bh=7vYhvTa0EsKkdKbYw4kgKH5spensmAuucNSR/pooHKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=GcQVsMvt9ej3AWmidQzp13+equwXAgl3TcO/o8VJKRbs4gAvcfenY6Znb1lMk4zQ34nkx/+OgW9QTV0oiTQnG+3tmQIkLtsnup1Rfh13jkcCqhWjrjAV5r5Cdu48t5zpGVzy6B+ESUYYmLWzQ0+ajPDkyo3JPxtqU++J+BPqwhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pu28dPwL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pu28dPwL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767089788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OZZOSut1u/TDBTxePQLgpeDsLzuX17NVLcEs6Y0hRck=;
	b=Pu28dPwLkQyY/fepeq/6f6wV1tJXIt27CyXrQL6+T/OQd/dYPessCswlz0urtroh7qqR/L
	NTa4KlhUaL7eLRa5AtliUTs9uPU7YYV+xKbfDqTOqz/yrNOg4NICR2A7r6Re7y/tp2lUxU
	fjxkLbBlGWetPmFtwlegjkf0jDDShqY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-402-gAO_6mMePzu-jFL55yp71A-1; Tue, 30 Dec 2025 05:16:26 -0500
X-MC-Unique: gAO_6mMePzu-jFL55yp71A-1
X-Mimecast-MFC-AGG-ID: gAO_6mMePzu-jFL55yp71A_1767089785
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-477a1e2b372so77924655e9.2
        for <virtualization@lists.linux.dev>; Tue, 30 Dec 2025 02:16:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767089785; x=1767694585;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OZZOSut1u/TDBTxePQLgpeDsLzuX17NVLcEs6Y0hRck=;
        b=DSy+/9v9ZvX+0ji7Cs/a0M7BvmEX4KfNj9yJPgxoAoHiROnLNWxrY83NF98/o8oKT3
         euDap6Y53IsMcs8Lbn+3WfzOu/mPvIdjEkl0xR3rjNO+EB9CcLAHEbRmJCuHZN4k2+yL
         cv7Uo8RvDdJUquZ9r4Y42QH0vA2EDXHDcEjTlRe7LEv+1cPafL5VfC84N7G/Y1gex9QE
         USfejAbtahxpJNBtE0nUq/yPsMLgv2+NWYONEcaqQmMWNc1IlkAEBb5J7e0PmFKFBrYV
         zDFeURrstmRBT+EOx29/Nsywq/KcSpYaS7MiISvUZ87JL2iufny2mnukCCmwaIxxpu6v
         XeJg==
X-Forwarded-Encrypted: i=1; AJvYcCWAP3uxAWZLf+BEudl0PRN20oZkJYqnbsXXloya1Qbo5DS23yYyI/CNtk91eP8tRulDIQsn5I/I3dfkH/NudA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyV2ZCSKTaU2hG+zvicxTG6TYNT41w4OwbBo3I74RuQRgvE4x3w
	ByazF8Cy8ooNGiiFUEtxhm5A1nEKB8rpDwwTyXCd/JZRfUpSfqBtb8Bls7X1dTvyZNjex6ZGR/9
	46+vxdd2YYovUZpxZwwx8nqInBasew4iSxmRdVO/a8SibC8PP+mdgJR+kA6iwpnPymqcc
X-Gm-Gg: AY/fxX61Z6nPHAaMsAyO1kIVD7fWXEOkjffYsn+iiF4j2qPrTI4O9MzNd73+mbpSCbC
	ax3U6vDZ+MYQVbf7LcRD2OUDjihXcJC2XU/YVW77Q/r2o4Kss525EP72Lhc+5v+3f3VYTvBlaJ2
	NeNJixAgDn2TMMtQDAAgGsHDFpD1+cd2nhHCdbpC/tJFLONtmxoH+bJfe4p/OP8KyFnBTLv/eII
	9neF9bHrLFOtArBpe0dR5Bf3LwYzvPRBWdOTVAvleYRi3aKYQGQUWdbZE2GrwsgXNrF0L4BmhXR
	1ITTYciDdzVgDSRoR2DT/KLYAKK60oHG6ZMH33TxcojfQmanyHMvZQCr+W2Xt3C5e0RoZyHb+3f
	AcuR1h21q6+xkKbnfOBZbrTjtIYCAO2h4QQ==
X-Received: by 2002:a05:600c:608d:b0:477:93f7:bbc5 with SMTP id 5b1f17b1804b1-47d195667d6mr373409445e9.10.1767089785447;
        Tue, 30 Dec 2025 02:16:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG01+uSPzH44CAd+66VyYkAwuPn/pb8j51wL1G42pmMr4duS4CHLId/Zv5CUmzKtGwuKnJahg==
X-Received: by 2002:a05:600c:608d:b0:477:93f7:bbc5 with SMTP id 5b1f17b1804b1-47d195667d6mr373408995e9.10.1767089785008;
        Tue, 30 Dec 2025 02:16:25 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be27b0d5asm646323275e9.13.2025.12.30.02.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 02:16:24 -0800 (PST)
Date: Tue, 30 Dec 2025 05:16:21 -0500
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
Subject: [PATCH RFC 11/13] virtio-rng: fix DMA alignment for data buffer
Message-ID: <318c48915a52f1739c23d46b2b99e3a51c7139de.1767089672.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: 91W0xAXDYABQNojwsTnbbyRhtQsfVxkHwN1aXZpw6ls_1767089785
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The data buffer in struct virtrng_info is used for DMA_FROM_DEVICE via
virtqueue_add_inbuf() and shares cachelines with the adjacent
CPU-written fields (data_avail, data_idx).

The device writing to the DMA buffer and the CPU writing to adjacent
fields could corrupt each other's data on non-cache-coherent platforms.

Add __dma_from_device_aligned_begin annotation to place these
in distinct cache lines.

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

