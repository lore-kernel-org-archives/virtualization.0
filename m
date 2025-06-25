Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6983269B08;
	Wed, 25 Jun 2025 13:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750857582; cv=none; b=H7JZdOnstfY056d+PLnP/v0sU9vkMaWo1nnspTnqBVkpZSSB7WBzFOUX0lZQ8DNz/qRpXIsYxNQBg9qEuvjy+3xdNo2cqUHCI0ssK4Z6hW73XInQj7abpty4bEAqvofVu6YMY9T0t5T3wq7BYR695GsafDqZ3RxwGjAxZATScxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750857582; c=relaxed/simple;
	bh=U1ovqnANomb/cEXYdYYeiuP4LQydDqNW/NB4OU1aqgE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jBsC+JEQLC8yVXLULblM04w4rPVvhIaERiTjXj4UE7I0lIYrr3Jc3YkZ6SL1qY/67vypjPwA6rvV3JDaihvdHRAs6Kb33qGVPigrA6gD90Hf3x7WGMeEei7Dy8xKu/0nh7Oi4BfGre3S0Y1T11A1VQU6HI2CyUkyzDpP3Kh0CxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N0G3gV+E; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N0G3gV+E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54036C4CEEE;
	Wed, 25 Jun 2025 13:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750857582;
	bh=U1ovqnANomb/cEXYdYYeiuP4LQydDqNW/NB4OU1aqgE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N0G3gV+E4IJhrAeOantpO1cwUDcMsTCEPcIcE6wM9Gm6ZtwQv921RF9CtRTt0u2ST
	 6zAGA6OPg7exrFGuRKaOuTBaAc3+xMSRRas96RdgU6LBRx9z1AHyuVVAaukNs4jqny
	 w87lOQJxPHyIi2wWXWfNDG/uhOfNvtNKL7VptMtzDVYmgSu8W5Ffhyy3cXRQ8W1qeN
	 RO1pVbaELBUG77Cpm2gj2Kg/KSFIyv8/ESeICwpQFGTpNKAYpx78H9+/4AK7jzqdgM
	 J/dSHbdmM6OAh3JFhCQFo+OhjxQc9meDO5S/8S+hV8AyJv+sp1BqLnSLCmXIbqc8/6
	 ldPiGE4Zu1Z0A==
From: Leon Romanovsky <leon@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	Christoph Hellwig <hch@lst.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Alexander Potapenko <glider@google.com>,
	Marco Elver <elver@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	=?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	iommu@lists.linux.dev,
	virtualization@lists.linux.dev,
	kasan-dev@googlegroups.com,
	linux-trace-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 7/8] dma-mapping: export new dma_*map_phys() interface
Date: Wed, 25 Jun 2025 16:19:04 +0300
Message-ID: <7013881bb86a37e92ffaf93de6f53701943bf717.1750854543.git.leon@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1750854543.git.leon@kernel.org>
References: <cover.1750854543.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

Introduce new DMA mapping functions dma_map_phys() and dma_unmap_phys()
that operate directly on physical addresses instead of page+offset
parameters. This provides a more efficient interface for drivers that
already have physical addresses available.

The new functions are implemented as the primary mapping layer, with
the existing dma_map_page_attrs() and dma_unmap_page_attrs() functions
converted to simple wrappers around the phys-based implementations.

The old page-based API is preserved in mapping.c to ensure that existing
code won't be affected by changing EXPORT_SYMBOL to EXPORT_SYMBOL_GPL
variant for dma_*map_phys().

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 include/linux/dma-mapping.h | 13 +++++++++++++
 kernel/dma/mapping.c        | 25 ++++++++++++++++++++-----
 2 files changed, 33 insertions(+), 5 deletions(-)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 55c03e5fe8cb..ba54bbeca861 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -118,6 +118,10 @@ dma_addr_t dma_map_page_attrs(struct device *dev, struct page *page,
 		unsigned long attrs);
 void dma_unmap_page_attrs(struct device *dev, dma_addr_t addr, size_t size,
 		enum dma_data_direction dir, unsigned long attrs);
