Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0AC313295
	for <virtualization@lists.linux.dev>; Mon,  5 Jan 2026 08:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767601383; cv=none; b=TkmIJE1hlkgDEFqyy7g0m8Wa0Q9COyQTcFYbi4fNAnhcDQwMdRsxdOrWLDK7dSGBC/fLlEUHowucz4OWGvYPw+d58h4pNu2pYOvPmrq+1WT5NYFdUxJKia6x+lqvKd4RX6PiEaAM2n1X5HLkQYrDVaG8ZVNkvf8Ys6BAlBZfujo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767601383; c=relaxed/simple;
	bh=OKICx5FGcs8IaWdKqJAnv5nr30MUEvkMmLH/rtLJg90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=OWsW4nRXRlySi6l6TCV2W/8YrLTuDXYhs/fzuw4I/HSWBqUSn1AwOeZMRK7p9qOD+LtOZLsGtZMFN8uYQXkbTq9XsxHV47BWCpgJE1n8F46E/2HNf4Cqr0oHk1tyNuDzYRvTPtjeiSjxIswrFn2AwKcps8tX6mv+AWEqlWMgDbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WqVz3irm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WqVz3irm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767601380;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=flvV58rpfI6B2CbimOq4yKlcklsexX+NampJykNGX78=;
	b=WqVz3irmgl/1ZpP+3Mg4itom3mhS8h0Rbrdtt95M6DwQFX+h30kcTMJGJZHFGGTXx46C9n
	k7QD5ZNc1cE4PvrTUNGjMkSJ8cUXCc4UItybwSIPOawmPH1Lus9RXtQaNSe6Q6nmbZntyM
	9kSdOgbhWt0yWZ60HwGundSiE5kWm3A=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-133-m8U9ULsqN-S7Fuh_UIxQ2Q-1; Mon, 05 Jan 2026 03:22:59 -0500
X-MC-Unique: m8U9ULsqN-S7Fuh_UIxQ2Q-1
X-Mimecast-MFC-AGG-ID: m8U9ULsqN-S7Fuh_UIxQ2Q_1767601378
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-47d28e7960fso89204695e9.0
        for <virtualization@lists.linux.dev>; Mon, 05 Jan 2026 00:22:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767601378; x=1768206178;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=flvV58rpfI6B2CbimOq4yKlcklsexX+NampJykNGX78=;
        b=masT2Vq8yXsELg0DffYBZARUagelqSYf32iN8PoT+PgvE6KKDqU/u4t8JAXGlz8uX1
         tMCiNmQnrLSCqP+rbavpCl8l7X07CIQLpLs2D8b3q4KGZnb5AIDMuu+MPdBt9C5bOmh+
         +mdpxliWZptI3WI3ZQ5/EFyjwPjHyZ0NZdQWIme9+mLiVqjkRebZIu3R9yaXu/1U39Ll
         A9lo2H3ly2zkuAr5285/jOzb+5gIjA1unRaNAB+JmD0uvbNUiWkuiwW0I7MqEyABwiLh
         79YWLsBw35JN4ZHUtwWS7b5t6tmHOAgmNivutuuqOjh6SCOWFWp8cDNi5hZMwIrVjGYy
         jGVw==
X-Forwarded-Encrypted: i=1; AJvYcCVYQ8s3HRGMgV9MxKO4/jvpuxc8K/2PJZLVl6jIHfFDgiE6ggPLEp7vda2B1k1+aLyh966tGxjc3N47CZZm7w==@lists.linux.dev
X-Gm-Message-State: AOJu0YzCn6CnDkjZovmpIelCu5DvE3p/mt5oDENS9+9xZSLK49b1Q5P0
	l/CndCcGFGnARVNrZSIDFMx2JecmKU1HQWLcQwvdv0q7faNt93lkAqUMUhk4UIIArx3HsZFoXuh
	XsDdjAcnxKfis2/mZqT2GPo5gVHBBD21HGKI8vqo+GFOL+w96UT7D92UA8jCgWiwZPqYi
