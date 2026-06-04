Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E21B35200A;
	Thu,  4 Jun 2026 09:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780565777; cv=none; b=Nu9eGVfQM3aUZ95J1WnltSHlaD0hFkSBXg5Roxzv0mv/rugov2VJuQiKKbaaKwrCwXWhADXkE2EqFGZY5glOcrevmgtJO8kM49OZz1H7vOI1p0auLf49q+Hjvvfhk87mqGS5A0SQ7KqxDfw9wZ7ZZT+2Cak/6re8wKJdCqCBlWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780565777; c=relaxed/simple;
	bh=opN/8F50m7pH/+N7nhktDQOKV6VRAE1qTVfPB6Ej2vo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U8Ru9yitRAOR3Dst1zf20jbE7BESl8kfVOkBuUxeUXKqwYQ+zh7XLGZAaiDEL2nT9z4ROxir83N8FYfSfWICxHNIc3mxSM3kV3gbAOFi1W9VCCMRwy5HQXlHVRszv7SP1nPf8CCwj7HeCtvl9h0tz/Rhi0qazJMHFNIEzMw9Xnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GsO5DY/N; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GsO5DY/N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780565776; x=1812101776;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=opN/8F50m7pH/+N7nhktDQOKV6VRAE1qTVfPB6Ej2vo=;
  b=GsO5DY/NcZ6Y54dccnyVMWHi81N8DldV707xAcvbi9z/eNfmT4+nwdgh
   tyiF6XirnmmrQfonwmyu1EUXkviyLYYieGWFEEORGhp66xK+0R26OIruG
   6nM5MDHs3Ejx8u5TsnO/S6ZtV8lvC0tbm11dG/KmZZnqf+pj+pchTlOgs
   3P6oteSEBU1IngtNMWn4PXO4WT5IFBxmqsx9iIFjjfnLgrobtdtTn5pNA
   2VeUX+H141sTBC1TA8QwhO3Ce3bR6Scggq8+sJKPe6puLBqPh0Rr1MDtA
   pNBW/DdYZ9yz3px/JvtyrY9MS03D4IUxzKMZcCbrSovwkIs462Yovv8XX
   Q==;
X-CSE-ConnectionGUID: o4clRROCSvSZxav9Jii/aA==
X-CSE-MsgGUID: Evf9B5utSI2VRyBsNwhm8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11806"; a="98963701"
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="98963701"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 02:36:15 -0700
X-CSE-ConnectionGUID: Ci7eD2CRQ9G46hUPZhpE7w==
X-CSE-MsgGUID: t2fFAioqRTqsMSOvO9K/KA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="240037539"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 02:36:10 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: marcandre.lureau@redhat.com,
	david@kernel.org,
	kas@kernel.org,
	rick.p.edgecombe@intel.com,
	prsampat@amd.com,
	pbonzini@redhat.com,
	mst@redhat.com,
	peterx@redhat.com,
	chenyi.qiang@intel.com,
	elena.reshetova@intel.com,
	michaeluth@amd.com,
	ackerleytng@google.com
Cc: linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev,
	virtualization@lists.linux.dev,
	x86@kernel.org,
	yilun.xu@intel.com,
	xiaoyao.li@intel.com,
	chao.p.peng@intel.com
Subject: [RFC PATCH 0/6] Support virtio-mem memory hotplug in TDX guests
Date: Thu,  4 Jun 2026 05:35:45 -0400
Message-ID: <20260604093551.1511079-1-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This RFC series explores the start-private memory approach for virtio-mem
CoCo support using TDG.MEM.PAGE.RELEASE. We are seeking feedback from
Kiryl on the CoCo guest implementation, MM experts on the callback
infrastructure and virtio-mem integration, and broader virtio/CoCo
community input on the overall approach. We are not seeking x86 maintainer
review at this stage.

== Background ==

In Confidential Computing (CoCo) guests like TDX, memory hotplug
operations face unique challenges:

1. Newly added memory must be explicitly "accepted" by the guest using
TDG.MEM.PAGE.ACCEPT TDCALL before it can be safely accessed. Accessing
unaccepted memory triggers VM exits and guest crashes.
2. Hypervisor may perform no-op unplug operations, leaving old memory in
place. Re-accepting this already-accepted memory during re-plug operations
returns errors.
3. State management become much more complex, "accepted"/"unccepted" plus
"plugged"/"unplugged".
4. Initial virtio-mem memory may be start-private or start-shared.

A previous series [1][2] supports start-private memory and utilized memory
hotplug notifiers to call tdx_accept_memory() before pages are freed to
the buddy allocator. However, this approach has limitations:

1. virtio-mem operates memory at subblock granularity (e.g., 2MB chunks
within 128MB memory blocks), while generic memory notifiers operate on entire
memory blocks, causing acceptance of unplugged subblocks with no backing
memory.
2. Re-accepting already-accepted memory returns errors. Ignoring these errors
can mislead the guest into believing re-accepted memory is zeroed when it
contains stale data.