+dma_addr_t dma_map_phys(struct device *dev, phys_addr_t phys, size_t size,
+		enum dma_data_direction dir, unsigned long attrs);
+void dma_unmap_phys(struct device *dev, dma_addr_t addr, size_t size,
+		enum dma_data_direction dir, unsigned long attrs);
 unsigned int dma_map_sg_attrs(struct device *dev, struct scatterlist *sg,
 		int nents, enum dma_data_direction dir, unsigned long attrs);
 void dma_unmap_sg_attrs(struct device *dev, struct scatterlist *sg,
@@ -172,6 +176,15 @@ static inline void dma_unmap_page_attrs(struct device *dev, dma_addr_t addr,
 		size_t size, enum dma_data_direction dir, unsigned long attrs)
 {
 }
+static inline dma_addr_t dma_map_phys(struct device *dev, phys_addr_t phys,
+		size_t size, enum dma_data_direction dir, unsigned long attrs)
+{
+	return DMA_MAPPING_ERROR;
+}
+static inline void dma_unmap_phys(struct device *dev, dma_addr_t addr,
+		size_t size, enum dma_data_direction dir, unsigned long attrs)
+{
+}
 static inline unsigned int dma_map_sg_attrs(struct device *dev,
 		struct scatterlist *sg, int nents, enum dma_data_direction dir,
 		unsigned long attrs)
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index 74efb6909103..29e8594a725a 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -152,12 +152,12 @@ static inline bool dma_map_direct(struct device *dev,
 	return dma_go_direct(dev, *dev->dma_mask, ops);
 }
 
-dma_addr_t dma_map_page_attrs(struct device *dev, struct page *page,
-		size_t offset, size_t size, enum dma_data_direction dir,
-		unsigned long attrs)
+dma_addr_t dma_map_phys(struct device *dev, phys_addr_t phys, size_t size,
+		enum dma_data_direction dir, unsigned long attrs)
 {
 	const struct dma_map_ops *ops = get_dma_ops(dev);
-	phys_addr_t phys = page_to_phys(page) + offset;
+	struct page *page = phys_to_page(phys);
+	size_t offset = offset_in_page(page);
 	bool is_pfn_valid = true;
 	dma_addr_t addr;
 
@@ -191,9 +191,17 @@ dma_addr_t dma_map_page_attrs(struct device *dev, struct page *page,
 
 	return addr;
 }
+EXPORT_SYMBOL_GPL(dma_map_phys);
+
+dma_addr_t dma_map_page_attrs(struct device *dev, struct page *page,
+		size_t offset, size_t size, enum dma_data_direction dir,
+		unsigned long attrs)
+{
+	return dma_map_phys(dev, page_to_phys(page) + offset, size, dir, attrs);
+}
 EXPORT_SYMBOL(dma_map_page_attrs);
 
-void dma_unmap_page_attrs(struct device *dev, dma_addr_t addr, size_t size,
+void dma_unmap_phys(struct device *dev, dma_addr_t addr, size_t size,
 		enum dma_data_direction dir, unsigned long attrs)
 {
 	const struct dma_map_ops *ops = get_dma_ops(dev);
@@ -209,6 +217,13 @@ void dma_unmap_page_attrs(struct device *dev, dma_addr_t addr, size_t size,
 	trace_dma_unmap_phys(dev, addr, size, dir, attrs);
 	debug_dma_unmap_phys(dev, addr, size, dir);
 }
+EXPORT_SYMBOL_GPL(dma_unmap_phys);
+
+void dma_unmap_page_attrs(struct device *dev, dma_addr_t addr, size_t size,
+		 enum dma_data_direction dir, unsigned long attrs)
+{
+	dma_unmap_phys(dev, addr, size, dir, attrs);
+}
 EXPORT_SYMBOL(dma_unmap_page_attrs);
 
 static int __dma_map_sg_attrs(struct device *dev, struct scatterlist *sg,
-- 
2.49.0

