From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 1/4] Add helper functions for paravirtual
	clocksources.
Date: Thu,  8 May 2008 13:48:32 +0200
Message-ID: <1210247315-20472-2-git-send-email-kraxel@redhat.com>
References: <1210247315-20472-1-git-send-email-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kvm-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1210247315-20472-1-git-send-email-kraxel@redhat.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/kvm-devel>,
	<mailto:kvm-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=kvm-devel>
List-Post: <mailto:kvm-devel@lists.sourceforge.net>
List-Help: <mailto:kvm-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/kvm-devel>,
	<mailto:kvm-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: kvm-devel-bounces@lists.sourceforge.net
Errors-To: kvm-devel-bounces@lists.sourceforge.net
To: virtualization@lists.osdl.org, kvm-devel@lists.sourceforge.net
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Gerd Hoffmann <kraxel@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

The helper functions are intended to be used by both xen and kvm
paravirtual clock sources.  Following patches of this series put
them into use.  They are based on the xen code.

Cc: Jeremy Fitzhardinge <jeremy@goop.org>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 arch/x86/Kconfig          |    4 +
 arch/x86/kernel/Makefile  |    1 +
 arch/x86/kernel/pvclock.c |  148 +++++++++++++++++++++++++++++++++++++++++++++
 include/asm-x86/pvclock.h |    6 ++
 4 files changed, 159 insertions(+), 0 deletions(-)
 create mode 100644 arch/x86/kernel/pvclock.c
 create mode 100644 include/asm-x86/pvclock.h

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 845ea2b..b12e188 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -415,6 +415,10 @@ config PARAVIRT
 	  over full virtualization.  However, when run without a hypervisor
 	  the kernel is theoretically slower and slightly larger.
 
+config PARAVIRT_CLOCK
+	bool
+	default n
+
 endif
 
 config MEMTEST_BOOTPARAM
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index bbdacb3..5d8e086 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -82,6 +82,7 @@ obj-$(CONFIG_VMI)		+= vmi_32.o vmiclock_32.o
 obj-$(CONFIG_KVM_GUEST)		+= kvm.o
 obj-$(CONFIG_KVM_CLOCK)		+= kvmclock.o
 obj-$(CONFIG_PARAVIRT)		+= paravirt.o paravirt_patch_$(BITS).o
+obj-$(CONFIG_PARAVIRT_CLOCK)	+= pvclock.o
 
 ifdef CONFIG_INPUT_PCSPKR
 obj-y				+= pcspeaker.o
