Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12622C0015E
	for <virtualization@archiver.kernel.org>; Fri, 14 Jul 2023 17:46:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6D2A94240B;
	Fri, 14 Jul 2023 17:46:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6D2A94240B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ir44YyooeFnP; Fri, 14 Jul 2023 17:46:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 90A2E42156;
	Fri, 14 Jul 2023 17:46:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 90A2E42156
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 67377C0071;
	Fri, 14 Jul 2023 17:46:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 46919C0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Jul 2023 17:46:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 17619421B3
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Jul 2023 17:46:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 17619421B3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id X3niIur_fo48
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Jul 2023 17:46:47 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 183A842156
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com
 [209.85.166.47])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 183A842156
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Jul 2023 17:46:47 +0000 (UTC)
Received: by mail-io1-f47.google.com with SMTP id
 ca18e2360f4ac-78666994bc2so90191139f.0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Jul 2023 10:46:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689356806; x=1691948806;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tJHdTuW6K/JMm302E5042Fy6Gfq2JzeP0VeTTGMNa/E=;
 b=PVenVmunChgSp97hW6rexOlDd19weV+DcctpNqV5g6p8bRBifs4q5vBT9NgyrOLUDH
 Xvso+smJPrIegbotyslftVai5/U7OP4XSKXoC9IITrhE4ccaUGRCcoM/mdsU1BiUPbG9
 NsYJTBiwlNzHnRAVMPeWiI6eiRAd8MCO/kG6GIje09jLQWa+iCY7Yk6WgNVZN5QTdXXB
 cjE8qNsJxu4YfgfJJBBkZXcOCu3jRQvY+cuitIN3SWpX/U6wu5rut/PNNfNuunhing4X
 xbKiekTmGkVH66P2UD0u635b5/NewI1oNEbT4Ei/ywjVdLDemDuY0fBM58gRiKae6x79
 tgRA==
X-Gm-Message-State: ABy/qLZRyOxt7YE/omoxKBO8IvlKb9YcwQtAXgT88gryh9/9HaJS1MIA
 lcM21vwLwHJnS6GeJXLPQQ==
X-Google-Smtp-Source: APBJJlFMTzdChYrg1EY1mjWK7DfeEYXAaYjpG3av2LG7K82WeR9AZZFvgqFl2nPjbs/2wRDPMr3kbQ==
X-Received: by 2002:a6b:f101:0:b0:787:1d0a:ce81 with SMTP id
 e1-20020a6bf101000000b007871d0ace81mr5975387iog.13.1689356806084; 
 Fri, 14 Jul 2023 10:46:46 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
 by smtp.gmail.com with ESMTPSA id
 i10-20020a02b68a000000b0042b3dcb1106sm2801125jam.47.2023.07.14.10.46.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Jul 2023 10:46:45 -0700 (PDT)
Received: (nullmailer pid 4058503 invoked by uid 1000);
 Fri, 14 Jul 2023 17:46:43 -0000
From: Rob Herring <robh@kernel.org>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>, Rob Clark <robdclark@gmail.com>,
 Orson Zhai <orsonzhai@gmail.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 Chunyan Zhang <zhang.lyra@gmail.com>,
 Thierry Reding <thierry.reding@gmail.com>, Krishna Reddy <vdumpa@nvidia.com>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH] iommu: Explicitly include correct DT includes
Date: Fri, 14 Jul 2023 11:46:39 -0600
Message-Id: <20230714174640.4058404-1-robh@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 iommu@lists.linux.dev, linux-tegra@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

The DT of_device.h and of_platform.h date back to the separate
of_platform_bus_type before it as merged into the regular platform bus.
As part of that merge prepping Arm DT support 13 years ago, they
"temporarily" include each other. They also include platform_device.h
and of.h. As a result, there's a pretty much random mix of those include
files used throughout the tree. In order to detangle these headers and
replace the implicit includes with struct declarations, users need to
explicitly include the correct includes.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom-debug.c | 2 +-
 drivers/iommu/arm/arm-smmu/arm-smmu.c            | 1 -
 drivers/iommu/arm/arm-smmu/qcom_iommu.c          | 3 +--
 drivers/iommu/ipmmu-vmsa.c                       | 1 -
 drivers/iommu/sprd-iommu.c                       | 1 +
 drivers/iommu/tegra-smmu.c                       | 2 +-
 drivers/iommu/virtio-iommu.c                     | 2 +-
 7 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom-debug.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom-debug.c
index b5b14108e086..bb89d49adf8d 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom-debug.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom-debug.c
@@ -3,7 +3,7 @@
  * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
-#include <linux/of_device.h>
+#include <linux/device.h>
 #include <linux/firmware/qcom/qcom_scm.h>
 #include <linux/ratelimit.h>
 
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index a86acd76c1df..d6d1a2a55cc0 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -29,7 +29,6 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
-#include <linux/of_device.h>
 #include <linux/pci.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
index a503ed758ec3..cc3f68a3516c 100644
--- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
+++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
@@ -22,8 +22,7 @@
 #include <linux/init.h>
 #include <linux/mutex.h>
 #include <linux/of.h>
-#include <linux/of_address.h>
-#include <linux/of_device.h>
+#include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/pm.h>
 #include <linux/pm_runtime.h>
diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index 9f64c5c9f5b9..0aeedd3e1494 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -17,7 +17,6 @@
 #include <linux/io-pgtable.h>
 #include <linux/iommu.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/sizes.h>
diff --git a/drivers/iommu/sprd-iommu.c b/drivers/iommu/sprd-iommu.c
index 39e34fdeccda..51144c232474 100644
--- a/drivers/iommu/sprd-iommu.c
+++ b/drivers/iommu/sprd-iommu.c
@@ -14,6 +14,7 @@
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/of_platform.h>
+#include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
 
diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 1cbf063ccf14..e445f80d0226 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -9,7 +9,7 @@
 #include <linux/iommu.h>
 #include <linux/kernel.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
+#include <linux/of_platform.h>
 #include <linux/pci.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 3551ed057774..17dcd826f5c2 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -13,7 +13,7 @@
 #include <linux/interval_tree.h>
 #include <linux/iommu.h>
 #include <linux/module.h>
-#include <linux/of_platform.h>
+#include <linux/of.h>
 #include <linux/pci.h>
 #include <linux/virtio.h>
 #include <linux/virtio_config.h>
-- 
2.40.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
