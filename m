Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5245F2E173D
	for <virtualization@lists.linux.dev>; Tue, 30 Dec 2025 10:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767089804; cv=none; b=ajFymM22gNmTB+3PJdHMQAvaNTROVbmnrYp/1OAU4Mj0KfZ7LusWJzSBf02yGLWmu+BFUq5D18dJOJR2n9w2DYU/9zwNS3cbET69dlLup8FulqvDSr1BJ3wy1Luct1BM8VcZpWfpYGlN5juKVqohF4YwiVNJRg3WZfsV1/mR0QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767089804; c=relaxed/simple;
	bh=RzxSFhz+bpkLtGdr/5qvrDQOf7DHug0oDxHEj4NfN04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=keiGBtJCDOjUkguRUqHrEp+kGKCpo0DgyjFzy2qc0LeFTj4QEFX4Qcj5IBhVOP+6EEoPR3rPK+xuf0TPcky+6+6oyMX2yEpRTLHzkzck804V/FL9lY4NfszX5JI4V5/ePN3kx+5YWEQtfcqW69shv/mpFlA9j4ksr/K0/H1NhBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A5w4BGLS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A5w4BGLS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767089801;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qjCbMizY1BaJF5yBWOLXV7DyUl9vbunxYIEFqfWmhYA=;
	b=A5w4BGLSdgKyJQOE/b2Tl9OMRP2B2KqBoRBGHc9suPggEsM8XhqK9tPUaYdx2ebACy8nwi
	eJbdxWDYlWOQ8ueC17QbYWepkVGU6uTTPzs0RA5vp6wjxuOKlZWsmBgcmQqV6pO7t0WnkZ
	JPorzRo8rs0Mz4MTF9EM1CBl4x4Nxew=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-576-BRrozh84PFCu9s6FfT5xJg-1; Tue, 30 Dec 2025 05:16:39 -0500
X-MC-Unique: BRrozh84PFCu9s6FfT5xJg-1
X-Mimecast-MFC-AGG-ID: BRrozh84PFCu9s6FfT5xJg_1767089798
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-477a1e2b372so77926765e9.2
        for <virtualization@lists.linux.dev>; Tue, 30 Dec 2025 02:16:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767089798; x=1767694598;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qjCbMizY1BaJF5yBWOLXV7DyUl9vbunxYIEFqfWmhYA=;
        b=FoiDnOJXcB7joQEU0wQ6CSRsj3SaPjxBZFj1uOrVIinsnD7JpwJ2hd/1GQFs6KyW/a
         Mm85bETaYSIpTMpoVPR5sw7BWEOsfPN9SadiMzPMM7Y2CdL9KTFZdjEMbql3+WXKotuG
         ObWpZllmTdhQ1NgG02pggjU4CvWN3GVbME8iylmizfr5nXbaqF3axQFtPNI8xPGxtRzB
         68bR9HehotjbiNtL5miKZTZlWUjDIQXS3oNLM3pxCQGcf/HtwER3KLSf1dqXjwaUNUwd
         bsEvY/uXLJ+xJvlq+kdZlwLwb5h6pSm5A2lmbtg6OKtTRew6Q6UXxk3hL8OOoxBMzyR4
         9PBA==
X-Forwarded-Encrypted: i=1; AJvYcCVvINEOytiZxhRMaHksVM6FuEUeRU7XZuE8JGwirPumnFD1tg9MYa3buiA3LmSxx9EwdgMrYMNX47Lnh0uZmg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzMA0ORtSIlre2rHT34VCw9S1sQ2DSugYdiSdwZL8ynGcTWwQ7J
	v68yqFFfZ0fDNL3V/oPF99T/YXJqdPBu9VOqL7i87pgHLFSUd/LYzJgGAeGiIZHcEirflpequq7
	mCOcnE43NkzoqnPLr4nDQSPWsiIICPqOSAqsWsX4Mm++KWOSYs/yuuGrJuwhMJTeXF8gk
X-Gm-Gg: AY/fxX6Ag8APCH5cJTeVqW0oCRDq8Ld7zEqhG+FQmoxZIkUJbTv6iELEQfXH6/V8zcE
	aWBVtaEfV7/Tl2ckM0wI7U7EhsEAtB4bc69qzJyoX8Vt4GIQ6YhAixIoTH9uIaZMeOwH4YWwb/F
	M/2NZ0favHJj8umtnrJRKwnfo/C3UfNrHE9UwTw1UETlu5U9hEVCekoZE5x0osNO/9oSLuClMr+
	7N/TZhRIR58fGWcrAABh31Nyx1X8XqPvdJOytbVQXMTvF0mnJYLj57hBYhcAxPzpuMjoRawYb0S
	/8jiCOuvACBu1WsxNeveypc7kcRAH+Lgxs0ypLrWNprr7GmV42UGkdgfzWY/om9CMjleMxCMbjQ
	NjqmejDLFI1fnq7Y/jEzb8Zq9h9DMWkCgsw==
X-Received: by 2002:a05:600c:620d:b0:47b:da85:b9ef with SMTP id 5b1f17b1804b1-47d19569c23mr469752575e9.16.1767089797975;
        Tue, 30 Dec 2025 02:16:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHj3WKIKEzUGPKu3zdwQlyOBMeOTgJhitK/YOLHPeOIUg2zxiErnT0jngxXmWGMEmg7Rb+0jg==
X-Received: by 2002:a05:600c:620d:b0:47b:da85:b9ef with SMTP id 5b1f17b1804b1-47d19569c23mr469752175e9.16.1767089797499;
        Tue, 30 Dec 2025 02:16:37 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be279c5f8sm610551235e9.9.2025.12.30.02.16.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 02:16:37 -0800 (PST)
Date: Tue, 30 Dec 2025 05:16:33 -0500
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
Subject: [PATCH RFC 09/13] virtio_input: fix DMA cacheline alignment for evts
Message-ID: <ba80d103c159a9dc36b89705e00f91bcff8857c3.1767089257.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: sHSqUrquFL3Uxl__5swOdP_qd68t8K9qepNWTnkgMmI_1767089798
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

