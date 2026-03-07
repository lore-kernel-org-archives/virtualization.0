Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96522286D53
	for <virtualization@lists.linux.dev>; Sat,  7 Mar 2026 01:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772845614; cv=none; b=GyNaw6QggpcNFevA3V6kUOV5mH+n+T6uHl+bl/+o/SWD1BFjzaDjk4Tg+jTUUn8WGXmAX1woBkOlN5fB9JN1my9OYS+1hiAxi3snLf7SELR/5/cSMHIBDOXYOnVJF/6BMUTFuqeq1zk73XA7OW5ed+xdkYfDuH6p1bjerp/Og44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772845614; c=relaxed/simple;
	bh=ksnYJ5X86WbgcBRlSUFMRlXPK4HJhXyOZMPOHMjp2H0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cs5MHVfQir7zf+UuaXYEef52pv5pA64dtBIm3L2IXfGVvPZBGpW9AFn0J8CZWWx+XDzgzpkI+foACacXMGn9dMh9eP1UYYD/McwB/T1Nlm7EIpG7BRm36iT0TFb0PBLRkudhIOaE+lntTRDh2n637uuJ7kFfqN09nb4SlLei9Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=DCTOH42W; arc=none smtp.client-ip=209.85.214.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="DCTOH42W"
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-2a9296b3926so73754115ad.1
        for <virtualization@lists.linux.dev>; Fri, 06 Mar 2026 17:06:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772845612; x=1773450412;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cUw9NhYmIBNJuB5E0xXDdMiSKNxtEhWoJKcE3kIR6ic=;
        b=m8zfzLwiY/7hLp9hCrngxsW6hIZzLB7Un3kMSqGpDwfcDpXdrj6of3BjR66VvB+QmK
         Aa0Zu1D+TzhK9TbSdMnlCeROcGUZ4108kvAEz5Bjz94nc5WWHo3wpDQ7h2JtJLIssxgh
         jynxTE2RMXXt5JUjbAKjnX/YZjtNw1JEI1FwQ7mTJkxGpOZAA+XDkFXw8h1z/TP7cR7J
         VArtPo04KTrRIJ+zN6hp35YGbSmYmGnGw376VQQKkPGo3m7pmjfo4PgtceVQH4fbF7fc
         NvFmmqCHhCBW81JNaRNPrgEVHnKoun79T6JCr9QMPqfXkV2tCRQWO+krKJY7ZgWlIpX3
         Ku+A==
X-Forwarded-Encrypted: i=1; AJvYcCUEXkQ1Rh9WbyGz25zhIQZCze/4xOI1sEgiKHySJB03xYtC66waDQm095Gk329soUmo8G15fBJbK9ADr/fJSQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzYlypyf0Jvv32cbN+MXgNTXDGe5i8ExOTf+v34tlLhvQcBIlyO
	RTC9YYVnH1DRZC6Qjho9fImQ4F7mCPmxeeJZc0PddLSlESbPaiK+ex+YUHq5HzJfPUNIjQdWr91
	sy18SP6WUz/J1VeEWIm7nywxMzo5VRO/TrhYU8izB1TLm7MXqztnutq3ogx+Q21Zw04RVDfnyEW
	yyC/GSCZKUemBVbPB8pYPXUltuhc8msU5rWgu0rWoW5kc0pouJfjkekyuK1E9Twlr9APax9A5AI
	NIzs6ugl7IlDPnzRYXMTkM2lw==
X-Gm-Gg: ATEYQzyQq5hvi6alAwx7HsxEoVRVjcQ9E0scbgErrI9Kpt59dpfZ+0zN1p8xgZu6AKd
	dnYQw+yUc2uCHt9P0/JrhYBvOPILuYI4IgVdtd+nWtaq+Yz+mnFqyxE0sIa6DaIkoFDG2zPD0DB
	In/II26kXEDtkcUnUwTnZxW83pjJcgqgv4AVHzWXVx02L5UvHbE0PuU4Ssj3kQVv3rY2U5v8Z/Q
	lkqXhLhT3rweKjk0km8D6TPKQM+RN61Z5221kXBLo8sow3grXFgKjfyQzv6CYHLlA+6+cuNtpnM
	lqmSAmxKBjwIjKaaqMZziZ07S+8OnQf7sP3GzoT/wQ9EtQ+T7W0PXSvh/ksTqjpgRHRb1nouJbd
	2yP7BjScMF1oG5+JR5FZJVZWRlK+UgFNPm24vLVFpx5Ytp/6xlpJzsqy47TGVpmqCY8A5hh4xF3
	Mro266oxdEOHqn1o3F0cidmzs+VFMxe2E4M8oZjgwRfsh2uko9sYwnNp6EGDmp7a4=
X-Received: by 2002:a17:903:120f:b0:2ae:5763:99cd with SMTP id d9443c01a7336-2ae82530359mr38809475ad.49.1772845611892;
        Fri, 06 Mar 2026 17:06:51 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-102.dlp.protect.broadcom.com. [144.49.247.102])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2ae83e57adcsm4145625ad.7.2026.03.06.17.06.51
        for <virtualization@lists.linux.dev>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Mar 2026 17:06:51 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-2be1bc0905bso4684905eec.1
        for <virtualization@lists.linux.dev>; Fri, 06 Mar 2026 17:06:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1772845610; x=1773450410; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cUw9NhYmIBNJuB5E0xXDdMiSKNxtEhWoJKcE3kIR6ic=;
        b=DCTOH42WtuejQq9ECBAeVDEjT5ybJwSdHE3wXghLvuIuRHOggfP6d9L7igzRMyiPjw
         FF9oAFwNCQjTFdRw5s5TCY0wo3vBkZvA/Hjmc/ENHw1NjjGGvmY24uZnUc+kpnJtldHw
         Sikdm9IOAlI9/tFePzqG4VarlD48MXTt6nCtw=
