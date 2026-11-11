Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794440688;
	b=PpTRK9OHvlz95GxIQRx8xjQ1mXNfbbRoHyLwSzUqECdKzPKlwRCWbPsTaFxShlcR6RNE
	 3YJJArcaVyD/+WJDgFz/i8/Km+sA/1CNnvqQh8lOmSy8UUt65xJKVm1MqmESgdSclNN3I
	 Lxo0AqT6Hu4RcarztZxO7VN6lXa67GPHGhC9hs1ZJ/u7g9b+nUwJnOJErk5hwjkHv51EO
	 ILVxlhjnv8sLbOoCu2xU+MOrXxPYRjpM6YPvLbDcY49Us9K22pKObRBU3dp9e/DFFDN4s
	 +BggBiYR6rbpYGntOkEMTt5vZ9c/FgFzFzpV7ag0UaeINr1qtba/FOgp8v+IDT+C5MA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794440688;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=QjkfhNnljBzuGrDTTeg8+Hg4if61ZIAEg5Uf4N2V+Q4=;
	b=EBdvhrYVw+gSXURKgY1oJNXByq5rPiy18XSbZOIGR4UxXqpnptq5R8miYxw6ife2yXdz
	 pbzJPtrvR29b+cKtSB2zZ5mbRpFH9NySBZ7ZZwmqvsnAJHZwPZ3YoXjrUrJJKIwH/vQQ/
	 ge3IBoQURoDPbuC1DVW3pWCepwwjbGOT1nCXO65oVmMuuf8tih7NyLPPk44t2NGIN9eIp
	 lDkhxTuZXC8OA6+ehRgYeyy2rWfj3c0QxtlrtbUB+q8Vbv35/eJHYHomDC0Dnj5cRe1qr
	 ZXbSpH8MmXAEN1lzRPUWMGWwiOUF4ZWjEkPdBW8ILmU2R5h+Ehn2e/1T+gRQq2fQlJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KV0Cd7zW;
	arc=none smtp.remote-ip=192.198.163.9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3CB60A2635
	for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 23:44:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA3CB60A2635
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KV0Cd7zW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794440688; x=1825976688;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=U1MDFCgTAgpjswU78txZG/8/izNhkf0r3rSAPUmiHZ0=;
  b=KV0Cd7zWtgo9qX2ufkaPghYGTqRlzguEz4orJgyWjlPZVjDGljgPo+y1
   7k+H6OjA+E0OWivzAoyhHaxPfMo5eVKLyc76J2/ZNpuknbzI58R91JYTc
   9xxNinktN3WL4VswizDNPTaK//nTJpAbljNbmuKfnmqEiIkL6oecEB1F5
   vlR2cWg9hLuQWv1C5DanqFCwNRKx2FQb2GZRa6pWwm2LY39j/v5hKBFGr
   qiDi5FFHcUMS4+abgviUgv+s5xPtuZlVm6t/K5jeEVYRwWQXccfPUI6Tl
   GD5jx5xy4rv41czFZM+xQZy2w1LStCN5maMS5hyxZdi4lLbhKpIzAGqLT
   Q==;
X-CSE-ConnectionGUID: I7cwHOrGRvi6VrWzWXgfvQ==
X-CSE-MsgGUID: lex8hqe9QoO+OtL61u+16w==
X-IronPort-AV: E=McAfee;i="6800,10657,11963"; a="3099125"
X-IronPort-AV: E=Sophos;i="6.27,208,1787036400"; 
   d="scan'208";a="3099125"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 15:44:46 -0800
X-CSE-ConnectionGUID: gOwC9/ZmTZCMmIufvKa+1Q==
X-CSE-MsgGUID: H0iwglT+TQiBExPMgAOOqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,208,1787036400"; 
   d="scan'208";a="10241297"
Received: from pavel-dev.sc.intel.com (HELO pepopov-mobl2.intel.com) ([10.3.206.11])
  by fmviesa012.fm.intel.com with ESMTP; 11 Nov 2026 15:44:45 -0800
From: Pavel Popov <pavel.e.popov@intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Arnd Bergmann <arnd@arndb.de>
Cc: Pavel Popov <pavel.e.popov@intel.com>,
	Leon Romanovsky <leon@kernel.org>,
	Lukas Wunner <lukas@wunner.de>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	Jim Chow <jim.chow@broadcom.com>,
	Radu Rugina <radu.rugina@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Wei Liu <wei.liu@kernel.org>,
	Michael Kelley <mhklinux@outlook.com>,
	Nathan Ciobanu <nathan.d.ciobanu@linux.intel.com>,
	bcm-kernel-feedback-list@broadcom.com,
	virtualization@lists.linux.dev,
	linux-hyperv@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 3/3] PCI/P2PDMA: Allow P2PDMA on Intel Xeon server CPUs
Date: Wed, 11 Nov 2026 16:44:39 -0700
Message-ID: <20261111234439.4098-4-pavel.e.popov@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261111234439.4098-1-pavel.e.popov@intel.com>
References: <20261111234439.4098-1-pavel.e.popov@intel.com>
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
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/pci/p2pdma.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 180fe5d6228..85e45bbe321 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -21,6 +21,8 @@
 #include <linux/seq_buf.h>
 #include <linux/xarray.h>
 
+#include <asm/cpu_device_id.h>
+
 struct pci_p2pdma {
 	struct gen_pool *pool;
 	bool p2pmem_published;
@@ -521,6 +523,21 @@ static void seq_buf_print_bus_devfn(struct seq_buf *buf, struct pci_dev *pdev)
 }
 
 #ifdef CONFIG_X86
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
+
 static bool cpu_supports_p2pdma(void)
 {
 	struct cpuinfo_x86 *c = &cpu_data(0);
@@ -529,6 +546,10 @@ static bool cpu_supports_p2pdma(void)
 	if (c->x86_vendor == X86_VENDOR_AMD && c->x86 >= 0x17)
 		return true;
 
+	/* Listed Intel Xeon CPUs support p2pdma */
+	if (x86_match_cpu(p2pdma_intel_cpu_ids))
+		return true;
+
 	return false;
 }
 #else /* !CONFIG_X86 */
-- 
2.54.0

