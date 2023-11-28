Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D38742ABD
	for <virtualization@lists.linux.dev>; Tue, 28 Nov 2023 20:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="KAkhIpYC"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-67a3e0fb11aso16259276d6.2
        for <virtualization@lists.linux.dev>; Tue, 28 Nov 2023 12:49:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1701204596; x=1701809396; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YSGX0jW3To7/xuABL7QXXsr1KCFhu7Z9tThr0mLMrMc=;
        b=KAkhIpYCqOBLLrojVB77d6P8fCDKbqdBh74lZXjTXZlQVWt9lUtMlWcGYvQrS5wF8N
         TjEMHn4RlbI7ARSl5o50SM/pN4oZg3mY+v3nG30R5/FPKE9s2pszJj6daGJ+ydiEpM0h
         pIsmUscmMTIqZoN4188qRd+QQmtrtbzWnP7vOxmrpPorezqlTS9CKEcfQa6l+4U7t9ND
         U5vZqdLUfKVc/kOcPgo11afUrYtt3lkr2cm+FF+g3ErvYVo6In3qA+II+zp7zrKgDkIM
         hgi172jQUZUKqYIblBDNVHBf5bY2LLo8D42BsYuOTBxzAlc+TRxqbm+b5wB4EZKo0B2n
         frPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701204596; x=1701809396;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YSGX0jW3To7/xuABL7QXXsr1KCFhu7Z9tThr0mLMrMc=;
        b=JvUE8VTr+owIigk8C+3mIrDGupFpSE0Q+EHLUQBp4Ar6TAz3vpWoCitoawFVfS3wxr
         1GPNr8XsSZ5rr+SF7CwQ7RMQ4zlvMeWGpxh+UU2f1ezv+c17YorM8Yr7AABdGZHkkQV7
         rIfxoeEk8eV169cPMOMk/bPhIPZOarSLQoOVGUPox57OSF0eb/adaqXLoilNfCk+A4xx
         bkZ8vok5Gjj4gcmEx4QNCbLtrynEQtVqjCZmtFwmkaAD/vKwfbit6T18G5cmDNtZwRgy
         4ShJj57C7hslWL9UCN08ug6TrlwQxYPA0ZsfBxDRSATimfgHnK+DnprYr+euiDmT//y2
         nnEA==
X-Gm-Message-State: AOJu0YylDaYPW79VTii94MhXhvunLdJiiTFhN6HDYQWNXlDjcFukkTRf
	dpO+22Mioz+tzKZxbsV2xGXSsA==
X-Google-Smtp-Source: AGHT+IH3XyzLx3HqaxxWdryJd33MqMJHkx6z6Xt3swBEGkMdx9JQSLka9GW0WH1FkTVqo27TzFUimQ==
X-Received: by 2002:a05:6214:246f:b0:67a:4ba1:84d5 with SMTP id im15-20020a056214246f00b0067a4ba184d5mr7928400qvb.16.1701204596396;
        Tue, 28 Nov 2023 12:49:56 -0800 (PST)
Received: from soleen.c.googlers.com.com (55.87.194.35.bc.googleusercontent.com. [35.194.87.55])
        by smtp.gmail.com with ESMTPSA id d11-20020a0cfe8b000000b0067a56b6adfesm1056863qvs.71.2023.11.28.12.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 12:49:56 -0800 (PST)
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
Subject: [PATCH 16/16] vfio: account iommu allocations
Date: Tue, 28 Nov 2023 20:49:38 +0000
Message-ID: <20231128204938.1453583-17-pasha.tatashin@soleen.com>
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

iommu allocations should be accounted in order to allow admins to
monitor and limit the amount of iommu memory.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 drivers/vfio/vfio_iommu_type1.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index eacd6ec04de5..b2854d7939ce 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -1436,7 +1436,7 @@ static int vfio_iommu_map(struct vfio_iommu *iommu, dma_addr_t iova,
 	list_for_each_entry(d, &iommu->domain_list, next) {
 		ret = iommu_map(d->domain, iova, (phys_addr_t)pfn << PAGE_SHIFT,
 				npage << PAGE_SHIFT, prot | IOMMU_CACHE,
-				GFP_KERNEL);
+				GFP_KERNEL_ACCOUNT);
 		if (ret)
 			goto unwind;
 
@@ -1750,7 +1750,8 @@ static int vfio_iommu_replay(struct vfio_iommu *iommu,
 			}
 
 			ret = iommu_map(domain->domain, iova, phys, size,
-					dma->prot | IOMMU_CACHE, GFP_KERNEL);
+					dma->prot | IOMMU_CACHE,
+					GFP_KERNEL_ACCOUNT);
 			if (ret) {
 				if (!dma->iommu_mapped) {
 					vfio_unpin_pages_remote(dma, iova,
@@ -1845,7 +1846,8 @@ static void vfio_test_domain_fgsp(struct vfio_domain *domain, struct list_head *
 			continue;
 
 		ret = iommu_map(domain->domain, start, page_to_phys(pages), PAGE_SIZE * 2,
-				IOMMU_READ | IOMMU_WRITE | IOMMU_CACHE, GFP_KERNEL);
+				IOMMU_READ | IOMMU_WRITE | IOMMU_CACHE,
+				GFP_KERNEL_ACCOUNT);
 		if (!ret) {
 			size_t unmapped = iommu_unmap(domain->domain, start, PAGE_SIZE);
 
-- 
2.43.0.rc2.451.g8631bc7472-goog

