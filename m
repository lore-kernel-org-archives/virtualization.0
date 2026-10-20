Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792517860;
	b=Aqw72Il+eWKll1ppodeuSSuXW+xmRcaoUJKwGUmRb6/4hh29QqZlDfzHRhgYbdHc2q0Y
	 +gc8UHWZ+vNxr8H9ygM/X1HJ/HYYG147UMLHwgjdf4f8bf+s1qA+g43T7ZYwCUn5pBJ1a
	 EqJsbp/dtql0H8xdcWVKtx4XZmszu4VAXpPQB2AMj3/huPT5Yk0mfYLVgc9G5JEma7x+0
	 TMuvI8ef9/yCD2Mna/rHChjsK80XiKiNtNRNkAEIx+cWIdMKECjJ0q7bb7cZxZqsJSC+q
	 qK5EBW9eHGPmPbF3v92bxk1I2W/mG6WxQ4BJijhAcsM6IufvBDon5BPSqLVcoj41Mjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792517860;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=TKkOlr8jhwPsaGpPmPHJTkYY5YSC6yQCu+UpabW7Ryk=;
	b=ek1NndpYQDzqllpN5Xg6IrlLe7+9i9Tqdd1UjIF6zmsEKFVMPuVq3e41+BU39fC9xCOl
	 OPSIXV/1DQzEVTq0hkVzpntOH8bUwwtbqXcOCD3tTFozTETNSGx+XTbGxs+QeVFJMe5fu
	 SBe8rtGXK3K/f3vdydkYJLYpGnBfZM81/DDaxVdUjfdlHtNDhO9Pr3L6vHfygunsFzQKl
	 e5eYJsYngCIIeYjK/rIhrUkHVbSiE8xHIPEKGj6f2R9TqRAQXfIK5rh2RBxRXlhVzMVYp
	 bCq+jO/E6e64w7MF/xpj1PeMxEtlh6Mva+voqdj/CMNGJSrNHf7x4tK7c6RL84x1SDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=T0MBG7cx;
	arc=none smtp.remote-ip=198.175.65.18
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA4560A3806
	for <virtualization@lists.linux.dev>; Tue, 20 Oct 2026 17:37:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2FA4560A3806
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=T0MBG7cx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792517859; x=1824053859;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LT+IC68DFoWhCEiVuCUJvJbdsesQnL9TfpdLkDLQFfY=;
  b=T0MBG7cxlA2UBKzkzKjgqa7cL7Vg4Vk3WWgZb/EykQ/sjeaFWMfXhyRR
   t/V/IKUTio1wBGb0CVNnSesivDBBqIy78RakmgcHIlqM8kn5muSGUCwqF
   YAwZmmk4O5WnggoRxXx4laIyQbniam4+54TWyOPvtkVIiWVDI+uwuldu0
   J8lkwO0V7moLScs8Jwaj1ysbvhuZRL1tP6+kzHEujuSOWdLHnMY7nag5k
   PTc5Iyqg7f0MA62Ed3+dxJCqR2dyyeplLNvbEVqUWPGCev87Iv8ugP5yM
   oidNlLg2Ka12X9P9haimhyrTba+mI+RNo1rm15Jhpvbz446T0gYIk7WY7
   w==;
X-CSE-ConnectionGUID: fYOeE+BxS72J3vxiShx7SA==
X-CSE-MsgGUID: ZW3W5FfnRu6y2eYEHjgIgw==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1240979"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1240979"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 10:37:38 -0700
X-CSE-ConnectionGUID: WWnwPJbtStKN75lp7RYfhg==
X-CSE-MsgGUID: HfTLR9KCTPefXawqQbOVdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="2875812"
Received: from pavel-dev.sc.intel.com (HELO pepopov-mobl2.amr.corp.intel.com) ([10.3.206.11])
  by orviesa009.jf.intel.com with ESMTP; 20 Oct 2026 10:37:38 -0700
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
Subject: [PATCH v4 1/2] PCI/P2PDMA: Move CONFIG_X86 #ifdef out of cpu_supports_p2pdma()
Date: Tue, 20 Oct 2026 10:37:35 -0700
Message-ID: <20261020173736.81755-2-pavel.e.popov@intel.com>
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

cpu_supports_p2pdma() has an #ifdef CONFIG_X86 block inside the
function body. Put the whole function under #ifdef CONFIG_X86 instead,
with a stub returning false for !CONFIG_X86.

No functional change.

Suggested-by: Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: Pavel Popov <pavel.e.popov@intel.com>
---
 drivers/pci/p2pdma.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 9334eb314663..6b4f0843b404 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -519,18 +519,23 @@ static void seq_buf_print_bus_devfn(struct seq_buf *buf, struct pci_dev *pdev)
 	seq_buf_printf(buf, "%s;", pci_name(pdev));
 }
 
+#ifdef CONFIG_X86
 static bool cpu_supports_p2pdma(void)
 {
-#ifdef CONFIG_X86
 	struct cpuinfo_x86 *c = &cpu_data(0);
 
 	/* Any AMD CPU whose family ID is Zen or newer supports p2pdma */
 	if (c->x86_vendor == X86_VENDOR_AMD && c->x86 >= 0x17)
 		return true;
-#endif
 
 	return false;
 }
+#else /* !CONFIG_X86 */
+static bool cpu_supports_p2pdma(void)
+{
+	return false;
+}
+#endif /* CONFIG_X86 */
 
 static const struct pci_p2pdma_whitelist_entry {
 	unsigned short vendor;
-- 
2.53.0

