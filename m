Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBD7814F62;
	Fri, 15 Mar 2024 08:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710490209; cv=none; b=LA+G0fYL4MG+N2GbQG1LlpDalMtc5C3VasKjta6Z4QWGS+MgJOR85xBUrmuVw4wOEUuRadRtkwqudYBqPrYnBS3mKIEKiz52xj62LNdj+8gSGZhS1t9X9GrLlRvFnhnExaP+11G4v6SyAxDFNH7ZMlGQnqRUOI7olIZEykQe+LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710490209; c=relaxed/simple;
	bh=RxTLbfwNyfhUNJ8BwmXMMXi+zOXJsGf9WJumvmzntUQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=crqewdVTPh7AKEODHAbtat/ECzKdwI2UwSXU5Y5djveEhUpXm1BE8qPC/yzg41BuNvAUu4ZEzBGgkHQMwx2f26kp59RvPW2TxNnIHJ1xt5FrylaX0hc9B5bTHrdN68wyaVsV9eUyrzt+nIU2Loare3RRIMYSaoi/DHEyYb3c/Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8DxWPBbAvRl1mUZAA--.61027S3;
	Fri, 15 Mar 2024 16:10:03 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8DxDc9aAvRlbchaAA--.42348S2;
	Fri, 15 Mar 2024 16:10:02 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Tianrui Zhao <zhaotianrui@loongson.cn>,
	WANG Xuerui <kernel@xen0n.name>,
	Juergen Gross <jgross@suse.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>
Cc: loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org
Subject: [PATCH v7 6/7] LoongArch: Add pv ipi support on guest kernel side
Date: Fri, 15 Mar 2024 16:10:02 +0800
Message-Id: <20240315081002.2813016-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240315080710.2812974-1-maobibo@loongson.cn>
References: <20240315080710.2812974-1-maobibo@loongson.cn>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8DxDc9aAvRlbchaAA--.42348S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW3Zr1UZw4kZF4fKFWUGF1Dtwc_yoWDXw1DpF
	ZrAr1kWr4rGFn7A395G395ur15J3s7Cw12q3W7AFyrAFsFqF15Xr4kKFyqqFy8ta1kGa4F
	gF95Gr4qga1UAabCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUkab4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI
	0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWrXVW3AwAv7VC2z280
	aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28Icx
	kI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2Iq
	xVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42
	IY6xIIjxv20xvE14v26F1j6w1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAI
	cVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2js
	IEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jT-e5UUUUU=

PARAVIRT option and pv ipi is added on guest kernel side, function
pv_ipi_init() is to add ipi sending and ipi receiving hooks. This function
firstly checks whether system runs on VM mode. If kernel runs on VM mode,
it will call function kvm_para_available() to detect current hypervirsor
type. Now only KVM type detection is supported, the paravirt function can
work only if current hypervisor type is KVM, since there is only KVM
supported on LoongArch now.

PV IPI uses virtual IPI sender and virtual IPI receiver function. With
virutal IPI sender, ipi message is stored in DDR memory rather than
emulated HW. IPI multicast is supported, and 128 vcpus can received IPIs
at the same time like X86 KVM method. Hypercall method is used for IPI
sending.

With virtual IPI receiver, HW SW0 is used rather than real IPI HW. Since
VCPU has separate HW SW0 like HW timer, there is no trap in IPI interrupt
acknowledge. And IPI message is stored in DDR, no trap in get IPI message.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 arch/loongarch/Kconfig                        |   9 ++
 arch/loongarch/include/asm/hardirq.h          |   1 +
 arch/loongarch/include/asm/paravirt.h         |  27 ++++
 .../include/asm/paravirt_api_clock.h          |   1 +
 arch/loongarch/kernel/Makefile                |   1 +
 arch/loongarch/kernel/irq.c                   |   2 +-
 arch/loongarch/kernel/paravirt.c              | 151 ++++++++++++++++++
 arch/loongarch/kernel/smp.c                   |   4 +-
 8 files changed, 194 insertions(+), 2 deletions(-)
 create mode 100644 arch/loongarch/include/asm/paravirt.h
 create mode 100644 arch/loongarch/include/asm/paravirt_api_clock.h
 create mode 100644 arch/loongarch/kernel/paravirt.c

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index b274784c2e26..a1fccaf117aa 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -578,6 +578,15 @@ config CPU_HAS_PREFETCH
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
 
