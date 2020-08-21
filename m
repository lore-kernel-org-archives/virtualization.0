Return-Path: <SRS0=hbIa=B7=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C07AC433E4
	for <virtualization@archiver.kernel.org>; Fri, 21 Aug 2020 13:16:19 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D360321741
	for <virtualization@archiver.kernel.org>; Fri, 21 Aug 2020 13:16:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Evc7JHiQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D360321741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id A77E48865A;
	Fri, 21 Aug 2020 13:16:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id f7eGO9onQJsp; Fri, 21 Aug 2020 13:16:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 722478863E;
	Fri, 21 Aug 2020 13:16:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5B528C0893;
	Fri, 21 Aug 2020 13:16:14 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E7710C089E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Aug 2020 13:16:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id D4A0587D65
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Aug 2020 13:16:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NWHkHzETJbIQ
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Aug 2020 13:16:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com
 [209.85.208.65])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 1AA7F87CB8
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Aug 2020 13:16:12 +0000 (UTC)
Received: by mail-ed1-f65.google.com with SMTP id l23so1369467edv.11
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Aug 2020 06:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=AnnlDaJISLBh3tlC6QY64TitbeK2bzvjOXLypqqoQOw=;
 b=Evc7JHiQsscTCCzRJuF4RGxVPF/TfJEQoNFtq/F7l4VJCPfkB8ZnzeHE1jSsjrZ5r7
 5C5idkHzraOBGbOnKZ34LNp9EprEIaOlttQSmNnVriYiMTyEn0rEcuYChBq7/TbDjIa9
 h9y8+WSyeAHbE/U5TdEhnhnBK3VaWQsOiKiNRvRwvjKBbSoZrDHgc/ZU3yHnRDYGsqwM
 dcz4chm8cEyq8yr22YRPHjEUeukQaL7QYjLiVubrUsFr+Z3R6l5PdO1A8jIMu+4qOmwq
 DC8C2F+j/g3CwmANZ24gMXCH2L7IB0mQp2b8fBSq4UKvRyEOgAylfTesVJgJHr38GfK+
 JKGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=AnnlDaJISLBh3tlC6QY64TitbeK2bzvjOXLypqqoQOw=;
 b=MPr1QuIMfuc2//th/lYz9nwTx3qgtPoFplOONGvdd2Ftd67Y04wTcH9E79NerldnZC
 gyAZU3ww0P2qlDCI8eUjDpgLtouOGgCXP5Pum59/y+EQNEoE8a20pAGubHKcQy9+BD/T
 iLyiem7CxmdbaauuxVw7L0fQfL6Qi3BEoMEh8sBMn5huJG2+0Qpoe9DVGuw6zZWgV9sQ
 mgE+7kZwWaSJovh4SyCaCfzYjvA8opxESjPTdDjEr6z3nEJxP8hlbf5TRnatxmomQFIR
 AO2QyI8oX4pZfkVpzjOmqBAkxuMraHqbmPIEYtcQXDxu4vS+E/3Qs3N26KlZtPmjIGzg
 hpJg==
X-Gm-Message-State: AOAM530GBiPF39xIRN6wSxoxE/UFaFWy/pF3qZVfiS7wxXYyAL1nrnHl
 FmyKhBpJJqCtWddRN06yh7mjVA==
X-Google-Smtp-Source: ABdhPJxLTyEDp1sdq7LgF1huRP9DNgLTxWOLZlImVJP3z0/PYSRni9H4ifVAEYm5/PMqx1CpjBujwg==
X-Received: by 2002:aa7:c353:: with SMTP id j19mr2827173edr.128.1598015770571; 
 Fri, 21 Aug 2020 06:16:10 -0700 (PDT)
Received: from localhost.localdomain
 ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id v4sm1299748eje.39.2020.08.21.06.16.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2020 06:16:10 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: iommu@lists.linux-foundation.org,
 virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org,
 linux-pci@vger.kernel.org
Subject: [PATCH v3 3/6] PCI: Add DMA configuration for virtual platforms
Date: Fri, 21 Aug 2020 15:15:37 +0200
Message-Id: <20200821131540.2801801-4-jean-philippe@linaro.org>
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

Hardware platforms usually describe the IOMMU topology using either
device-tree pointers or vendor-specific ACPI tables.  For virtual
platforms that don't provide a device-tree, the virtio-iommu device
contains a description of the endpoints it manages.  That information
allows us to probe endpoints after the IOMMU is probed (possibly as late
as userspace modprobe), provided it is discovered early enough.

Add a hook to pci_dma_configure(), which returns -EPROBE_DEFER if the
endpoint is managed by a vIOMMU that will be loaded later, or 0 in any
other case to avoid disturbing the normal DMA configuration methods.
When CONFIG_VIRTIO_IOMMU_TOPOLOGY_HELPERS isn't selected, the call to
virt_dma_configure() is compiled out.

As long as the information is consistent, platforms can provide both a
device-tree and a built-in topology, and the IOMMU infrastructure is
able to deal with multiple DMA configuration methods.

Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/pci/pci-driver.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 449466f71040..dbe9d33606b0 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -19,6 +19,7 @@
 #include <linux/kexec.h>
 #include <linux/of_device.h>
 #include <linux/acpi.h>
+#include <linux/virt_iommu.h>
 #include "pci.h"
 #include "pcie/portdrv.h"
 
@@ -1605,6 +1606,10 @@ static int pci_dma_configure(struct device *dev)
 	struct device *bridge;
 	int ret = 0;
 
+	ret = virt_dma_configure(dev);
+	if (ret)
+		return ret;
+
 	bridge = pci_get_host_bridge_device(to_pci_dev(dev));
 
 	if (IS_ENABLED(CONFIG_OF) && bridge->parent &&
-- 
2.28.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