X-Gm-Gg: AY/fxX5I8rIblyiONgtsiQpMNy9U+Q/oA8Gx0LLj+1m+vSDyHNPS3YVJhipLPHtuP0/
	WH8JnYIaP4CFNXj6AtYAMBixJvwhFIwNrqj92WionnwRFVKt0iE5CN4kAAcHiSqmDWBz1cjFtbB
	ni8koYAwIDkt1vUzJmrvLAkbEoTU7xWPMenIhXGZlpw2crA2BmVkwm9PTD+WKcfo87/8DThtozY
	3AoWdG2xPVHi2NjTxMfrySNXIBCcwCSuctFCUYl5Q03Ghp7YKWdnJ7/kLXGGoL7Uh7ZgtpY3BAO
	Bb1HCmC0rXxo8YPMJncmY1/oQM3xZhC4AraicvyEkUUL73Lguym6Hc3VtLvWJkKES34Ivbo/AXN
	RsaLNtD7R8RdQOvyz0IhTOUE1AIjZpKAAjA==
X-Received: by 2002:a05:600c:a31a:b0:477:b48d:ba7a with SMTP id 5b1f17b1804b1-47d1afcd9e2mr472221805e9.32.1767601378040;
        Mon, 05 Jan 2026 00:22:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEuXSIOihQGqTUh73UD1lwUxn/oQlvSzbaEszKjq8q7pmaQg9MTKbAK1XIofFksKZVCqoImYw==
X-Received: by 2002:a05:600c:a31a:b0:477:b48d:ba7a with SMTP id 5b1f17b1804b1-47d1afcd9e2mr472221315e9.32.1767601377489;
        Mon, 05 Jan 2026 00:22:57 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d6d13ed0asm147684535e9.3.2026.01.05.00.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 00:22:57 -0800 (PST)
Date: Mon, 5 Jan 2026 03:22:54 -0500
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
Subject: [PATCH v2 01/15] dma-mapping: add
 __dma_from_device_group_begin()/end()
Message-ID: <19163086d5e4704c316f18f6da06bc1c72968904.1767601130.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: ReDXrSxMJH_IsGdECfETib7hBJuo878LwnIMFn1SftY_1767601378
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

When a structure contains a buffer that DMA writes to alongside fields
that the CPU writes to, cache line sharing between the DMA buffer and
CPU-written fields can cause data corruption on non-cache-coherent
platforms.

Add __dma_from_device_group_begin()/end() annotations to ensure proper
alignment to prevent this:

struct my_device {
	spinlock_t lock1;
	__dma_from_device_group_begin();
	char dma_buffer1[16];
	char dma_buffer2[16];
	__dma_from_device_group_end();
	spinlock_t lock2;
};

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/linux/dma-mapping.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index aa36a0d1d9df..29ad2ce700f0 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -7,6 +7,7 @@
 #include <linux/dma-direction.h>
 #include <linux/scatterlist.h>
 #include <linux/bug.h>
+#include <linux/cache.h>
 
 /**
  * List of possible attributes associated with a DMA mapping. The semantics
@@ -703,6 +704,18 @@ static inline int dma_get_cache_alignment(void)
 }
 #endif
 
+#ifdef ARCH_HAS_DMA_MINALIGN
+#define ____dma_from_device_aligned __aligned(ARCH_DMA_MINALIGN)
+#else
+#define ____dma_from_device_aligned
+#endif
+/* Mark start of DMA buffer */
+#define __dma_from_device_group_begin(GROUP)			\
+	__cacheline_group_begin(GROUP) ____dma_from_device_aligned
+/* Mark end of DMA buffer */
+#define __dma_from_device_group_end(GROUP)			\
+	__cacheline_group_end(GROUP) ____dma_from_device_aligned
+
 static inline void *dmam_alloc_coherent(struct device *dev, size_t size,
 		dma_addr_t *dma_handle, gfp_t gfp)
 {
-- 
MST

