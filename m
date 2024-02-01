Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32A843B2A8;
	Thu,  1 Feb 2024 03:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706757598; cv=none; b=nAlIz4xhrhLFBAkq/BWJhLFzSMo5CL65uIWxbhV5HiXYwrY3kqis1zK5YJTGkLs9MGh6bbTYWYbZreVx3MDXARslkr0tKb+LIbFV5pxX2L+oZX04uNJkvNTsuGwiU/+9DiouRTF7wctsh7L/Z+zPcvxRiauoyresixmmE/Z6CKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706757598; c=relaxed/simple;
	bh=0ZTxd1BxJsW/4rbA8jFXv+6trpyo0NlYbtXO8WO78hA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qJ+lZZt7TUOicN8u6z6KKWSZDqbn7SzVH+wNJDIPFNSarS0KMB2L6/AWH/94I/IK2bgmc96cTvLZEmToRb6aCW2Mv+PiyoNkP9uo09s6EuPjrO+Pn8gCnB8k3H/ZSZSK309S+pEyZC7RLIdvLD+x5V9gG/CQkzVZ0dpPjk1x3aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8CxWOjZDbtlPVQJAA--.8075S3;
	Thu, 01 Feb 2024 11:19:53 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8DxfRPWDbtltkIrAA--.3273S6;
	Thu, 01 Feb 2024 11:19:52 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Tianrui Zhao <zhaotianrui@loongson.cn>,
	Juergen Gross <jgross@suse.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org
Subject: [PATCH v4 4/6] LoongArch: Add paravirt interface for guest kernel
Date: Thu,  1 Feb 2024 11:19:48 +0800
Message-Id: <20240201031950.3225626-5-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240201031950.3225626-1-maobibo@loongson.cn>
References: <20240201031950.3225626-1-maobibo@loongson.cn>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8DxfRPWDbtltkIrAA--.3273S6
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW3Xw1xtFyxuw4kWw48Wr15GFX_yoW7tr15pa
	4DAr4kWa1kGFn3A393KrWY9r15Jws7Cry29Fy3u34FyFsFqr1UXr4vgryqvFyDta1kJay0
	gFyrGws0ga1UAabCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUk2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv
	67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
	Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_Xr0_Ar1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE
	42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6x
	kF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU2F4iUUUUU

The patch adds paravirt interface for guest kernel, function
pv_guest_initi() firstly checks whether system runs on VM mode. If kernel
runs on VM mode, it will call function kvm_para_available() to detect
whether current VMM is KVM hypervisor. And the paravirt function can work
only if current VMM is KVM hypervisor, since there is only KVM hypervisor
supported on LoongArch now.

This patch only adds paravirt interface for guest kernel, however there
is not effective pv functions added here.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 arch/loongarch/Kconfig                        |  9 ++++
 arch/loongarch/include/asm/kvm_para.h         |  7 ++++
 arch/loongarch/include/asm/paravirt.h         | 27 ++++++++++++
 .../include/asm/paravirt_api_clock.h          |  1 +
 arch/loongarch/kernel/Makefile                |  1 +
 arch/loongarch/kernel/paravirt.c              | 41 +++++++++++++++++++
 arch/loongarch/kernel/setup.c                 |  2 +
 7 files changed, 88 insertions(+)
 create mode 100644 arch/loongarch/include/asm/paravirt.h
 create mode 100644 arch/loongarch/include/asm/paravirt_api_clock.h
 create mode 100644 arch/loongarch/kernel/paravirt.c

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index 10959e6c3583..817a56dff80f 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -585,6 +585,15 @@ config CPU_HAS_PREFETCH
 	bool
 	default y
 
+config PARAVIRT
+	bool "Enable paravirtualization code"
+	depends on AS_HAS_LVZ_EXTENSION
+	help
+          This changes the kernel so it can modify itself when it is run
+	  under a hypervisor, potentially improving performance significantly
+	  over full virtualization.  However, when run without a hypervisor
+	  the kernel is theoretically slower and slightly larger.
+
 config ARCH_SUPPORTS_KEXEC
 	def_bool y
 
diff --git a/arch/loongarch/include/asm/kvm_para.h b/arch/loongarch/include/asm/kvm_para.h
index 9425d3b7e486..41200e922a82 100644
--- a/arch/loongarch/include/asm/kvm_para.h
+++ b/arch/loongarch/include/asm/kvm_para.h
@@ -2,6 +2,13 @@
 #ifndef _ASM_LOONGARCH_KVM_PARA_H
 #define _ASM_LOONGARCH_KVM_PARA_H
 
