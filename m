Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD6D322C66;
	Tue,  9 Sep 2025 15:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757432778; cv=none; b=m7ublv3ipQbB1UZidOQip6wWizbYhCy/6FV2gBWzpPk98og+XYsZjz3teI57dQzzNIPIJ7ldw4vgPgEHLA4AfDlp4vUH6yXl4AO/WQil69MqJnGhXmxHpTPb9FL/L0I2mLfCOnr/OuQgEibAOG1riPNZAIGfiLEvCoiXBoiavFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757432778; c=relaxed/simple;
	bh=K3CttPAPrnMMK990SipxOoBAj8OkU40HmHUqqsla42k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hFm/ojd9KTChgUNj9rvJvzSAelaorEAQwCe6WEHpoNcqd4xc34vCmKdjjEANgq0hDMAHVogBzeHUydpIowdbINjNOjg7BZGenxxYqRuAyNOPX1BvoLCl5h2vpjwTHU6XeniCeuy3/CWnYdKdxT1ZTurCd0vqCxbHdR5rnJWqoxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=iVyAPeeS; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="iVyAPeeS"
Received: from thinkpad-p16sg1.corp.microsoft.com (unknown [20.236.11.102])
	by linux.microsoft.com (Postfix) with ESMTPSA id CB75D211AA17;
	Tue,  9 Sep 2025 08:46:15 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CB75D211AA17
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1757432776;
	bh=MLeivrLEOZek6SMLKDE33++Zkcd6skvIc2fWGH65W+s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iVyAPeeSOfKpX05GKFZdZL3wkxv+aDuAGLDWRbTaOjJpdWaMk1hIUqMR1JWSpeZV2
	 gMkBclSjmSwji717PqcvZLnJByOiWj+2uSqlJyoHSH0/k5I/7GbOvE9pw0N1g0rMNO
	 oIKw4LH3nas2sbqnSaRRlAx29ue0TWSiRiObca5s=
From: Shyam Saini <shyamsaini@linux.microsoft.com>
To: thierry.reding@gmail.com,
	robin.murphy@arm.com,
	robh@kernel.org,
	joro@8bytes.org,
	jgg@ziepe.ca
Cc: iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	virtualization@lists.linux.dev,
	will@kernel.org,
	jacob.pan@linux.microsoft.com,
	eric.auger@redhat.com,
	code@tyhicks.com,
	eahariha@linux.microsoft.com,
	vijayb@linux.microsoft.com,
	bboscaccy@linux.microsoft.com,
	saravanak@google.com,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	lizhi.hou@amd.com,
	clement.leger@bootlin.com
Subject: [PATCH v4 2/4] iommu/of: fix device tree configuration for PCI devices
Date: Tue,  9 Sep 2025 08:45:58 -0700
Message-Id: <20250909154600.910110-3-shyamsaini@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250909154600.910110-1-shyamsaini@linux.microsoft.com>
References: <20250909154600.910110-1-shyamsaini@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Individual PCI devices lack dedicated device tree nodes, but
their IOMMU configuration (including reserved IOVA regions) is often
defined at the PCI host controller level in the device tree. The
"iommu-addresses" property in reserved-memory nodes specifies IOVA
ranges that should be reserved for specific devices.

Currently, PCI devices cannot access these configurations because their
dev->of_node is NULL, preventing of_iommu_get_resv_regions() from
discovering reserved regions defined in the device tree.

There are at least 3 ways to reserve iommu-addresses for individual PCI
devices,
 - 1) By dynamically adding DTS nodes for individual PCI devices using
   [2] CONFIG_PCI_DYNAMIC_OF_NODES, this requires hardcoding PCI device
   IDs in DECLARE_PCI_FIXUP_FINAL

 - 2) By adding PCI devices nodes either in DTS or by modifying FDT at
   boot time in the firmware, eg [3] However, of_iommu driver doesn't
   seem to handle individual PCI devices, additionally this approach
   doesn't seem to much scalable for the complex PCI hierarchy

 - 3) By configuring PCI host controller DTS node for PCI device so
   that it can inherit iommu-addresses defined in the parent node.

This commit addresses the problem using approach 3) by assigning the
PCI host controller's device tree node to PCI devices during IOMMU
configuration, enabling them to inherit the host controller's device
tree properties. This allows PCI devices to properly discover and
reserve IOVA regions specified in the device tree.

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