Currently, virtio-mem spec doesn't define what kind of hotplugged memory
should be supported for CoCo guest, shared or private or both. There is a
newer series [3][4] supporting start-shared memory in discuss. It converts
shared->private before online (via set_memory_encrypted-> MapGPA + ACCEPT),
and back to shared on unplug (via set_memory_decrypted).

== About this series ==

This series takes a different direction, supporting start-private memory
and addressing the limitations of previous series [1] by implementing a
callback-based infrastructure that integrates TDX memory acceptance and
release operations with proper subblock granularity. See Rick and Paolo's
discussion about using TDG.MEM.PAGE.RELEASE in [1].

The goal is not to compete with existing efforts, but rather to kick off
discussion and seek for suggestions from mm expert whether utilizing
callback-based infrastructure and PAGE.RELEASE API is a viable scheme.

We chose the generic post-plug and pre-unplug callback approach because
it provides a simple proof-of-concept that can support kexec/kdump
scenarios, though it does not support lazy acceptance. We rely on
community discussion to identify better, more upstreamable solutions if
the start-private direction is ultimately adopted.

== More details ==

**Post-plug callbacks** are registered by TDX guests during early boot and
triggered by virtio-mem after successfully requesting memory from the
hypervisor. The callback invokes tdx_accept_memory(), which performs
TDG.MEM.PAGE.ACCEPT TDCALL on the exact memory range that was plugged,
providing subblock-aware granularity. Note that tdx_accept_memory() may
not be fully self-consistent in all environments, as some pages may
remain in an "accepted" state while others do not, since page release is
not supported across all TDX module versions.

**Pre-unplug callbacks** are registered during early boot and invoked by
virtio-mem before requesting memory removal from the hypervisor. The
callback executes tdx_release_memory(), which performs
TDG.MEM.PAGE.RELEASE TDCALL with an optimization strategy that attempts
1GB/2MB page releases first before falling back to 4KB pages for maximum
efficiency. Unlike acceptance operations, tdx_release_memory() maintains
full self-consistency since page acceptance is universally supported
across TDX implementations.

**Error handling strategy** prioritizes system stability by marking the
virtio-mem device as broken whenever TDX operations fail:

1. Post-plug failures: If memory acceptance fails after successful
hypervisor allocation, the device is marked as broken to prevent memory
corruption. The hypervisor-side memory is leaked for the device lifetime.
2. Pre-unplug failures: If TDX memory release fails, the device is marked as
broken and no hypervisor unplug is attempted.
3. Hypervisor unplug failures: If the hypervisor unplug fails after
successful TDX release, the system attempts to re-accept the memory for
consistency. If re-acceptance fails, the device is marked as broken.

This approach avoids complex recovery mechanisms that could fail and
cause state corruption, choosing instead to fail safely by disabling the
device when TDX operations cannot maintain consistent state between guest
and hypervisor.

**PAGE.RELEASE configuration** requires explicit enablement by the
hypervisor during TD creation. The hypervisor must set the
CONFIG_FLAGS.PAGE_RELEASE flag in the TD's configuration to enable
TDG.MEM.PAGE.RELEASE functionality within the guest. Without this
configuration, guests cannot perform memory release operations and must
rely on the hypervisor to handle private memory release. This series
focuses on guest-side changes and does not include hypervisor
modifications, which can be added in future versions if needed.

== Testing ==
Tested with qemu [2] which supports start-private memory:
Basic memory hotplug/unplug test.
Basic kexec/kdump functions test with zero/half/full memory plugged.

Interestingly, it also pass with qemu [4] which supports start-shared memory,
because acceptance triggers memory convert implicitly, but it's slow as
implicit conversion is 4K page granularity.

== Future work ==
support lazy accept

Thanks
Zhenzhong

[1] kernel: https://lore.kernel.org/kvm/20260324-tdx-hotplug-fixes-v1-0-8f29f2c17278@redhat.com/
[2] qemu: https://lore.kernel.org/qemu-devel/20260226140001.3622334-1-marcandre.lureau@redhat.com/
[3] kernel: https://lore.kernel.org/lkml/20260401-coco-v1-1-b9c3072e2d9c@redhat.com/
[4] qemu: https://lore.kernel.org/qemu-devel/20260504-rdm5-v4-0-bdf61e57c1e1@redhat.com/


Zhenzhong Duan (6):
  mm/memory_hotplug: Add memory post-plug callback infrastructure
  mm/memory_hotplug: Add memory pre-unplug callback infrastructure
  virtio-mem: Integrate memory acceptance and release callbacks
  x86/tdx: Register memory post-plug callback for TDX guests
  x86/tdx: Register memory pre-unplug callback for TDX guests
  x86/tdx: Release private memory before private->shared conversion

 arch/x86/include/asm/shared/tdx.h |   2 +
 include/linux/memory_hotplug.h    |  21 ++++
 arch/x86/coco/tdx/tdx.c           | 174 ++++++++++++++++++++++++++++++
 drivers/virtio/virtio_mem.c       |  80 ++++++++++++--
 mm/memory_hotplug.c               |  40 +++++++
 5 files changed, 307 insertions(+), 10 deletions(-)

-- 
2.52.0

