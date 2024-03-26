Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA7E11BF3A;
	Tue, 26 Mar 2024 08:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711442135; cv=none; b=A0lh+bzqUtAobb0tLahlQUHEAFTgurSVjLJyQHJMbwvqP2fI3KUamDm5wT1FLn3dAw97xvDE49BZfNzPVmzzL48QtxDfPpdbEWVB0671tDISWZFEN68fKos997DooU55qWUVLekY/miXVuFwdsEbXiULb2g8AFp8xt1mEb0wQxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711442135; c=relaxed/simple;
	bh=h9EeJQUPGscodmSjnmp0D/vEOTmiEFfN3yvTqvtFhuk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZrgX9t+mUFFRxXIPJleWeV+8jv2n3nLS4/WBksTTTQt/UYT98cf0bVIH+4fuDY18T/QUCY700Q9geCYOFBK1ya5FO7Up1dKEPfjPdzN/7NGMBVYvXQz26SIsdzP49WFMh61GMQwu0FBZsiiX3xa2FwMIAJKX4lDwam/cPLpIl38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8DxfesFggJmEEoeAA--.5470S3;
	Tue, 26 Mar 2024 16:06:29 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8CxbRMBggJmhaRoAA--.9600S4;
	Tue, 26 Mar 2024 16:06:29 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Tianrui Zhao <zhaotianrui@loongson.cn>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: Juergen Gross <jgross@suse.com>,
	kvm@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev,
	x86@kernel.org
Subject: [PATCH 2/2] LoongArch: Add steal time support in guest side
Date: Tue, 26 Mar 2024 16:06:25 +0800
Message-Id: <20240326080625.898051-3-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240326080625.898051-1-maobibo@loongson.cn>
References: <20240326080625.898051-1-maobibo@loongson.cn>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8CxbRMBggJmhaRoAA--.9600S4
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==
X-Gw-Check: c0fd0a87d2a814b0

Percpu struct kvm_steal_time is added here, its size is 64 bytes and
also defined as 64 bytes, so that the whole structure is in one physical
page.

When vcpu is onlined, function pv_register_steal_time() is called. This
function will pass physical address of struct kvm_steal_time and tells
hypervisor to enable steal time. When vcpu is offline, physical address
is set as 0 and tells hypervisor to disable steal time.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 arch/loongarch/include/asm/paravirt.h |   5 +
 arch/loongarch/kernel/paravirt.c      | 130 ++++++++++++++++++++++++++
 arch/loongarch/kernel/time.c          |   2 +
 3 files changed, 137 insertions(+)

diff --git a/arch/loongarch/include/asm/paravirt.h b/arch/loongarch/include/asm/paravirt.h
index 58f7b7b89f2c..fe27fb5e82b8 100644
--- a/arch/loongarch/include/asm/paravirt.h
+++ b/arch/loongarch/include/asm/paravirt.h
@@ -17,11 +17,16 @@ static inline u64 paravirt_steal_clock(int cpu)
 }
 
 int pv_ipi_init(void);
+int __init pv_time_init(void);
 #else
 static inline int pv_ipi_init(void)
 {
 	return 0;
 }
 
+static inline int pv_time_init(void)
+{
+	return 0;
+}
 #endif // CONFIG_PARAVIRT
 #endif
diff --git a/arch/loongarch/kernel/paravirt.c b/arch/loongarch/kernel/paravirt.c
index 9044ed62045c..56182c64ab38 100644
--- a/arch/loongarch/kernel/paravirt.c
+++ b/arch/loongarch/kernel/paravirt.c
@@ -5,10 +5,13 @@
 #include <linux/jump_label.h>
 #include <linux/kvm_para.h>
 #include <asm/paravirt.h>
+#include <linux/reboot.h>
 #include <linux/static_call.h>
 
 struct static_key paravirt_steal_enabled;
 struct static_key paravirt_steal_rq_enabled;
