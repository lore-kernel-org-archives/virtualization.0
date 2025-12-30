Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2162E4315F
	for <virtualization@lists.linux.dev>; Tue, 30 Dec 2025 10:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767089761; cv=none; b=A+z8HFS44TbDsih3uD5HGOnHQaHkTFuLR20R/y144OZl4H5UVsosepah3PUpX4Wviwi6UdOyXdGohP8JIZKLc/km4GePY9pBk/oCWIpDGvhDI+quwwYKIRPPGSrU1D90MXS1jTegQFkjWfMVY/tJ1PMdF8/15wqBkrVz7YYA/P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767089761; c=relaxed/simple;
	bh=1JUA4c0efATkxneQm73kN9tTpnR2rWTicL6pMgMgIPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=PlqTEm5vonXRAv/zUJIIwMMUWNK0vSFOi/jDIGyFITHXEUtNI01t1Ngwd1vz2a3BNy3KhT7JB+AGACoRVQ1iLG4HYQsyb2YFkTwEak1uJOb2VaTwYFjvypoVE7dbKuzwDUmyNfsxXqo6r00PrbMpf+HlfyiTDY6PUx4cmCkc+Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UWMgGlED; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UWMgGlED"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767089758;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lIFloJTLYi5ioijSED2t687CZ+kUT7GxSlzISMtKW5A=;
	b=UWMgGlEDMuAcicNDwwEMsN8ND6K+yGn6+thx2DjkYgyTxUx9YHMzwRjfVARuxYNOau7tPh
	yqtApNi4DDHkHRuWQLOv9m77fmVEsQ9NP+M8RLoW1OOF85CTQWauERjz9KJFEk+fSP/7JX
	ynnANhDh4bwlMlqliO0cJh2U8I0ST+E=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-Na8AWAP7On28pyJFOxGYJg-1; Tue, 30 Dec 2025 05:15:54 -0500
X-MC-Unique: Na8AWAP7On28pyJFOxGYJg-1
X-Mimecast-MFC-AGG-ID: Na8AWAP7On28pyJFOxGYJg_1767089754
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-42fdbba545fso5949628f8f.0
        for <virtualization@lists.linux.dev>; Tue, 30 Dec 2025 02:15:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767089753; x=1767694553;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lIFloJTLYi5ioijSED2t687CZ+kUT7GxSlzISMtKW5A=;
        b=fltLbF8QWazahSXPQ9Eb7qX5mCiaDI6NTXIIbJnwtZDfTB9pa5QbjWueuUgqSuCEo6
         f+sqoLhuGK9t9pHyFfcFm/kNiM4K3wBDYgkXa1cqSi8N7wFwCv6svYcVLwW7huq+KUgu
         lFmZqxYNB47nLrh9mGrK2sp9BIDnJSgDwVS3m9Z5/WVioxWAa9BWpUgpHgKQS+UvU9D3
         ydH9PQN7XUmkwaWbtQJ/Anp4SeWsZ/Gt9isH3+Qu2s+jSYxXFIsZwC1hJmh2j3PW/ad3
         nWn/P2Ts5D7odjbwIBZsOX+p0ZTD/gFsq4fRMOIWQ+OO/7utmcnYsswrs0kZv16sbzxV
         ZjNg==
X-Forwarded-Encrypted: i=1; AJvYcCWCl20lLVT9yCtD4fPlRrvhOrwz/gVtEb+xdn1es/hwSjgmT9AfDwm3cnlDMj0x1Kf79ApwohmWLTWIavDjPg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxNFuq3dVxVg9u4eK7m4gBcHyVAPNjZAX/Prg9OMAPLGOR5zlP+
	pBs1f5tmhJ/wI/GW3+5ik94QMKLigTItPb5alWpFum1PkDDM/qa/LXVc4ohh/5tEmUZNxwmZxnt
	g1CL6Ju5IbiagiVhJoufYR2RWMx2kcI/OxNfrhC4Z529sahpcpvr3lQsktz3uvX/jTxK5
