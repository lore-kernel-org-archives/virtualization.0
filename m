Return-Path: <SRS0=hbIa=B7=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0469BC433DF
	for <virtualization@archiver.kernel.org>; Fri, 21 Aug 2020 13:16:14 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C326420724
	for <virtualization@archiver.kernel.org>; Fri, 21 Aug 2020 13:16:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NpM+QAeA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C326420724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 8C04A8862D;
	Fri, 21 Aug 2020 13:16:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2S+Agwhl4GJ8; Fri, 21 Aug 2020 13:16:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 9B9E38819B;
	Fri, 21 Aug 2020 13:16:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 81DCAC0889;
	Fri, 21 Aug 2020 13:16:12 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9CD1EC0051
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Aug 2020 13:16:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 8BEC588360
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Aug 2020 13:16:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sCWdA6OJjqmw
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Aug 2020 13:16:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com
 [209.85.208.68])
 by hemlock.osuosl.org (Postfix) with ESMTPS id CB2908832D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Aug 2020 13:16:09 +0000 (UTC)
Received: by mail-ed1-f68.google.com with SMTP id m20so1395817eds.2
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Aug 2020 06:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=CGfR6v3AK9RiKFWmVUt4OX8zldgtD7R209TqBrFRf6A=;
 b=NpM+QAeAtDS+vuHr/qsAxLGz0RzOZbBpb7eNNFUK3Kan9Wha3FSnGrRgODlSfxTHji
 jqPHivHK0RsfnSvZINhMJVXV5ePliRbvAny/XW+puDQKC9eSaVAT90nZ237E34X+jPYz
 kqcNeVfjnEsJ8Zd/HJrDBnyrln9AFE9kVmyfgvbVnVxLMTT6NChJuydDWP2g8r/bs627
 o/8F+GSTZ5LbFww31m11upQpAqghI7vnm3FSwkHTJlg1f7RR+pI4bBJ3Zi1Je66cAb+E
 K1wzyw+hhAwliNdzhiHjWsJXWyJbMOjB6LnZIj4Kyg9JvalM3Q+LR0JUdr19byex8jUC
 RJ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=CGfR6v3AK9RiKFWmVUt4OX8zldgtD7R209TqBrFRf6A=;
 b=eYl4v6dW32hcow9utU1IUC0nqyKs5SXEo4BK1/8SJVIZDa7RjRjHUzPLg/ePPhau+v
 g4IDo+VwIilqfsrm9PITE8Y5EPZnnf+JAv6oIIirj3qBmVQQ6hmNMeBddXwvumJYt8sc
 DdNGs5RJOj2D5ueRScz/+MyCyA8/0uGcJ/45zVoQ8Mitf10RGlNfn1FzD5hrrSDfw0Zz
 rW26+9vGYK2RTNzlKqHiMzXGnU8ruXCESTj8gcSeyltlkPzZDTzHSUP1XT8/FRYB9aPq
 gtx75Z5dCB4jicsSKGUUoT8FGMa70Yh9w5O7Iab3hF4hP9rdxRmg3iWrcuUGGx7KdabY
 3nFw==
X-Gm-Message-State: AOAM533D+VEBzmdJR4E3YraeIe8YwEbv4rPSrhkpLKr9sBS1YpjMYK9m
 Yr1eXhJ/oCR237fCtzflRkTe6w==
X-Google-Smtp-Source: ABdhPJxokcQ0IuXysG4c3tg0Qxks3XmbNzQjbGHqNkBr899EEr9X26aBW5gNkvYxSfGRWPA0z+/VaA==
X-Received: by 2002:a05:6402:b1c:: with SMTP id
 bm28mr2790782edb.116.1598015768219; 
 Fri, 21 Aug 2020 06:16:08 -0700 (PDT)
Received: from localhost.localdomain
 ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id v4sm1299748eje.39.2020.08.21.06.16.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2020 06:16:07 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: iommu@lists.linux-foundation.org,
 virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org,
 linux-pci@vger.kernel.org
Subject: [PATCH v3 1/6] iommu/virtio: Move to drivers/iommu/virtio/
Date: Fri, 21 Aug 2020 15:15:35 +0200
Message-Id: <20200821131540.2801801-2-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200821131540.2801801-1-jean-philippe@linaro.org>
References: <20200821131540.2801801-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, lorenzo.pieralisi@arm.com,
 mst@redhat.com, joro@8bytes.org, eric.auger@redhat.com,
 sebastien.boeuf@intel.com, bhelgaas@google.com
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

Before adding new files to the virtio-iommu driver, move it to its own
subfolder, similarly to other IOMMU drivers.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/Makefile                    | 3 +--
 drivers/iommu/virtio/Makefile             | 2 ++
 drivers/iommu/{ => virtio}/virtio-iommu.c | 0
 MAINTAINERS                               | 2 +-
 4 files changed, 4 insertions(+), 3 deletions(-)
 create mode 100644 drivers/iommu/virtio/Makefile
 rename drivers/iommu/{ => virtio}/virtio-iommu.c (100%)

diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index 11f1771104f3..fc7523042512 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-obj-y += amd/ intel/ arm/
+obj-y += amd/ intel/ arm/ virtio/
 obj-$(CONFIG_IOMMU_API) += iommu.o
 obj-$(CONFIG_IOMMU_API) += iommu-traces.o
 obj-$(CONFIG_IOMMU_API) += iommu-sysfs.o
@@ -26,4 +26,3 @@ obj-$(CONFIG_EXYNOS_IOMMU) += exynos-iommu.o
 obj-$(CONFIG_FSL_PAMU) += fsl_pamu.o fsl_pamu_domain.o
 obj-$(CONFIG_S390_IOMMU) += s390-iommu.o
 obj-$(CONFIG_HYPERV_IOMMU) += hyperv-iommu.o
-obj-$(CONFIG_VIRTIO_IOMMU) += virtio-iommu.o
diff --git a/drivers/iommu/virtio/Makefile b/drivers/iommu/virtio/Makefile
new file mode 100644
index 000000000000..279368fcc074
--- /dev/null
+++ b/drivers/iommu/virtio/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_VIRTIO_IOMMU) += virtio-iommu.o
diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio/virtio-iommu.c
similarity index 100%
rename from drivers/iommu/virtio-iommu.c
rename to drivers/iommu/virtio/virtio-iommu.c
diff --git a/MAINTAINERS b/MAINTAINERS
index deaafb617361..3602b223c9b2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18451,7 +18451,7 @@ VIRTIO IOMMU DRIVER
 M:	Jean-Philippe Brucker <jean-philippe@linaro.org>
 L:	virtualization@lists.linux-foundation.org
 S:	Maintained
-F:	drivers/iommu/virtio-iommu.c
+F:	drivers/iommu/virtio/
 F:	include/uapi/linux/virtio_iommu.h
 
 VIRTIO MEM DRIVER
-- 
2.28.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
