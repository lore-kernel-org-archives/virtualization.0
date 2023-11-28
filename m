Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE7E42AB3
	for <virtualization@lists.linux.dev>; Tue, 28 Nov 2023 20:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="g96RUD2M"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-67a44ee7ab3so16623766d6.0
        for <virtualization@lists.linux.dev>; Tue, 28 Nov 2023 12:49:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1701204595; x=1701809395; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iygGvNb1KE298FiVkmeH8gdBVxeTTuJw4eGKIF/nIuM=;
        b=g96RUD2MOY1Bvm1FLg7x/+xgNZNHsFe/a5met5K5jH9N40+hWJYrTU4ik+TAI/8OYg
         b4QwzX/uv3J8AWxtFq4Ijj6ZEajpiR+znDJXdI+G1eTKD7K/WGelLofRz9pXl1ZO1DlU
         N5vuiW73n62x8UYdIW93nZCgoaxdJ4Z1QzkvJffJMAJTbh1bkMoVjuRenByX+Fj+jKfA
         I8vOvc1g7NCbG9q78jbwtPRLORPbz4DrbmJ4+T7dwWHhd5HKexTuOQGjm0G8sFmR4wHX
         vsBShE7aEPUNr4BkRSrTeX5Qe1MBrCqE/QsZWkRKQRiS7wWYMAHUCI7nLpqAemTxenRG
         OgqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701204595; x=1701809395;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iygGvNb1KE298FiVkmeH8gdBVxeTTuJw4eGKIF/nIuM=;
        b=GdiaDk8C8mRRXvc4Qrt5XVsKsT04RdiPOJFfQBT4+sdIAIoUAJdOK92iDMN3jl/uwu
         Kamu1GsA2iT+IJgD/WmRq2b0PdV4+lsDVxvRvBrYzf0YjypYQp0VaE7VfHeyF8m6MOdc
         x1/Jf4s8J5VKM/AAyNB//bDznfFIg/WgNk7+v0OMOuuXUL602V1vaqtEj7MJ4b2sikDV
         hJpjZ4HsmJuKUVsaEelsgBBgnWBnQrTIvD2slnkyhd2Ntzd2HIUt4TuFrN3nPkXvsSUj
         ePhWJA7PU+2zL7EHkXjIfY/aUlhBEy2WFTByxetubQ0koiW/hUDXzqrDDJ56fo4yLLqt
         Dy5Q==
X-Gm-Message-State: AOJu0YyS8MemzDwiUzGTMo8axR54FK9F6Dv2r9taU+Je4Zx5qwgheqI+
	Rtgx09HcnB7nF/d4zkIopm1+PA==
X-Google-Smtp-Source: AGHT+IE0Jl3QLEggdMt0xv2T8AyvhzkahJgD3VRGmfbhI7sqHJ8Aa/AdHKiYq6E8wbv77IBFZbLYmg==
X-Received: by 2002:ad4:5dc6:0:b0:67a:21aa:6513 with SMTP id m6-20020ad45dc6000000b0067a21aa6513mr18119809qvh.17.1701204595440;
        Tue, 28 Nov 2023 12:49:55 -0800 (PST)
Received: from soleen.c.googlers.com.com (55.87.194.35.bc.googleusercontent.com. [35.194.87.55])
        by smtp.gmail.com with ESMTPSA id d11-20020a0cfe8b000000b0067a56b6adfesm1056863qvs.71.2023.11.28.12.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 12:49:54 -0800 (PST)
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
Subject: [PATCH 15/16] vhost-vdpa: account iommu allocations
Date: Tue, 28 Nov 2023 20:49:37 +0000
Message-ID: <20231128204938.1453583-16-pasha.tatashin@soleen.com>
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
 drivers/vhost/vdpa.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index da7ec77cdaff..a51c69c078d9 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -968,7 +968,8 @@ static int vhost_vdpa_map(struct vhost_vdpa *v, struct vhost_iotlb *iotlb,
 			r = ops->set_map(vdpa, asid, iotlb);
 	} else {
 		r = iommu_map(v->domain, iova, pa, size,
-			      perm_to_iommu_flags(perm), GFP_KERNEL);
+			      perm_to_iommu_flags(perm),
+			      GFP_KERNEL_ACCOUNT);
 	}
 	if (r) {
 		vhost_iotlb_del_range(iotlb, iova, iova + size - 1);
-- 
2.43.0.rc2.451.g8631bc7472-goog

