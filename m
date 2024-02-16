Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1FE12EBE8
	for <virtualization@lists.linux.dev>; Fri, 16 Feb 2024 14:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708094438; cv=none; b=CqY2Ka5txuD1JaHF5GqffEv5WDrxWueaQ5bj3YIf4xtkzs1clvL0OEl4NEj8kyi2qDM0F+Vx4XTdyW7rnw2jTL0mLIWp0wV7b0ddViLzAy/tm2LIPDG9H1Xjwg57NItvcaB4y8zuEn/qsImQwTHLdl2zCpAj7DIvCY/L21rEKKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708094438; c=relaxed/simple;
	bh=VNML90UaXktZKuCOd5A/cwVT7pPIGW6JzGtZcT2C/jA=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YLMG6fu8XdZLD0nrIz/vriugd/tAHd76nrfP4KpLd61Pa6XT4/FG9C2T7YbyeqiUKROrYv3+am/IReI6J9rQssemkI8VdTTSEVI5/Nq8NqMFaX5bFmC9oWIKCwRzbfk60tIU07kXdOklVGioQ2xUm0+PnS7r0381RhlvbtDtwmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yw9RTXmO; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yw9RTXmO"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a2f79e79f0cso316929366b.2
        for <virtualization@lists.linux.dev>; Fri, 16 Feb 2024 06:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708094434; x=1708699234; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WJiF2hWzkU3/F88EHjNDrbxkoRCZ4txRyg+xgBcF7fk=;
        b=yw9RTXmOVb69/qP10MCTN51NUz/lqyQpnHL2r8By3HCyGX7V51wU0GxTdWzQf8kBHo
         ENx5g98gw2YZD21l1UJIv4sRaQynX5EPf4HkZC4Zlk2eucNSGOp8tMfRdxAv7YXalK+F
         9MIRR75i355Mz5SRosE/9TNBZqbpsVgOc14uCEVEKrK94Gxr8cJCHAIUZJlC/DXjuf0W
         vJOkM9gBuwlfINnnhr9ZnRKrsaZp31pCPI7AJUcqC92NbkJnN7+0iPRUF3gYGdxq93xe
         AsaZhBvVy5XkrfXELcL2e3DKlR2zpNSm2XYHhFN9QMWlN3nLmt9eWyswKgymtqq99vLd
         6vJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708094434; x=1708699234;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WJiF2hWzkU3/F88EHjNDrbxkoRCZ4txRyg+xgBcF7fk=;
        b=F952NfdkGZtR0GFzOAkfS5K3RU1c9CugGLzIhsWynfCxJ7GlpXFHwXciZFArwDfSvJ
         gSskvFqExlfWvTn89a5xrZfKEzjYtDMXJYSvrZl0bIR20wnXGb8jusSBb1Pkrd+Sl7dw
         pisp5Fikrf/lAXqNjLih/sBqSsB/nh9is0bAL7niFaShq7h2ueShnCMgcByjp7oZfxqr
         A2boIo9dyMywA/Wl2Tgw7SIEllK5e5/OQSObCnp8uYFggsS5Vvlopvkgy1FS4vHT7NNe
         op4ac4K8aUjLyDe6KyqCeJ2+C8a5PvYw7PDXAkL1lFxcI8YAzGgmrjS1EpvPydpCQtLJ
         ERkg==
X-Forwarded-Encrypted: i=1; AJvYcCX9daQgeELJvsFy0CcD7Gr5pZbhxcccEgvcQO5k/ARMMw6PEs4guyUTkC9bbC46AkIwE+W2ah8q5dKTC6BwDwWdFZnYjCMVPdgn7NmKDSA=
X-Gm-Message-State: AOJu0Ywd68xqG5RB198IOstg6IvFqUdKXjm/B3UH4SHpBKTHUut1yl9L
	JasmuGMQOODbz0lq04lB+62MiLJ96IlRva1xusIRI2AkffKKrpVNn7qHvSKjGu4=
