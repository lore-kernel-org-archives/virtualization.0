Received: from delivery.antispam.mailspamprotection.com (delivery.antispam.mailspamprotection.com [185.56.87.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC2043E4B0;
	Wed, 16 Sep 2026 21:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.56.87.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789593686; cv=pass; b=qP4ABvliN6pirplktBWHI4MGGI1o6BGtWyXF1aftSA3gWbBD61S1bLNadgDH8skraEmFxM+FFCO1zIpK094qNeFHpG/8xF4lhbUS0qSOPVHblR6mXFxUQxG1zrQtrmE+4r45WevAg9hNV8xd2h2MHZtAIyvYAgoBa/NbcRZCzYg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789593686; c=relaxed/simple;
	bh=K0aajd5pS48LBp4SgsLFJE8s+5HK9UUUoA1f8WnnLLQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iP/rA9k/ax6TCKABHzEoM/L/mWRYc0PbBHaqBzJS4jrKC4U+iAIn9RiJh8i9iOc0DCliM2vYLi9ISUADLlFA/87SBoqaT9b3xvxc9to/ZPPB2kCkcZ9jToWjXrroM9T3+DmsdvkqBR3usTy9HDAa8Uu5YyD2nPCIM837ph3EJ3U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it; spf=pass smtp.mailfrom=valla.it; dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b=Qtf21keA; dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b=lImYJULP; arc=pass smtp.client-ip=185.56.87.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valla.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b="Qtf21keA";
	dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b="lImYJULP"
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=outgoing.instance-europe-west4-h0bm.prod.antispam.mailspamprotection.com; s=arckey; t=1789593683;
	 b=MiKxLnCYJQE3k6DCrlRh89+tyJ2B+6pdNwDWE3nn/gqb69FT2JIILqObYSh+STD9bva4q4MJua
	  CbKZXNo1qdVk+O9YSTsdx1too84eeSVp0lqiWpkIrlrW3knO5/ZcY+jt3w0P5+W9zmv/BD5ajv
	  Aqie6tlEi8FdW4EqPQBCeHNm6jA1zhmdo3QlbPzio1D/SJ8HDtfVMsV++C3OGv4UNj/3zSZYoP
	  VoDSiD4U18gd2SXwJBIma5gHKozeQibS01ZFwft0ngsNdQFoOQlCIuGUNffy6mBEGKm3/dXt/6
	  JoxotswLAMBBEiP//ogyD+so7RleIYyx+8Se1JbDGk1plA==;
ARC-Authentication-Results: i=1; outgoing.instance-europe-west4-h0bm.prod.antispam.mailspamprotection.com; smtp.remote-ip=35.214.173.214;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed; d=outgoing.instance-europe-west4-h0bm.prod.antispam.mailspamprotection.com; s=arckey; t=1789593683;
	bh=K0aajd5pS48LBp4SgsLFJE8s+5HK9UUUoA1f8WnnLLQ=;
	h=Cc:To:In-Reply-To:References:Message-ID:Content-Transfer-Encoding:
	  Content-Type:MIME-Version:Subject:Date:From:DKIM-Signature:DKIM-Signature;
	b=lQCivJwh5ac2QqC9XT+Q1WHdgKqyc1qaIJOy/MM9ZTdLcnTmpn9GGxQhjTbnt2X9GOFiDzZDOt
	  nPhNez4v65FhnRAkKJ+UttOXw3qqtZK5Matgyo/A8M7dcPBf85tjyfYsL7w61kAYPpJ1b9NLIb
	  5TerktOVrqngedUw7Wr92n/xWqJCtX81UexHLhldFM+/gQLdPe5x4g16Y6UTxu19jbF3XXMcZ9
	  /tlATN5cMajpGfgD58dThem3iIC9SKZCJIztbQla6m+1FGQd1EU5WilPn6W3tebiscZTuf1QT7
	  nvxpOKvurTb8/EgmA2STZtDlUdNgqnX0Rqmjma4Z8ZL0gw==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
	:Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject
	:Date:From:Reply-To:List-Unsubscribe;
	bh=O4gn2eTg00df8U5IdZkWMPepVAvVYYSdUxbjRaptMcA=; b=Qtf21keAaHfJR0NHqzwKqij4ol
	fRmwHGWDhmAezGJer6+7I7/VLz9MEfcDAoSvdIbJKft2JXoDd+29S0OQ47Oo3ynMQPn0F17nJQkeK
	VJ/N3joDlKEAlEZm0j9nS4M9EOCjZvTAQmhqKLN0jrX7jpoRagRvE+D/gm3wAK8NJ5pA=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214] helo=esm19.siteground.biz)
	by instance-europe-west4-h0bm.prod.antispam.mailspamprotection.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.5)
	(envelope-from <francesco@valla.it>)
	id 1x6wuO-0000000BhjC-1Pv3;
	Wed, 16 Sep 2026 21:11:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
	s=default; h=Cc:To:Subject:Date:From:list-help:list-unsubscribe:
	list-subscribe:list-post:list-owner:list-archive;
	bh=O4gn2eTg00df8U5IdZkWMPepVAvVYYSdUxbjRaptMcA=; b=lImYJULP606lAusNp0RIZVHM1H
	X+2IhcV4MWT1bJsGzKtI6WJJNy9MnK5IlHFu4gvLWCNpMW7byY+jYFgfU/ypI9MVic7iE/igZni1E
	Jy/VMKdw1Y4sewlhk9/OeFOlhmtjCVAYNM4k9l/e4pj2JKzUS//mokZnbxTh81JlMFoU=;
Received: from [95.233.221.121] (port=62880 helo=[192.168.178.175])
	by esm19.siteground.biz with essmtpa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.5)
	(envelope-from <francesco@valla.it>)
	id 1x6wuJ-0000000058P-1cbZ;
	Wed, 16 Sep 2026 21:11:07 +0000
