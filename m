Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B822E175F
	for <virtualization@lists.linux.dev>; Tue, 30 Dec 2025 10:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767089762; cv=none; b=W4TTEKqMLpw9U0KBI0dgTAf1NfSpEhTtkIdQ16DgVnppoGzadLVruG8S1mVezFACEAcoS7d9QINBD2jMtm8ip+fcbB/JJ1BgiqI02VTdn/0/3h6kUreUGq0HhDu4IKYGmAeFCWn82zE/Mlyni42siAzPF4ozw1Ex7+G1qYChpDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767089762; c=relaxed/simple;
	bh=PKPLA1kpbL7fJYEUVDcqch/rjberNxsCb/G2InoSmIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=QCsd8+yp0pby4stg9P9B23zg7cNRRcLDJRDStqRXfLgKQ9PGAkMCGKJxhDGUKI+G+DbrCdh+wdIltMMZ80SrepBW9BJi/pKyUIC2Tr5gpTA05y3j+YpF9qzB+Bx4x+Wg7Fc9olwj/6e4aG8Oe92dR3kja2+JI1sNKxI8V7vZg30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hzo/ukVG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hzo/ukVG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767089759;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vlUDEgWO93Cmk0Xa8O4C3C5KUT8jOBeRcuReRJ9yK0k=;
	b=Hzo/ukVGpCpZFTerO6TPVTUe75x9pQ1BR1LptdEzWoyEQ/osq2e8qbvA7igncJP60Lnn8M
	cAmlIoq9purJRZszQ7iImNMTkvCoPlaZd4humItpsA8OY7yk+kDS7DCURt5KOhFT3wU3pq
	/MrPGTP9IJ8w/QKJNIwqFSmI5wmFvcc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-XjJXmsfLNSKOlFK_LWY1EA-1; Tue, 30 Dec 2025 05:15:58 -0500
X-MC-Unique: XjJXmsfLNSKOlFK_LWY1EA-1
X-Mimecast-MFC-AGG-ID: XjJXmsfLNSKOlFK_LWY1EA_1767089757
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-477c49f273fso125578545e9.3
        for <virtualization@lists.linux.dev>; Tue, 30 Dec 2025 02:15:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767089757; x=1767694557;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vlUDEgWO93Cmk0Xa8O4C3C5KUT8jOBeRcuReRJ9yK0k=;
        b=j9l8G5qaX3P4qzW/wtmFNYiqsIWLPMWSlqYZAjYWRp4ySvsKXzPwcYKGNojLaTvrkp
         JtFriEKBFEChH8L17zfEh7Q3V4sdrUVJVWa2X31CcwOV4Dnz/2ue5g3osnvpHbYmkvEb
         N+gFTkXTOaqtD8dfOeQ4wWlTIerh44j+pStDw14Q8cwUmHSVsLJgQ49j6KIj4DDdc+YS
         K8VxsSZ2qURroJf/aWzNAx/ffFkv5cRht/YwyxrvhwOdR5739/6wpd1+SK/r/q8ovWxZ
         lFnMIO4JXzKZkV5w9FVjd2EM0dLTjl3hea2eJgAqmUeAESEE6HIEA/Q8Q1Ro7wlcQx0H
         V6xg==
X-Forwarded-Encrypted: i=1; AJvYcCVFDste1vdU86m6ySHSeq6dOKl2a9E2Z56QHWcfYnl2JRpXacTQ63JPsF8sj9I/4KT09lxVDNUJ8NjXR26kpA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwIeje3ZBUM9xrn4oMolQ+u/6nGnIoEUq98kAYw0iryejS1RBqY
	OEUNZuh9QJHU5bWWmN8XDouprYPN3xh1OqLUaCy1uzEUT2mpR5zzSRMBI8Jdi29crS0+Udf/G5k
	58l5A4gV6mYUce8mAUxY9cYrAcRw6Mpbx9rI/pEk2WF+4JANeKCQs1bz11egiUBAQKl8k
