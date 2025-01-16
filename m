Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0FC71DD88F;
	Thu, 16 Jan 2025 23:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737069796; cv=none; b=szECKFsjAbLMSusAwbPT6Ib2pzia7SjE0uVfimdZsv0sO14vrLO6rg6UeHKlJzE3CsXZdQ5UDKmu73hY8DaYWOxMmot4ppIwByhwHarkVI/R3DPcxUY+FNGor3L5e2x62hdhK6n0i9CyYQ3Y2MBuSoNj/G468i0Wreea92PD4jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737069796; c=relaxed/simple;
	bh=lzcKpMvtoa9caH1dK776bAbqnopCsa5ERUGfA82TvbY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HUbb7Wjit3VB3IniH9YQHYYcEfpRWqMHLko1fLsBtYiXaAqvd/MpENhQPXG3zDuxBrHung2pVEgbkQP9lU4erCO2gU1NzIG6cBTh2ESRBWWT397O/tgq6N/SlgjNyPnMdcDpFfpljhJvjFvwvU5SjYOBElEvhXnVfZrvrByIsiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=aj9ZpFs/; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="aj9ZpFs/"
Received: from thinkpad-p16sg1.corp.microsoft.com (unknown [20.236.10.66])
	by linux.microsoft.com (Postfix) with ESMTPSA id 220C020591A5;
	Thu, 16 Jan 2025 15:23:14 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 220C020591A5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1737069794;
	bh=NTt6eAeZulOXgSwKKcojtQtTZr5qsec7mtCKAgDqis0=;
	h=From:To:Cc:Subject:Date:From;
	b=aj9ZpFs/zTz59cSblNi82HiQ8/TWkT0sHEKkMl+c98XoAGr8T8D3xbIBOvEFqeSP6
	 m+1n5yQFhBrkvITROOo+h3x8wDz2Z200t7jCrl64+w4kgPD0bvNN8DFlC+e9GmxCBH
	 1oKkouiPTWwYHCxlxtqfVyvbaq/0dDWUnNtUDYZ0=
From: Shyam Saini <shyamsaini@linux.microsoft.com>
To: iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: will@kernel.org,
	jacob.pan@linux.microsoft.com,
	eric.auger@redhat.com,
	code@tyhicks.com,
	eahariha@linux.microsoft.com,
	vijayb@linux.microsoft.com
Subject: [PATCH 0/3] make MSI IOVA base address and its length configurable
Date: Thu, 16 Jan 2025 15:23:04 -0800
Message-Id: <20250116232307.1436693-1-shyamsaini@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Currently, the MSI_IOVA_BASE address is hard-coded to 0x80000000,
assuming that all platforms have this address available for MSI IOVA
reservation. However, this is not always the case, as some platforms
reserve this address for other purposes. Consequently, these platforms
cannot reserve the MSI_IOVA_BASE address for MSI.

There was an [1] attempt to fix this problem by passing the MSI IOVA
base as a kernel command line parameter. In the previous attempt,
Will suggested reserving the MSI IOVA at runtime whenever there is a
conflict with the default MSI_IOVA_BASE. However, dynamically reserving
this address has debuggability concerns, as it becomes difficult to
track IOMMU mapping failures.

This patch series aims to address the issue by introducing a new DTS
property, "arm,smmu-pci-msi-iova-data". This property allows the
configuration of MSI IOVA with a custom MSI base address and a custom
length for IOMMU/SMMU drivers. It accommodates platforms that do not
have the default MSI base address available for MSI reservation.

[1]: https://lore.kernel.org/lkml/20200914181307.117792-1-vemegava@linux.microsoft.com/

Thanks,
Shyam

Shyam Saini (3):
  dt-bindings: iommu: add "arm,smmu-pci-msi-iova-data" property
  iommu: consolidate MSI_IOVA macro definitions
  arm-smmu: use dts passed MSI IOVA address and length

 .../bindings/iommu/arm,smmu-v3.yaml           | 12 +++++
 .../devicetree/bindings/iommu/arm,smmu.yaml   | 12 +++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 10 ++++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  3 --
 drivers/iommu/arm/arm-smmu/arm-smmu.c         | 11 +++--
 drivers/iommu/virtio-iommu.c                  |  8 ++--
 include/linux/iommu.h                         | 44 +++++++++++++++++++
 7 files changed, 86 insertions(+), 14 deletions(-)

-- 
2.34.1

