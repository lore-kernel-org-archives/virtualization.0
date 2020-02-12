From: Alexey Makhalov via Virtualization
 <virtualization@lists.linux-foundation.org>
Subject: [PATCH 3/5] x86/vmware: Steal time clock for VMware guest
Date: Wed, 12 Feb 2020 20:03:10 +0000
Message-ID: <20200212200312.2033-4-amakhalov@vmware.com>
References: <20200212200312.2033-1-amakhalov@vmware.com>
Reply-To: Alexey Makhalov <amakhalov@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200212200312.2033-1-amakhalov@vmware.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: x86@kernel.org
Cc: Juergen Gross <jgross@suse.com>, Alexey Makhalov <amakhalov@vmware.com>, Jonathan Corbet <corbet@lwn.net>, "VMware, Inc." <pv-drivers@vmware.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Josh Poimboeuf <jpoimboe@redhat.com>, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, Tomer Zeltzer <tomerr90@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

Steal time is the amount of CPU time needed by a guest
virtual machine that is not provided by the host. Steal
time occurs when the host allocates this CPU time
elsewhere: for example, to another guest.

Steal time can be enabled by adding VM configuration option
stealclock.enable = "TRUE". It is supported by VMs that run
hardware version 13 or newer.

This change introduces the VMware steal time infrastructure.
The high level code (such as enabling, disabling and
hot-plug routines) was derived from KVM one.

[Tomer: use READ_ONCE macros and 32bit guests support]

Signed-off-by: Alexey Makhalov <amakhalov@vmware.com>
Co-developed-by: Tomer Zeltzer <tomerr90@gmail.com>
Signed-off-by: Tomer Zeltzer <tomerr90@gmail.com>
Reviewed-by: Thomas Hellstrom <thellstrom@vmware.com>
---
 arch/x86/kernel/cpu/vmware.c | 197 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 197 insertions(+)

diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
index efb22fa76ba4..59459992ad47 100644
--- a/arch/x86/kernel/cpu/vmware.c
+++ b/arch/x86/kernel/cpu/vmware.c
@@ -25,6 +25,8 @@
 #include <linux/init.h>
 #include <linux/export.h>
 #include <linux/clocksource.h>
+#include <linux/cpu.h>
+#include <linux/reboot.h>
 #include <asm/div64.h>
 #include <asm/x86_init.h>
 #include <asm/hypervisor.h>
@@ -47,6 +49,11 @@
 #define VMWARE_CMD_GETVCPU_INFO  68
 #define VMWARE_CMD_LEGACY_X2APIC  3
 #define VMWARE_CMD_VCPU_RESERVED 31
+#define VMWARE_CMD_STEALCLOCK    91
+
+#define STEALCLOCK_NOT_AVAILABLE (-1)
+#define STEALCLOCK_DISABLED        0
+#define STEALCLOCK_ENABLED         1
 
 #define VMWARE_PORT(cmd, eax, ebx, ecx, edx)				\
 	__asm__("inl (%%dx), %%eax" :					\
@@ -86,6 +93,18 @@
 	}							\
 	} while (0)
 
+struct vmware_steal_time {
+	union {
+		uint64_t clock;	/* stolen time counter in units of vtsc */
+		struct {
+			/* only for little-endian */
+			uint32_t clock_low;
+			uint32_t clock_high;
+		};
+	};
+	uint64_t reserved[7];
+};
+
 static unsigned long vmware_tsc_khz __ro_after_init;
 static u8 vmware_hypercall_mode     __ro_after_init;
 
@@ -104,6 +123,8 @@ static unsigned long vmware_get_tsc_khz(void)
 #ifdef CONFIG_PARAVIRT
 static struct cyc2ns_data vmware_cyc2ns __ro_after_init;
 static int vmw_sched_clock __initdata = 1;
+static DEFINE_PER_CPU_DECRYPTED(struct vmware_steal_time, steal_time) __aligned(64);
+static bool has_steal_clock;
 
 static __init int setup_vmw_sched_clock(char *s)
 {
@@ -135,6 +156,163 @@ static void __init vmware_cyc2ns_setup(void)
 	pr_info("using clock offset of %llu ns\n", d->cyc2ns_offset);
 }
 