X-Gm-Gg: AY/fxX7XSH5Zi1tydFQ+03079jcBc6X8a0MHweodHDlJqWGyByaqKpqk8+UEwhJFLW+
	ziybGbeuhPfnRq9GpyePjb0qmiitYTXndMU+rFf6mzvO2Pl54BPgyb1Bsz8xcdXEPEak4NuX/zA
	irb/Qhf+CfpjaGI9jniWxXOZgPbB4SEzq96ZZFnK+xytuxZXWStWdJ5HsKaTvwRb6CABPaXAYss
	9Y7xZ8ohu3p0jn3AN+E9Z8vd/NSKn7wA8P59ONFcNtiGjzfU39/A4fEwqhnp3JIASDniJTrUUCD
	O8kDofXym/BrB79DKghthqAM8ph2r8aZ8vnm0t6an+ITv+DrJN1eKcfwv3sg7ziO0KajqEiFZx5
	L7XJ/1MLsFZQtFN2fCVMkfJSlpnYUkf6Rrg==
X-Received: by 2002:a05:600c:3b0e:b0:477:b0b9:3129 with SMTP id 5b1f17b1804b1-47d1955b7d1mr374948275e9.3.1767089757035;
        Tue, 30 Dec 2025 02:15:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFcsewURuffZ55cO3Q+sj2TN55Hu1ppUSdeqHbu2iFeBFoCSmT0tG7gytPk3ITCZSUZTYC9tQ==
X-Received: by 2002:a05:600c:3b0e:b0:477:b0b9:3129 with SMTP id 5b1f17b1804b1-47d1955b7d1mr374947795e9.3.1767089756491;
        Tue, 30 Dec 2025 02:15:56 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be3a6c6ebsm263705445e9.4.2025.12.30.02.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 02:15:56 -0800 (PST)
Date: Tue, 30 Dec 2025 05:15:53 -0500
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
Subject: [PATCH RFC 03/13] dma-mapping: add DMA_ATTR_CPU_CACHE_CLEAN
Message-ID: <1f271a22a3aae6afb97c5f9ae35b1802eaa036a7.1767089672.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: VRdPONQ6T_93vsUjfW1xyWKb5h7zqkYnvS_IZ0uJju4_1767089757
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

When multiple small DMA_FROM_DEVICE or DMA_BIDIRECTIONAL buffers share a
cacheline, and DMA_API_DEBUG is enabled, we get this warning:
	cacheline tracking EEXIST, overlapping mappings aren't
supported.

This is because when one of the mappings is removed, while another
one is active, CPU might write into the buffer.

Add an attribute for the driver to promise not to do this,
making the overlapping safe, and suppressing the warning.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/linux/dma-mapping.h | 7 +++++++
 kernel/dma/debug.c          | 3 ++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 47b7de3786a1..8216a86cd0c2 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -78,6 +78,13 @@
  */
 #define DMA_ATTR_MMIO		(1UL << 10)
 
+/*
+ * DMA_ATTR_CPU_CACHE_CLEAN: Indicates the CPU will not dirty any cacheline
+ * overlapping this buffer while it is mapped for DMA. All mappings sharing
+ * a cacheline must have this attribute for this to be considered safe.
+ */
+#define DMA_ATTR_CPU_CACHE_CLEAN	(1UL << 11)
+
 /*
  * A dma_addr_t can hold any valid DMA or bus address for the platform.  It can
  * be given to a device to use as a DMA source or target.  It is specific to a
diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index 138ede653de4..7e66d863d573 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -595,7 +595,8 @@ static void add_dma_entry(struct dma_debug_entry *entry, unsigned long attrs)
 	if (rc == -ENOMEM) {
 		pr_err_once("cacheline tracking ENOMEM, dma-debug disabled\n");
 		global_disable = true;
-	} else if (rc == -EEXIST && !(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
+	} else if (rc == -EEXIST &&
+		   !(attrs & (DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_CPU_CACHE_CLEAN)) &&
 		   !(IS_ENABLED(CONFIG_DMA_BOUNCE_UNALIGNED_KMALLOC) &&
 		     is_swiotlb_active(entry->dev))) {
 		err_printk(entry->dev, entry,
-- 
MST

