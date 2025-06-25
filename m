Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93273269B08;
	Wed, 25 Jun 2025 13:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750857578; cv=none; b=FppWF8lS+1+a+BJ7mMV8oYnvU+9L5C9b8tldz/wUrLtb6xNrQzxeC1rKWt9wjtvETJOwb6kkrpvMTH8EIYO2PMN+TIGpsAZaeIkHJBvAlxm0FI8qkB36ZFwD6T09lxAhUDx0Jet75bmSNaFCG3iPZIkgtNYPt4ARLhTeGE/9qlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750857578; c=relaxed/simple;
	bh=pv7jnMJTkJVOWVb/twnbCICvjtCn/HJgKS2K42rWa78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SMZGGKidSHzVcn89nwmjRY+4Kfu5oVv3xA+Pm58juHHrxivCwmIOsnkQOCgQ/2tNOaoe8FMkuR/WD/JoaEPRtcWmPSRkZT+RM4GDCnPi43usLFHY4JcFfjN0o5pBU02v9cOyj9jseaV4l1korkXVwKEbS/aOL+0K/I+DDpe2kpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JmvSEIY+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JmvSEIY+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C193CC4CEEA;
	Wed, 25 Jun 2025 13:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750857578;
	bh=pv7jnMJTkJVOWVb/twnbCICvjtCn/HJgKS2K42rWa78=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JmvSEIY+7ban/csViJFvTitjdhG8lqD1RrM9Bs5vfSX9RUXW8VcItqnFKYK2IHLEp
	 Oj2lQpsBja99AvsQZszqc5HRTCd6sTT2RtsSsG6njLkXmU7qMY7Vv1lVgBzXyQPbYb
	 mwcqp68DZHG0wv/LITtswgnUm5CJOJrlmJA71Izf1q+m6fso9FWpqVFZFJs+E3/PJL
	 bafB00mS656RTCoymMmH42juG8s5ossf9tDfV3oq8Q1fChuX8RreRxr/WBdOxO1x0w
	 XEs/Im4vy1Epw96JlCjF5ya6mj/Q07IUEwpzgcRddZa4ZUr/RT6TslLGklPWGDJsVe
	 KAxqIq8HM4v0Q==
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
Subject: [PATCH 6/8] dma-mapping: fail early if physical address is mapped through platform callback
Date: Wed, 25 Jun 2025 16:19:03 +0300
Message-ID: <5fc1f0ca52a85834b3e978c5d6a3171d7dd3c194.1750854543.git.leon@kernel.org>
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

All platforms which implement map_page interface don't support physical
addresses without real struct page. Add condition to check it.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 kernel/dma/mapping.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index 709405d46b2b..74efb6909103 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -158,6 +158,7 @@ dma_addr_t dma_map_page_attrs(struct device *dev, struct page *page,
 {
 	const struct dma_map_ops *ops = get_dma_ops(dev);
 	phys_addr_t phys = page_to_phys(page) + offset;
+	bool is_pfn_valid = true;
 	dma_addr_t addr;
 
 	BUG_ON(!valid_dma_direction(dir));
@@ -170,8 +171,20 @@ dma_addr_t dma_map_page_attrs(struct device *dev, struct page *page,
 		addr = dma_direct_map_phys(dev, phys, size, dir, attrs);
 	else if (use_dma_iommu(dev))
 		addr = iommu_dma_map_phys(dev, phys, size, dir, attrs);
-	else
+	else {
+		if (IS_ENABLED(CONFIG_DMA_API_DEBUG))
+			is_pfn_valid = pfn_valid(PHYS_PFN(phys));
+
+		if (unlikely(!is_pfn_valid))
+			return DMA_MAPPING_ERROR;
+
+		/*
+		 * All platforms which implement .map_page() don't support
+		 * non-struct page backed addresses.
+		 */
 		addr = ops->map_page(dev, page, offset, size, dir, attrs);
+	}
+
 	kmsan_handle_dma(phys, size, dir);
 	trace_dma_map_phys(dev, phys, addr, size, dir, attrs);
 	debug_dma_map_phys(dev, phys, size, dir, addr, attrs);
-- 
2.49.0

