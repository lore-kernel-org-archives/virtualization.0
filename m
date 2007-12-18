From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 21/21] [PATCH] finish processor.h integration
Date: Tue, 18 Dec 2007 14:38:18 +0100
Message-ID: <20071218133818.GA9941__45569.528771057$1197985432$gmane$org@elte.hu>
References: <11979320302030-git-send-email-gcosta@redhat.com>
	<11979320354186-git-send-email-gcosta@redhat.com>
	<11979320401316-git-send-email-gcosta@redhat.com>
	<11979320451308-git-send-email-gcosta@redhat.com>
	<1197932050948-git-send-email-gcosta@redhat.com>
	<11979320551036-git-send-email-gcosta@redhat.com>
	<11979320603229-git-send-email!-gcosta@redhat.com>
	<11979320653161-git-send-email-gcosta@redhat.com>
	<11979320693300-git-send-email-gcosta@redhat.com>
	<20071218131932.GA9457@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20071218131932.GA9457@elte.hu>
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
Cc: ehabkost@redhat.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, chrisw@sous-sol.org, anthony@codemonkey.ws, hpa@zytor.com, akpm@linux-foundation.org, tglx@linutronix.de, roland@redhat.com, ak@suse.de
List-Id: virtualization@lists.linuxfoundation.org


* Ingo Molnar <mingo@elte.hu> wrote:

> > What's left in processor_32.h and processor_64.h cannot be cleanly 
> > integrated. However, it's just a couple of definitions. They are 
> > moved to processor.h around ifdefs, and the original files are 
> > deleted. Note that there's much less headers included in the final 
> > version.
> 
> and this patch breaks the build on the attached config, with:
> 
>    CC      arch/x86/mm/boot_ioremap_32.o
>  In file included from include/asm/fixmap_32.h:28,
>                   from include/asm/fixmap.h:2,
>                   from include/asm/pgtable_32.h:16,
>                   from include/asm/pgtable.h:2,
>                   from arch/x86/mm/boot_ioremap_32.c:21:
>  include/asm/acpi.h:159: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'acpi_fake_nodes'
>  make[1]: *** [arch/x86/mm/boot_ioremap_32.o] Error 1
>  make: *** [arch/x86/mm/boot_ioremap_32.o] Error 2

really, please do _much_ more careful unification. We unified two full 
architectures in .24-rc1 and there was _not a single regression_ due to 
that unification. Not a single build failure, not a single boot or 
runtime failure.

here the problem is apparently caused by your patch, a careless 
'unification' of include file sections. 32-bit had this:

-#include <asm/vm86.h>
-#include <asm/math_emu.h>
-#include <asm/segment.h>
-#include <asm/page.h>
-#include <asm/types.h>
-#include <asm/sigcontext.h>
-#include <asm/cpufeature.h>
-#include <asm/msr.h>
-#include <asm/system.h>
-#include <linux/threads.h>
-#include <linux/init.h>
-#include <asm/desc_defs.h>

64-bit had this:

-#include <asm/segment.h>
-#include <asm/page.h>
-#include <asm/types.h>
-#include <asm/sigcontext.h>
-#include <asm/cpufeature.h>
-#include <linux/threads.h>
-#include <asm/msr.h>
-#include <asm/current.h>
-#include <asm/system.h>
-#include <linux/personality.h>
-#include <asm/desc_defs.h>

and the 'unified' processor.h has:

+#include <asm/desc_defs.h>
+#include <asm/msr.h>
 #include <asm/page.h>
 #include <asm/percpu.h>
 #include <asm/system.h>
 #include <asm/percpu.h>
 #include <linux/cpumask.h>
 #include <linux/cache.h>
+#include <linux/personality.h>

Those are visible, _crutial_ differences totally unmentioned in the 
patch.

yes, our include file dependencies are a jungle, the differences between 
32-bit and 64-bit are arbitrary in 80% of the cases, but still there's 
no reason why this couldnt be done correctly. The patch below is a quick 
bandaid that adds the missing bits.

	Ingo

------------------>
Subject: x86: fix include file mess
From: Ingo Molnar <mingo@elte.hu>

fix include file mess.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 include/asm-x86/processor.h |   16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

Index: linux-x86.q/include/asm-x86/processor.h
===================================================================
--- linux-x86.q.orig/include/asm-x86/processor.h
+++ linux-x86.q/include/asm-x86/processor.h
@@ -6,15 +6,27 @@
 struct task_struct;
 struct mm_struct;
 
+#ifdef CONFIG_X86_32
+# include <asm/math_emu.h>
+# include <asm/vm86.h>
+#endif
+
+#include <asm/cpufeature.h>
+#include <asm/current.h>
 #include <asm/desc_defs.h>
 #include <asm/msr.h>
 #include <asm/page.h>
 #include <asm/percpu.h>
+#include <asm/segment.h>
+#include <asm/sigcontext.h>
 #include <asm/system.h>
-#include <asm/percpu.h>
-#include <linux/cpumask.h>
+#include <asm/types.h>
+
 #include <linux/cache.h>
+#include <linux/cpumask.h>
+#include <linux/init.h>
 #include <linux/personality.h>
+#include <linux/threads.h>
 
 /*
  * Default implementation of macro that returns current