+static int vmware_cmd_stealclock(uint32_t arg1, uint32_t arg2)
+{
+	uint32_t result, info;
+
+	asm volatile (VMWARE_HYPERCALL :
+		"=a"(result),
+		"=c"(info) :
+		"a"(VMWARE_HYPERVISOR_MAGIC),
+		"b"(0),
+		"c"(VMWARE_CMD_STEALCLOCK),
+		"d"(0),
+		"S"(arg1),
+		"D"(arg2) :
+		"memory");
+	return result;
+}
+
+static bool stealclock_enable(phys_addr_t pa)
+{
+	return vmware_cmd_stealclock(upper_32_bits(pa),
+				     lower_32_bits(pa)) == STEALCLOCK_ENABLED;
+}
+
+static int __stealclock_disable(void)
+{
+	return vmware_cmd_stealclock(0, 1);
+}
+
+static void stealclock_disable(void)
+{
+	__stealclock_disable();
+}
+
+static bool vmware_is_stealclock_available(void)
+{
+	return __stealclock_disable() != STEALCLOCK_NOT_AVAILABLE;
+}
+
+/**
+ * vmware_steal_clock() - read the per-cpu steal clock
+ * @cpu:            the cpu number whose steal clock we want to read
+ *
+ * The function reads the steal clock if we are on a 64-bit system, otherwise
+ * reads it in parts, checking that the high part didn't change in the
+ * meantime.
+ *
+ * Return:
+ *      The steal clock reading in ns.
+ */
+static uint64_t vmware_steal_clock(int cpu)
+{
+	struct vmware_steal_time *steal = &per_cpu(steal_time, cpu);
+	uint64_t clock;
+
+	if (IS_ENABLED(CONFIG_64BIT))
+		clock = READ_ONCE(steal->clock);
+	else {
+		uint32_t initial_high, low, high;
+
+		do {
+			initial_high = READ_ONCE(steal->clock_high);
+			/* Do not reorder initial_high and high readings */
+			virt_rmb();
+			low = READ_ONCE(steal->clock_low);
+			/* Keep low reading in between */
+			virt_rmb();
+			high = READ_ONCE(steal->clock_high);
+		} while (initial_high != high);
+
+		clock = ((uint64_t)high << 32) | low;
+	}
+
+	return mul_u64_u32_shr(clock, vmware_cyc2ns.cyc2ns_mul,
+			     vmware_cyc2ns.cyc2ns_shift);
+}
+
+static void vmware_register_steal_time(void)
+{
+	int cpu = smp_processor_id();
+	struct vmware_steal_time *st = &per_cpu(steal_time, cpu);
+
+	if (!has_steal_clock)
+		return;
+
+	if (!stealclock_enable(slow_virt_to_phys(st))) {
+		has_steal_clock = false;
+		return;
+	}
+
+	pr_info("vmware-stealtime: cpu %d, pa %llx\n",
+		cpu, (unsigned long long) slow_virt_to_phys(st));
+}
+
+static void vmware_disable_steal_time(void)
+{
+	if (!has_steal_clock)
+		return;
+
+	stealclock_disable();
+}
+
+static void vmware_guest_cpu_init(void)
+{
+	if (has_steal_clock)
+		vmware_register_steal_time();
+}
+
+static void vmware_pv_guest_cpu_reboot(void *unused)
+{
+	vmware_disable_steal_time();
+}
+
+static int vmware_pv_reboot_notify(struct notifier_block *nb,
+				unsigned long code, void *unused)
+{
+	if (code == SYS_RESTART)
+		on_each_cpu(vmware_pv_guest_cpu_reboot, NULL, 1);
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block vmware_pv_reboot_nb = {
+	.notifier_call = vmware_pv_reboot_notify,
+};
+
+#ifdef CONFIG_SMP
+static void __init vmware_smp_prepare_boot_cpu(void)
+{
+	vmware_guest_cpu_init();
+	native_smp_prepare_boot_cpu();
+}
+
+static int vmware_cpu_online(unsigned int cpu)
+{
+	local_irq_disable();
+	vmware_guest_cpu_init();
+	local_irq_enable();
+	return 0;
+}
+
+static int vmware_cpu_down_prepare(unsigned int cpu)
+{
+	local_irq_disable();
+	vmware_disable_steal_time();
+	local_irq_enable();
+	return 0;
+}
+#endif
+
+static __init int activate_jump_labels(void)
+{
+	if (has_steal_clock)
+		static_key_slow_inc(&paravirt_steal_enabled);
+
+	return 0;
+}
+arch_initcall(activate_jump_labels);
+
 static void __init vmware_paravirt_ops_setup(void)
 {
 	pv_info.name = "VMware hypervisor";
@@ -148,6 +326,25 @@ static void __init vmware_paravirt_ops_setup(void)
 	if (vmw_sched_clock)
 		pv_ops.time.sched_clock = vmware_sched_clock;
 
+	if (vmware_is_stealclock_available()) {
+		has_steal_clock = true;
+		pv_ops.time.steal_clock = vmware_steal_clock;
+
+		/* We use reboot notifier only to disable steal clock */
+		register_reboot_notifier(&vmware_pv_reboot_nb);
+
+#ifdef CONFIG_SMP
+		smp_ops.smp_prepare_boot_cpu =
+			vmware_smp_prepare_boot_cpu;
+		if (cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
+					      "x86/vmware:online",
+					      vmware_cpu_online,
+					      vmware_cpu_down_prepare) < 0)
+			pr_err("vmware_guest: Failed to install cpu hotplug callbacks\n");
+#else
+		vmware_guest_cpu_init();
+#endif
+	}
 }
 #else
 #define vmware_paravirt_ops_setup() do {} while (0)
-- 
2.14.2
