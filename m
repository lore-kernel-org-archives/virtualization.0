Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3104855C0C
	for <virtualization@lists.linux.dev>; Tue, 28 Nov 2023 20:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="Xko5rNb6"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-67a3fabcee3so1812546d6.0
        for <virtualization@lists.linux.dev>; Tue, 28 Nov 2023 12:49:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1701204589; x=1701809389; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GuhRNW8EraGxCVOazJoq98oeC/940DRf0iOPJkOnyXY=;
        b=Xko5rNb6oDZNdBRrZxxbEubTVlzLov53UBwkw0RijvH8EQ5g3kQiqEAojwfmid5Iq3
         cvV0eZwkKzANN8qgLs4SuygzahgU/nWQ4Nfy1ozlN0cCAs6mnnLafgWNTnOQTu8sVmhU
         w4zWOZ9Ce+0cpOUJP2fXQtWxD5bunxHd3clMl66rdN6XWJOAs0nDEmDsDrHNhgRmyiXP
         PBJyVwLRGy31bNwJTOkNW+PLj/ODpY47q0G6mXYXsgmaMts+0yzEtM+Os20fe3GiD1VA
         uhLgx2gr0C74vSd/TWiqsgXsmQ2okaMnzXWWTRo6NlUSrlyn6KmH9utowrPveBrdCXUH
         N2aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701204589; x=1701809389;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GuhRNW8EraGxCVOazJoq98oeC/940DRf0iOPJkOnyXY=;
        b=eaVQn58H/HHk63U8g8MW+LoO+ZrfC/gmAdDm34CZD0ihxoySe1xlsu1qHZDtRdzpC2
         FdsinFKal5tWFIwrqDezabmQxs+/fD4LIYQe0Sx/R92jjz9kd5gP+6H+3DfUE2FL56fB
         63RjaNCZVXICwfoZ8xBTqJ4TLnhtf8lBmmEzD8Worx7Od6cCBDq6pATsJjwX97PT3eec
         Yi3FMKIPHx0qiIEDel1CjCbUKLneJOeDkBS8cNxaOjhrZkiBzV39J26Vhx3UK1XG95Aq
         ZTU3Gzk2EptJu4CCK/YD+ZfyR4QBFwI0hFyn5168uh/RJAwqgM6dE14bbw06cyk3GvVM
         NFtg==
X-Gm-Message-State: AOJu0YxbpW1rUMFtcActh8BGXe1tlMUsvZXOZDW8VclQrJ7+bqqUNjtj
	MzN2m8//+uToAy4fKQMbHF+Bzw==
X-Google-Smtp-Source: AGHT+IGPu3upFAdCP6yNYmrLD/qlosIlP36YcCIt0RdR7fCBV7LNnnJ4icXgqHOsHyLuFzh/n11wOA==
X-Received: by 2002:a05:6214:1c0b:b0:67a:4546:9895 with SMTP id u11-20020a0562141c0b00b0067a45469895mr14672496qvc.12.1701204589666;
        Tue, 28 Nov 2023 12:49:49 -0800 (PST)
Received: from soleen.c.googlers.com.com (55.87.194.35.bc.googleusercontent.com. [35.194.87.55])
        by smtp.gmail.com with ESMTPSA id d11-20020a0cfe8b000000b0067a56b6adfesm1056863qvs.71.2023.11.28.12.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 12:49:49 -0800 (PST)
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
Subject: [PATCH 09/16] iommu/iommufd: use page allocation function provided by iommu-pages.h
Date: Tue, 28 Nov 2023 20:49:31 +0000
Message-ID: <20231128204938.1453583-10-pasha.tatashin@soleen.com>
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

Convert iommu/iommufd/* files to use the new page allocation functions
provided in iommu-pages.h.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 drivers/iommu/iommufd/iova_bitmap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommufd/iova_bitmap.c b/drivers/iommu/iommufd/iova_bitmap.c
index 0a92c9eeaf7f..6b8575b93f17 100644
--- a/drivers/iommu/iommufd/iova_bitmap.c
+++ b/drivers/iommu/iommufd/iova_bitmap.c
@@ -253,7 +253,7 @@ struct iova_bitmap *iova_bitmap_alloc(unsigned long iova, size_t length,
 	bitmap->iova = iova;
 	bitmap->length = length;
 	mapped->iova = iova;
-	mapped->pages = (struct page **)__get_free_page(GFP_KERNEL);
+	mapped->pages = iommu_alloc_page(GFP_KERNEL);
 	if (!mapped->pages) {
 		rc = -ENOMEM;
 		goto err;
@@ -284,7 +284,7 @@ void iova_bitmap_free(struct iova_bitmap *bitmap)
 	iova_bitmap_put(bitmap);
 
 	if (mapped->pages) {
-		free_page((unsigned long)mapped->pages);
+		iommu_free_page(mapped->pages);
 		mapped->pages = NULL;
 	}
 
-- 
2.43.0.rc2.451.g8631bc7472-goog