X-Gm-Gg: AY/fxX7t/5yCPYMS7Q48Rq4Hf4t2WSMq18Eau61hXzd40LSYjUKAYhFkBSbNJqZ9x3A
	Z8aOVA42XuwgeXcj9L3wCTafm7KYQoDCdyJknZByLOPFmVa1+OU4WfIiqPToMlSCEGjRTRPc1dj
	lnkqyPaGSA9w4Eu8GM4Bb3A8c/zPMANQKDtru++lrkdX4CQHLEBv899I+ba1OWsiGvG1uN40yKW
	aAVxUQ68uchyITP+FiO3G/neEpZF0R8mxvUaOujBrI9/HJMaDid30qLTwJJXmnZY+O24+xtKAsK
	y5bc/z632kuy8YgHIgurDBmY0mUbW3v/OUbUGTLeWy/gcSO+icTRCbkhfKAnDHvI8Iw8yrqQyYI
	BESkF1y2lBDxESiymXb7Dv9LIxGYaVsvFXg==
X-Received: by 2002:a05:600c:46cf:b0:477:9e0c:f59 with SMTP id 5b1f17b1804b1-47d18b833a6mr393752885e9.2.1767089753548;
        Tue, 30 Dec 2025 02:15:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF0nrcJnS7RjupXcIyxgJ/7OwvI0dkgJ3plFmvdD3JvcGLBLhWJUwOhq1auRl2SqH+pkIX7dw==
X-Received: by 2002:a05:600c:46cf:b0:477:9e0c:f59 with SMTP id 5b1f17b1804b1-47d18b833a6mr393752425e9.2.1767089752979;
        Tue, 30 Dec 2025 02:15:52 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be272eaf8sm630001695e9.5.2025.12.30.02.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 02:15:52 -0800 (PST)
Date: Tue, 30 Dec 2025 05:15:49 -0500
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
Subject: [PATCH RFC 02/13] docs: dma-api: document __dma_align_begin/end
Message-ID: <192a335d783a2e54f539dc5ff81bf3207dafa88f.1767089672.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: DAV5zyaKMblUM-FE0AMbhkfpdMR0AI2j4B3sYN103zA_1767089754
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Document the __dma_align_begin/__dma_align_end annotations
introduced by the previous patch.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 Documentation/core-api/dma-api-howto.rst | 42 ++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/Documentation/core-api/dma-api-howto.rst b/Documentation/core-api/dma-api-howto.rst
index 96fce2a9aa90..99eda4c5c8e7 100644
--- a/Documentation/core-api/dma-api-howto.rst
+++ b/Documentation/core-api/dma-api-howto.rst
@@ -146,6 +146,48 @@ What about block I/O and networking buffers?  The block I/O and
 networking subsystems make sure that the buffers they use are valid
 for you to DMA from/to.
 
+__dma_from_device_aligned_begin/end annotations
+===============================================
+
+As explained previously, when a structure contains a DMA_FROM_DEVICE buffer
+(device writes to memory) alongside fields that the CPU writes to, cache line
+sharing between the DMA buffer and CPU-written fields can cause data corruption
+on CPUs with DMA-incoherent caches.
+
+The ``__dma_from_device_aligned_begin/__dma_from_device_aligned_end``
+annotations ensure proper alignment to prevent this::
+
+	struct my_device {
+		spinlock_t lock1;
+		__dma_from_device_aligned_begin char dma_buffer1[16];
+		char dma_buffer2[16];
+		__dma_from_device_aligned_end spinlock_t lock2;
+	};
+
+On cache-coherent platforms these macros expand to nothing. On non-coherent
+platforms, they ensure the minimal DMA alignment, which can be as large as 128
+bytes.
+
+.. note::
+
+	To isolate a DMA buffer from adjacent fields, you must apply
+	``__dma_from_device_aligned_begin`` to the first DMA buffer field
+	**and additionally** apply ``__dma_from_device_aligned_end`` to the
+	**next** field in the structure, **beyond** the DMA buffer (as opposed
+	to the last field of the DMA buffer!).  This protects both the head and
+	tail of the buffer from cache line sharing.
+
+	When the DMA buffer is the **last field** in the structure, just
+	``__dma_from_device_aligned_begin`` is enough - the compiler's struct
+	padding protects the tail::
+
+		struct my_device {
+			spinlock_t lock;
+			struct mutex mlock;
+			__dma_from_device_aligned_begin char dma_buffer1[16];
+			char dma_buffer2[16];
+		};
+
 DMA addressing capabilities
 ===========================
 
-- 
MST

