Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794440687;
	b=x0AE3u7QpMITplJ7Ji2XUMLL2ZW8NgbKkqSi7lCzR7VmrkAhm1TM4dE41hjfvcf8eNrG
	 Ew8y8U23mET3MBtqJ5xiBkunS/qhlGisplkQT1MuwbBqoUG24YUvaq/Xw292kDoQxrxTJ
	 M7TljSAuF7uNC5/eZgua3g8y5WDpqk++tZvIbwRVKBnW0ZJjV68z6w3eetTSzuxBp5JFa
	 rH8+LX+E+12e8s4UebenDTw0FZds5w+kJbxm92ZpQ0qQdM0e0s/zBOlKDmBENMNttTNA/
	 bStDG1F7WXyjYR82NOxvIjWIJdgJr4FffCafXZfh3xvjOEJ8yA3jzJ3mTzXvE/oeiNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794440687;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=sdSp4JAEBIO1pQeZZS71rX8i5HCrtwFNUZ7pCreT77A=;
	b=jltDt0fyGVwZMeNRsdZ7hXw6/ubd87v8jSq2c/ZYPsr28GBtElHzD62tbHyamYjNIXer
	 RJI4ciybP9emRmc3whZlX0VlxV71v1vOP20nxn3tcKXkLUobE2pXfj1IkAq83VtusdMgb
	 bxMUMciVuBmb+mdQDgrrhTkR37ZQelqaAmlLSPEX/3ruE0sPAYq1tsyzHkAw9utaOAUc1
	 Tz2tRgscNd3HYAq90YS6/AZsRKJwAImQnPlVR6xCa5sK4HsRM8nryMKWm/urzQbx9L9XX
	 XS+6hyRYTi1tquHdlqPz8pvYgi8GbkRPHVb2Im/UyZKODpfclY8SyagqpPLW/788dIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=JDipvfRr;
	arc=none smtp.remote-ip=192.198.163.9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB29606A32E
	for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 23:44:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6BB29606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=JDipvfRr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794440683; x=1825976683;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dj125zGEvAXWXtzneUQm2Fo30+JV1EKjt/TJ4mkqfhI=;
  b=JDipvfRrznd3eP+Io0CSfO0EU/HlYPT9Uydbber39QQ3FlJwH3YwAPaZ
   c+b1YjOq+kb+bRXeAESPBL90fEluWIwhrzD7kT9fim9tVjAxakNx5qQgn
   2nP5EWgwIAon9D6Xu1EJrAjkKWSsGenHhQLilPPYjPGz6fBzzhsvgAKTR
   ZJQ8ATsyKkD+nHWKwFMIj8yGZw8QeTUBDQAdNzY+qsRIPaabWbbQYBOt7
   H6aGdczSHVvYXLbQlVkM76pTNeqm4i+xoQMK+mprd2mc0hq1s3nv7jPhL
   UF66ATVh2p4hE4krv/Izm69FFqv3+yQgif29cGsD3UILbo99n9JGMP8V1
   Q==;
X-CSE-ConnectionGUID: 8WlRH0TeT+qAEZc/6Zx6NA==
X-CSE-MsgGUID: 8ZXW0cc3RFmXMLfxhmO+4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11963"; a="3099102"
X-IronPort-AV: E=Sophos;i="6.27,208,1787036400"; 
   d="scan'208";a="3099102"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 15:44:43 -0800
X-CSE-ConnectionGUID: kH3cqayDS3GUWnZAsbZHfA==
X-CSE-MsgGUID: h2vE+jaoRUKLZ6aRiGD2fQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,208,1787036400"; 
   d="scan'208";a="10241290"
Received: from pavel-dev.sc.intel.com (HELO pepopov-mobl2.intel.com) ([10.3.206.11])
  by fmviesa012.fm.intel.com with ESMTP; 11 Nov 2026 15:44:42 -0800
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
Subject: [PATCH v5 1/3] asm-generic: Add <asm-generic/cpu_device_id.h>
Date: Wed, 11 Nov 2026 16:44:37 -0700
Message-ID: <20261111234439.4098-2-pavel.e.popov@intel.com>
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

<asm/cpu_device_id.h> exists only on x86, so generic code that
matches on x86 CPU models has to wrap the include in #ifdef
CONFIG_X86.

Add an empty generic version, so the header can be included
unconditionally. The CPU match tables themselves still need
CONFIG_X86 for the model defines.

Suggested-by: Leon Romanovsky <leon@kernel.org>
Link: https://lore.kernel.org/r/25a0cdb4-9c4f-4531-bdf2-8d09eedd0883@app.fastmail.com
Signed-off-by: Pavel Popov <pavel.e.popov@intel.com>
---
 include/asm-generic/Kbuild          | 1 +
 include/asm-generic/cpu_device_id.h | 5 +++++
 2 files changed, 6 insertions(+)
 create mode 100644 include/asm-generic/cpu_device_id.h

diff --git a/include/asm-generic/Kbuild b/include/asm-generic/Kbuild
index b7a388bef6e..fad71809ffa 100644
--- a/include/asm-generic/Kbuild
+++ b/include/asm-generic/Kbuild
@@ -13,6 +13,7 @@ mandatory-y += cacheflush.h
 mandatory-y += cfi.h
 mandatory-y += checksum.h
 mandatory-y += compat.h
+mandatory-y += cpu_device_id.h
 mandatory-y += current.h
 mandatory-y += delay.h
 mandatory-y += device.h
diff --git a/include/asm-generic/cpu_device_id.h b/include/asm-generic/cpu_device_id.h
new file mode 100644
index 00000000000..05c38c3ca1d
--- /dev/null
+++ b/include/asm-generic/cpu_device_id.h
@@ -0,0 +1,5 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_GENERIC_CPU_DEVICE_ID_H
+#define _ASM_GENERIC_CPU_DEVICE_ID_H
+
+#endif /* _ASM_GENERIC_CPU_DEVICE_ID_H */
-- 
2.54.0

