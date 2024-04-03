Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F050B10A2B
	for <virtualization@lists.linux-foundation.org>; Wed,  3 Apr 2024 01:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712106988; cv=none; b=egmkyhOdnfSDdSutHTQb2ysyecgJSfWV1eW1CVF1e7Bnliu9b6RanSN/MHnnf6pYJLpX4SeE3+LQMmn8aznTbX/eBXZKT7mLa3kAC12lciBoX9LyZDTfZ2TYONoyUZQrRvEG3qtH0MlrIjX6kXjqj94+B4MuHxpH2PysEshtQBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712106988; c=relaxed/simple;
	bh=C/LU1Jlwpb7DB0AiR4br+N1SMTz6Vau5VN7TeJPZZAE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tiqVNdWpiZa8733yG2Be9yIroGgFAoXz+uC6oJ23WSx8cfSQTsigqvavTOBnaMosO2Y23E1ebRXawgyxv3tueq0otbxZGPbBskvascVbryNxbqkvawhy8hcoyKx1s5K0FVZAGDYoHGFndojxbaWgt3KYzJiZXodqJ23HL1694pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ggVweHsQ; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ggVweHsQ"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 85CE940B72
	for <virtualization@lists.linux-foundation.org>; Wed,  3 Apr 2024 01:16:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.699
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2QQLENJl30cV for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Apr 2024 01:16:25 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.16; helo=mgamail.intel.com; envelope-from=baolu.lu@linux.intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 4C1C2402DC
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none) header.from=linux.intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4C1C2402DC
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ggVweHsQ
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4C1C2402DC
	for <virtualization@lists.linux-foundation.org>; Wed,  3 Apr 2024 01:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712106985; x=1743642985;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=C/LU1Jlwpb7DB0AiR4br+N1SMTz6Vau5VN7TeJPZZAE=;
  b=ggVweHsQMlcJBPeO1Ov3iwM2TIIqFlmnw/rNZj3kH1MHBXUvINfT59lE
   8RqYO1ombZFfX1iGMNdBSLP653ofWB1W/qNhPO9+QLbhEyYNTg7azLfSd
   qkzkJNH45lIq6FSzUsSnj89/JZnYCjoc6VCAqFrDUEoa/I/lv9FVCMEks
   fTymcN4IqSfVXjjcTBvCqAqJt9fOPgLGFFcRrntsTcNc+nyjcXGcFtu0I
   BEvavpCkW3CI+qN0z0/Lkwv6l5QxsQkWrOrwDrHdPyUhFL2FNM/Xs0a6w
   wgOKnOUGE15HfkPLXpld+rchQv+ZpQgGqIuZzhQMx4P0LGrr2qeonITBX
   w==;
X-CSE-ConnectionGUID: pyXZh2S/SLeclCFVA3i1pA==
X-CSE-MsgGUID: vSFZJLDoTCOHQWUFeJA4hQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="7439707"
X-IronPort-AV: E=Sophos;i="6.07,176,1708416000"; 
   d="scan'208";a="7439707"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 18:16:23 -0700
X-CSE-ConnectionGUID: SonVAOAOSMC875vBrUutvQ==
X-CSE-MsgGUID: 0cNtGg+NQk6i+4OEZGq6eA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,176,1708416000"; 
   d="scan'208";a="22953257"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orviesa003.jf.intel.com with ESMTP; 02 Apr 2024 18:16:20 -0700
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
Subject: [PATCH v4 0/9] IOMMUFD: Deliver IO page faults to user space
Date: Wed,  3 Apr 2024 09:15:10 +0800
Message-Id: <20240403011519.78512-1-baolu.lu@linux.intel.com>
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
https://github.com/LuBaolu/intel-iommu/commits/iommufd-io-pgfault-delivery-v4

Change log:

v4:
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
  iommufd: Fault-capable hw page table attach/detach/replace
  iommufd: Add fault and response message definitions
  iommufd: Add iommufd fault object
  iommufd: Associate fault object with iommufd_hw_pgtable
  iommufd/selftest: Add IOPF support for mock device
  iommufd/selftest: Add coverage for IOPF test

 include/linux/iommu.h                         |  33 +-
 include/linux/uacce.h                         |   2 +-
 drivers/dma/idxd/idxd.h                       |   2 +-
 drivers/iommu/iommu-priv.h                    |   9 +
 drivers/iommu/iommufd/iommufd_private.h       |  43 ++
 drivers/iommu/iommufd/iommufd_test.h          |   8 +
 include/uapi/linux/iommufd.h                  | 122 ++++++
 tools/testing/selftests/iommu/iommufd_utils.h |  84 +++-
 drivers/dma/idxd/cdev.c                       |   4 +-
 drivers/iommu/io-pgfault.c                    |  37 +-
 drivers/iommu/iommu-sva.c                     |  64 ++-
 drivers/iommu/iommu.c                         | 158 +++++++-
 drivers/iommu/iommufd/device.c                |  16 +-
 drivers/iommu/iommufd/fault.c                 | 372 ++++++++++++++++++
 drivers/iommu/iommufd/hw_pagetable.c          |  36 +-
 drivers/iommu/iommufd/main.c                  |   6 +
 drivers/iommu/iommufd/selftest.c              |  63 +++
 drivers/misc/uacce/uacce.c                    |   2 +-
 tools/testing/selftests/iommu/iommufd.c       |  18 +
 .../selftests/iommu/iommufd_fail_nth.c        |   2 +-
 drivers/iommu/iommufd/Makefile                |   1 +
 21 files changed, 968 insertions(+), 114 deletions(-)
 create mode 100644 drivers/iommu/iommufd/fault.c

-- 
2.34.1