+static DEFINE_PER_CPU(struct kvm_steal_time, steal_time) __aligned(64);
+static int has_steal_clock;
 
 static u64 native_steal_clock(int cpu)
 {
@@ -17,6 +20,57 @@ static u64 native_steal_clock(int cpu)
 
 DEFINE_STATIC_CALL(pv_steal_clock, native_steal_clock);
 
+static bool steal_acc = true;
+static int __init parse_no_stealacc(char *arg)
+{
+	steal_acc = false;
+	return 0;
+}
+early_param("no-steal-acc", parse_no_stealacc);
+
+static u64 para_steal_clock(int cpu)
+{
+	u64 steal;
+	struct kvm_steal_time *src;
+	int version;
+
+	src = &per_cpu(steal_time, cpu);
+	do {
+
+		version = src->version;
+		/* Make sure that the version is read before the steal */
+		virt_rmb();
+		steal = src->steal;
+		/* Make sure that the steal is read before the next version */
+		virt_rmb();
+
+	} while ((version & 1) || (version != src->version));
+	return steal;
+}
+
+static int pv_register_steal_time(void)
+{
+	int cpu = smp_processor_id();
+	struct kvm_steal_time *st;
+	unsigned long addr;
+
+	if (!has_steal_clock)
+		return -EPERM;
+
+	st = &per_cpu(steal_time, cpu);
+	addr = per_cpu_ptr_to_phys(st);
+
+	/* The whole structure kvm_steal_time should be one page */
+	if (PFN_DOWN(addr) != PFN_DOWN(addr + sizeof(*st))) {
+		pr_warn("Illegal PV steal time addr %lx\n", addr);
+		return -EFAULT;
+	}
+
+	addr |= KVM_STEAL_PHYS_VALID;
+	kvm_hypercall2(KVM_HCALL_FUNC_NOTIFY, KVM_FEATURE_STEAL_TIME, addr);
+	return 0;
+}
+
 #ifdef CONFIG_SMP
 static void pv_send_ipi_single(int cpu, unsigned int action)
 {
@@ -110,6 +164,32 @@ static void pv_init_ipi(void)
 	if (r < 0)
 		panic("SWI0 IRQ request failed\n");
 }
+
+static void pv_disable_steal_time(void)
+{
+	if (has_steal_clock)
+		kvm_hypercall2(KVM_HCALL_FUNC_NOTIFY, KVM_FEATURE_STEAL_TIME, 0);
+}
+
+static int pv_cpu_online(unsigned int cpu)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	pv_register_steal_time();
+	local_irq_restore(flags);
+	return 0;
+}
+
+static int pv_cpu_down_prepare(unsigned int cpu)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	pv_disable_steal_time();
+	local_irq_restore(flags);
+	return 0;
+}
 #endif
 
 static bool kvm_para_available(void)
@@ -149,3 +229,53 @@ int __init pv_ipi_init(void)
 
 	return 1;
 }
+
+static void pv_cpu_reboot(void *unused)
+{
+	pv_disable_steal_time();
+}
+
+static int pv_reboot_notify(struct notifier_block *nb, unsigned long code,
+		void *unused)
+{
+	on_each_cpu(pv_cpu_reboot, NULL, 1);
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block pv_reboot_nb = {
+	.notifier_call  = pv_reboot_notify,
+};
+
+int __init pv_time_init(void)
+{
+	int feature;
+
+	if (!cpu_has_hypervisor)
+		return 0;
+	if (!kvm_para_available())
+		return 0;
+
+	feature = read_cpucfg(CPUCFG_KVM_FEATURE);
+	if (!(feature & KVM_FEATURE_STEAL_TIME))
+		return 0;
+
+	has_steal_clock = 1;
+	if (pv_register_steal_time()) {
+		has_steal_clock = 0;
+		return 0;
+	}
+
+	register_reboot_notifier(&pv_reboot_nb);
+	static_call_update(pv_steal_clock, para_steal_clock);
+	static_key_slow_inc(&paravirt_steal_enabled);
+	if (steal_acc)
+		static_key_slow_inc(&paravirt_steal_rq_enabled);
+
+#ifdef CONFIG_SMP
+	if (cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN, "loongarch/pv:online",
+				pv_cpu_online, pv_cpu_down_prepare) < 0)
+		pr_err("Failed to install cpu hotplug callbacks\n");
+#endif
+	pr_info("Using stolen time PV\n");
+	return 0;
+}
diff --git a/arch/loongarch/kernel/time.c b/arch/loongarch/kernel/time.c
index fd5354f9be7c..46d7d40c87e3 100644
--- a/arch/loongarch/kernel/time.c
+++ b/arch/loongarch/kernel/time.c
@@ -15,6 +15,7 @@
 
 #include <asm/cpu-features.h>
 #include <asm/loongarch.h>
+#include <asm/paravirt.h>
 #include <asm/time.h>
 
 u64 cpu_clock_freq;
@@ -214,4 +215,5 @@ void __init time_init(void)
 
 	constant_clockevent_init();
 	constant_clocksource_init();
+	pv_time_init();
 }
-- 
2.39.3

