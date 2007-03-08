From: Steven Rostedt <rostedt@goodmis.org>
Subject: [RFC/PATCH PV_OPS X86_64 14/17] paravirt_ops - vsyscall
Date: Thu, 08 Mar 2007 01:02:33 -0500
Message-ID: <1173333753.25848.15.camel@localhost.localdomain>
References: <20070308054422.820010000@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: virtualization@lists.osdl.org
Cc: Chris Wright <chrisw@sous-sol.org>, Glauber de Oliveira Costa <gcosta@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

plain text document attachment (xx-paravirt-vsyscall.patch)
vsyscall interface updates for paravirt ops.

Signed-off-by: Steven Rostedt srostedt@redhat.com
Signed-off-by: Glauber de Oliveira Costa <gcosta@redhat.com>


Index: clean-start/arch/x86_64/kernel/vsyscall.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- clean-start.orig/arch/x86_64/kernel/vsyscall.c
+++ clean-start/arch/x86_64/kernel/vsyscall.c
@@ -73,7 +73,7 @@ static __always_inline void do_vgettimeo
 		usec =3D __xtime.tv_nsec / 1000;
 =

 		if (__vxtime.mode !=3D VXTIME_HPET) {
-			t =3D get_cycles_sync();
+			t =3D vget_cycles_sync();
 			if (t < __vxtime.last_tsc)
 				t =3D __vxtime.last_tsc;
 			usec +=3D ((t - __vxtime.last_tsc) *
@@ -147,8 +147,8 @@ time_t __vsyscall(1) vtime(time_t *t)
 long __vsyscall(2)
 vgetcpu(unsigned *cpu, unsigned *node, struct getcpu_cache *tcache)
 {
-	unsigned int dummy, p;
-	unsigned long j =3D 0;
+	unsigned int p;
+	unsigned long dummy, j =3D 0;
 =

 	/* Fast cache - only recompute value once per jiffies and avoid
 	   relatively costly rdtscp/cpuid otherwise.
@@ -162,7 +162,8 @@ vgetcpu(unsigned *cpu, unsigned *node, s
 		p =3D tcache->blob[1];
 	} else if (__vgetcpu_mode =3D=3D VGETCPU_RDTSCP) {
 		/* Load per CPU data from RDTSCP */
-		rdtscp(dummy, dummy, p);
+		/* rdtscp() cannot be called due to the paravirt indirection */
+		asm("rdtscp" : "=3DA" (dummy), "=3Dc" (p));
 	} else {
 		/* Load per CPU data from GDT */
 		asm("lsl %1,%0" : "=3Dr" (p) : "r" (__PER_CPU_SEG));
@@ -256,7 +257,11 @@ static void __cpuinit vsyscall_set_cpu(i
 	node =3D cpu_to_node[cpu];
 #endif
 	if (cpu_has(&cpu_data[cpu], X86_FEATURE_RDTSCP))
-		write_rdtscp_aux((node << 12) | cpu);
+		/* This is write_rdtscp_aux. It cannot be called directly
+		 * due to the paravirt indirection */
+		asm("wrmsr"  :  /* no output */
+			     :  "d"(0),
+				"a" ((node << 12) | cpu), "c" (0xc0000103));
 =

 	/* Store cpu number in limit so that it can be loaded quickly
 	   in user space in vgetcpu.
@@ -285,8 +290,12 @@ cpu_vsyscall_notifier(struct notifier_bl
 =

 static void __init map_vsyscall(void)
 {
+#ifndef CONFIG_PARAVIRT
 	extern char __vsyscall_0;
 	unsigned long physaddr_page0 =3D __pa_symbol(&__vsyscall_0);
+#else
+	unsigned long physaddr_page0 =3D __pa_symbol(paravirt_ops.vsyscall_page);
+#endif
 =

 	/* Note that VSYSCALL_MAPPED_PAGES must agree with the code below. */
 	__set_fixmap(VSYSCALL_FIRST_PAGE, physaddr_page0, PAGE_KERNEL_VSYSCALL);
@@ -299,7 +308,14 @@ static int __init vsyscall_init(void)
 	BUG_ON((unsigned long) &vtime !=3D VSYSCALL_ADDR(__NR_vtime));
 	BUG_ON((VSYSCALL_ADDR(0) !=3D __fix_to_virt(VSYSCALL_FIRST_PAGE)));
 	BUG_ON((unsigned long) &vgetcpu !=3D VSYSCALL_ADDR(__NR_vgetcpu));
-	map_vsyscall();
+#ifdef CONFIG_PARAVIRT
+	if (paravirt_ops.vsyscall_page)
+#endif
+		map_vsyscall();
+#ifdef CONFIG_PARAVIRT
+	else
+		__sysctl_vsyscall =3D 0;
+#endif
 #ifdef CONFIG_SYSCTL
 	register_sysctl_table(kernel_root_table2, 0);
 #endif

--