+/*
+ * Hypcall code field
+ */
+#define HYPERVISOR_KVM			1
+#define HYPERVISOR_VENDOR_SHIFT		8
+#define HYPERCALL_CODE(vendor, code)	((vendor << HYPERVISOR_VENDOR_SHIFT) + code)
+
 /*
  * LoongArch hypcall return code
  */
diff --git a/arch/loongarch/include/asm/paravirt.h b/arch/loongarch/include/asm/paravirt.h
new file mode 100644
index 000000000000..b64813592ba0
--- /dev/null
+++ b/arch/loongarch/include/asm/paravirt.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_LOONGARCH_PARAVIRT_H
+#define _ASM_LOONGARCH_PARAVIRT_H
+
+#ifdef CONFIG_PARAVIRT
+#include <linux/static_call_types.h>
+struct static_key;
+extern struct static_key paravirt_steal_enabled;
+extern struct static_key paravirt_steal_rq_enabled;
+
+u64 dummy_steal_clock(int cpu);
+DECLARE_STATIC_CALL(pv_steal_clock, dummy_steal_clock);
+
+static inline u64 paravirt_steal_clock(int cpu)
+{
+	return static_call(pv_steal_clock)(cpu);
+}
+
+int pv_guest_init(void);
+#else
+static inline int pv_guest_init(void)
+{
+	return 0;
+}
+
+#endif // CONFIG_PARAVIRT
+#endif
diff --git a/arch/loongarch/include/asm/paravirt_api_clock.h b/arch/loongarch/include/asm/paravirt_api_clock.h
new file mode 100644
index 000000000000..65ac7cee0dad
--- /dev/null
+++ b/arch/loongarch/include/asm/paravirt_api_clock.h
@@ -0,0 +1 @@
+#include <asm/paravirt.h>
diff --git a/arch/loongarch/kernel/Makefile b/arch/loongarch/kernel/Makefile
index 3c808c680370..662e6e9de12d 100644
--- a/arch/loongarch/kernel/Makefile
+++ b/arch/loongarch/kernel/Makefile
@@ -48,6 +48,7 @@ obj-$(CONFIG_MODULES)		+= module.o module-sections.o
 obj-$(CONFIG_STACKTRACE)	+= stacktrace.o
 
 obj-$(CONFIG_PROC_FS)		+= proc.o
+obj-$(CONFIG_PARAVIRT)		+= paravirt.o
 
 obj-$(CONFIG_SMP)		+= smp.o
 
diff --git a/arch/loongarch/kernel/paravirt.c b/arch/loongarch/kernel/paravirt.c
new file mode 100644
index 000000000000..21d01d05791a
--- /dev/null
+++ b/arch/loongarch/kernel/paravirt.c
@@ -0,0 +1,41 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/export.h>
+#include <linux/types.h>
+#include <linux/jump_label.h>
+#include <linux/kvm_para.h>
+#include <asm/paravirt.h>
+#include <linux/static_call.h>
+
+struct static_key paravirt_steal_enabled;
+struct static_key paravirt_steal_rq_enabled;
+
+static u64 native_steal_clock(int cpu)
+{
+	return 0;
+}
+
+DEFINE_STATIC_CALL(pv_steal_clock, native_steal_clock);
+
+static bool kvm_para_available(void)
+{
+	static int hypervisor_type;
+	int config;
+
+	if (!hypervisor_type) {
+		config = read_cpucfg(CPUCFG_KVM_SIG);
+		if (!memcmp(&config, KVM_SIGNATURE, 4))
+			hypervisor_type = HYPERVISOR_KVM;
+	}
+
+	return hypervisor_type == HYPERVISOR_KVM;
+}
+
+int __init pv_guest_init(void)
+{
+	if (!cpu_has_hypervisor)
+		return 0;
+	if (!kvm_para_available())
+		return 0;
+
+	return 1;
+}
diff --git a/arch/loongarch/kernel/setup.c b/arch/loongarch/kernel/setup.c
index edf2bba80130..de5c36dccc49 100644
--- a/arch/loongarch/kernel/setup.c
+++ b/arch/loongarch/kernel/setup.c
@@ -43,6 +43,7 @@
 #include <asm/efi.h>
 #include <asm/loongson.h>
 #include <asm/numa.h>
+#include <asm/paravirt.h>
 #include <asm/pgalloc.h>
 #include <asm/sections.h>
 #include <asm/setup.h>
@@ -367,6 +368,7 @@ void __init platform_init(void)
 	pr_info("The BIOS Version: %s\n", b_info.bios_version);
 
 	efi_runtime_init();
+	pv_guest_init();
 }
 
 static void __init check_kernel_sections_mem(void)
-- 
2.39.3