X-Google-Smtp-Source: AGHT+IFP5HHX1guzF/48MOqdlDZBBAfEIzlz2cxyflX0prrbUITF2QEfGuDa23nujSq4oJPlrwTGyw==
X-Received: by 2002:a17:906:2c0c:b0:a3d:ab64:7525 with SMTP id e12-20020a1709062c0c00b00a3dab647525mr3120223ejh.11.1708094434431;
        Fri, 16 Feb 2024 06:40:34 -0800 (PST)
Received: from krzk-bin.. ([78.10.207.130])
        by smtp.gmail.com with ESMTPSA id a8-20020a170906670800b00a3ce3c5b2a4sm1592942ejp.195.2024.02.16.06.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 06:40:33 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Hector Martin <marcan@marcan.st>,
	Sven Peter <sven@svenpeter.dev>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Rob Clark <robdclark@gmail.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Yong Wu <yong.wu@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Krishna Reddy <vdumpa@nvidia.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-tegra@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: [PATCH 2/4] iommu: constify of_phandle_args in xlate
Date: Fri, 16 Feb 2024 15:40:25 +0100
Message-Id: <20240216144027.185959-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240216144027.185959-1-krzysztof.kozlowski@linaro.org>
References: <20240216144027.185959-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The xlate callbacks are supposed to translate of_phandle_args to proper
provider without modifying the of_phandle_args.  Make the argument
pointer to const for code safety and readability.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/iommu/apple-dart.c                  | 3 ++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 3 ++-
 drivers/iommu/arm/arm-smmu/arm-smmu.c       | 3 ++-
 drivers/iommu/arm/arm-smmu/qcom_iommu.c     | 3 ++-
 drivers/iommu/exynos-iommu.c                | 2 +-
 drivers/iommu/iommu.c                       | 2 +-
 drivers/iommu/ipmmu-vmsa.c                  | 4 ++--
 drivers/iommu/msm_iommu.c                   | 4 ++--
 drivers/iommu/mtk_iommu.c                   | 3 ++-
 drivers/iommu/mtk_iommu_v1.c                | 3 ++-
 drivers/iommu/rockchip-iommu.c              | 2 +-
 drivers/iommu/sprd-iommu.c                  | 3 ++-
 drivers/iommu/sun50i-iommu.c                | 2 +-
 drivers/iommu/tegra-smmu.c                  | 4 ++--
 drivers/iommu/virtio-iommu.c                | 3 ++-
 include/linux/iommu.h                       | 4 ++--
 16 files changed, 28 insertions(+), 20 deletions(-)

diff --git a/drivers/iommu/apple-dart.c b/drivers/iommu/apple-dart.c
index ef3ee95706da..eb1e62cd499a 100644
--- a/drivers/iommu/apple-dart.c
+++ b/drivers/iommu/apple-dart.c
@@ -779,7 +779,8 @@ static void apple_dart_domain_free(struct iommu_domain *domain)
 	kfree(dart_domain);
 }
 
-static int apple_dart_of_xlate(struct device *dev, struct of_phandle_args *args)
+static int apple_dart_of_xlate(struct device *dev,
+			       const struct of_phandle_args *args)
 {
 	struct apple_dart_master_cfg *cfg = dev_iommu_priv_get(dev);
 	struct platform_device *iommu_pdev = of_find_device_by_node(args->np);
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 0ffb1cf17e0b..4434d6a2fc2f 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2739,7 +2739,8 @@ static int arm_smmu_enable_nesting(struct iommu_domain *domain)
 	return ret;
 }
 
-static int arm_smmu_of_xlate(struct device *dev, struct of_phandle_args *args)
+static int arm_smmu_of_xlate(struct device *dev,
+			     const struct of_phandle_args *args)
 {
 	return iommu_fwspec_add_ids(dev, args->args, 1);
 }
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index 68b6bc5e7c71..8e5e4ab5fad3 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -1551,7 +1551,8 @@ static int arm_smmu_set_pgtable_quirks(struct iommu_domain *domain,
 	return ret;
 }
 
-static int arm_smmu_of_xlate(struct device *dev, struct of_phandle_args *args)
+static int arm_smmu_of_xlate(struct device *dev,
+			     const struct of_phandle_args *args)
 {
 	u32 mask, fwid = 0;
 
diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
index 17a1c163fef6..e079bb7a993e 100644
--- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
+++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
@@ -546,7 +546,8 @@ static struct iommu_device *qcom_iommu_probe_device(struct device *dev)
 	return &qcom_iommu->iommu;
 }
 