diff --git a/arch/loongarch/include/asm/hardirq.h b/arch/loongarch/include/asm/hardirq.h
index 9f0038e19c7f..b26d596a73aa 100644
--- a/arch/loongarch/include/asm/hardirq.h
+++ b/arch/loongarch/include/asm/hardirq.h
@@ -21,6 +21,7 @@ enum ipi_msg_type {
 typedef struct {
 	unsigned int ipi_irqs[NR_IPI];
 	unsigned int __softirq_pending;
+	atomic_t message ____cacheline_aligned_in_smp;
 } ____cacheline_aligned irq_cpustat_t;
 
 DECLARE_PER_CPU_SHARED_ALIGNED(irq_cpustat_t, irq_stat);
diff --git a/arch/loongarch/include/asm/paravirt.h b/arch/loongarch/include/asm/paravirt.h
new file mode 100644
index 000000000000..58f7b7b89f2c
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
+int pv_ipi_init(void);
+#else
+static inline int pv_ipi_init(void)
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
 
diff --git a/arch/loongarch/kernel/irq.c b/arch/loongarch/kernel/irq.c
index ce36897d1e5a..4863e6c1b739 100644
--- a/arch/loongarch/kernel/irq.c
+++ b/arch/loongarch/kernel/irq.c
@@ -113,5 +113,5 @@ void __init init_IRQ(void)
 			per_cpu(irq_stack, i), per_cpu(irq_stack, i) + IRQ_STACK_SIZE);
 	}
 
-	set_csr_ecfg(ECFGF_IP0 | ECFGF_IP1 | ECFGF_IP2 | ECFGF_IPI | ECFGF_PMC);
+	set_csr_ecfg(ECFGF_SIP0 | ECFGF_IP0 | ECFGF_IP1 | ECFGF_IP2 | ECFGF_IPI | ECFGF_PMC);
 }