diff --git a/arch/x86/kernel/pvclock.c b/arch/x86/kernel/pvclock.c
new file mode 100644
index 0000000..33e526f
--- /dev/null
+++ b/arch/x86/kernel/pvclock.c
@@ -0,0 +1,148 @@
+/*  paravirtual clock -- common code used by kvm/xen
+
+    This program is free software; you can redistribute it and/or modify
+    it under the terms of the GNU General Public License as published by
+    the Free Software Foundation; either version 2 of the License, or
+    (at your option) any later version.
+
+    This program is distributed in the hope that it will be useful,
+    but WITHOUT ANY WARRANTY; without even the implied warranty of
+    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+    GNU General Public License for more details.
+
+    You should have received a copy of the GNU General Public License
+    along with this program; if not, write to the Free Software
+    Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+*/
+
+#include <linux/kernel.h>
+#include <linux/percpu.h>
+#include <asm/pvclock.h>
+
+/*
+ * These are perodically updated
+ *    xen: magic shared_info page
+ *    kvm: gpa registered via msr
+ * and then copied here.
+ */
+struct pvclock_shadow_time {
+	u64 tsc_timestamp;     /* TSC at last update of time vals.  */
+	u64 system_timestamp;  /* Time, in nanosecs, since boot.    */
+	u32 tsc_to_nsec_mul;
+	int tsc_shift;
+	u32 version;
+};
+
+/*
+ * Scale a 64-bit delta by scaling and multiplying by a 32-bit fraction,
+ * yielding a 64-bit result.
+ */
+static inline u64 scale_delta(u64 delta, u32 mul_frac, int shift)
+{
+	u64 product;
+#ifdef __i386__
+	u32 tmp1, tmp2;
+#endif
+
+	if (shift < 0)
+		delta >>= -shift;
+	else
+		delta <<= shift;
+
+#ifdef __i386__
+	__asm__ (
+		"mul  %5       ; "
+		"mov  %4,%%eax ; "
+		"mov  %%edx,%4 ; "
+		"mul  %5       ; "
+		"xor  %5,%5    ; "
+		"add  %4,%%eax ; "
+		"adc  %5,%%edx ; "
+		: "=A" (product), "=r" (tmp1), "=r" (tmp2)
+		: "a" ((u32)delta), "1" ((u32)(delta >> 32)), "2" (mul_frac) );
+#elif __x86_64__
+	__asm__ (
+		"mul %%rdx ; shrd $32,%%rdx,%%rax"
+		: "=a" (product) : "0" (delta), "d" ((u64)mul_frac) );
+#else
+#error implement me!
+#endif
+
+	return product;
+}
+
+static u64 pvclock_get_nsec_offset(struct pvclock_shadow_time *shadow)
+{
+	u64 delta = native_read_tsc() - shadow->tsc_timestamp;
+	return scale_delta(delta, shadow->tsc_to_nsec_mul, shadow->tsc_shift);
+}
+
+/*
+ * Reads a consistent set of time-base values from hypervisor,
+ * into a shadow data area.
+ */
+static unsigned pvclock_get_time_values(struct pvclock_shadow_time *dst,
+					struct kvm_vcpu_time_info *src)
+{
+	do {
+		dst->version = src->version;
+		rmb();		/* fetch version before data */
+		dst->tsc_timestamp     = src->tsc_timestamp;
+		dst->system_timestamp  = src->system_time;
+		dst->tsc_to_nsec_mul   = src->tsc_to_system_mul;
+		dst->tsc_shift         = src->tsc_shift;
+		rmb();		/* test version after fetching data */
+	} while ((src->version & 1) || (dst->version != src->version));
+
+	return dst->version;
+}
+
+/*
+ * This is our read_clock function. The host puts an tsc timestamp each time
+ * it updates a new time. Without the tsc adjustment, we can have a situation
+ * in which a vcpu starts to run earlier (smaller system_time), but probes
+ * time later (compared to another vcpu), leading to backwards time
+ */
+
+cycle_t pvclock_clocksource_read(struct kvm_vcpu_time_info *src)
+{
+	struct pvclock_shadow_time shadow;
+	unsigned version;
+	cycle_t ret, offset;
+
+	do {
+		version = pvclock_get_time_values(&shadow, src);
+		barrier();
+		offset = pvclock_get_nsec_offset(&shadow);
+		ret = shadow.system_timestamp + offset;
+		barrier();
+	} while (version != src->version);
+
+	return ret;
+}
+
+void pvclock_read_wallclock(struct kvm_wall_clock *wall_clock,
+			    struct kvm_vcpu_time_info *vcpu_time,
+			    struct timespec *ts)
+{
+	u32 version;
+	u64 delta;
+	struct timespec now;
+
+	/* get wallclock at system boot */
+	do {
+		version = wall_clock->wc_version;
+		rmb();		/* fetch version before time */
+		now.tv_sec  = wall_clock->wc_sec;
+		now.tv_nsec = wall_clock->wc_nsec;
+		rmb();		/* fetch time before checking version */
+	} while ((wall_clock->wc_version & 1) || (version != wall_clock->wc_version));
+
+	delta = pvclock_clocksource_read(vcpu_time);	/* time since system boot */
+	delta += now.tv_sec * (u64)NSEC_PER_SEC + now.tv_nsec;
+
+	now.tv_nsec = do_div(delta, NSEC_PER_SEC);
+	now.tv_sec = delta;
+
+	set_normalized_timespec(ts, now.tv_sec, now.tv_nsec);
+}
diff --git a/include/asm-x86/pvclock.h b/include/asm-x86/pvclock.h
new file mode 100644
index 0000000..2b9812f
--- /dev/null
+++ b/include/asm-x86/pvclock.h
@@ -0,0 +1,6 @@
+#include <linux/clocksource.h>
+#include <asm/kvm_para.h>
+cycle_t pvclock_clocksource_read(struct kvm_vcpu_time_info *src);
+void pvclock_read_wallclock(struct kvm_wall_clock *wall,
+			    struct kvm_vcpu_time_info *vcpu,
+			    struct timespec *ts);
-- 
1.5.4.1


-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