-static int qcom_iommu_of_xlate(struct device *dev, struct of_phandle_args *args)
+static int qcom_iommu_of_xlate(struct device *dev,
+			       const struct of_phandle_args *args)
 {
 	struct qcom_iommu_dev *qcom_iommu;
 	struct platform_device *iommu_pdev;
diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 2c6e9094f1e9..d98c9161948a 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -1431,7 +1431,7 @@ static void exynos_iommu_release_device(struct device *dev)
 }
 
 static int exynos_iommu_of_xlate(struct device *dev,
-				 struct of_phandle_args *spec)
+				 const struct of_phandle_args *spec)
 {
 	struct platform_device *sysmmu = of_find_device_by_node(spec->np);
 	struct exynos_iommu_owner *owner = dev_iommu_priv_get(dev);
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 170329a085b8..26a31ba4f72d 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3038,7 +3038,7 @@ void iommu_fwspec_free(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(iommu_fwspec_free);
 
-int iommu_fwspec_add_ids(struct device *dev, u32 *ids, int num_ids)
+int iommu_fwspec_add_ids(struct device *dev, const u32 *ids, int num_ids)
 {
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	int i, new_num;
diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index ace1fc4bd34b..cd7219319c8b 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -709,7 +709,7 @@ static phys_addr_t ipmmu_iova_to_phys(struct iommu_domain *io_domain,
 }
 
 static int ipmmu_init_platform_device(struct device *dev,
-				      struct of_phandle_args *args)
+				      const struct of_phandle_args *args)
 {
 	struct platform_device *ipmmu_pdev;
 
@@ -773,7 +773,7 @@ static bool ipmmu_device_is_allowed(struct device *dev)
 }
 
 static int ipmmu_of_xlate(struct device *dev,
-			  struct of_phandle_args *spec)
+			  const struct of_phandle_args *spec)
 {
 	if (!ipmmu_device_is_allowed(dev))
 		return -ENODEV;
diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
index 67124f4228b1..d4c0f2ad184b 100644
--- a/drivers/iommu/msm_iommu.c
+++ b/drivers/iommu/msm_iommu.c
@@ -588,7 +588,7 @@ static void print_ctx_regs(void __iomem *base, int ctx)
 
 static int insert_iommu_master(struct device *dev,
 				struct msm_iommu_dev **iommu,
-				struct of_phandle_args *spec)
+				const struct of_phandle_args *spec)
 {
 	struct msm_iommu_ctx_dev *master = dev_iommu_priv_get(dev);
 	int sid;
@@ -616,7 +616,7 @@ static int insert_iommu_master(struct device *dev,
 }
 
 static int qcom_iommu_of_xlate(struct device *dev,
-			       struct of_phandle_args *spec)
+			       const struct of_phandle_args *spec)
 {
 	struct msm_iommu_dev *iommu = NULL, *iter;
 	unsigned long flags;
diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 7abe9e85a570..955de8fb7732 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -957,7 +957,8 @@ static struct iommu_group *mtk_iommu_device_group(struct device *dev)
 	return group;
 }
 
-static int mtk_iommu_of_xlate(struct device *dev, struct of_phandle_args *args)
+static int mtk_iommu_of_xlate(struct device *dev,
+			      const struct of_phandle_args *args)
 {
 	struct platform_device *m4updev;
 
diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
index 25b41222abae..ae16d8238d84 100644
--- a/drivers/iommu/mtk_iommu_v1.c
+++ b/drivers/iommu/mtk_iommu_v1.c
@@ -398,7 +398,8 @@ static const struct iommu_ops mtk_iommu_v1_ops;
  * MTK generation one iommu HW only support one iommu domain, and all the client
  * sharing the same iova address space.
  */
-static int mtk_iommu_v1_create_mapping(struct device *dev, struct of_phandle_args *args)
+static int mtk_iommu_v1_create_mapping(struct device *dev,
+				       const struct of_phandle_args *args)
 {
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	struct mtk_iommu_v1_data *data;
diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index 2685861c0a12..da79d9f4cf63 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -1140,7 +1140,7 @@ static void rk_iommu_release_device(struct device *dev)
 }
 
 static int rk_iommu_of_xlate(struct device *dev,
-			     struct of_phandle_args *args)
+			     const struct of_phandle_args *args)
 {
 	struct platform_device *iommu_dev;
 	struct rk_iommudata *data;
diff --git a/drivers/iommu/sprd-iommu.c b/drivers/iommu/sprd-iommu.c
index 537359f10997..ba53571a8239 100644
--- a/drivers/iommu/sprd-iommu.c
+++ b/drivers/iommu/sprd-iommu.c
@@ -390,7 +390,8 @@ static struct iommu_device *sprd_iommu_probe_device(struct device *dev)
 	return &sdev->iommu;
 }
 
-static int sprd_iommu_of_xlate(struct device *dev, struct of_phandle_args *args)
+static int sprd_iommu_of_xlate(struct device *dev,
+			       const struct of_phandle_args *args)
 {
 	struct platform_device *pdev;
 
diff --git a/drivers/iommu/sun50i-iommu.c b/drivers/iommu/sun50i-iommu.c
index 41484a5a399b..decd52cba998 100644
--- a/drivers/iommu/sun50i-iommu.c
+++ b/drivers/iommu/sun50i-iommu.c
@@ -819,7 +819,7 @@ static struct iommu_device *sun50i_iommu_probe_device(struct device *dev)
 }
 
 static int sun50i_iommu_of_xlate(struct device *dev,
-				 struct of_phandle_args *args)
+				 const struct of_phandle_args *args)
 {
 	struct platform_device *iommu_pdev = of_find_device_by_node(args->np);
 	unsigned id = args->args[0];
diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 310871728ab4..14e525bd0d9b 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -830,7 +830,7 @@ static struct tegra_smmu *tegra_smmu_find(struct device_node *np)
 }
 
 static int tegra_smmu_configure(struct tegra_smmu *smmu, struct device *dev,
-				struct of_phandle_args *args)
+				const struct of_phandle_args *args)
 {
 	const struct iommu_ops *ops = smmu->iommu.ops;
 	int err;
@@ -959,7 +959,7 @@ static struct iommu_group *tegra_smmu_device_group(struct device *dev)
 }
 
 static int tegra_smmu_of_xlate(struct device *dev,
-			       struct of_phandle_args *args)
+			       const struct of_phandle_args *args)
 {
 	struct platform_device *iommu_pdev = of_find_device_by_node(args->np);
 	struct tegra_mc *mc = platform_get_drvdata(iommu_pdev);
diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 34db37fd9675..04048f64a2c0 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -1051,7 +1051,8 @@ static struct iommu_group *viommu_device_group(struct device *dev)
 		return generic_device_group(dev);
 }
 
