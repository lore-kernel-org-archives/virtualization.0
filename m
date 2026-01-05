Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8805F313552
	for <virtualization@lists.linux.dev>; Mon,  5 Jan 2026 08:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767601393; cv=none; b=VmPv8Aj095VHreEfR+Ftm5SEdOOB0f4KCiU4ELBqwwnu8jLrnk7PW7OkSKmiSp2gsEIdYbtPq10Qz3vOxK1aCRN08lSQLQsT2/o9ryp8ALH93eO4QASPuyss/8Opl12+zGHJ3uXDuD3fRVBDVGVT5ge+eYCcPy5etZ/cXLZ9/7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767601393; c=relaxed/simple;
	bh=IXDkDZtAt0m+aQ314vUNmBOnLJtrDRmmzuRNBy60P98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=rIWoxuCAMYmACf2VYbFI/e86Ut+KYIeEEXwGDh+wT2VoAwgB7fuGD3XNVTemo1OLnlUcOWJg0JpZLYl7Y/Zz0yjXr9hOSJkMGc5+ibqAA7wD+ysnGkAMx32otXeHx9Kai0PCnjylQUFtbPJxODKgRMFkVFuqejpDjgzZUe95N8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TW2EwW5C; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TW2EwW5C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767601390;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1GET0dQPIEY4INQeC72jj/1xpmrzV3mfvZ6nPpr/HKY=;
	b=TW2EwW5C9pRuSMnDTTYdbj45Gwd8UPcMInyJ37BV3QzhJqNhTSlbUQBs4ulg7Rg25eeOVK
	W4pCDxywJrcWVIWwtcxTDjGKF9xWCjLHtF5RE/GIg39T2nE01IOtQlB5ZxOAVYiF/fPfZi
	0/fDjigGkjymrpDN/75oKLwpZzu57JE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-396-oarFagWfOSGJJFPYYeQCVA-1; Mon, 05 Jan 2026 03:23:07 -0500
X-MC-Unique: oarFagWfOSGJJFPYYeQCVA-1
X-Mimecast-MFC-AGG-ID: oarFagWfOSGJJFPYYeQCVA_1767601386
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-47d4029340aso79950395e9.3
        for <virtualization@lists.linux.dev>; Mon, 05 Jan 2026 00:23:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767601386; x=1768206186;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1GET0dQPIEY4INQeC72jj/1xpmrzV3mfvZ6nPpr/HKY=;
        b=plZeYWGBxb5WJZmbNELySw33Q4iNoTIzRu1cVrz6hw/GonWPXicz8RbITWS2SedNK/
         VyGTKdkbUg5irHEV5ZBAkOF8ftzYcH5CWGHPRCMf/W5QbXmHDr3QMI4sarp0q2jsDwv/
         lYvTdKzSTDWX/d+2WbJER4i7Na8qHYT93EzlWOfo+hmQOljxQ3OhjNPOgNdaWKhTLlRm
         BTgpqT2AJdbdlZ6j+7O+ibdJ0AhsZL56MXIEhmT0B5Gim96GuEM2hCNyrcc92aMagYkg
         Zy9rJbZm0sP0fSdy1cWR1csV/eVimp4tkvm2NluiT83ORyl4tfXJH2/7Qczkivplf+cd
         tJ2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUfjSWpqAhoggowLp9O7McfE2iTmouUr0tdC61lfwFOOi1Tovs4USdF3CPi6p5HUkH61hbhFwbwTFtypK486A==@lists.linux.dev
X-Gm-Message-State: AOJu0YzReszseQ9MrNHLOe2ajFO5aCZKI5mvM8LualqB1dG34DXLG7aC
	2qostTb+f2v2SO789PM9iRg634xqRkk1tPfovTlGr4raSjR0DT/+4ddWGJ4KPvBZ4sPeBYYCZAI
	TwPAVX/M7Md7regdIDIdk3h8wIYCspjhB/S8sHviiuW4L8haONfnfUJg+tId8GKLCerCN
X-Gm-Gg: AY/fxX418NVwJuR5Kc6ytZajopubhLDY/nsrBHgibTKRmfs4GPwZ8+ciY99dtPcqflW
	rDDFTBnjMpyHMUADotGg6GI3hEFWCrtRXNsnvgKxqWY6PDmJ5p/1JUga44HL6DohDMUrG38OpTi
	FRt8EXZqGIyDX7ojEdXnMAiDWOTpf/3C0eZ+6pFYd4zq8iKH9V5WeGQvywvVSpfCXIYp31j3IXT
	lN9hGyprm6uMnUNmXi3tqDWA3Y1p1d40cCusAUWrMZNfU3/Ezk+1TS55/95HhPDeexn6H/BOJk/
	vCewtUEHEjYRgY5fxCUyCLTP2JfdG5YDD3c0iJL921cVknc5SGwKPbPvcRiD3qDzvHGYZ2/hUuR
	lqyOKtYpiRe80V1ZS8dhkUKGJgArMk/bQKQ==
X-Received: by 2002:a05:600c:8107:b0:477:7f4a:44b0 with SMTP id 5b1f17b1804b1-47d1959441fmr614821595e9.33.1767601385794;
        Mon, 05 Jan 2026 00:23:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFFnRSrw61tFPN3ingmu+tnGwj19lkkHlcV8EUdBq7ZpNk54zAQl+NVy05hzMsFUOEhZ22F+w==
X-Received: by 2002:a05:600c:8107:b0:477:7f4a:44b0 with SMTP id 5b1f17b1804b1-47d1959441fmr614820945e9.33.1767601385198;
        Mon, 05 Jan 2026 00:23:05 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d6c0a1d89sm52159655e9.12.2026.01.05.00.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 00:23:04 -0800 (PST)
Date: Mon, 5 Jan 2026 03:23:01 -0500
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
Subject: [PATCH v2 03/15] dma-mapping: add DMA_ATTR_CPU_CACHE_CLEAN
Message-ID: <2d5d091f9d84b68ea96abd545b365dd1d00bbf48.1767601130.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: yNsijeIWk2r6rEsV8-BXrntt3UqBCz-lw363bxbsNGU_1767601386
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

When multiple small DMA_FROM_DEVICE or DMA_BIDIRECTIONAL buffers share a
cacheline, and DMA_API_DEBUG is enabled, we get this warning:
	cacheline tracking EEXIST, overlapping mappings aren't supported.

This is because when one of the mappings is removed, while another one
is active, CPU might write into the buffer.

Add an attribute for the driver to promise not to do this, making the
overlapping safe, and suppressing the warning.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/linux/dma-mapping.h | 7 +++++++
 kernel/dma/debug.c          | 3 ++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 29ad2ce700f0..29973baa0581 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -79,6 +79,13 @@
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

