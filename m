Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com [209.85.216.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D89284B2F
	for <virtualization@lists.linux.dev>; Sat,  7 Mar 2026 01:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772845615; cv=none; b=UpwJFpUASVP8WPu+nNevmg3WLGdxfVPpRPFrhnyd+2EVEKZmR1F0oWyHSgM/qVzUrVLhi42MMj2qW9DOwSgUwfY8V/V0nE1KFOvI0LXHeB2jWckRkFVq3/yphqbXzGvzcW52vTX8TsmiVDjeGaITwi6cxZ5BTU9QVfy9oJUz+KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772845615; c=relaxed/simple;
	bh=rYYGRODllNK9eX0TUjsapgqgpHgysFWK4Kr8HBelE/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j/n0/JBo7xHcqkCSRGXgy28V8LLCXVwRR+Fi2VwSG/4U8PRTv3Cx+sS3FgYrw9sgHMCl/oXML4a3kCWesooiOR/5qpfBq/rhqAwXS0UxoT8aU/yCyjZEe3SLrfr1yJl5aE72W7rn3XHTPygw/VbPWQ8Xg2O0KBBblpALaxSzXMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=U70aoUCF; arc=none smtp.client-ip=209.85.216.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="U70aoUCF"
Received: by mail-pj1-f97.google.com with SMTP id 98e67ed59e1d1-3599126be32so3600309a91.1
        for <virtualization@lists.linux.dev>; Fri, 06 Mar 2026 17:06:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772845613; x=1773450413;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LVGUdA4dy5MsWjDIDv+6CpBj4bGfDTWltsIW6DUSLms=;
        b=rjD+jJmuGXX/RVcCGh4rYouqad2Xs118+opsJpiMNWAA0CYNcBsPTft0Vis2JlYFOv
         GlLZWQCIhAOkeqBwvkCqQp62cMChPIaqajvRfY3rh4OknSeOONPGgmpksyX9u10H3hGa
         0n0stbKsIJfmJ360n3MRyJUcXoO76JraM5d+N+Vn2KqkV1Hkr46qkIz6RzkYDlQTFkWd
         x7FnVQbupmWU5l7f4GJtdRvJVtz7DqgikMGdAoHVa+qpCTVBGiRmRtMx5EiP6fdotwAF
         1mrbh870BfVwZDGdZtv/4yMc4sXqJb3wrHhRPDgq+mD1GLIlBvPyZ0Q1f+dm0V6Qw5wF
         aCNg==
X-Forwarded-Encrypted: i=1; AJvYcCUauCbidmk1oZtQpVIKiJRVw9wRMH0XLGZ5ko0WxZehWqLQC7x14SjgxdjR+UDlbi1encCt2I1wGeO998HTeg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxZ7tvQptwKQTauXJvCL0oi6tZzlowD7xiLF8d0S9/79/XklgiP
	pv4Zi8Xg0zAb+pBfCOjyKGw2MgVdFzhcqMpYeUhnIm4uuedVRBwWj6/a8cl64TVxtWU64hHewof
	eRXScF5rh6wXZyqHZUlvq5isFx+vAP6KCH+OECBq7+qQN333+Fq+3HmM0jB9FN/smEi5pDrhQbh
	pkkhaZAlhft7BbEkKBRZxTESNsQSiYo8PbAUvC5q0dRFB9mPc86dpwxLrmBA+LxzbmRxSFRI3ac
	Rv0K816tGXszmhkL0OSBa4Yew==
X-Gm-Gg: ATEYQzwKV0bqeJw8VYKsnbqXnWAfF55p5UsMy/ygWG+U35QtQY9Z/1TAXH50isyH7Lg
	GZfrCb66J2ZfYEAO3yg6pzjoG+fc/FAObJ5MyEJVrex5ISkcJHryUdpy81txHM2UxBvCzIzx7HW
	mjckOSIG7vZ6TeE0Nv8+MccuwReKVBvtpUbzxsMSQMPfHzUJGJcca0A4jilR7/qnuqh/9w8W+Gn
	Z+Qut2bkvonlSCn3jZZa79leBY84PQYddAx9wc7jUZkYqgkCiFDVhNOIPbsbTqo+alYTxmgiL7i
	o5He2fkeb72SLcO6zaQmSiSMFuVpae8aCub1p4SiKp9s4df4G31udNxnd08ff5XGjXH3P0bZQN3
	aK2ukPaVniYW/2GoZ8sdtjbaTJrKzt62IzCbuq7zoxXkPHMIM9qPUkz+oRj0dp4OFhLZHYV1k6A
	0Chqh3KNiKpe3Xi7+ak5+rsFKnb9ntpie12rGKWar6FeU0rNENgVC5LqoRJuUEMGQ=
X-Received: by 2002:a17:90b:1d43:b0:359:1130:1047 with SMTP id 98e67ed59e1d1-359be344adfmr3476725a91.17.1772845613476;
        Fri, 06 Mar 2026 17:06:53 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-102.dlp.protect.broadcom.com. [144.49.247.102])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-359c013aec0sm360065a91.6.2026.03.06.17.06.53
        for <virtualization@lists.linux.dev>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Mar 2026 17:06:53 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-2be47f2899aso14482289eec.0
        for <virtualization@lists.linux.dev>; Fri, 06 Mar 2026 17:06:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1772845612; x=1773450412; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LVGUdA4dy5MsWjDIDv+6CpBj4bGfDTWltsIW6DUSLms=;
        b=U70aoUCFANEO1BvC7dQeOx5UCz+6UTbc42LIhLJb3P3FZBN3OHXBrAwLKrhIgke3LR
         51eJXfESMhisM98oxmKFhpIHnhpwCp+q38T5xVE2F9yHkZ2s3sRAju1d7fkRZmX8/hLE
         jR47udxSXaG6wSowzqJj1mDX+DjUXTn733cAA=
