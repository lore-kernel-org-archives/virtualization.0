Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792517861;
	b=imTqnD7sGFgLtVMe3NzdcYdFrKOvBeIIPvjhQjx/VOOt8dKHbQOx7tRsG9MM2AMq4bbQ
	 H8ZV3EFbEAfNl3tTPIOEUSFCmt1eLEld2Q1EOAIrvYcRLa7lO2ygU17330MdFYzY1iFit
	 KNEDoAksw2++1lB3BO5xHO9CSH/s/k0Cdav6vUoaiDOHp+EBzzHfN6/Lw0AGYVKKp8NPo
	 iSsC14CAURX7sHegIiMkI4YAhq3Uy5C2q4QFMn3wMtmLBorZhIBxHV8asz/arRXI/tbDo
	 5G2ZQBZBO6qpolXbH8iER+/WNM7Zg2zR3KpGw5oerxfIeekiyJDqRoFY61N7Ti0LVdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792517861;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=PCz/m/c0hrv+w+UfpzDjo15sDLKbVAPCRpnlY8c/hao=;
	b=HYTerl+L6wCdraVacrvUrPUVl9zbZ9aFoaF/ohLNIZnMlTVWC+9lnfTeNiv5RDpVn/qq
	 TcduY9/w3Pb6JX1WOOn2rzvh8CWri2FhiigAa7HyC0A66WfUc0/81QEGO7c2lfaTeUnJh
	 BRp8Z/gJadLqMNlFJpQ1VSSkfl/l32ojj1vA0KMMXemR0HdPtHzS+QC+p01QmKJY4OG92
	 ghiBJPDLHBe+FKaDViicJQCfiwz8YZCitQi8aZeXb3ZJXlZeLXIHMfyFvYPUpuF3xj8Mr
	 92bY/K/HACYqVxWbEoHaOxpx3hqzHYxrITupMEgQ9oihoD4q57/84nOfug4ygNQWUTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=AhdF1xZu;
	arc=none smtp.remote-ip=198.175.65.18
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7DE60A382A
	for <virtualization@lists.linux.dev>; Tue, 20 Oct 2026 17:37:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD7DE60A382A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=AhdF1xZu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792517860; x=1824053860;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RUyd6kZ+YfWyuoa7IgqAcMEVhKzI1d/tst80lIZ4YJ8=;
  b=AhdF1xZuaTO6iGp/vgt5QQwP8653qp2gE9jJ7/FA6r23lJcgiEfi28Xu
   2HwIwouiyla9rz0HDtAjsTWl1pgGwjjzfeTxqYKKXsx3UpS7VFRz+4YEQ
   CjNAPSlIo1xL3AjfeNpNDDsmLCP04zmgs8W+dlxfQgWKxJKm3JaoYWEKH
   UBltv/09ws3Avv4NxEDksPMA+cNqMPl8pyBC3zswguBUODrDJHhzz95+R
   25thtlgjlKw7ByMYKi3tdAdMoabnETXmDxZvSIWwEsNToPmYjc8No8t6B
   gxiIFkUlJxHxroPjRZhd815zniPAzYC/K9UTH7DJA05O/4epZiQUj0J0Y
   w==;
X-CSE-ConnectionGUID: w2fzHZtYT2SkxyLn39pw3Q==
X-CSE-MsgGUID: F+TS35J6SveOmnL5jbVJzA==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1240987"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1240987"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 10:37:39 -0700
X-CSE-ConnectionGUID: HxxsQgfXS4Kbw/wpKlkfsw==
X-CSE-MsgGUID: 4G7+9sKVSiqsPwilTyfZng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="2875821"
Received: from pavel-dev.sc.intel.com (HELO pepopov-mobl2.amr.corp.intel.com) ([10.3.206.11])
  by orviesa009.jf.intel.com with ESMTP; 20 Oct 2026 10:37:39 -0700
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
Subject: [PATCH v4 2/2] PCI/P2PDMA: Allow P2PDMA on Intel Xeon server CPUs
Date: Tue, 20 Oct 2026 10:37:36 -0700
Message-ID: <20261020173736.81755-3-pavel.e.popov@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261020173736.81755-1-pavel.e.popov@intel.com>
References: <20261020173736.81755-1-pavel.e.popov@intel.com>
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
 drivers/pci/p2pdma.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 6b4f0843b404..cb9084fb0990 100644
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
@@ -520,6 +525,21 @@ static void seq_buf_print_bus_devfn(struct seq_buf *buf, struct pci_dev *pdev)
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
@@ -528,6 +548,10 @@ static bool cpu_supports_p2pdma(void)
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
2.53.0