From: Francesco Valla <francesco@valla.it>
Date: Wed, 16 Sep 2026 23:10:49 +0200
Subject: [PATCH RFC 04/12] dma-coherent: add base and size APIs
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-remoteproc_virtio_map-v1-4-dac8c5eb4aa9@valla.it>
References: <20260916-remoteproc_virtio_map-v1-0-dac8c5eb4aa9@valla.it>
In-Reply-To: <20260916-remoteproc_virtio_map-v1-0-dac8c5eb4aa9@valla.it>
To: Bjorn Andersson <andersson@kernel.org>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Robin Murphy <robin.murphy@arm.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, virtualization@lists.linux.dev, 
 imx@lists.linux.dev, iommu@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, Francesco Valla <francesco@valla.it>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3008; i=francesco@valla.it;
 h=from:subject:message-id; bh=K0aajd5pS48LBp4SgsLFJE8s+5HK9UUUoA1f8WnnLLQ=;
 b=owGbwMvMwCX2aH1OUIzHTgbG02pJDFmrWR+3z9Go39bW/vGDvNcGNdnFXRt/XjNkVr17dU37w
 8NRCW+NOkpZGMS4GGTFFFlC1t24t2eu+be0DYyPYOawMoEMYeDiFICJvOFk+CvPM9lq7Raf75ci
 0k5+zblju7Lzf0v+/oi3C5ts/SekLqxl+CuzM//dPn65SDWJBx+kt8RvlDYztNkjHfP0fE9q2jf
 53zwA
X-Developer-Key: i=francesco@valla.it; a=openpgp;
 fpr=CC70CBC9AA13257C6CCED8669601767CA07CA0EA
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - esm19.siteground.biz
X-AntiAbuse: Original Domain - lists.linux.dev
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - valla.it
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-SGantispam-id: 75333834ec8a57e5f8c67ad90c5b645a
X-AntiAbuse: ID - 75333834ec8a57e5f8c67ad90c5b645a
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1x6wuO-0000000BhjC-1Pv3-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-h0bm.prod.antispam.mailspamprotection.com;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none

Add two new APIs for the dma coherent memory to get the base and size of
the pool associated to a device.

Signed-off-by: Francesco Valla <francesco@valla.it>
---
 include/linux/dma-map-ops.h | 10 ++++++++++
 kernel/dma/coherent.c       | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
index 8fae2b7deb20..580b69321d56 100644
--- a/include/linux/dma-map-ops.h
+++ b/include/linux/dma-map-ops.h
@@ -156,6 +156,8 @@ int dma_alloc_from_dev_coherent(struct device *dev, ssize_t size,
 int dma_release_from_dev_coherent(struct device *dev, int order, void *vaddr);
 int dma_mmap_from_dev_coherent(struct device *dev, struct vm_area_struct *vma,
 		void *cpu_addr, size_t size, int *ret);
+size_t dma_dev_coherent_size(struct device *dev);
+dma_addr_t dma_dev_coherent_base(struct device *dev);
 #else
 static inline int dma_declare_coherent_memory(struct device *dev,
 		phys_addr_t phys_addr, dma_addr_t device_addr, size_t size)
@@ -167,6 +169,14 @@ static inline int dma_declare_coherent_memory(struct device *dev,
 #define dma_release_from_dev_coherent(dev, order, vaddr) (0)
 #define dma_mmap_from_dev_coherent(dev, vma, vaddr, order, ret) (0)
 static inline void dma_release_coherent_memory(struct device *dev) { }
+static inline size_t dma_dev_coherent_size(struct device *dev)
+{
+	return 0;
+}
+static inline dma_addr_t dma_dev_coherent_base(struct device *dev)
+{
+	return DMA_MAPPING_ERROR;
+}
 #endif /* CONFIG_DMA_DECLARE_COHERENT */
 
 #ifdef CONFIG_DMA_GLOBAL_POOL
diff --git a/kernel/dma/coherent.c b/kernel/dma/coherent.c
index 45bbae947f4b..f4aa5813604b 100644
--- a/kernel/dma/coherent.c
+++ b/kernel/dma/coherent.c
@@ -277,6 +277,40 @@ int dma_mmap_from_dev_coherent(struct device *dev, struct vm_area_struct *vma,
 	return __dma_mmap_from_coherent(mem, vma, vaddr, size, ret);
 }
 
+/**
+ * dma_dev_coherent_size() - total size of the device coherent pool
+ * @dev:	device from which we allocate memory
+ *
+ * Returns the total size of the coherent memory pool associated to the given
+ * device, or 0 in case of no pool.
+ */
+size_t dma_dev_coherent_size(struct device *dev)
+{
+	struct dma_coherent_mem *mem = dev_get_coherent_memory(dev);
+
+	if (!mem)
+		return 0;
+
+	return (mem->size << PAGE_SHIFT);
+}
+
+/**
+ * dma_dev_coherent_base() - base address of the device coherent pool
+ * @dev:	device from which we allocate memory
+ *
+ * Returns the base address of the coherent memory pool associated with the
+ * device, or DMA_MAPPING_ERROR in case of no pool.
+ */
+dma_addr_t dma_dev_coherent_base(struct device *dev)
+{
+	struct dma_coherent_mem *mem = dev_get_coherent_memory(dev);
+
+	if (!mem)
+		return DMA_MAPPING_ERROR;
+
+	return dma_get_device_base(dev, mem);
+}
+
 #ifdef CONFIG_DMA_GLOBAL_POOL
 static struct dma_coherent_mem *dma_coherent_default_memory __ro_after_init;
 

-- 
2.55.0

