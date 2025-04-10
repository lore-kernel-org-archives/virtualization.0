Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA701D5ADE;
	Thu, 10 Apr 2025 22:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744325437; cv=none; b=rB8+OFD3tcUHeFF1IeoXNXdtOm9pzyjTQaCVkEjPlxCQVbCLM3oxzOVaPswzoiLrgH0g5hrgL3BFMJ5dHRSq1p66tsJmtzu6LVFIaoQLaNalehvaLvBzUMOf928pdy+r4qpkevFZBqUsgTryhOjgBGC9eRnn7lm+JJ6l3/HQddA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744325437; c=relaxed/simple;
	bh=P1iXDiE8J8ek4XOmWgtJcdDtey4KnTMCvw2UkhMIrE4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=guDWywTwwKX46sWucvIK48jX4t7BzcH58d1kI+siyjjfGkljbNhlPkUWs3lnh6rVlgQm31GAlg+ttAHTMQ+7EmbJplKZv/WrUyi8Q0N65gWjXbeug0bEkBX8aMGC+jHJ58Gd9cpqp2jStZ/s0OS3vdu5bmoFvjsfy379/aWEOeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=St9i/IlO; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="St9i/IlO"
Received: from thinkpad-p16sg1.corp.microsoft.com (unknown [20.236.10.206])
	by linux.microsoft.com (Postfix) with ESMTPSA id EDD132114DAB;
	Thu, 10 Apr 2025 15:50:34 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EDD132114DAB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1744325435;
	bh=XQOB4P9tl5xP8BTMFQTkA/5MgocI9fZkIBoJhuuZIMM=;
	h=From:To:Cc:Subject:Date:From;
	b=St9i/IlObVbj6pZJi6K4m05RyLTZHZvLujb+r7TY89ASvq7FBJpBLSi7ZjiU0ZVzN
	 IIH1/NU3Qc0MZsjrX3TLCrd0llm3w8ouWNCkmNP/L6TKsEaf1MlbMoWtaALEDj9gRn
	 damsdo3DPTHe1skB73yFsOhNmbZcL9NN6x3DkFBI=
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
	vijayb@linux.microsoft.com
Subject: [PATCH v2 0/3] arm-smmu: select suitable IOVA
Date: Thu, 10 Apr 2025 15:50:27 -0700
Message-Id: <20250410225030.2528385-1-shyamsaini@linux.microsoft.com>
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

This patch series aims to address the issue by introducing a new DTS
property, "arm,smmu-faulty-msi-iova" which can be used to hold faulty
MSI IOVA address. This property can be passed to ARM SMMU drivers
via device tree so that the drivers can select appropriate MSI IOVA base
address which doesn't intersect with the faulty MSI IOVA address.

This approach accommodates platforms that do not have the default MSI base address
available for MSI reservation.

[1]: https://lore.kernel.org/lkml/20200914181307.117792-1-vemegava@linux.microsoft.com/

Thanks,
Shyam

---
v2:
- add new dts property to hold faulty MSI IOVA and select appropriate
  MSI IOVA address

v1:
Link: https://lore.kernel.org/linux-iommu/20250116232307.1436693-1-shyamsaini@linux.microsoft.com/

Shyam Saini (3):
  arm-smmu: move MSI_IOVA macro definitions
  arm-smmu: select suitable MSI IOVA
  dt-bindings: iommu: add "arm,smmu-faulty-msi-iova" property

 .../bindings/iommu/arm,smmu-v3.yaml           |  8 +++
 .../devicetree/bindings/iommu/arm,smmu.yaml   |  8 +++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  9 +++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  3 --
 drivers/iommu/arm/arm-smmu/arm-smmu.c         | 10 ++--
 drivers/iommu/virtio-iommu.c                  |  2 -
 include/linux/iommu.h                         | 52 +++++++++++++++++++
 7 files changed, 81 insertions(+), 11 deletions(-)

-- 
2.34.1

