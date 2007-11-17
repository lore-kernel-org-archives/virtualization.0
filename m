From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 5/24] smp x86 consolidation
Date: Sat, 17 Nov 2007 10:32:25 +0100
Message-ID: <20071117093224.GA32256__49540.5632457279$1195492647$gmane$org@elte.hu>
References: <11946337851964-git-send-email-gcosta@redhat.com>
	<11946337933104-git-send-email-gcosta@redhat.com>
	<11946337991750-git-send-email-gcosta@redhat.com>
	<11946338053158-git-send-email-gcosta@redhat.com>
	<11946338103068-git-send-email-gcosta@redhat.com>
	<1194633815833-git-send-email-gcosta@redhat.com>
	<4734FB67.8080500@goop.org> <4735098B.7040305@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4735098B.7040305@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Glauber de Oliveira Costa <gcosta@redhat.com>
Cc: lguest@ozlabs.org, kvm-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, chrisw@sous-sol.org, anthony@codemonkey.ws, tglx@linutronix.de, akpm@linux-foundation.org, ak@suse.de
List-Id: virtualization@lists.linuxfoundation.org


* Glauber de Oliveira Costa <gcosta@redhat.com> wrote:

> > I'm getting link errors in 32-bit:
> > 
> > arch/x86/kernel/built-in.o: In function `native_smp_send_reschedule':
> > /home/jeremy/hg/xen/paravirt/linux/arch/x86/kernel/smpcommon.c:262: undefined reference to `genapic'
> > arch/x86/kernel/built-in.o: In function `native_smp_call_function_mask':
> > /home/jeremy/hg/xen/paravirt/linux/arch/x86/kernel/smpcommon.c:113: undefined reference to `genapic'
> > 
> Ok, it compiled just fine here. I bet it's due to  one of that i386 lots
> of variants.

this patch is causing build failures all around the place. It does not 
build on CONFIG_X86_SUMMIT, it does not build if CONFIG_X86_GENERICARCH 
is turned off, etc. It does not even build on UP - fix for that is 
attached below. I've dropped this patch for now.

	Ingo

-------------->
Subject: x86: fix build error
From: Ingo Molnar <mingo@elte.hu>

fix build error on !CONFIG_SMP.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/asm-x86/smp.h |    2 ++
 1 file changed, 2 insertions(+)

Index: linux/include/asm-x86/smp.h
===================================================================
--- linux.orig/include/asm-x86/smp.h
+++ linux/include/asm-x86/smp.h
@@ -2,6 +2,7 @@
 #define _X86_SMP_H_
 
 #ifndef __ASSEMBLY__
+#ifdef CONFIG_SMP
 struct smp_ops
 {
 	void (*smp_prepare_boot_cpu)(void);
@@ -55,6 +56,7 @@ void native_smp_prepare_boot_cpu(void);
 void native_smp_prepare_cpus(unsigned int max_cpus);
 int native_cpu_up(unsigned int cpunum);
 void native_smp_cpus_done(unsigned int max_cpus);
+#endif
 
 #ifndef CONFIG_PARAVIRT
 #define startup_ipi_hook(phys_apicid, start_eip, start_esp) 		\
