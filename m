From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: [patch 11/34] Xen-pv_ops: Add smp_ops interface
Date: Tue, 13 Mar 2007 16:30:28 -0700
Message-ID: <20070313233031.356079665@goop.org>
References: <20070313233017.933601256@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
Content-Disposition: inline; filename=smp-ops.patch
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Andi Kleen <ak@muc.de>
Cc: Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, xen-devel@lists.xensource.com, Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, James Bottomley <James.Bottomley@HansenPartnership.com>
List-Id: virtualization@lists.linuxfoundation.org

Add a smp_ops interface.  This abstracts the API defined by
<linux/smp.h> for use within arch/i386.  The primary intent is that it
be used by a paravirtualizing hypervisor to implement SMP, but it
could also be used by non-APIC-using sub-archtectures.

This is related to CONFIG_PARAVIRT, but is implemented unconditionally
since it is simpler that way and not a highly performance-sensitive
interface.

Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
Cc: Andi Kleen <ak@suse.de>
Cc: Ingo Molnar <mingo@elte.hu>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>

---
 arch/i386/kernel/smp.c     |   21 +++++++++++++----
 arch/i386/kernel/smpboot.c |    8 +++---
 include/asm-i386/smp.h     |   53 ++++++++++++++++++++++++++++++++++++++++=
++++
 3 files changed, 73 insertions(+), 9 deletions(-)

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/i386/kernel/smp.c
+++ b/arch/i386/kernel/smp.c
@@ -483,7 +483,7 @@ void flush_tlb_all(void)
  * it goes straight through and wastes no time serializing
  * anything. Worst case is that we lose a reschedule ...
  */
-void smp_send_reschedule(int cpu)
+void native_smp_send_reschedule(int cpu)
 {
 	WARN_ON(cpu_is_offline(cpu));
 	send_IPI_mask(cpumask_of_cpu(cpu), RESCHEDULE_VECTOR);
@@ -529,9 +529,9 @@ static struct call_data_struct *call_dat
  * You must not call this function with disabled interrupts or from a
  * hardware interrupt handler or from a bottom half handler.
  */
-int smp_call_function_mask(cpumask_t mask,
-			   void (*func)(void *), void *info,
-			   int wait)
+static int native_smp_call_function_mask(cpumask_t mask,
+					 void (*func)(void *), void *info,
+					 int wait)
 {
 	struct call_data_struct data;
 	cpumask_t allbutself;
@@ -650,7 +650,7 @@ static void stop_this_cpu (void * dummy)
  * this function calls the 'stop' function on all other CPUs in the system.
  */
 =

-void smp_send_stop(void)
+void native_smp_send_stop(void)
 {
 	smp_call_function(stop_this_cpu, NULL, 1, 0);
 =

@@ -721,3 +721,14 @@ int safe_smp_processor_id(void)
 =

 	return cpuid >=3D 0 ? cpuid : 0;
 }
+
+struct smp_ops smp_ops =3D {
+	.smp_prepare_boot_cpu =3D native_smp_prepare_boot_cpu,
+	.smp_prepare_cpus =3D native_smp_prepare_cpus,
+	.cpu_up =3D native_cpu_up,
+	.smp_cpus_done =3D native_smp_cpus_done,
+
+	.smp_send_stop =3D native_smp_send_stop,
+	.smp_send_reschedule =3D native_smp_send_reschedule,
+	.smp_call_function_mask =3D native_smp_call_function_mask,
+};
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/i386/kernel/smpboot.c
+++ b/arch/i386/kernel/smpboot.c
@@ -1173,7 +1173,7 @@ static void __init smp_boot_cpus(unsigne
 =

 /* These are wrappers to interface to the new boot process.  Someone
    who understands all this stuff should rewrite it properly. --RR 15/Jul/=
02 */
-void __init smp_prepare_cpus(unsigned int max_cpus)
+void __init native_smp_prepare_cpus(unsigned int max_cpus)
 {
 	smp_commenced_mask =3D cpumask_of_cpu(0);
 	cpu_callin_map =3D cpumask_of_cpu(0);
@@ -1181,7 +1181,7 @@ void __init smp_prepare_cpus(unsigned in
 	smp_boot_cpus(max_cpus);
 }
 =

-void __devinit smp_prepare_boot_cpu(void)
+void __devinit native_smp_prepare_boot_cpu(void)
 {
 	cpu_set(smp_processor_id(), cpu_online_map);
 	cpu_set(smp_processor_id(), cpu_callout_map);
@@ -1277,7 +1277,7 @@ void __cpu_die(unsigned int cpu)
 }
 #endif /* CONFIG_HOTPLUG_CPU */
 =

-int __cpuinit __cpu_up(unsigned int cpu)
+int __cpuinit native_cpu_up(unsigned int cpu)
 {
 	unsigned long flags;
 #ifdef CONFIG_HOTPLUG_CPU
@@ -1327,7 +1327,7 @@ int __cpuinit __cpu_up(unsigned int cpu)
 	return 0;
 }
 =

-void __init smp_cpus_done(unsigned int max_cpus)
+void __init native_smp_cpus_done(unsigned int max_cpus)
 {
 #ifdef CONFIG_X86_IO_APIC
 	setup_ioapic_dest();
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/include/asm-i386/smp.h
+++ b/include/asm-i386/smp.h
@@ -51,6 +51,59 @@ extern void cpu_exit_clear(void);
 extern void cpu_exit_clear(void);
 extern void cpu_uninit(void);
 #endif
+
+struct smp_ops
+{
+	void (*smp_prepare_boot_cpu)(void);
+	void (*smp_prepare_cpus)(unsigned max_cpus);
+	int (*cpu_up)(unsigned cpu);
+	void (*smp_cpus_done)(unsigned max_cpus);
+
+	void (*smp_send_stop)(void);
+	void (*smp_send_reschedule)(int cpu);
+	int (*smp_call_function_mask)(cpumask_t mask,
+				      void (*func)(void *info), void *info,
+				      int wait);
+};
+
+extern struct smp_ops smp_ops;
+
+static inline void smp_prepare_boot_cpu(void)
+{
+	smp_ops.smp_prepare_boot_cpu();
+}
+static inline void smp_prepare_cpus(unsigned int max_cpus)
+{
+	smp_ops.smp_prepare_cpus(max_cpus);
+}
+static inline int __cpu_up(unsigned int cpu)
+{
+	return smp_ops.cpu_up(cpu);
+}
+static inline void smp_cpus_done(unsigned int max_cpus)
+{
+	smp_ops.smp_cpus_done(max_cpus);
+}
+
+static inline void smp_send_stop(void)
+{
+	smp_ops.smp_send_stop();
+}
+static inline void smp_send_reschedule(int cpu)
+{
+	smp_ops.smp_send_reschedule(cpu);
+}
+static inline int smp_call_function_mask(cpumask_t mask,
+					 void (*func) (void *info), void *info,
+					 int wait)
+{
+	return smp_ops.smp_call_function_mask(mask, func, info, wait);
+}
+
+void native_smp_prepare_boot_cpu(void);
+void native_smp_prepare_cpus(unsigned int max_cpus);
+int native_cpu_up(unsigned int cpunum);
+void native_smp_cpus_done(unsigned int max_cpus);
 =

 #ifndef CONFIG_PARAVIRT
 #define startup_ipi_hook(phys_apicid, start_eip, start_esp) 		\

-- =