X-Forwarded-Encrypted: i=1; AJvYcCUT6mMFYDP62SB9qAiUpAA7JQ5Dd6wcgHSJgrdMzCff6DoYZjZON0ZXExsNLcoWyc0fQV5Hkj+vMIWdBC8HNw==@lists.linux.dev
X-Received: by 2002:a05:7301:fa0f:b0:2bd:e892:b075 with SMTP id 5a478bee46e88-2be4dea8cfamr1393887eec.9.1772845610200;
        Fri, 06 Mar 2026 17:06:50 -0800 (PST)
X-Received: by 2002:a05:7301:fa0f:b0:2bd:e892:b075 with SMTP id 5a478bee46e88-2be4dea8cfamr1393873eec.9.1772845609534;
        Fri, 06 Mar 2026 17:06:49 -0800 (PST)
Received: from amakhalov-build-vm.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be4f80cc1dsm2237336eec.3.2026.03.06.17.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 17:06:49 -0800 (PST)
From: Alexey Makhalov <alexey.makhalov@broadcom.com>
To: x86@kernel.org,
	virtualization@lists.linux.dev,
	bp@alien8.de,
	hpa@zytor.com,
	dave.hansen@linux.intel.com,
	mingo@redhat.com,
	tglx@linutronix.de
Cc: ajay.kaher@broadcom.com,
	brennan.lamoreaux@broadcom.com,
	bo.gan@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	linux-kernel@vger.kernel.org,
	kas@kernel.org,
	rick.p.edgecombe@intel.com,
	linux-coco@lists.linux.dev,
	Alexey Makhalov <alexey.makhalov@broadcom.com>
Subject: [PATCH 3/4] x86/vmware: Report guest crash to the hypervisor
Date: Sat,  7 Mar 2026 00:42:37 +0000
Message-ID: <20260307004238.1181299-4-alexey.makhalov@broadcom.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260307004238.1181299-1-alexey.makhalov@broadcom.com>
References: <20260307004238.1181299-1-alexey.makhalov@broadcom.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Register the guest crash reporter to panic_notifier_list,
which will be called at panic time. Guest crash reporter
will report the crash to the hypervisor through
a hypercall.

Co-developed-by: Brennan Lamoreaux <brennan.lamoreaux@broadcom.com>
Signed-off-by: Brennan Lamoreaux <brennan.lamoreaux@broadcom.com>
Signed-off-by: Alexey Makhalov <alexey.makhalov@broadcom.com>
---
 arch/x86/include/asm/vmware.h |  1 +
 arch/x86/kernel/cpu/vmware.c  | 21 +++++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/arch/x86/include/asm/vmware.h b/arch/x86/include/asm/vmware.h
index c23164503e54..bf6141353774 100644
--- a/arch/x86/include/asm/vmware.h
+++ b/arch/x86/include/asm/vmware.h
@@ -97,6 +97,7 @@
 #define VMWARE_CMD_GETHZ		45
 #define VMWARE_CMD_GETVCPU_INFO		68
 #define VMWARE_CMD_STEALCLOCK		91
+#define VMWARE_CMD_REPORTGUESTCRASH	102
 /*
  * Hypercall command mask:
  *   bits [6:0] command, range [0, 127]
diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
index d9753b1aba58..8997295a5a5c 100644
--- a/arch/x86/kernel/cpu/vmware.c
+++ b/arch/x86/kernel/cpu/vmware.c
@@ -31,6 +31,7 @@
 #include <linux/static_call.h>
 #include <linux/sched/cputime.h>
 #include <linux/kmsg_dump.h>
+#include <linux/panic_notifier.h>
 #include <asm/div64.h>
 #include <asm/x86_init.h>
 #include <asm/hypervisor.h>
@@ -451,6 +452,24 @@ static void __init vmware_paravirt_ops_setup(void)
 #define vmware_paravirt_ops_setup() do {} while (0)
 #endif
 
+static int vmware_report_guest_crash(struct notifier_block *self,
+				     unsigned long action, void *data)
+{
+	vmware_hypercall1(VMWARE_CMD_REPORTGUESTCRASH, 0);
+	return 0;
+}
+
+static struct notifier_block guest_crash_reporter = {
+	.notifier_call = vmware_report_guest_crash
+};
+
+static int __init register_guest_crash_reporter(void)
+{
+	atomic_notifier_chain_register(&panic_notifier_list,
+					&guest_crash_reporter);
+
+	return 0;
+}
 /*
  * VMware hypervisor takes care of exporting a reliable TSC to the guest.
  * Still, due to timing difference when running on virtual cpus, the TSC can
@@ -545,6 +564,8 @@ static void __init vmware_platform_setup(void)
 	vmware_set_capabilities();
 
 	kmsg_dump_register(&kmsg_dumper);
+
+	register_guest_crash_reporter();
 }
 
 static u8 __init get_hypercall_mode(void)
-- 
2.43.7

