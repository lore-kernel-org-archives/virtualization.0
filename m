Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA42314B81
	for <virtualization@lists.linux.dev>; Mon,  5 Jan 2026 08:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767601388; cv=none; b=bSyVbm590ayYxnglsUOhsxcxzPVeDe1wm3rzOZ8vc58tWfowakHJuFxDzoG60EO8+ha9IiXFfMDAbjYdh3IRJhBBAJHbkDrixWRycuZtLfcSsXN1eUkBHlS4Pcoe8IYJ9zUKMGErosjo7GW5EG14nugzOyabSLmwtukeeUGC0Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767601388; c=relaxed/simple;
	bh=prNYGYHAMpr2WjcHI5N+V/0OjaLMaL48hqD0tOu0jIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=KORJoXUHc7Cw3TvCERpvhJ/iknSsn4si5QL5cEGRG///AT0hc5pJI2RFYhAZT+ngpMH2gJ71yiKTSDnW/rzPZn+QRq44v6wxghuub78t4b89lcx4GokNl4I1LJ91G2yKs2oHX9zdddEfcSWk5L1sAoMfe1upZuj3XitD3lBkgTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LS3uTdc+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LS3uTdc+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767601384;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vW7mLQEFNX/sa5+JF2UQBkqoBaqIc5/VpH7fDXfLlqs=;
	b=LS3uTdc+FsttqHOfOw/HO7GM9NxeIOzRBH2kw/DWe+ws+Rr11TKPF6fDzwZu9w9Hq9EHdJ
	vCfDbLVf2yHeZChraF7wHGi1fWqRTVGd5TwviBVIkc0jqMhe0VSYhy4thw9Amx8yDypRMH
	tP8s3tojCidvhpDNofTpDPxBCNxuAF0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-344-onS0XdbpN4WQexLGWqiskw-1; Mon, 05 Jan 2026 03:23:03 -0500
X-MC-Unique: onS0XdbpN4WQexLGWqiskw-1
X-Mimecast-MFC-AGG-ID: onS0XdbpN4WQexLGWqiskw_1767601382
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-432488a0ce8so10721650f8f.2
        for <virtualization@lists.linux.dev>; Mon, 05 Jan 2026 00:23:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767601382; x=1768206182;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vW7mLQEFNX/sa5+JF2UQBkqoBaqIc5/VpH7fDXfLlqs=;
        b=uZMCm/ZLULs6U/g/uZ0MZ/a3ilk9VXb3zZhtcM7wVSfgmS98KG7NbZU/iMyuOgMl8d
         IHhbJsoJUsUoWK2CaxQOKYrkGkKScpaBtBquLCP/aH2GRks4lNlflya1P+yd8wTEtI3S
         7sppw19Liw1iIMy1WZlj3g0OJdIxshe7tcDPcuz8hhNmGRYGrQsCbK7kqDY4fl10CHd+
         +zHfbPmELXmMvb3lXPR+AAH+kM5stgQB5NcPfqR6VYa4YzQGO/+ZABAFaC2oXS/cYTGD
         ngeS5SV9j33dM7ChJzopP46l53WY7gtnn/g5Alm8b2fT9luSQts25iumtJOKzqH39iEy
         Crbw==
X-Forwarded-Encrypted: i=1; AJvYcCXJHMXHA0CPzBPDpSH885vwU9CZF+NLfFwv4xKBzapURwDVwWEe+cSp0pPjWWcVCpAHbkfdS3/Jj1AYg9JO0Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YxozBwiCgMqVZvkaYGyZehMiPiGNTc1/BVGnpT4M0mgdet10PcL
	E23A69Me7Hoz8z33XhWbot2dASoy9XCjovSpOrKy0xJjPncB5gOQcwlLiyxT5Fo7fP2/StEYflF
	XhPRSanz67ZyPLIQLbeTngJ2IGUeOCSaA9jhYWza7JZEoBtPeXPUwG1veFrSCFMbdl8xC
X-Gm-Gg: AY/fxX7EW9bshbcPTpSEaLXIX7NV5fp0L4nAWm9qqO6bTwXu4NKH/pilFGVLfwh6/z1
	1TcG6t1W4U0Csp9nUGdspJppDy3J5HddxOg0KbQNV246Nck7ahc8xpnztpkQKBBPnF4h+WRj/1b
	LmSkzyOP/1WicXhMmNDSmHLzLkNJTu1rjmwLN3rj9PmuCdAlUVcm1xfMwIFJcJc6XuQeFWFvvir
	lkk6EBoJMjfonwEicPCplUVN1g+tz/0M8LAAMqunaJPTCvpTfAGoo0oop5NeQmc8/aued4BWCCi
	W+2jM4kbDsZSyWGRULlED5VC2ffBMSxZHP6UoL8UJqU4KdSekuQxH4bLE3OsxwPFiUgVYy6Ib+0
	BGXbCtaE6q12f3rgknAz6mqZ7nGbxtjZSvA==