X-Forwarded-Encrypted: i=1; AJvYcCWct2NnmOHIj3xhF9iTrA8Pt1wr/uqo4IJ5M48CCfhwQRc/V45ziE2UFZa90UrVo4Bwo6W4ileXX279Joa1LQ==@lists.linux.dev
X-Received: by 2002:a05:7300:cd8a:b0:2be:142f:d499 with SMTP id 5a478bee46e88-2be4dfc61b1mr1673507eec.16.1772845611526;
        Fri, 06 Mar 2026 17:06:51 -0800 (PST)
X-Received: by 2002:a05:7300:cd8a:b0:2be:142f:d499 with SMTP id 5a478bee46e88-2be4dfc61b1mr1673488eec.16.1772845610837;
        Fri, 06 Mar 2026 17:06:50 -0800 (PST)
Received: from amakhalov-build-vm.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be4f80cc1dsm2237336eec.3.2026.03.06.17.06.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 17:06:50 -0800 (PST)
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
Subject: [PATCH 4/4] x86/vmware: Support steal time clock for encrypted guests
Date: Sat,  7 Mar 2026 00:42:38 +0000
Message-ID: <20260307004238.1181299-5-alexey.makhalov@broadcom.com>
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

Shared memory containing steal time counter should be set to
decrypted when guest memory is encrypted.

Co-developed-by: Bo Gan <bo.gan@broadcom.com>
Signed-off-by: Bo Gan <bo.gan@broadcom.com>
Signed-off-by: Alexey Makhalov <alexey.makhalov@broadcom.com>
---
 arch/x86/kernel/cpu/vmware.c | 41 ++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
index 8997295a5a5c..e33400d4f2c1 100644
--- a/arch/x86/kernel/cpu/vmware.c
+++ b/arch/x86/kernel/cpu/vmware.c
@@ -32,6 +32,7 @@
 #include <linux/sched/cputime.h>
 #include <linux/kmsg_dump.h>
 #include <linux/panic_notifier.h>
+#include <linux/set_memory.h>
 #include <asm/div64.h>
 #include <asm/x86_init.h>
 #include <asm/hypervisor.h>
@@ -39,6 +40,7 @@
 #include <asm/apic.h>
 #include <asm/vmware.h>
 #include <asm/svm.h>
+#include <asm/coco.h>
 
 #undef pr_fmt
 #define pr_fmt(fmt)	"vmware: " fmt
@@ -379,9 +381,47 @@ static struct notifier_block vmware_pv_reboot_nb = {
 	.notifier_call = vmware_pv_reboot_notify,
 };
 
+/*
+ * Map per-CPU variables for all possible CPUs as decrypted.
+ * Do this early in boot, before sharing the corresponding
+ * guest physical addresses with the hypervisor.
+ */
+static void __init set_shared_memory_decrypted(void)
+{
+	int cpu;
+
+	if (!cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
+		return;
+
+	for_each_possible_cpu(cpu) {
+		unsigned long size = sizeof(vmw_steal_time);
+		unsigned long addr = (unsigned long)&per_cpu(vmw_steal_time,
+							cpu);
+
+		/*
+		 * There is no generic high-level API to mark memory as
+		 * decrypted. Intel's set_memory_decrypted() depends on the
+		 * buddy allocator and can fail early in boot if a page split
+		 * is required and allocation is not possible. Use AMD's
+		 * early_set_memory_decrypted() instead, which can perform
+		 * the split during early boot.
+		 */
+		early_set_memory_decrypted(addr, size);
+
+		/* That's it for AMD */
+		if (cc_vendor == CC_VENDOR_AMD)
+			continue;
+
+		set_memory_decrypted(addr & PAGE_MASK, 1UL <<
+				     get_order((addr & ~PAGE_MASK) + size));
+
+	}
+}
+
 #ifdef CONFIG_SMP
 static void __init vmware_smp_prepare_boot_cpu(void)
 {
+	set_shared_memory_decrypted();
 	vmware_guest_cpu_init();
 	native_smp_prepare_boot_cpu();
 }
@@ -444,6 +484,7 @@ static void __init vmware_paravirt_ops_setup(void)
 					      vmware_cpu_down_prepare) < 0)
 			pr_err("vmware_guest: Failed to install cpu hotplug callbacks\n");
 #else
+		set_shared_memory_decrypted();
 		vmware_guest_cpu_init();
 #endif
 	}
-- 
2.43.7

