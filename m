From: Ingo Molnar <mingo@elte.hu>
Subject: [patch] x86, paravirt-spinlocks: fix boot hang (was: Re: [PATCH
	RFC 0/4] Paravirtual spinlocks)
Date: Wed, 9 Jul 2008 15:49:44 +0200
Message-ID: <20080709134944.GA15190__11984.3014552773$1215611664$gmane$org@elte.hu>
References: <20080707190749.299430659@goop.org>
	<20080709122852.GA30579@elte.hu> <20080709133358.GA7005@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20080709133358.GA7005@elte.hu>
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
Cc: Jens Axboe <axboe@kernel.dk>, Nick Piggin <nickpiggin@yahoo.com.au>, Xen devel <xen-devel@lists.xensource.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Christoph Lameter <clameter@linux-foundation.org>, the arch/x86 maintainers <x86@kernel.org>, Petr Tesarik <ptesarik@suse.cz>, LKML <linux-kernel@vger.kernel.org>, Virtualization <virtualization@lists.linux-foundation.org>, Thomas Friebel <thomas.friebel@amd.com>
List-Id: virtualization@lists.linuxfoundation.org


* Ingo Molnar <mingo@elte.hu> wrote:

> the patches caused a boot hang with this config:
> 
>  http://redhat.com/~mingo/misc/config-Wed_Jul__9_14_47_04_CEST_2008.bad

ok, fixed it via the patch below.

	Ingo

-------------->
commit 6412367fe22dc54cc727e7bec5bd65c36c1a0754
Author: Ingo Molnar <mingo@elte.hu>
Date:   Wed Jul 9 15:42:09 2008 +0200

    x86, paravirt-spinlocks: fix boot hang
    
    the paravirt-spinlock patches caused a boot hang with this config:
    
     http://redhat.com/~mingo/misc/config-Wed_Jul__9_14_47_04_CEST_2008.bad
    
    i have bisected it down to:
    
    |  commit e17b58c2e85bc2ad2afc07fb8d898017c2b75ed1
    |  Author: Jeremy Fitzhardinge <jeremy@goop.org>
    |  Date:   Mon Jul 7 12:07:53 2008 -0700
    |
    |      xen: implement Xen-specific spinlocks
    
    i.e. applying that patch alone causes the hang. The hang happens in the
    ftrace self-test:
    
      initcall utsname_sysctl_init+0x0/0x19 returned 0 after 0 msecs
      calling  init_sched_switch_trace+0x0/0x4c
      Testing tracer sched_switch: PASSED
      initcall init_sched_switch_trace+0x0/0x4c returned 0 after 167 msecs
      calling  init_function_trace+0x0/0x12
      Testing tracer ftrace:
      [hard hang]
    
    it should have continued like this:
    
      Testing tracer ftrace: PASSED
      initcall init_function_trace+0x0/0x12 returned 0 after 198 msecs
      calling  init_irqsoff_tracer+0x0/0x14
      Testing tracer irqsoff: PASSED
      initcall init_irqsoff_tracer+0x0/0x14 returned 0 after 3 msecs
      calling  init_mmio_trace+0x0/0x12
      initcall init_mmio_trace+0x0/0x12 returned 0 after 0 msecs
    
    the problem is that such lowlevel primitives as spinlocks should never
    be built with -pg (which ftrace does). Marking paravirt.o as non-pg and
    marking all spinlock ops as always-inline solve the hang.
    
    Signed-off-by: Ingo Molnar <mingo@elte.hu>

diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 2dd1ccd..faba669 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -7,10 +7,11 @@ extra-y                := head_$(BITS).o head$(BITS).o head.o init_task.o vmlinu
 CPPFLAGS_vmlinux.lds += -U$(UTS_MACHINE)
 
 ifdef CONFIG_FTRACE
-# Do not profile debug utilities
+# Do not profile debug and lowlevel utilities
 CFLAGS_REMOVE_tsc_64.o = -pg
 CFLAGS_REMOVE_tsc_32.o = -pg
 CFLAGS_REMOVE_rtc.o = -pg
+CFLAGS_REMOVE_paravirt.o = -pg
 endif
 
 #
