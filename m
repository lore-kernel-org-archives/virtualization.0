Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4FD82C76
	for <virtualization@lists.linux-foundation.org>; Tue,  2 Jul 2024 06:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719902255; cv=none; b=AtBEwCtpE81APaVKySJurOv3B8sH7+ulN6oJ0HfVvHCYXhWgdZ1wgC9aWHv8TZ+CQUoVO4SUw2TmwmrVq+a6Chm1YpOS22G+Yq0KsWkQtk4t5EYtvuqLWXr58nTJMPdujjG6+C3rdmfYD7DkREQbbBmn99zQaxm+BZa3OTDOwgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719902255; c=relaxed/simple;
	bh=ebuYOo3up2lIO+mZ8J6j1N1O2VYAll9pwU9NvDibdg8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uWihw4a9qNIWh52h5Q14GzqGtRuVJFZTTeoAscUEzmjXno/ciV2LIupchEKHaH+CQXqTOR3yv7rihNFFigyqyBpV9UOJZRm8fBNulD4viZceUfeWh96gkO0jhZTnt39sotRtDlxR8/XOfNzPNqARxu3Tp4O/sazppW5Ivzs9t94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mw/OW+3i; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mw/OW+3i"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A562E60804
	for <virtualization@lists.linux-foundation.org>; Tue,  2 Jul 2024 06:37:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.299
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yw_DnQ7uatTs for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Jul 2024 06:37:32 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.10; helo=mgamail.intel.com; envelope-from=baolu.lu@linux.intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 3A1F1607D2
Authentication-Results: smtp3.osuosl.org; dmarc=none (p=none dis=none) header.from=linux.intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3A1F1607D2
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Mw/OW+3i
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3A1F1607D2
	for <virtualization@lists.linux-foundation.org>; Tue,  2 Jul 2024 06:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719902252; x=1751438252;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ebuYOo3up2lIO+mZ8J6j1N1O2VYAll9pwU9NvDibdg8=;
  b=Mw/OW+3iipoJjiO0nYOPvuLAhKedo7IcapHF6EmbRAlsmnRSXvu1hXxf
   gVQuHN1lu6miTmz7YutJ/GGZI+xqqFAKaZnDSt3Ky/sMe5Eb2QJkNoUBW
   6cMTlIQrXKbTJMdXx6WvVE0FDj1Au110NnA9eIYr2f2T+RuP+nlTeoCtW
   gpe8BrjbS/GZf8M8PrK/49XeWdsGsiq0NL08p+o6jC6/ohB0zxSIKZSHA
   deym5ab8ofHjbWAaoTTrT5Dkq/9dhsi+K03n74bPr9mkND1qKLm075NxT
   aIjUB8f6vfo3Z6ghZAVYWR4n5B1MIpFD/wusZCjMeGJRAbc3TxN+XFcV4
   A==;
X-CSE-ConnectionGUID: iG7sKq/GQN+7FIjstnEP1g==
X-CSE-MsgGUID: guRcO2aYRziic0SmQqK3IA==
X-IronPort-AV: E=McAfee;i="6700,10204,11120"; a="28455567"
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="28455567"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 23:37:31 -0700
X-CSE-ConnectionGUID: sJdbJ6N6Tya2N9RApR+X5Q==
X-CSE-MsgGUID: 8zjQDBa8Q3WgslKjkGX/tA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="50137095"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by fmviesa003.fm.intel.com with ESMTP; 01 Jul 2024 23:37:27 -0700
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
Subject: [PATCH v8 00/10] IOMMUFD: Deliver IO page faults to user space
Date: Tue,  2 Jul 2024 14:34:34 +0800
Message-Id: <20240702063444.105814-1-baolu.lu@linux.intel.com>
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
https://github.com/LuBaolu/intel-iommu/commits/iommufd-io-pgfault-delivery-v8

Change log:
v8:
 - Update an out-of-date commit message.
 - Fix an error unwind issue by storing to a reserved entry.
 - Add a fail_nth selftest case to test iommufd_ucmd_respond() failure
   path.
 - Fix a refcounting issue in hwpt allocation with fault object.
 - Miscellaneous cleanup.

v7: https://lore.kernel.org/linux-iommu/20240616061155.169343-1-baolu.lu@linux.intel.com/
 - Move the setting of handle.domain into the helpers.
 - Return value of copy_to_user() should be converted to -EFAULT.
 - Add more checks on a fetched dma handle in the sva bind path.
 - Add a constant flag in iommu_ops to replace
   IOMMU_CAP_USER_IOASID_TABLE.
 - Simplify iommu_hwpt_pgfault and iommu_hwpt_page_response by removing
   some unnecessary fields.
 - Address the wrong order between dec users and ctx_put in fault FD
   release path.
 - Miscellaneous cleanup.

v6: https://lore.kernel.org/linux-iommu/20240527040517.38561-1-baolu.lu@linux.intel.com/
 - Refine the attach handle code by shifting the handle allocation to
   the caller. The caller will then provide the allocated handle to the
   domain attachment interfaces.
 - Add reference counter in iommufd_fault_iopf_enable/disable() helpers.
 - Fix the return values of fault FD's read/write fops.
 - Add IOMMU_CAP_USER_IOASID_TABLE capability and check it before roll
   back getting attach_handle to RID.
 - Move the iopf respond queue from iommufd device to iommufd fault.
 - Disallow PRI enablement on SR-IOV VF devices.
 - Miscellaneous cleanup.

v5: https://lore.kernel.org/linux-iommu/20240430145710.68112-1-baolu.lu@linux.intel.com/
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

Lu Baolu (10):
  iommu: Introduce domain attachment handle
  iommu: Remove sva handle list
  iommu: Add attach handle to struct iopf_group
  iommu: Extend domain attach group with handle support
  iommufd: Add fault and response message definitions
  iommufd: Add iommufd fault object
  iommufd: Fault-capable hwpt attach/detach/replace
  iommufd: Associate fault object with iommufd_hw_pgtable
  iommufd/selftest: Add IOPF support for mock device
  iommufd/selftest: Add coverage for IOPF test

 include/linux/iommu.h                         |  41 +-
 drivers/iommu/iommu-priv.h                    |  11 +
 drivers/iommu/iommufd/iommufd_private.h       |  80 ++++
 drivers/iommu/iommufd/iommufd_test.h          |   8 +
 include/uapi/linux/iommufd.h                  | 109 +++++
 tools/testing/selftests/iommu/iommufd_utils.h |  86 +++-
 drivers/dma/idxd/init.c                       |   2 +-
 drivers/iommu/io-pgfault.c                    |  63 +--
 drivers/iommu/iommu-sva.c                     |  42 +-
 drivers/iommu/iommu.c                         | 185 ++++++--
 drivers/iommu/iommufd/device.c                |   7 +-
 drivers/iommu/iommufd/fault.c                 | 433 ++++++++++++++++++
 drivers/iommu/iommufd/hw_pagetable.c          |  38 +-
 drivers/iommu/iommufd/main.c                  |   6 +
 drivers/iommu/iommufd/selftest.c              |  64 +++
 tools/testing/selftests/iommu/iommufd.c       |  22 +
 .../selftests/iommu/iommufd_fail_nth.c        |   2 +-
 drivers/iommu/iommufd/Makefile                |   1 +
 18 files changed, 1083 insertions(+), 117 deletions(-)
 create mode 100644 drivers/iommu/iommufd/fault.c

-- 
2.34.1

