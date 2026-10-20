Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792509189;
	b=4k91qbb8ZSr8OHWGbdvalouWeAEw7o8ZenprTfDj/tYZqvbx6q13QdXfe7WJWLELDHX1
	 OSACMFWTbSK1FhUDKU6mZYB+PvOpJIvFz7AG1/OTg78WC0PHdJ9PDc8fzyd9MkIDJ2dIH
	 MCI/dU6auNPTtwxiVFrhVedoXTeIiuTkoZinXhX1SZMHXr0KnCJ3cQqK4HacUYY/0tR9S
	 CxmyP6CrC+ccGoP03AqbifpZC7FKi7DIoVD/FfDWNIljxAIgZwvubIX52XTrwZnRbq36U
	 wfVSJtF5WzE1Da3UoNJwOajN8jsbUuygs7GhwOnK/UZmtu3QSiCpJnjnkX2EvW6a5EA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792509189;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=4qbnn9WYV/c0LTdxKCwktHicYZbQdiXAH7GJhTBPF8Q=;
	b=HR0PIatEQY9ZfkuCCZeZPXlOmzY0Ydd1ey6ti7jkpfQGT3DiMp6walLAI+br0VUQJA5c
	 kB4Ry5J2ZArSMs8pAzmi4f3hyy/j2SQJmcUDgZ9jahNPo02j9RYafd1HIZEU0eJaTD6Lr
	 5yXgXJoPVM1/wSIH5DNh2vrlY+E/pz5StOa00qE9kN7gRFqA9a2BaOQNCPswvfn6xJJGJ
	 9Ll8OgIE9TelHExpTAwEYeXOUGuo2+dMVCJdcY+tLy4RY71Rmdj+tXg8NsUFgrkV29iSR
	 zQxu2FTG1vmi0cO1QBBWQXYYGj7E29Uc2eyPA0TaNZbNFUzBIok0unnxSQo578ZZbog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=f+sIV72B;
	arc=none smtp.remote-ip=192.198.163.14
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C73606A324
	for <virtualization@lists.linux.dev>; Tue, 20 Oct 2026 15:13:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71C73606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=f+sIV72B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792509187; x=1824045187;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=sO1oax3YMZ1BLzaTVYU90W2doi5OwwgSWeG+L03qR5k=;
  b=f+sIV72BJkAn5lIKLz95Zj8cWDC8RzR/JrnI7R+ZeU/WWlym7jYPPpxT
   WY4XlyXENKrl+/5Yxo6WNd9rM51ShGifFOdPWT1A9RqGWcf+iDoxa1vIu
   VORV7DUD1Jqqh91+yimO9yl9Yo+Y2flxz0b09z7xmX2RR9EvDrcf/HuJY
   897waRjX4+uWTjYe0e0OW+nEPS/QNgaI3ZBNduq6ZQwjWpqgPUC2HcYHx
   5yFtUonEARRnRCY90+tBzjFe5bhmNIwgJriEs/gstyVLdvD6aglV4oP1P
   mX5ofL2dhNcdaTBX0xi6itj/AtFt1oIxkUxyKd5TZ8B+F7PEQB93mwTEZ
   A==;
X-CSE-ConnectionGUID: HUEasjd5SNiO3T/A9Kd4aQ==
X-CSE-MsgGUID: VTwgl7DtR+GBH8n9N1F+EQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1228265"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1228265"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 08:13:06 -0700
X-CSE-ConnectionGUID: s/N0+p+gTFqfWHU+r9eAjg==
X-CSE-MsgGUID: Gbghaj4VTnCvc1SqSu4XqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="2731624"
Received: from pavel-dev.sc.intel.com (HELO pepopov-mobl2.amr.corp.intel.com) ([10.3.206.11])
  by orviesa008.jf.intel.com with ESMTP; 20 Oct 2026 08:13:06 -0700
From: Pavel Popov <pavel.e.popov@intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>
Cc: Pavel Popov <pavel.e.popov@intel.com>,
	Leon Romanovsky <leon@kernel.org>,
	Lukas Wunner <lukas@wunner.de>,
	Jim Chow <jim.chow@broadcom.com>,
	Radu Rugina <radu.rugina@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Wei Liu <wei.liu@kernel.org>,
	Michael Kelley <mhklinux@outlook.com>,
	Nathan Ciobanu <nathan.d.ciobanu@linux.intel.com>,
	bcm-kernel-feedback-list@broadcom.com,
	virtualization@lists.linux.dev,
	linux-hyperv@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] PCI/P2PDMA: Allow P2PDMA on Intel Xeon server CPUs