X-Received: by 2002:a05:6000:2403:b0:431:35a:4a7d with SMTP id ffacd0b85a97d-4324e708fe3mr58459606f8f.58.1767601382020;
        Mon, 05 Jan 2026 00:23:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF+toNYrDF1foh7qEGgsaPaQu5EoHgXBV6IY+Dg2iZDwh/L3E0Nw+HN1rJa40DHNfa5Ktydrg==
X-Received: by 2002:a05:6000:2403:b0:431:35a:4a7d with SMTP id ffacd0b85a97d-4324e708fe3mr58459566f8f.58.1767601381336;
        Mon, 05 Jan 2026 00:23:01 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324eaa08efsm99942627f8f.29.2026.01.05.00.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 00:23:00 -0800 (PST)
Date: Mon, 5 Jan 2026 03:22:57 -0500
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
	Bartosz Golaszewski <brgl@kernel.org>, linux-doc@vger.kernel.org,
	linux-crypto@vger.kernel.org, virtualization@lists.linux.dev,
	linux-scsi@vger.kernel.org, iommu@lists.linux.dev,
	kvm@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH v2 02/15] docs: dma-api: document
 __dma_from_device_group_begin()/end()
Message-ID: <01ea88055ded4d70cac70ba557680fd5fa7d9ff5.1767601130.git.mst@redhat.com>
References: <cover.1767601130.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1767601130.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: yIst69KFn9174O9qm_WgVmJBpTpVKnBDvmhtySsEDMM_1767601382
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Document the __dma_from_device_group_begin()/end() annotations.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 Documentation/core-api/dma-api-howto.rst | 52 ++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/Documentation/core-api/dma-api-howto.rst b/Documentation/core-api/dma-api-howto.rst
index 96fce2a9aa90..e97743ab0f26 100644
--- a/Documentation/core-api/dma-api-howto.rst
+++ b/Documentation/core-api/dma-api-howto.rst
@@ -146,6 +146,58 @@ What about block I/O and networking buffers?  The block I/O and
 networking subsystems make sure that the buffers they use are valid
 for you to DMA from/to.
 
+__dma_from_device_group_begin/end annotations
+=============================================
+
+As explained previously, when a structure contains a DMA_FROM_DEVICE /
+DMA_BIDIRECTIONAL buffer (device writes to memory) alongside fields that the
+CPU writes to, cache line sharing between the DMA buffer and CPU-written fields
+can cause data corruption on CPUs with DMA-incoherent caches.
+
+The ``__dma_from_device_group_begin(GROUP)/__dma_from_device_group_end(GROUP)``
+macros ensure proper alignment to prevent this::
+
+	struct my_device {
+		spinlock_t lock1;
+		__dma_from_device_group_begin();
+		char dma_buffer1[16];
+		char dma_buffer2[16];
+		__dma_from_device_group_end();
+		spinlock_t lock2;
+	};
+
+To isolate a DMA buffer from adjacent fields, use
+``__dma_from_device_group_begin(GROUP)`` before the first DMA buffer
+field and ``__dma_from_device_group_end(GROUP)`` after the last DMA
+buffer field (with the same GROUP name). This protects both the head
+and tail of the buffer from cache line sharing.
+
+The GROUP parameter is an optional identifier that names the DMA buffer group
+(in case you have several in the same structure)::
+
+	struct my_device {
+		spinlock_t lock1;
+		__dma_from_device_group_begin(buffer1);
+		char dma_buffer1[16];
+		__dma_from_device_group_end(buffer1);
+		spinlock_t lock2;
+		__dma_from_device_group_begin(buffer2);
+		char dma_buffer2[16];
+		__dma_from_device_group_end(buffer2);
+	};
+
+On cache-coherent platforms these macros expand to zero-length array markers.
+On non-coherent platforms, they also ensure the minimal DMA alignment, which
+can be as large as 128 bytes.
+
+.. note::
+
+        It is allowed (though somewhat fragile) to include extra fields, not
+        intended for DMA from the device, within the group (in order to pack the
+        structure tightly) - but only as long as the CPU does not write these
+        fields while any fields in the group are mapped for DMA_FROM_DEVICE or
+        DMA_BIDIRECTIONAL.
+
 DMA addressing capabilities
 ===========================
 
-- 
MST