diff --git a/arch/loongarch/kernel/paravirt.c b/arch/loongarch/kernel/paravirt.c
new file mode 100644
index 000000000000..9044ed62045c
--- /dev/null
+++ b/arch/loongarch/kernel/paravirt.c
@@ -0,0 +1,151 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/export.h>
+#include <linux/types.h>
+#include <linux/interrupt.h>
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
+#ifdef CONFIG_SMP
+static void pv_send_ipi_single(int cpu, unsigned int action)
+{
+	unsigned int min, old;
+	irq_cpustat_t *info = &per_cpu(irq_stat, cpu);
+
+	old = atomic_fetch_or(BIT(action), &info->message);
+	if (old)
+		return;
+
+	min = cpu_logical_map(cpu);
+	kvm_hypercall3(KVM_HCALL_FUNC_PV_IPI, 1, 0, min);
+}
+
+#define KVM_IPI_CLUSTER_SIZE		(2 * BITS_PER_LONG)
+static void pv_send_ipi_mask(const struct cpumask *mask, unsigned int action)
+{
+	unsigned int cpu, i, min = 0, max = 0, old;
+	__uint128_t bitmap = 0;
+	irq_cpustat_t *info;
+
+	if (cpumask_empty(mask))
+		return;
+
+	action = BIT(action);
+	for_each_cpu(i, mask) {
+		info = &per_cpu(irq_stat, i);
+		old = atomic_fetch_or(action, &info->message);
+		if (old)
+			continue;
+
+		cpu = cpu_logical_map(i);
+		if (!bitmap) {
+			min = max = cpu;
+		} else if (cpu > min && cpu < min + KVM_IPI_CLUSTER_SIZE) {
+			max = cpu > max ? cpu : max;
+		} else if (cpu < min && (max - cpu) < KVM_IPI_CLUSTER_SIZE) {
+			bitmap <<= min - cpu;
+			min = cpu;
+		} else {
+			/*
+			 * Physical cpuid is sorted in ascending order ascend
+			 * for the next mask calculation, send IPI here
+			 * directly and skip the remainding cpus
+			 */
+			kvm_hypercall3(KVM_HCALL_FUNC_PV_IPI,
+				(unsigned long)bitmap,
+				(unsigned long)(bitmap >> BITS_PER_LONG), min);
+			min = max = cpu;
+			bitmap = 0;
+		}
+		__set_bit(cpu - min, (unsigned long *)&bitmap);
+	}
+
+	if (bitmap)
+		kvm_hypercall3(KVM_HCALL_FUNC_PV_IPI, (unsigned long)bitmap,
+				(unsigned long)(bitmap >> BITS_PER_LONG), min);
+}
+
+static irqreturn_t loongson_do_swi(int irq, void *dev)
+{
+	irq_cpustat_t *info;
+	long action;
+
+	/* Clear swi interrupt */
+	clear_csr_estat(1 << INT_SWI0);
+	info = this_cpu_ptr(&irq_stat);
+	action = atomic_xchg(&info->message, 0);
+	if (action & SMP_CALL_FUNCTION) {
+		generic_smp_call_function_interrupt();
+		info->ipi_irqs[IPI_CALL_FUNCTION]++;
+	}
+
+	if (action & SMP_RESCHEDULE) {
+		scheduler_ipi();
+		info->ipi_irqs[IPI_RESCHEDULE]++;
+	}
+
+	return IRQ_HANDLED;
+}
+
+static void pv_init_ipi(void)
+{
+	int r, swi0;
+
+	swi0 = get_percpu_irq(INT_SWI0);
+	if (swi0 < 0)
+		panic("SWI0 IRQ mapping failed\n");
+	irq_set_percpu_devid(swi0);
+	r = request_percpu_irq(swi0, loongson_do_swi, "SWI0", &irq_stat);
+	if (r < 0)
+		panic("SWI0 IRQ request failed\n");
+}
+#endif
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
+int __init pv_ipi_init(void)
+{
+	int feature;
+
+	if (!cpu_has_hypervisor)
+		return 0;
+	if (!kvm_para_available())
+		return 0;
+
+	/*
+	 * check whether KVM hypervisor supports pv_ipi or not
+	 */
+	feature = read_cpucfg(CPUCFG_KVM_FEATURE);
+#ifdef CONFIG_SMP
+	if (feature & KVM_FEATURE_PV_IPI) {
+		smp_ops.init_ipi		= pv_init_ipi;
+		smp_ops.send_ipi_single		= pv_send_ipi_single;
+		smp_ops.send_ipi_mask		= pv_send_ipi_mask;
+	}
+#endif
+
+	return 1;
+}
diff --git a/arch/loongarch/kernel/smp.c b/arch/loongarch/kernel/smp.c
index 1fce775be4f6..9eff7aa4c552 100644
--- a/arch/loongarch/kernel/smp.c
+++ b/arch/loongarch/kernel/smp.c
@@ -29,6 +29,7 @@
 #include <asm/loongson.h>
 #include <asm/mmu_context.h>
 #include <asm/numa.h>
+#include <asm/paravirt.h>
 #include <asm/processor.h>
 #include <asm/setup.h>
 #include <asm/time.h>
@@ -309,6 +310,7 @@ void __init loongson_smp_setup(void)
 	cpu_data[0].core = cpu_logical_map(0) % loongson_sysconf.cores_per_package;
 	cpu_data[0].package = cpu_logical_map(0) / loongson_sysconf.cores_per_package;
 
+	pv_ipi_init();
 	iocsr_write32(0xffffffff, LOONGARCH_IOCSR_IPI_EN);
 	pr_info("Detected %i available CPU(s)\n", loongson_sysconf.nr_cpus);
 }
@@ -352,7 +354,7 @@ void loongson_boot_secondary(int cpu, struct task_struct *idle)
 void loongson_init_secondary(void)
 {
 	unsigned int cpu = smp_processor_id();
-	unsigned int imask = ECFGF_IP0 | ECFGF_IP1 | ECFGF_IP2 |
+	unsigned int imask = ECFGF_SIP0 | ECFGF_IP0 | ECFGF_IP1 | ECFGF_IP2 |
 			     ECFGF_IPI | ECFGF_PMC | ECFGF_TIMER;
 
 	change_csr_ecfg(ECFG0_IM, imask);
-- 
2.39.3

