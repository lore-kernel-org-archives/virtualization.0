Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26924145B28
	for <virtualization@lists.linux.dev>; Thu, 16 May 2024 13:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715864642; cv=none; b=owdafXZfWYlBgG0HxLPkehrqhgDHzzJaQiQ0GS+ehjPJS67FEOlZtiA6yz1AfHL4FXSAhts//bs36+AlQ3tZy0NlWNgbUluad9YKZDEj1Tv/zWlMbnyHDisbxwuilRMLXDvfojtKOuhNzHfzO9fsFbWt3YCSk4WM6Q82HOIGK9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715864642; c=relaxed/simple;
	bh=WGVi5aGdGAHMERiHO+uuNhv6KeyDPpakxxwg5naMK3I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CIN9lB/O80keIhX6t0NHlw2fTu2ESy28MD/14qpy74Ysvj2YlApS6c22t25MK3XChalF5aEdV+SbjQp5dCK4uSAQgclaCGTnv9wFoTT4u5h2gQGfzrq8+Rqy1I0tyAPsD9A/zNwWvNkT5R9ACL0F2hRFv589wGx7dfVcF0nvJVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OD0cqvwS; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OD0cqvwS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715864640; x=1747400640;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WGVi5aGdGAHMERiHO+uuNhv6KeyDPpakxxwg5naMK3I=;
  b=OD0cqvwSmd3nqExP0glxOBjDO+drwZknMFM6r1+1ZvBxdM2CcJF4fnum
   rDkq2fpv4yYGB9qvMVJ8CWck7O+az43dtPamLrBvViT7zKSzsIgrwOc5z
   kRSRm+ctmr0v22AK/22foK/nu9V+Q6GYd/8+u/LkjkzT/SKxlxlWMNpKA
   DHTpGR5ySF06Ctns50mA1TJq5rdNYPNkB0lEe0Y8tT/KfeemGAs+VF4uV
   NjV47TcnTN0FTjo6W2PJN0+EiAPaZaWsTIGw8YZPB2eC7i1/7/1mHuMsg
   CcfruLXrFnH/x6kS7PetcrnWMPdtY7XVXZaLWMSULYT/VVeKp9aEH8N+7
   Q==;
X-CSE-ConnectionGUID: 7E47N0WDT+aVuBpzrRjokw==
X-CSE-MsgGUID: WwHdp7QJSl6HeVIZlZSQRA==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="22551060"
X-IronPort-AV: E=Sophos;i="6.08,164,1712646000"; 
   d="scan'208";a="22551060"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2024 06:03:59 -0700
X-CSE-ConnectionGUID: /cXk0nLgSPuffZMaA2Cp5w==
X-CSE-MsgGUID: VZU03uQxQqOyCS3ANyZY9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,164,1712646000"; 
   d="scan'208";a="31523926"
Received: from unknown (HELO chenyu-dev.sh.intel.com) ([10.239.62.107])
  by fmviesa010.fm.intel.com with ESMTP; 16 May 2024 06:03:53 -0700
From: Chen Yu <yu.c.chen@intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>
Cc: Juergen Gross <jgross@suse.com>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.amakhalov@broadcom.com>,
	Arnd Bergmann <arnd@arndb.de>,
	"H. Peter Anvin" <hpa@zytor.com>,
	x86@kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Chen Yu <yu.c.chen@intel.com>,
	Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Prem Nath Dey <prem.nath.dey@intel.com>,
	Xiaoping Zhou <xiaoping.zhou@intel.com>
Subject: [PATCH] x86/paravirt: Disable virt spinlock when CONFIG_PARAVIRT_SPINLOCKS disabled
Date: Thu, 16 May 2024 21:02:44 +0800
Message-Id: <20240516130244.893573-1-yu.c.chen@intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Performance drop is reported when running encode/decode workload and
BenchSEE cache sub-workload.
Bisect points to commit ce0a1b608bfc ("x86/paravirt: Silence unused
native_pv_lock_init() function warning"). When CONFIG_PARAVIRT_SPINLOCKS
is disabled the virt_spin_lock_key is set to true on bare-metal.
The qspinlock degenerates to test-and-set spinlock, which decrease the
performance on bare-metal.

Fix this by disabling virt_spin_lock_key if CONFIG_PARAVIRT_SPINLOCKS
is not set, or it is on bare-metal.

Fixes: ce0a1b608bfc ("x86/paravirt: Silence unused native_pv_lock_init() function warning")
Suggested-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Reported-by: Prem Nath Dey <prem.nath.dey@intel.com>
Reported-by: Xiaoping Zhou <xiaoping.zhou@intel.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 arch/x86/kernel/paravirt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index 5358d43886ad..ee51c0949ed8 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -55,7 +55,7 @@ DEFINE_STATIC_KEY_TRUE(virt_spin_lock_key);
 
 void __init native_pv_lock_init(void)
 {
-	if (IS_ENABLED(CONFIG_PARAVIRT_SPINLOCKS) &&
+	if (!IS_ENABLED(CONFIG_PARAVIRT_SPINLOCKS) ||
 	    !boot_cpu_has(X86_FEATURE_HYPERVISOR))
 		static_branch_disable(&virt_spin_lock_key);
 }
-- 
2.25.1