-static int viommu_of_xlate(struct device *dev, struct of_phandle_args *args)
+static int viommu_of_xlate(struct device *dev,
+			   const struct of_phandle_args *args)
 {
 	return iommu_fwspec_add_ids(dev, args->args, 1);
 }
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 1ea2a820e1eb..600fc6e6f308 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -468,7 +468,7 @@ struct iommu_ops {
 	/* Request/Free a list of reserved regions for a device */
 	void (*get_resv_regions)(struct device *dev, struct list_head *list);
 
-	int (*of_xlate)(struct device *dev, struct of_phandle_args *args);
+	int (*of_xlate)(struct device *dev, const struct of_phandle_args *args);
 	bool (*is_attach_deferred)(struct device *dev);
 
 	/* Per device IOMMU features */
@@ -902,7 +902,7 @@ struct iommu_mm_data {
 int iommu_fwspec_init(struct device *dev, struct fwnode_handle *iommu_fwnode,
 		      const struct iommu_ops *ops);
 void iommu_fwspec_free(struct device *dev);
-int iommu_fwspec_add_ids(struct device *dev, u32 *ids, int num_ids);
+int iommu_fwspec_add_ids(struct device *dev, const u32 *ids, int num_ids);
 const struct iommu_ops *iommu_ops_from_fwnode(struct fwnode_handle *fwnode);
 
 static inline struct iommu_fwspec *dev_iommu_fwspec_get(struct device *dev)
-- 
2.34.1

