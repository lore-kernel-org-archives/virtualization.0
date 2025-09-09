Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10D71322A07;
	Tue,  9 Sep 2025 15:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757432770; cv=none; b=iFljxtXhfL9NvY0TQ1wnjCX+1uZNAnwjDsqunKIYsMRn8JhU1Go2kddDrPXvDuDYcEsGasd6pXmfgj2NPQj6eosPy4VfxLsgKHsGFlj00y7fgPYgp15ENdQD/S1HBJQRH+KBTENSQIHGtl0rd/Uqk+JY/NxkNpyw63D4oRK4XVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757432770; c=relaxed/simple;
	bh=JK0T8orYe8MA3atJz4cPc7kGrM7i3bACwe870D4AzeE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jsOWSeUMsZ482EnZTMFjjRXZtMbcQvSlOZPCMh6kvBD5cwnaOMdh54+JxJug0meyJTP7iRk2zKAaMOz9cy9xS/IIu3ICp0k15ZEcxNlFLtkRCYAbWbPup6JWFKYRgMNZytPRh9RWqcgpk19eLyvPIpSZTPz9wNUv6u88+hXPjro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=HjjrcaIW; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="HjjrcaIW"
Received: from thinkpad-p16sg1.corp.microsoft.com (unknown [20.236.11.102])
	by linux.microsoft.com (Postfix) with ESMTPSA id B885E2119CBC;
	Tue,  9 Sep 2025 08:46:06 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B885E2119CBC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1757432767;
	bh=GQXZNPBz0DhvyMwtEtFgMvcxMmecvXfOavBE9BmZlWw=;
	h=From:To:Cc:Subject:Date:From;
	b=HjjrcaIWlpWgjhW/CFD+kkQkerGsFe8lAQDD80BJGmzKxaF01/OQU+MxbCvv2TcdV
	 UdBQ8sxJ8WS0dc2zy2+KHeNft7I2WQkuSQdcH0qo+aDeiGWetjzL4cJZRHptjEcodd
	 7kt4SmQ5D45cHazLv5NssPuCXeI+1wIlWDMbZY4U=
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
Subject: [PATCH v4 0/4] arm-smmu: select suitable MSI IOVA
Date: Tue,  9 Sep 2025 08:45:56 -0700
Message-Id: <20250909154600.910110-1-shyamsaini@linux.microsoft.com>
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
base as a kernel command line parameter.

The faulty iommu-addresses can be reserved in DTS and suitable MSI_IOVA
can be selected (Suggested by Jason), However, for individual PCI
devices of_iommu driver can't reserve iommu-addresses as these devices
doesn't inherit parent DTS properties.

There are at least 3 ways to reserve iommu-addresses for individual PCI
devices,
 - 1) By dynamically adding DTS nodes for individual PCI devices using
   [2] CONFIG_PCI_DYNAMIC_OF_NODES, this requires hardcoding PCI device
   IDs in DECLARE_PCI_FIXUP_FINAL

 - 2) By adding PCI devices nodes either in DTS or by modifying FDT at
   boot time in the firmware, eg [3] However, of_iommu driver doesn't
   seem to handle individual PCI devices, additionally this approach
   doesn't seem to much scalable for the complex PCI hierarchy

 - 3) By configuring PCI host controller DTS node for PCI device so that it
   can inherit iommu-addresses defined in the parent node.

This patch series aims to address both the problems described above: 
- select suitable MSI IOVA when the default MSI IOVA conflicts with
  reserved iommu addresses 
- Using 3) approach appropriately handle iommu-addresses for individual
  PCI devices during IOMMU configuration


This patch series accommodates platforms that do not have the default MSI
base address available for MSI reservation by implementing both solutions
described above.

[1]: https://lore.kernel.org/lkml/20200914181307.117792-1-vemegava@linux.microsoft.com/
[2]: https://lwn.net/Articles/939317/
[3]: https://elixir.bootlin.com/linux/v6.16/source/arch/arm64/boot/dts/nvidia/tegra186.dtsi#L1388

Thanks,
Shyam

---
v4:
- Add warn message to indicate MSI IOVA reservation issue
- Fix loop condition in arm_smmu_get_resv_regions()
- Refactor arm_smmu_get_resv_regions() by introducing iommu_set_sw_msi()
  helper function

v3:
- Drop "arm,smmu-faulty-msi-iova" property change
- Fix iommu driver device tree configuration for PCI devices
- Use "iommu-addresses" property to identify reserved MSI IOVA regions,
  and introduce an additional MSI_IOVA_BASE2 macro to select a suitable
  MSI IOVA base if the default overlaps with a reserved region (suggested by Jason)
Link: https://lore.kernel.org/linux-iommu/20250806215539.1240561-1-shyamsaini@linux.microsoft.com/

v2:
- add new dts property to hold faulty MSI IOVA and select appropriate
  MSI IOVA address
Link: https://lore.kernel.org/linux-iommu/20250410225030.2528385-1-shyamsaini@linux.microsoft.com/

v1:
Link: https://lore.kernel.org/linux-iommu/20250116232307.1436693-1-shyamsaini@linux.microsoft.com/

Shyam Saini (4):
  arm-smmu: move MSI_IOVA macro definitions
  iommu/of: fix device tree configuration for PCI devices
  arm-smmu: select suitable MSI IOVA
  drivers: iommu: refactor arm_smmu_get_resv_regions

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 13 ++-----
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  3 --
 drivers/iommu/arm/arm-smmu/arm-smmu.c       | 16 ++------
 drivers/iommu/iommu.c                       | 37 ++++++++++++++++++
 drivers/iommu/of_iommu.c                    | 11 ++++++
 drivers/iommu/virtio-iommu.c                |  2 -
 include/linux/iommu.h                       | 42 +++++++++++++++++++++
 7 files changed, 96 insertions(+), 28 deletions(-)

-- 
2.34.1

