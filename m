Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5434E77115
	for <virtualization@lists.linux-foundation.org>; Tue, 30 Apr 2024 14:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714489132; cv=none; b=sEgiK6/nlV2apLqImHepnrVr5Ta38q1t/FeU5g3e+Fcev1MW2ivwYMUDPkce3UgLNg8inhJ0gcE5wfFg5gHrJ/zupeg2Dq91ZtAfSLUjhfkinushR3fbFF9swknUtH8//ZctVM9lOIKFJh8pnQ/YMlb0phycUPs4nVjYsQm/2FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714489132; c=relaxed/simple;
	bh=JBVAR+sLuGoJYKowBGO4Ad8l5eFBbZOvpATG0wKcI6E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=r00VYJLMcJILd0IHoMFohp2A0jRzt2WgI+6g+VKIrZ0u1ID9PV3QtoDDJtVn1LRjS9SI3p7/Ux/bAkbYqnyp7FL/ooaFcLHdtWfJmEbXJhT9n8N88dPLPCSPYXGQL/38q3x6XiyDrHAIE1PkWYVO4NTgjOzIS8vAUxPuv/P7BY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LKztKAz1; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LKztKAz1"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E8ABF80BF5
	for <virtualization@lists.linux-foundation.org>; Tue, 30 Apr 2024 14:58:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.299
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AXKIXKWT3Dps for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Apr 2024 14:58:50 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.19; helo=mgamail.intel.com; envelope-from=baolu.lu@linux.intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 8742B80BE9
Authentication-Results: smtp1.osuosl.org; dmarc=none (p=none dis=none) header.from=linux.intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8742B80BE9
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LKztKAz1
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8742B80BE9
	for <virtualization@lists.linux-foundation.org>; Tue, 30 Apr 2024 14:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714489130; x=1746025130;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JBVAR+sLuGoJYKowBGO4Ad8l5eFBbZOvpATG0wKcI6E=;
  b=LKztKAz1rRBC+LzDN5BUWdvjQBhQKZbOznGxGOMKWNkshhggb403RVvj
   XMc1oXEufLu4VXasmZLEyKKG/vFlrBw3IXM4txqJThJZrStY/xdZ3oy+c
   pnv3CqDFIIAEJkNa9BGen4qd6rxV/kYo+gqszorT73wET/DipJTxW8O5e
   6zWAlB5Bf227mEiF+YIi4AzoinA8ij9jyNV86S9F/QJ1gejI/eV8/u4y0
   v6v19dNwFlR5B8ZQsQ9lBh/XfouaNxXrk9t2Cd049n43okdNDrxKe/OG0
   DF4FVGSzuN64KAU/7R+EWY0Qo8ttTlkWl8OBja0ED5sjOMR68poJ809dl
   g==;
X-CSE-ConnectionGUID: Yht+vvx+Q/WGEw8ZK8jeuQ==
X-CSE-MsgGUID: N+dX+11VTJu4UcDrSYsLKg==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="10059817"
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="10059817"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 07:58:49 -0700
X-CSE-ConnectionGUID: UXIgDc36RUabnKJBXrtVMQ==
X-CSE-MsgGUID: bU6XimoEQIyW+ufqsKOryg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="31282110"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by orviesa004.jf.intel.com with ESMTP; 30 Apr 2024 07:58:45 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Joel Granados <j.granados@samsung.com>
Cc: iommu@lists.linux.dev,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v5 0/9] IOMMUFD: Deliver IO page faults to user space
Date: Tue, 30 Apr 2024 22:57:01 +0800
Message-Id: <20240430145710.68112-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series implements the functionality of delivering IO page faults to
user space through the IOMMUFD framework. One feasible use case is the
nested translation. Nested translation is a hardware feature that
supports two-stage translation tables for IOMMU. The second-stage
translation table is managed by the host VMM, while the first-stage
translation table is owned by user space. This allows user space to
control the IOMMU mappings for its devices.

When an IO page fault occurs on the first-stage translation table, the
IOMMU hardware can deliver the page fault to user space through the
IOMMUFD framework. User space can then handle the page fault and respond
to the device top-down through the IOMMUFD. This allows user space to
implement its own IO page fault handling policies.

User space application that is capable of handling IO page faults should
allocate a fault object, and bind the fault object to any domain that it
is willing to handle the fault generatd for them. On a successful return
of fault object allocation, the user can retrieve and respond to page
faults by reading or writing to the file descriptor (FD) returned.

The iommu selftest framework has been updated to test the IO page fault
delivery and response functionality.

