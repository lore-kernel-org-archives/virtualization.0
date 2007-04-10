From: Chris Wright <chrisw@sous-sol.org>
Subject: Re: paravirt repo rebased to 2.6.21-rc6-mm1
Date: Tue, 10 Apr 2007 16:48:34 -0700
Message-ID: <20070410234833.GU10574@sequoia.sous-sol.org>
References: <461C1C7B.5080509@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <461C1C7B.5080509@goop.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Chris Wright <chrisw@sous-sol.org>, Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

* Jeremy Fitzhardinge (jeremy@goop.org) wrote:
> Seems to work OK for native and Xen.  I had to play a bit with the
> paravirt-sched-clock patch to deal with the VMI changes.  Zach, can you
> check that it still works?

Cool, thanks for the rebase.  Here's some small fixes.

Minor issue with CONFIG_STACK_UNWIND in -mm vs. pda-to-percpu:

diff -r a5e50a2e914a include/asm-i386/unwind.h
--- a/include/asm-i386/unwind.h	Tue Apr 10 16:20:13 2007 -0700
+++ b/include/asm-i386/unwind.h	Tue Apr 10 16:34:58 2007 -0700
@@ -71,7 +71,7 @@ static inline void arch_unw_init_blocked
 	info->regs.xss =3D __KERNEL_DS;
 	info->regs.xds =3D __USER_DS;
 	info->regs.xes =3D __USER_DS;
-	info->regs.xfs =3D __KERNEL_PDA;
+	info->regs.xfs =3D __KERNEL_PERCPU;
 }
 =

 extern asmlinkage int arch_unwind_init_running(struct unwind_frame_info *,

Another issue when !SMP from xen-smp.patch.  leave_mm was SMP only before,
it basically still is except for one call from xen_exit_mmap().  This is
the simplest sol'n.


diff -r a5e50a2e914a include/asm-i386/mmu_context.h
--- a/include/asm-i386/mmu_context.h	Tue Apr 10 16:20:13 2007 -0700
+++ b/include/asm-i386/mmu_context.h	Tue Apr 10 16:45:58 2007 -0700
@@ -41,9 +41,11 @@ static inline void enter_lazy_tlb(struct
  */
 static inline void leave_mm (unsigned long cpu)
 {
+#ifdef CONFIG_SMP
 	if (per_cpu(cpu_tlbstate, cpu).state =3D=3D TLBSTATE_OK)
 		BUG();
 	cpu_clear(cpu, per_cpu(cpu_tlbstate, cpu).active_mm->cpu_vm_mask);
+#endif
 	load_cr3(swapper_pg_dir);
 }
 =