Date: Tue, 20 Oct 2026 08:13:05 -0700
Message-ID: <20261020151305.65218-1-pavel.e.popov@intel.com>
X-Mailer: git-send-email 2.54.0
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Peer-to-Peer DMA (P2PDMA) between two devices requires either a shared
upstream bridge or a host bridge matching pci_p2pdma_whitelist[]. In
VMware guests, passthrough devices appear directly on virtual root
buses without host bridge devices. In Hyper-V guests, each passthrough
device appears in a PCI domain of its own without a host bridge
device. Consequently, P2PDMA checks evaluate endpoint Device IDs
against the host bridge whitelist, causing P2PDMA requests to fail
regardless of host support.

This affects discrete devices such as GPUs, NICs and NVMe drives.

Add an explicit list of the Intel Xeon server generations from
Skylake-SP to Diamond Rapids to cpu_supports_p2pdma(). These are the
CPUs whose host bridges are in pci_p2pdma_whitelist[] without
restrictions. AMD Zen and newer are already covered by
cpu_supports_p2pdma(), so only Intel entries are needed.

Tested with the Intel Level Zero P2P benchmark (ze_peer) on Arc Pro B60
cards in a Linux guest on VMware ESXi 9.0 (Emerald Rapids host).

Signed-off-by: Pavel Popov <pavel.e.popov@intel.com>
---
Changes in v3:
- Drop the hypervisor check and move the Xeon list into
  cpu_supports_p2pdma(), next to the AMD check, as suggested by Logan
  Gunthorpe and Leon Romanovsky [1]
- Fold the VMware and Hyper-V patches into one, as the check no longer
  depends on the hypervisor

Changes in v2:
- Replace the Skylake-and-newer threshold with an explicit list of Intel
  Xeon server generations, from Skylake-SP to Diamond Rapids (Logan
  Gunthorpe)
- Move the CONFIG_X86 #ifdef out of hypervisor_supports_p2pdma()
  (Logan Gunthorpe)
- Rebased on current mainline

[1] https://lore.kernel.org/r/20261016153147.GC219304@unreal

v2: https://lore.kernel.org/r/20261016223402.19991-1-pavel.e.popov@intel.com
v1: https://lore.kernel.org/r/20261009154034.82321-1-pavel.e.popov@intel.com

 drivers/pci/p2pdma.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 9334eb314663..2650d605d87d 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -21,6 +21,11 @@
 #include <linux/seq_buf.h>
 #include <linux/xarray.h>
 
+#ifdef CONFIG_X86
+#include <asm/cpu_device_id.h>
+#include <asm/intel-family.h>
+#endif
+
 struct pci_p2pdma {
 	struct gen_pool *pool;
 	bool p2pmem_published;
@@ -519,6 +524,23 @@ static void seq_buf_print_bus_devfn(struct seq_buf *buf, struct pci_dev *pdev)
 	seq_buf_printf(buf, "%s;", pci_name(pdev));
 }
 
+#ifdef CONFIG_X86
+/* Intel Xeon CPUs whose host bridges support p2pdma */
+static const struct x86_cpu_id p2pdma_intel_cpu_ids[] = {
+	X86_MATCH_VFM(INTEL_SKYLAKE_X, NULL),
+	X86_MATCH_VFM(INTEL_ICELAKE_X, NULL),
+	X86_MATCH_VFM(INTEL_ICELAKE_D, NULL),
+	X86_MATCH_VFM(INTEL_SAPPHIRERAPIDS_X, NULL),
+	X86_MATCH_VFM(INTEL_EMERALDRAPIDS_X, NULL),
+	X86_MATCH_VFM(INTEL_GRANITERAPIDS_X, NULL),
+	X86_MATCH_VFM(INTEL_GRANITERAPIDS_D, NULL),
+	X86_MATCH_VFM(INTEL_ATOM_CRESTMONT_X, NULL),
+	X86_MATCH_VFM(INTEL_ATOM_DARKMONT_X, NULL),
+	X86_MATCH_VFM(INTEL_DIAMONDRAPIDS_X, NULL),
+	{}
+};
+#endif
+
 static bool cpu_supports_p2pdma(void)
 {
 #ifdef CONFIG_X86
@@ -527,6 +549,10 @@ static bool cpu_supports_p2pdma(void)
 	/* Any AMD CPU whose family ID is Zen or newer supports p2pdma */
 	if (c->x86_vendor == X86_VENDOR_AMD && c->x86 >= 0x17)
 		return true;
+
+	/* Listed Intel Xeon CPUs support p2pdma */
+	if (x86_match_cpu(p2pdma_intel_cpu_ids))
+		return true;
 #endif
 
 	return false;

base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
-- 
2.53.0

