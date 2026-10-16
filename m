Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A3537EFFC
	for <virtualization@lists.linux.dev>; Fri, 16 Oct 2026 22:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792190048; cv=none; b=UdJpBApENmNp+68ZhRc84/+bXE5OltQl7rUGMy2HpJwwyK3/l+Z5S7KPJ6gIrMLWzOR59fVQhF4LccNZFMibLh0ITSPMKqHhPKnbtancXUk6WKvcfdi9C5+sfbnYIWzIDsNHcl1F6JibMPz6Us9L4YRJw61oHPj6+ZnSYBineBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792190048; c=relaxed/simple;
	bh=xXTgKKiF8Vh29vliOCJzdcrX82neJvvVERU0Nyh0x1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MZjYkX23Aj2ZZ9BHe8ELwO4229rqXP5A0aeFLR/nRw7NRApb7BbWtn/yXqHhRekaOqzmXtHNV9zRtBQ/wlZZd3RK4Wsit7zrZ1lYo0P/7IWHoKR8CZe4uRBiHuBM9u7X1itAvWxAnAXybmFl/DtgIHAWzyfbvhM5Vxd5PD6hOdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fJ0V1Mb3; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fJ0V1Mb3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792190047; x=1823726047;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xXTgKKiF8Vh29vliOCJzdcrX82neJvvVERU0Nyh0x1I=;
  b=fJ0V1Mb39fwAUiKHmE0h4jvikko01SL3pZEdHOmBu9S9yavd2wtzc07p
   LAm/RyG9c1LFR6g8fzjoRYgSMbN+Oggf4Unq+l+OswaFiuOpObA94M7YB
   1v9XEOehF8NrQ8lX+dIEnRbYMBPlytCG4aekrH/ppDeV6GZF2SZo+TmoY
   7RSeG7puNGoezKOp433uUBG9V/qNwkFDhZBQlDWr2OQfHCoHg5StUjhH2
   xuCAsds9QMWiCuJ4e5VvHxK2ixJaPhI8EBSjUJcTXlJoR1MxnXhqFjxsa
   1OLnyPEef21Zp55Y3qdPswqbeI2dsU+h4zWRihn1P4v0P+v7Q5hmiVzcA
   g==;
X-CSE-ConnectionGUID: CDD0dkY/Q9WlhWeZCllsMA==
X-CSE-MsgGUID: kIKFK7voQAOeBzHLgSQO8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11937"; a="990194"
X-IronPort-AV: E=Sophos;i="6.27,162,1787036400"; 
   d="scan'208";a="990194"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2026 15:34:06 -0700
X-CSE-ConnectionGUID: kwq0Bn+xQ267JFNLPHxhHg==
X-CSE-MsgGUID: mRY1CQsaQbe/voAv60Fnmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,162,1787036400"; 
   d="scan'208";a="2025034"
Received: from pavel-dev.sc.intel.com (HELO pepopov-mobl2.intel.com) ([10.3.206.11])
  by orviesa009.jf.intel.com with ESMTP; 16 Oct 2026 15:34:04 -0700
From: Pavel Popov <pavel.e.popov@intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>
Cc: pavel.e.popov@intel.com,
	Jim Chow <jim.chow@broadcom.com>,
	Radu Rugina <radu.rugina@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Wei Liu <wei.liu@kernel.org>,
	Michael Kelley <mhklinux@outlook.com>,
	Lukas Wunner <lukas@wunner.de>,
	Leon Romanovsky <leonro@nvidia.com>,
	Nathan Ciobanu <nathan.d.ciobanu@linux.intel.com>,
	bcm-kernel-feedback-list@broadcom.com,
	virtualization@lists.linux.dev,
	linux-hyperv@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] PCI/P2PDMA: Allow P2PDMA in VMware guests on Intel hosts
Date: Fri, 16 Oct 2026 15:34:01 -0700
Message-ID: <20261016223402.19991-2-pavel.e.popov@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261016223402.19991-1-pavel.e.popov@intel.com>
References: <20261016223402.19991-1-pavel.e.popov@intel.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Peer-to-Peer DMA (P2PDMA) between two devices requires either a shared
upstream bridge or a host bridge matching pci_p2pdma_whitelist[]. In
VMware guests, passthrough devices appear directly on virtual root
buses without host bridge devices. Consequently, P2PDMA checks
evaluate endpoint Device IDs against the host bridge whitelist,
causing P2PDMA requests to fail regardless of host support.

This affects discrete devices such as GPUs, NICs and NVMe drives.

The P2PDMA host bridge check does not work in a VMware guest. Bypass it
for host CPUs whose host bridges are in pci_p2pdma_whitelist[] without
restrictions. The list covers the Intel Xeon server generations from
Skylake-SP to Diamond Rapids. AMD Zen and newer are already covered by
cpu_supports_p2pdma(), so only Intel entries are needed.

Tested with the Intel Level Zero P2P benchmark (ze_peer) on Arc Pro B60
cards in a Linux guest on VMware ESXi 9.0 (Emerald Rapids host).

Signed-off-by: Pavel Popov <pavel.e.popov@intel.com>
---
 drivers/pci/p2pdma.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 9334eb314663..1b4886d4f9be 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -21,6 +21,12 @@
 #include <linux/seq_buf.h>
 #include <linux/xarray.h>
 
+#ifdef CONFIG_X86
+#include <asm/cpu_device_id.h>
+#include <asm/hypervisor.h>
+#include <asm/intel-family.h>
+#endif
+
 struct pci_p2pdma {
 	struct gen_pool *pool;
 	bool p2pmem_published;
@@ -532,6 +538,37 @@ static bool cpu_supports_p2pdma(void)
 	return false;
 }
 
+#ifdef CONFIG_X86
+/* CPUs whose host bridges support p2pdma, see pci_p2pdma_whitelist[] */
+static const struct x86_cpu_id hypervisor_p2pdma_cpu_ids[] = {
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
+static bool hypervisor_supports_p2pdma(void)
+{
+	/* Hypervisor hides host topology, allow p2pdma on whitelisted CPUs */
+	if (hypervisor_is_type(X86_HYPER_VMWARE))
+		return x86_match_cpu(hypervisor_p2pdma_cpu_ids);
+
+	return false;
+}
+#else /* !CONFIG_X86 */
+static bool hypervisor_supports_p2pdma(void)
+{
+	return false;
+}
+#endif /* CONFIG_X86 */
+
 static const struct pci_p2pdma_whitelist_entry {
 	unsigned short vendor;
 	int device;
@@ -781,6 +818,7 @@ calc_map_type_and_dist(struct pci_dev *provider, struct pci_dev *client,
 
 map_through_host_bridge:
 	if (!cpu_supports_p2pdma() &&
+	    !hypervisor_supports_p2pdma() &&
 	    !host_bridge_whitelist(provider, client, acs_redirects)) {
 		if (verbose)
 			pci_warn(client, "cannot be used for peer-to-peer DMA as the client and provider (%s) do not share an upstream bridge or whitelisted host bridge\n",
-- 
2.53.0

