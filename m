Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D66322618F;
	Wed,  6 Aug 2025 21:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754517350; cv=none; b=uudthLCEGwL6KQ0+2Lyx92FTN4EvioR1XwZk7axn+jQFSzacx2I3FXv7arki7+Cr2UV2fvZXNdjd++ljStqkScYunDwf547PenpherfoOVNK+qUqjsIXNRHHukRNqfiXww4eWgSm+truXv0wm7DKhy2N8awNSJow+6NLHBuqDnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754517350; c=relaxed/simple;
	bh=j95Df0u1twPoNe4ufuiyqZ4gjJJnOCPJvR8Y38Unaa4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mP9q7h//MxLXBhjTO9KbYm7xlRbcth+DhEf/rw3XhsSgxrIr/9umMgaBwJ4juNZ6q9h+WztZPUUyzSA49bTerE4kwEm6M2epvgaQopKFEIsgoftaxbd0xY5WQbzjSoiWsuUUBtn0xUp3gfE5/EcTjeLxqazLnEGcdNwoZJKS2A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=rfGsuz8d; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="rfGsuz8d"
Received: from thinkpad-p16sg1.corp.microsoft.com (unknown [40.65.108.177])
	by linux.microsoft.com (Postfix) with ESMTPSA id 6D9BD2018F33;
	Wed,  6 Aug 2025 14:55:48 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6D9BD2018F33
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1754517348;
	bh=EB5F7X0QTQBLYUeJTZBsEDkMArE5SLaRkOQ9lia3kO8=;
	h=From:To:Cc:Subject:Date:From;
	b=rfGsuz8deZNit4jb/h6AAxRxsJrJRm5iHZARB0RYBxr38DNSJnTp1Pl6AJBdkQ4dE
	 vl7PB/Pg8MKcRk6pIMjkzLlMaZbc+RdW0Qzm28cyv0SnwA3+WKl+gQOtRGZhKGUG99
	 hb5kWS7YYT/TdX46xMv7YyL7BhxMr1/weJku+I2U=
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
Subject: [PATCH v3 0/3] arm-smmu: select suitable MSI IOVA
Date: Wed,  6 Aug 2025 14:55:36 -0700
Message-Id: <20250806215539.1240561-1-shyamsaini@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: **

Hi,

Currently, the MSI_IOVA_BASE address is hard-coded to 0x80000000,
assuming that all platforms have this address available for MSI IOVA
reservation. However, this is not always the case, as some platforms
reserve this address for other purposes. Consequently, these platforms
cannot reserve the MSI_IOVA_BASE address for MSI.

There was an [1] attempt to fix this problem by passing the MSI IOVA
base as a kernel command line parameter.

This patch series aims to address the issue by reserving faulty MSI_IOVA
and selecting suitable MSI IOVA address for a given platform.

This approach accommodates platforms that do not have the default MSI base address
available for MSI reservation.

[1]: https://lore.kernel.org/lkml/20200914181307.117792-1-vemegava@linux.microsoft.com/

Thanks,
Shyam

---
v3:
- Drop "arm,smmu-faulty-msi-iova" property change
- Fix iommu driver device tree configuration for PCI devices
- Use "iommu-addresses" property to identify reserved MSI IOVA regions,
  and introduce an additional MSI_IOVA_BASE2 macro to select a suitable
  MSI IOVA base if the default overlaps with a reserved region (suggested by Jason)

v2:
- add new dts property to hold faulty MSI IOVA and select appropriate
  MSI IOVA address
Link: https://lore.kernel.org/linux-iommu/20250410225030.2528385-1-shyamsaini@linux.microsoft.com/

v1:
Link: https://lore.kernel.org/linux-iommu/20250116232307.1436693-1-shyamsaini@linux.microsoft.com/

Shyam Saini (3):
  arm-smmu: move MSI_IOVA macro definitions
  iommu/of: fix device tree configuration for PCI devices
  arm-smmu: select suitable MSI IOVA

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 27 ++++++++++++++-----
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  3 ---
 drivers/iommu/arm/arm-smmu/arm-smmu.c       | 30 ++++++++++++++-------
 drivers/iommu/of_iommu.c                    | 11 ++++++++
 drivers/iommu/virtio-iommu.c                |  2 --
 include/linux/iommu.h                       | 28 +++++++++++++++++++
 6 files changed, 79 insertions(+), 22 deletions(-)

-- 
2.34.1

