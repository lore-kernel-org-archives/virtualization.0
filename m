Received: from mail-ua1-f98.google.com (mail-ua1-f98.google.com [209.85.222.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74FFA1C84A6
	for <virtualization@lists.linux.dev>; Tue, 10 Mar 2026 00:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773101835; cv=none; b=PsMiavwcV1DnAjc8YCRCnFb9xnbR4srQHMcRrDg5MYSfXA90a8IzrSAPcU/WpqHweEmXzxqJY+nchWnQ/IUJVMjoDxycsBwC9pL2RPY3IFPxM7XStX45+eHcC2YLG7nQyScotyg3UXYozLG3tOq2SqYe/niPzva5OhiOpmgMGQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773101835; c=relaxed/simple;
	bh=Zj2gWskcTdeCbRgEtbKYU2726zg6QEH0voYcKcQfhMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yr0ZTzwf6uVZg0g0MYkPaANJt3pmTBpw+G490bMPmkf+LG0JeOZXSla2sAXjTV47hbwcPFvPjOXUtPtu5KbURd7S8cPigX1KXepjcyUtYUKhPgkgWG6ewF9r0QVIpSFgzF54WzT5Jk0QIOdvanG9VeLhcRjii1MbNThbKZ2rvY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=X0lT1JDr; arc=none smtp.client-ip=209.85.222.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="X0lT1JDr"
Received: by mail-ua1-f98.google.com with SMTP id a1e0cc1a2514c-94de664b541so3420848241.1
        for <virtualization@lists.linux.dev>; Mon, 09 Mar 2026 17:17:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773101833; x=1773706633;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OiGZAwROU5TJxpiCLUT0uYKKo5HkD6AnGMRObmR/GVo=;
        b=CjZm4u1vgbGX/hx0BrdUVkvlVYbA3kNQ/cciQ9YgsJiNt3GHVgSL12iBc8x5LYIOay
         HtgpVR9IPxLDPfIqR8IecSDf5X7eV7a6ljG3AeBvF1g/gCxw6Xn2dvizynl8Qfwu1yDY
         Yu87LwJgxvDfuQsOlyeVMFYVdHf4xKb06nYzDo+y0DIshx8iN6msF1+HP6R1Tb/rwzUq
         PiHnF7n62483rw553sOkt0Ynw39dUY9TBA+PbB8qfdtPB4cpQtFhsb45MUX+Ct8sEPfZ
         VWi66VVRbj8l/K08jLvb365aRBV2sJ56KGtP6kmfQS7YPf8YmsMwwDyW6UDoJZMfQqE5
         bpyA==
X-Forwarded-Encrypted: i=1; AJvYcCUgwiPKvdIZr6NcasPP/87ga8FZ07dPXv11gFeFDirFiQ91Ev+f2Z23hLZioJLkjBUk2g7mL+9jwUxQYudQug==@lists.linux.dev
X-Gm-Message-State: AOJu0YwKRXJJqpRSjpdPxl5xNy73DOR0g1OUBz/MLCw+vWaBXgO2tBNI
	t12XQNSlEDiLFzOGEMmBCRZbgAaOSc5FiDjSwF71Iv7Sma8q7MMSoXoJxv3ngu1Bcp7X8FzK+XU
	Tie78tap8esftlh1+WTDrv3zUkZcCEEFVxBtRnBkOFu6/pUlW9yAvI5zjPYaEJG7smx+B0hPF6O
	gXc6Lzw3f2peD3XSs2L2/MRMCUFjjubVvVYfzlSMFVQ+BrI6SIMJc9nfgShbZagV3T6qTaIC9R7
	sKiH5etY3E0r1CU2JZbkkLTAw==
X-Gm-Gg: ATEYQzyFNo9A+09kP7NF6djSmS2ndayC3TK30SFhLhjSIdMKmZtexpR3K8oyIBmohBl
	IBlwSI2DoPK3ivSDRJtNpNuMLDWYX7vlsCZQBiehcl1jlCOVmhgQl//obcciwPRx1pTNEMBI6Qs
	YysFo56scbRatWpve75fB2oUugNMuuhOkclwGVqxSuwEClPyWkrxYNXSjYZqHL3ZfHgj+uEKv+J
	2RP9IoJ1OVn9MjQA8fvDBBssgukCdhuK6HkeeNh12jVhPKcFOO/JL0iR7EHjhy0d6jwBtu+HE7r
	coPcscvA6X6NxplJQBb8lYsCxnVOIb+CiAfnswIg/Y8nOTkM43NqF+5K05/41GrIT1DeEkpzLtR
	uTZpOuwsPZfR2DM1FUAzux+vlaZKmAQSRSIwlIsoG6zCQTPeJJumvHDo/XCN8u2t4bm5ur++lCP
	89o3OpAQhYdIj6nqZje/5hv94s+i9CoErdoOG7XAErly0iN9t0yVTBznNRutxal7I=
X-Received: by 2002:a05:6102:d8c:b0:5f5:3a9a:7db0 with SMTP id ada2fe7eead31-5ffe639191emr3916978137.41.1773101833280;
        Mon, 09 Mar 2026 17:17:13 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id ada2fe7eead31-5ffe8cded7bsm1019595137.5.2026.03.09.17.17.13
        for <virtualization@lists.linux.dev>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Mar 2026 17:17:13 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-2bdff07d8f4so13758320eec.1
        for <virtualization@lists.linux.dev>; Mon, 09 Mar 2026 17:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1773101832; x=1773706632; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OiGZAwROU5TJxpiCLUT0uYKKo5HkD6AnGMRObmR/GVo=;
        b=X0lT1JDrUM8m+eCmSBk0rWHILHkOPY4wDumC78mfI15EDYlH08wG9iwhSuNEyEkX64
         qhzqEizShTH1kG3r+MAJ884e0Q94X3r4+y7Zn+2JDyXH4yINx+/gEXwpq42XOySTKhT1
         xqAJZ9cnkbkJdsNXbOUZ4CmuG4CYz7XAhgAvw=
X-Forwarded-Encrypted: i=1; AJvYcCUdJfpZopoTOH5c83UKLmEn1VbyLwO+VudSYWlhzOZ1AlS+wW5xcgApi64FiSfThj9M/A6Fq51KzRDWjm2Ong==@lists.linux.dev
X-Received: by 2002:a05:7300:b90b:b0:2ba:9115:2fab with SMTP id 5a478bee46e88-2be4dfef8fdmr4822983eec.12.1773101832218;
        Mon, 09 Mar 2026 17:17:12 -0700 (PDT)
X-Received: by 2002:a05:7300:b90b:b0:2ba:9115:2fab with SMTP id 5a478bee46e88-2be4dfef8fdmr4822962eec.12.1773101831621;
        Mon, 09 Mar 2026 17:17:11 -0700 (PDT)
Received: from amakhalov-build-vm.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be4f948324sm12678991eec.17.2026.03.09.17.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 17:17:11 -0700 (PDT)
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
Subject: [PATCH v2 3/4] x86/vmware: Report guest crash to the hypervisor
Date: Mon,  9 Mar 2026 23:52:49 +0000
Message-ID: <20260309235250.2611115-4-alexey.makhalov@broadcom.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260309235250.2611115-1-alexey.makhalov@broadcom.com>
References: <20260307004238.1181299-1-alexey.makhalov@broadcom.com>
 <20260309235250.2611115-1-alexey.makhalov@broadcom.com>
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
index 9955f2ea0c84..c631e577348a 100644
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

