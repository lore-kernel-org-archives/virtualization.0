From: Zengruan Ye <yezengruan@huawei.com>
Subject: [PATCH v3 7/8] KVM: arm64: Add interface to support vCPU preempted check
Date: Thu, 16 Jan 2020 20:46:25 +0800
Message-ID: <20200116124626.1155-8-yezengruan@huawei.com>
References: <20200116124626.1155-1-yezengruan@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200116124626.1155-1-yezengruan@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org, linux-doc@vger.kernel.org, virtualization@lists.linux-foundation.org
Cc: yezengruan@huawei.com, maz@kernel.org, james.morse@arm.com, linux@armlinux.org.uk, suzuki.poulose@arm.com, julien.thierry.kdev@gmail.com, catalin.marinas@arm.com, mark.rutland@arm.com, will@kernel.org, steven.price@arm.com, daniel.lezcano@linaro.org, wanghaibin.wang@huawei.com, peterz@infradead.org, longman@redhat.com, kbuild test robot <lkp@intel.com>
List-Id: virtualization@lists.linuxfoundation.org

This is to fix some lock holder preemption issues. Some other locks
implementation do a spin loop before acquiring the lock itself.
Currently kernel has an interface of bool vcpu_is_preempted(int cpu). It
takes the CPU as parameter and return true if the CPU is preempted.
Then kernel can break the spin loops upon the retval of vcpu_is_preempted.

As kernel has used this interface, So lets support it.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Zengruan Ye <yezengruan@huawei.com>
---
 arch/arm64/include/asm/paravirt.h      | 12 ++++++++++++
 arch/arm64/include/asm/spinlock.h      |  9 +++++++++
 arch/arm64/kernel/Makefile             |  2 +-
 arch/arm64/kernel/paravirt-spinlocks.c | 13 +++++++++++++
 arch/arm64/kernel/paravirt.c           |  4 +++-
 5 files changed, 38 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm64/kernel/paravirt-spinlocks.c

diff --git a/arch/arm64/include/asm/paravirt.h b/arch/arm64/include/asm/paravirt.h
index cf3a0fd7c1a7..7b1c81b544bb 100644
--- a/arch/arm64/include/asm/paravirt.h
+++ b/arch/arm64/include/asm/paravirt.h
@@ -11,8 +11,13 @@ struct pv_time_ops {
 	unsigned long long (*steal_clock)(int cpu);
 };
 
+struct pv_lock_ops {
+	bool (*vcpu_is_preempted)(int cpu);
+};
+
 struct paravirt_patch_template {
 	struct pv_time_ops time;
+	struct pv_lock_ops lock;
 };
 
 extern struct paravirt_patch_template pv_ops;
@@ -24,6 +29,13 @@ static inline u64 paravirt_steal_clock(int cpu)
 
 int __init pv_time_init(void);
 
+__visible bool __native_vcpu_is_preempted(int cpu);
+
+static inline bool pv_vcpu_is_preempted(int cpu)
+{
+	return pv_ops.lock.vcpu_is_preempted(cpu);
+}
+
 #else
 
 #define pv_time_init() do {} while (0)
diff --git a/arch/arm64/include/asm/spinlock.h b/arch/arm64/include/asm/spinlock.h
index b093b287babf..b5d1982414c5 100644
--- a/arch/arm64/include/asm/spinlock.h
+++ b/arch/arm64/include/asm/spinlock.h
@@ -7,8 +7,17 @@
 
 #include <asm/qrwlock.h>
 #include <asm/qspinlock.h>
+#include <asm/paravirt.h>
 
 /* See include/linux/spinlock.h */
 #define smp_mb__after_spinlock()	smp_mb()
 
+#ifdef CONFIG_PARAVIRT
+#define vcpu_is_preempted vcpu_is_preempted
+static inline bool vcpu_is_preempted(long cpu)
+{
+	return pv_vcpu_is_preempted(cpu);
+}
+#endif // CONFIG_PARAVIRT
+
 #endif /* __ASM_SPINLOCK_H */
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index fc6488660f64..b23cdae433a4 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -50,7 +50,7 @@ obj-$(CONFIG_ARMV8_DEPRECATED)		+= armv8_deprecated.o
 obj-$(CONFIG_ACPI)			+= acpi.o
 obj-$(CONFIG_ACPI_NUMA)			+= acpi_numa.o
 obj-$(CONFIG_ARM64_ACPI_PARKING_PROTOCOL)	+= acpi_parking_protocol.o
-obj-$(CONFIG_PARAVIRT)			+= paravirt.o
+obj-$(CONFIG_PARAVIRT)			+= paravirt.o paravirt-spinlocks.o
 obj-$(CONFIG_RANDOMIZE_BASE)		+= kaslr.o
 obj-$(CONFIG_HIBERNATION)		+= hibernate.o hibernate-asm.o
 obj-$(CONFIG_KEXEC_CORE)		+= machine_kexec.o relocate_kernel.o	\
diff --git a/arch/arm64/kernel/paravirt-spinlocks.c b/arch/arm64/kernel/paravirt-spinlocks.c
new file mode 100644
index 000000000000..718aa773d45c
--- /dev/null
+++ b/arch/arm64/kernel/paravirt-spinlocks.c
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright(c) 2019 Huawei Technologies Co., Ltd
+ * Author: Zengruan Ye <yezengruan@huawei.com>
+ */
+
+#include <linux/spinlock.h>
+#include <asm/paravirt.h>
+
+__visible bool __native_vcpu_is_preempted(int cpu)
+{
+	return false;
+}
diff --git a/arch/arm64/kernel/paravirt.c b/arch/arm64/kernel/paravirt.c
index 1ef702b0be2d..d8f1ba8c22ce 100644
--- a/arch/arm64/kernel/paravirt.c
+++ b/arch/arm64/kernel/paravirt.c
@@ -26,7 +26,9 @@
 struct static_key paravirt_steal_enabled;
 struct static_key paravirt_steal_rq_enabled;
 
-struct paravirt_patch_template pv_ops;
+struct paravirt_patch_template pv_ops = {
+	.lock.vcpu_is_preempted		= __native_vcpu_is_preempted,
+};
 EXPORT_SYMBOL_GPL(pv_ops);
 
 struct pv_time_stolen_time_region {
-- 
2.19.1
