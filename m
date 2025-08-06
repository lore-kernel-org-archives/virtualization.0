Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA602E36E7;
	Wed,  6 Aug 2025 21:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754517351; cv=none; b=J5TavR4cHFHxUzZYnsImCPn+SH8eZZ1odPk/AEW1MK4wsoxU1Q1hexSasWjApJGCEvrHXBKIhFoRPAO7KF0XcVq3GUZRRX7TJ5xekSjZ2euTww/L6NTM/KymmYkgdgEFAoh45rJv92rMDNhCe9zt+Bx602zoaKWCaWrx4RzsK58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754517351; c=relaxed/simple;
	bh=6CdVf+8QwnsWurspL0tzC6i8y5cR4lI/8FubTN/0D8M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S54vSRdjprn7icBDi2RMZOPLQuNQF4C/6zQrvRO1ZDP3Vexof26d5tNTxxtxEXO9/qMVYIF4eW6YEQ/ZhZi8o/gMVDGWrbj/hd6U6wT5iJ1u+1FgNSIgXmZchUc0prVvT3pzd3trvYlb1XlmACBZEr0NeqsDGE85PcvRb5E+Yf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=IHlSUyCu; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="IHlSUyCu"
Received: from thinkpad-p16sg1.corp.microsoft.com (unknown [40.65.108.177])
	by linux.microsoft.com (Postfix) with ESMTPSA id 6015B201BC92;
	Wed,  6 Aug 2025 14:55:49 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6015B201BC92
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1754517349;
	bh=I9Zyvxd9QcR3+RgwZw0Pfazx1gPOwalq9eyq9Lnt7M8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IHlSUyCuOtKdJO1Ul39hnfFzFmUS6bMPUl4LAbiJyHekgrUKxKprvvFWPIx7x6WsX
	 0f++5HzJ/+rTx4tLSfmpFusF2rIX06RemKuA4MGrcE3JzPHbEobUJWL0kOgcbr5nBQ
	 5yafgMMarU2fZgBderoNS3ILRvuKuw+wlzuaTF4E=
From: Shyam Saini <shyamsaini@linux.microsoft.com>
To: iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: jgg@ziepe.ca,
	will@kernel.org,
	jacob.pan@linux.microsoft.com,
	eric.auger@redhat.com,
	code@tyhicks.com,
	eahariha@linux.microsoft.com,
	vijayb@linux.microsoft.com,
	bboscaccy@linux.microsoft.com
Subject: [PATCH v3 2/3] iommu/of: fix device tree configuration for PCI devices
Date: Wed,  6 Aug 2025 14:55:38 -0700
Message-Id: <20250806215539.1240561-3-shyamsaini@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250806215539.1240561-1-shyamsaini@linux.microsoft.com>
References: <20250806215539.1240561-1-shyamsaini@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: **

Individual PCI devices lack dedicated device tree nodes, but
their IOMMU configuration (including reserved IOVA regions) is often
defined at the PCI host controller level in the device tree. The
"iommu-addresses" property in reserved-memory nodes specifies IOVA
ranges that should be reserved for specific devices.

Currently, PCI devices cannot access these configurations because their
dev->of_node is NULL, preventing of_iommu_get_resv_regions() from
discovering reserved regions defined in the device tree.

Fix this by assigning the PCI host controller's device tree node to
PCI devices during IOMMU configuration, enabling them to inherit the
host controller's device tree properties. This allows PCI devices to
properly discover and reserve IOVA regions specified in the device tree.

Link: https://lore.kernel.org/linux-iommu/20250529183815.GA236098@ziepe.ca/
Signed-off-by: Shyam Saini <shyamsaini@linux.microsoft.com>
---
 drivers/iommu/of_iommu.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 6b989a62def20..077482917e3e8 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -145,6 +145,17 @@ int of_iommu_configure(struct device *dev, struct device_node *master_np,
 		err = pci_for_each_dma_alias(to_pci_dev(dev),
 					     of_pci_iommu_init, &info);
 		of_pci_check_device_ats(dev, master_np);
+
+		/*
+		 * For PCI devices, ensure the device's of_node points to the
+		 * PCI host controller's device tree node so that reserved regions
+		 * and other DT-specific IOMMU configuration can be found.
+		 * PCI devices typically don't have individual DT nodes, but
+		 * their configuration (including reserved regions) is defined
+		 * at the PCI host controller level.
+		 */
+		if (!err && master_np && !dev->of_node)
+			dev->of_node = of_node_get(master_np);
 	} else {
 		err = of_iommu_configure_device(master_np, dev, id);
 	}
-- 
2.34.1

