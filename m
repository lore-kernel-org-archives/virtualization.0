Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE0F376A08;
	Tue, 23 Jun 2026 10:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782209874; cv=none; b=iBJFpPl2TPxv7nCqxDic729yPLWsGcwVT1CV5IH1zz4BY4EL8mVDkla59/kYuVxqZJh4kFV8I+PweBbTqXt2Mnc+kNJ+mzgq8SUe0vRnPlv5Ehoqr83tD2uf7u4fweFvrq6sUz7qw/sI2inN+9R6os6nACNzCP+YHUin3dr/VWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782209874; c=relaxed/simple;
	bh=9+NmUPZYan/2z3lhCSLU0gmTAwoalPBELi3FaHFAQLk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HMAc/6QL9vVZemGtWRLYcb99WkzR911zf0vooLak+qeNiePhxE1tRklLt5hSjMC3bLaoMVOBihbRn1zQu5tj2j2ILagHCUfrP8Gzoo/pjX8H396/8UDU2t4KvjcezxUKZxyp3kmO70+ihb0dRJDzD+sjzq4bpFdrUaA92Fk/huQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jb6wQiNl; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jb6wQiNl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782209873; x=1813745873;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9+NmUPZYan/2z3lhCSLU0gmTAwoalPBELi3FaHFAQLk=;
  b=Jb6wQiNlyhQF6yjY1Y6KPx/XAHf/tMqeQd92oN+99YvjrOzbkU/C0CsJ
   oh6kqll2fLfS3eB1kx6IpwheFcGryb9G19EFssxnhLQTNn1uys7YdjJhb
   G1ja5kYk7WjJY/oAphAqTsR0piEK7E278iuuUXczupe2htF8pj+1tUrdj
   0ElDmuwtiZgql7yp5WW0BIPxO+qZqSwk0AjA1PX40Wrl5Lg4psN9htyQH
   x7e725QceyUULQau+Ord4UlCTh6c7LznbtDwY1UwK+9Lp2dJ8N543FrKy
   oALiHZKOSpiEMcFlPLGQvrBhfNY16geut8p6au3IijCqywUFwPGg60U2t
   g==;
X-CSE-ConnectionGUID: pgDt5LnDTwODHAX2qcXwTA==
X-CSE-MsgGUID: PjqdLhKqR6u9j5K23adCQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11825"; a="82717777"
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; 
   d="scan'208";a="82717777"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 03:17:52 -0700
X-CSE-ConnectionGUID: RhHLqMzURSmpCYOQcmFWuQ==
X-CSE-MsgGUID: rrLgd3jeShecIHLr9tfqtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; 
   d="scan'208";a="245339804"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 03:17:48 -0700
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
	michael.roth@amd.com,
	ackerleytng@google.com
Cc: linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev,
	virtualization@lists.linux.dev,
	x86@kernel.org,
	yilun.xu@intel.com,
	xiaoyao.li@intel.com,
	chao.p.peng@intel.com
Subject: [RFCv2 PATCH 0/6] Support memory hotplug/unplug for TDX CoCo guests
Date: Tue, 23 Jun 2026 06:17:31 -0400
Message-ID: <20260623101739.79695-1-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This RFCv2 series implements comprehensive support for virtio-mem and ACPI
DIMM memory hotplug/unplug in Intel TDX confidential computing guests.
It explores the start-private memory approach utilizing the native
TDG.MEM.PAGE.RELEASE API.

We are seeking feedback from Kiryl on the CoCo guest implementation, MM
experts on DIMM & virio-mem memory hotplug integration and broader
virtio/CoCo community input on the overall approach. We are not seeking
x86 maintainer review at this stage.

== Changes from RFC v1 ==

- Eliminated callback infrastructure: Dropped plug callback and replaced
  unplug callback with platform-level unaccept function into core MM
  hotplug and virtio-mem subsystems.
- Added comprehensive bitmap tracking: Introduced a "plugged" bitmap
  alongside the unaccepted bitmap to track populated hotplug memory
  states to support load_unaligned_zeropad().
- Enhanced SRAT parsing: Extended the EFI stub to parse ACPI SRAT tables
  early, ensuring hotpluggable ranges are tracked from initial boot.

For more introduction about the background or other efforts in community,
please check the RFCv1 cover letter [1].

== Technical Approach ==

- Early SRAT Integration: A lightweight EFI stub parser scans ACPI SRAT
  tables to identify hotpluggable ranges and adjust bitmap boundaries
  early, avoiding the overhead of the full ACPI subsystem.
- Comprehensive Bitmap Tracking: Introduces a "plugged" bitmap right
  after the unaccepted bitmap. Both static and hotplugged memory are
  tracked, allowing the guest to map which ranges are populated by the
  VMM. This prevents acceptance beyond plugged memory boundaries due to
  load_unaligned_zeropad() operations.
- Platform Extensibility: Exposes generic CoCo memory interfaces. Other
  confidential platforms (like AMD SEV-SNP) can easily adopt this by
  hooking their specific mechanisms into arch_unaccept_memory().
- Hotplug & Guest Control: Integrates platform-level unaccept logic
  into ACPI hotplug and virtio-mem handlers. Uses TDG.MEM.PAGE.RELEASE
  for TDX to explicitly set memory to the "unaccepted" state during
  unplug, removing host hole-punching dependencies.
- Kexec Handover: Leverages existing EFI mechanisms to seamlessly hand
  over both the extended unaccepted bitmap and the new plugged bitmap
  across kexec boundaries.

== Testing ==

- dimm and virtio-mem memory hotplug/unplug
- lazy and eager accept
- kexec/kdump with hotplugged memory

This is tested with Marc-André Lureau's newest qemu series [2]

Comments appreciated, thanks.

Zhenzhong

[1] https://lore.kernel.org/all/20260604093551.1511079-1-zhenzhong.duan@intel.com/
[2] https://lore.kernel.org/all/20260604-rdm5-v5-0-5768e6a0943d@redhat.com/

Zhenzhong Duan (6):
  efi/unaccepted: Support hotplug memory in unaccepted bitmap via SRAT
  efi/unaccepted: Set unaccepted bits for all hotplug memory
  efi/unaccepted: Create plugged bitmap to support hotplug memory in
    coco guest
  x86/tdx: Implement arch_unaccept_memory()
  mm/memory_hotplug: Support ACPI hotplug/unplug for coco guest
  virtio-mem: Support memory hotplug/unplug for coco guest

 arch/x86/include/asm/shared/tdx.h             |   2 +
 arch/x86/include/asm/tdx.h                    |   2 +
 arch/x86/include/asm/unaccepted_memory.h      |  11 ++
 drivers/firmware/efi/libstub/efistub.h        |   6 +
 include/linux/efi.h                           |   5 +
 include/linux/mm.h                            |  11 ++
 arch/x86/boot/compressed/mem.c                |   4 +-
 arch/x86/coco/tdx/tdx.c                       | 120 ++++++++++++++++
 drivers/firmware/efi/efi.c                    |   4 +-
 .../firmware/efi/libstub/unaccepted_memory.c  | 128 +++++++++++++++++-
 drivers/firmware/efi/unaccepted_memory.c      | 122 ++++++++++++++++-
 drivers/virtio/virtio_mem.c                   |   8 ++
 mm/memory_hotplug.c                           |  16 +++
 13 files changed, 425 insertions(+), 14 deletions(-)

-- 
2.52.0

