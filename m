Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446495C080
	for <virtualization@lists.linux.dev>; Tue, 28 Nov 2023 20:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="hRAALFrS"
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-db40b699d2bso5356654276.1
        for <virtualization@lists.linux.dev>; Tue, 28 Nov 2023 12:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1701204589; x=1701809389; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S6nAo2mT7pHcrL/oNBUQ6H06jfJ0V1n29MMcCYzl3v8=;
        b=hRAALFrSBf8iA8Z0eUPgWobZcR0yVPAZa31juWJtPiuYKKtY3l/OMctlXM5ijn7/Hs
         SIQXShk1paL5rc5D6CyeZxxG2XqZbU0YGtMu3BaPZ7S7gls1C6pMehsXV79V9EkvWeZA
         fxI+3aJEA+2Fm+3F/zacblJKgpD3ZwhiIPMk3YDglkSqgduX+wBeYHu1OZuUr2WbOtEV
         PAeZpkwsfB7ySnxS24wgKPuZoiPU0vhwM5P2i3MWi7w1/CNGHE9TDO0XPVyFHn1HqRrO
         EcdtT+RAjT5mqUZnjmvN5lrdD3jYj2CBnWKqzJ5C3BdVu0aVbVQUfM89KnEkJG069BXD
         YlKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701204589; x=1701809389;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S6nAo2mT7pHcrL/oNBUQ6H06jfJ0V1n29MMcCYzl3v8=;
        b=qf3mViSKD92Upz0KvpD017sISlwPRdkA6GCeUkgQf0BoykrypnuxwYNK2R7Bx6RsrK
         esRNQv20G9q0931/6gUikdnEGIhUBqZ32cRPRq1UxMAyn/6IuLxGj+b6zuaf6ybjwZ5t
         9C1kKbPGpBTMIw7fZnXFFr1Fc74eYppqe4PW6BcDY6bQYi2zIPe5nCAhxq5embCoUvYe
         wYXQKFxQPhiM29jehNKsilt/Ew6TgGDSYaNNosjbc4QbFF1CT5OeqmZdhC43Yc7vAYlr
         RXnBtKbwFl1sT0V9E/+rCo5LLLmdjbX8vR9NZ10UiLFrnA1u5JVXCZFpRrxNvhJNp0kN
         zyHw==
X-Gm-Message-State: AOJu0YwJv/+D/kFtkkqtT9KmMmQ/5u/BAkc1OCzdz+10GMeqY0mfasQL
	3hNPyj/7fVSBLJ1LZJuJ0yW9iw==
X-Google-Smtp-Source: AGHT+IHzqIoJvEd/INF3AF90sz+4QhWdk8I4ronh0w1gK1vKHyIxxYwztLst06FhLLj54D6SeAj/qg==
X-Received: by 2002:a25:68c7:0:b0:da0:c6ae:ad0e with SMTP id d190-20020a2568c7000000b00da0c6aead0emr15080570ybc.21.1701204588830;
        Tue, 28 Nov 2023 12:49:48 -0800 (PST)
Received: from soleen.c.googlers.com.com (55.87.194.35.bc.googleusercontent.com. [35.194.87.55])
        by smtp.gmail.com with ESMTPSA id d11-20020a0cfe8b000000b0067a56b6adfesm1056863qvs.71.2023.11.28.12.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 12:49:48 -0800 (PST)
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
Subject: [PATCH 08/16] iommu/fsl: use page allocation function provided by iommu-pages.h
Date: Tue, 28 Nov 2023 20:49:30 +0000
Message-ID: <20231128204938.1453583-9-pasha.tatashin@soleen.com>
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

Convert iommu/fsl_pamu.c to use the new page allocation functions
provided in iommu-pages.h.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 drivers/iommu/fsl_pamu.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/fsl_pamu.c b/drivers/iommu/fsl_pamu.c
index f37d3b044131..7bfb49940f0c 100644
--- a/drivers/iommu/fsl_pamu.c
+++ b/drivers/iommu/fsl_pamu.c
@@ -16,6 +16,7 @@
 #include <linux/platform_device.h>
 
 #include <asm/mpc85xx.h>
+#include "iommu-pages.h"
 
 /* define indexes for each operation mapping scenario */
 #define OMI_QMAN        0x00
@@ -828,7 +829,7 @@ static int fsl_pamu_probe(struct platform_device *pdev)
 		(PAGE_SIZE << get_order(OMT_SIZE));
 	order = get_order(mem_size);
 
-	p = alloc_pages(GFP_KERNEL | __GFP_ZERO, order);
+	p = __iommu_alloc_pages(GFP_KERNEL, order);
 	if (!p) {
 		dev_err(dev, "unable to allocate PAACT/SPAACT/OMT block\n");
 		ret = -ENOMEM;
@@ -916,7 +917,7 @@ static int fsl_pamu_probe(struct platform_device *pdev)
 		iounmap(guts_regs);
 
 	if (ppaact)
-		free_pages((unsigned long)ppaact, order);
+		iommu_free_pages(ppaact, order);
 
 	ppaact = NULL;
 
-- 
2.43.0.rc2.451.g8631bc7472-goog