The series and related patches are available on GitHub:
https://github.com/LuBaolu/intel-iommu/commits/iommufd-io-pgfault-delivery-v5

Change log:
v5:
 - Removed attach handle reference count from the core. Drivers will now
   synchronize their use of handles and domain attach/detach.
 - Automatically responds to all outstanding faults in hwpt detach or
   replace paths.
 - Supports getting a domain-type specific attach handle.
 - Reorganized the series by changing the patch order.
 - Miscellaneous cleanup.

v4: https://lore.kernel.org/linux-iommu/20240403011519.78512-1-baolu.lu@linux.intel.com/
 - Add the iommu domain attachment handle to replace the iopf-specific
   domain attachment interfaces introduced in the previous v3.
 - Replace the iommu_sva with iommu domain attachment handle.
 - Refine some fields in the fault and response message encoding
   according to feedback collected during v3 review period.
 - Refine and fix some problems in the fault FD implementation.
 - Miscellaneous cleanup.

v3: https://lore.kernel.org/linux-iommu/20240122073903.24406-1-baolu.lu@linux.intel.com/
 - Add iopf domain attach/detach/replace interfaces to manage the
   reference counters of hwpt and device, ensuring that both can only be
   destroyed after all outstanding IOPFs have been responded to. 
 - Relocate the fault handling file descriptor from hwpt to a fault
   object to enable a single fault handling object to be utilized
   across multiple domains.
 - Miscellaneous cleanup and performance improvements.

v2: https://lore.kernel.org/linux-iommu/20231026024930.382898-1-baolu.lu@linux.intel.com/
 - Move all iommu refactoring patches into a sparated series and discuss
   it in a different thread. The latest patch series [v6] is available at
   https://lore.kernel.org/linux-iommu/20230928042734.16134-1-baolu.lu@linux.intel.com/
 - We discussed the timeout of the pending page fault messages. We
   agreed that we shouldn't apply any timeout policy for the page fault
   handling in user space.
   https://lore.kernel.org/linux-iommu/20230616113232.GA84678@myrica/
 - Jason suggested that we adopt a simple file descriptor interface for
   reading and responding to I/O page requests, so that user space
   applications can improve performance using io_uring.
   https://lore.kernel.org/linux-iommu/ZJWjD1ajeem6pK3I@ziepe.ca/

v1: https://lore.kernel.org/linux-iommu/20230530053724.232765-1-baolu.lu@linux.intel.com/

Lu Baolu (9):
  iommu: Introduce domain attachment handle
  iommu: Replace sva_iommu with iommu_attach_handle
  iommu: Add attachment handle to struct iopf_group
  iommufd: Add fault and response message definitions
  iommufd: Add iommufd fault object
  iommufd: Fault-capable hwpt attach/detach/replace
  iommufd: Associate fault object with iommufd_hw_pgtable
  iommufd/selftest: Add IOPF support for mock device
  iommufd/selftest: Add coverage for IOPF test

 include/linux/iommu.h                         |  32 +-
 include/linux/uacce.h                         |   2 +-
 drivers/dma/idxd/idxd.h                       |   2 +-
 drivers/iommu/iommu-priv.h                    |  17 +
 drivers/iommu/iommufd/iommufd_private.h       |  43 ++
 drivers/iommu/iommufd/iommufd_test.h          |   8 +
 include/uapi/linux/iommufd.h                  | 122 ++++++
 tools/testing/selftests/iommu/iommufd_utils.h |  84 +++-
 drivers/dma/idxd/cdev.c                       |   4 +-
 drivers/iommu/io-pgfault.c                    |  34 +-
 drivers/iommu/iommu-sva.c                     |  43 +-
 drivers/iommu/iommu.c                         | 156 +++++++-
 drivers/iommu/iommufd/device.c                |  16 +-
 drivers/iommu/iommufd/fault.c                 | 373 ++++++++++++++++++
 drivers/iommu/iommufd/hw_pagetable.c          |  35 +-
 drivers/iommu/iommufd/main.c                  |   8 +-
 drivers/iommu/iommufd/selftest.c              |  63 +++
 drivers/misc/uacce/uacce.c                    |   2 +-
 tools/testing/selftests/iommu/iommufd.c       |  18 +
 .../selftests/iommu/iommufd_fail_nth.c        |   2 +-
 drivers/iommu/iommufd/Makefile                |   1 +
 21 files changed, 959 insertions(+), 106 deletions(-)
 create mode 100644 drivers/iommu/iommufd/fault.c

-- 
2.34.1

