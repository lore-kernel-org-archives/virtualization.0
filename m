Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6785F59B5C
	for <virtualization@lists.linux.dev>; Tue, 28 Nov 2023 20:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="JUbNNyj3"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-77d6f853ba0so17354185a.0
        for <virtualization@lists.linux.dev>; Tue, 28 Nov 2023 12:49:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1701204584; x=1701809384; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=agdpEgslqhHdhrn0hnWdDpIJa9Hen54IbPQiTYhpn3E=;
        b=JUbNNyj3i1jj8ldgTdT6H1nTVaBkpdD5S9T1ytuCnKCBfzoDZV+X+PWr/g9M80KvBn
         YsABdW2LwQ98MuBfrGpq1Eftu45coQNW/9ll0q2LPKEXclsQVS7DkGpkgTCXMlkEK9sE
         g1QVw/vcKk7OYEsCIqavLqbDD0bZdkv4yd8M4DeKevjq0zVka2DBqGnnVeN1IOuyUeqK
         MJsrYclzYuu9Z9WX0iPSDXhxY74OUyyZWpmEWd3fFTShXs5YcqsNuMNaaZRjvwbsfTZM
         kSeNHWWIQn0yk0xnuM0YdmPto7rKrpLV2VeJjbGVGWKAGrVrdZ4D9aAPZU1dEPst5DSG
         XK3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701204584; x=1701809384;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=agdpEgslqhHdhrn0hnWdDpIJa9Hen54IbPQiTYhpn3E=;
        b=q5WOmKsboex7EoQdcd7LvWjvi803MQDOsKSx0zOxySnwMC1Ostk2Qar8Z+8aqY1BoI
         BiM72q86M3QBcmBqJkO/8W57nArdSTYtIlqkdgXJxd7znQRfFkBZOcwVtYnOCzRnD/mE
         YdjJq2nL6904kxUvkODdxUiO12cX/VXUnFbWpXhs09ui/8eUHjVexnmETGW6gLUJEONx
         vZaK0eAWlSWYu01NC/PrCfvCrWqr24f7MqagtdvYG4SqO5axj0+VUvBPcZRcAtFaCTHx
         Cx6wM8pKeWl+gLBjwgV7fdkX/b4VvaMzPJPdXFpGNcoVd2RWUxwYsHVEOGodEqgjqmfa
         BprQ==
X-Gm-Message-State: AOJu0YytsX58GBQ4l6qkZhkfwLxus899J6TXFBh/5XwsttsBHDjkQ1ZU
	IMXL9LqUojtclWKJe0ixF+vZhw==
X-Google-Smtp-Source: AGHT+IGsN1gYKfhSPZCpUVGbGKIu06D7uLG0xM+OZwtg49W/WqG56O+xCl6uRGYTfUcoNhDPZKc9YQ==
X-Received: by 2002:a05:6214:2249:b0:67a:52eb:7a00 with SMTP id c9-20020a056214224900b0067a52eb7a00mr10312900qvc.7.1701204584210;
        Tue, 28 Nov 2023 12:49:44 -0800 (PST)
Received: from soleen.c.googlers.com.com (55.87.194.35.bc.googleusercontent.com. [35.194.87.55])
        by smtp.gmail.com with ESMTPSA id d11-20020a0cfe8b000000b0067a56b6adfesm1056863qvs.71.2023.11.28.12.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 12:49:43 -0800 (PST)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: akpm@linux-foundation.org,
	alex.williamson@redhat.com,
	alim.akhtar@samsung.com,
	alyssa@rosenzweig.io,
	asahi@lists.linux.dev,
	baolu.lu@linux.intel.com,
	bhelgaas@google.com,
	cgroups@vger.kernel.org,
	corbet@lwn.net,
	david@redhat.com,
	dwmw2@infradead.org,
	hannes@cmpxchg.org,
	heiko@sntech.de,
	iommu@lists.linux.dev,
	jasowang@redhat.com,
	jernej.skrabec@gmail.com,
	jgg@ziepe.ca,
	jonathanh@nvidia.com,
	joro@8bytes.org,
	kevin.tian@intel.com,
	krzysztof.kozlowski@linaro.org,
	kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-rockchip@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	linux-tegra@vger.kernel.org,
	lizefan.x@bytedance.com,
	marcan@marcan.st,
	mhiramat@kernel.org,
	mst@redhat.com,
	m.szyprowski@samsung.com,
	netdev@vger.kernel.org,
	pasha.tatashin@soleen.com,
	paulmck@kernel.org,
	rdunlap@infradead.org,
	robin.murphy@arm.com,
	samuel@sholland.org,
	suravee.suthikulpanit@amd.com,
	sven@svenpeter.dev,
	thierry.reding@gmail.com,
	tj@kernel.org,
	tomas.mudrunka@gmail.com,
	vdumpa@nvidia.com,
	virtualization@lists.linux.dev,
	wens@csie.org,
	will@kernel.org,
	yu-cheng.yu@intel.com
Subject: [PATCH 03/16] iommu/io-pgtable-arm: use page allocation function provided by iommu-pages.h
Date: Tue, 28 Nov 2023 20:49:25 +0000
Message-ID: <20231128204938.1453583-4-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
In-Reply-To: <20231128204938.1453583-1-pasha.tatashin@soleen.com>
References: <20231128204938.1453583-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert iommu/io-pgtable-arm.c to use the new page allocation functions
provided in iommu-pages.h.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 drivers/iommu/io-pgtable-arm.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 72dcdd468cf3..21d315151ad6 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -21,6 +21,7 @@
 #include <asm/barrier.h>
 
 #include "io-pgtable-arm.h"
+#include "iommu-pages.h"
 
 #define ARM_LPAE_MAX_ADDR_BITS		52
 #define ARM_LPAE_S2_MAX_CONCAT_PAGES	16
@@ -197,7 +198,7 @@ static void *__arm_lpae_alloc_pages(size_t size, gfp_t gfp,
 	void *pages;
 
 	VM_BUG_ON((gfp & __GFP_HIGHMEM));
-	p = alloc_pages_node(dev_to_node(dev), gfp | __GFP_ZERO, order);
+	p = __iommu_alloc_pages_node(dev_to_node(dev), gfp, order);
 	if (!p)
 		return NULL;
 
@@ -221,7 +222,7 @@ static void *__arm_lpae_alloc_pages(size_t size, gfp_t gfp,
 	dev_err(dev, "Cannot accommodate DMA translation for IOMMU page tables\n");
 	dma_unmap_single(dev, dma, size, DMA_TO_DEVICE);
 out_free:
-	__free_pages(p, order);
+	__iommu_free_pages(p, order);
 	return NULL;
 }
 
@@ -231,7 +232,7 @@ static void __arm_lpae_free_pages(void *pages, size_t size,
 	if (!cfg->coherent_walk)
 		dma_unmap_single(cfg->iommu_dev, __arm_lpae_dma_addr(pages),
 				 size, DMA_TO_DEVICE);
-	free_pages((unsigned long)pages, get_order(size));
+	iommu_free_pages(pages, get_order(size));
 }
 
 static void __arm_lpae_sync_pte(arm_lpae_iopte *ptep, int num_entries,
-- 
2.43.0.rc2.451.g8631bc7472-goog

