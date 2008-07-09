From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [patch] x86, paravirt-spinlocks: fix boot hang
Date: Wed, 09 Jul 2008 08:55:43 -0700
Message-ID: <4874DF7F.4080204__10697.3784663298$1215619174$gmane$org@goop.org>
References: <20080707190749.299430659@goop.org>
	<20080709122852.GA30579@elte.hu> <20080709133358.GA7005@elte.hu>
	<20080709134944.GA15190@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20080709134944.GA15190@elte.hu>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Jens Axboe <axboe@kernel.dk>, Nick Piggin <nickpiggin@yahoo.com.au>, Xen devel <xen-devel@lists.xensource.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Christoph Lameter <clameter@linux-foundation.org>, the arch/x86 maintainers <x86@kernel.org>, Petr Tesarik <ptesarik@suse.cz>, LKML <linux-kernel@vger.kernel.org>, Virtualization <virtualization@lists.linux-foundation.org>, Thomas Friebel <thomas.friebel@amd.com>
List-Id: virtualization@lists.linuxfoundation.org

Ingo Molnar wrote:
> * Ingo Molnar <mingo@elte.hu> wrote:
>
>   
>> the patches caused a boot hang with this config:
>>
>>  http://redhat.com/~mingo/misc/config-Wed_Jul__9_14_47_04_CEST_2008.bad
>>     
>
> ok, fixed it via the patch below.
>
> 	Ingo
>
> -------------->
> commit 6412367fe22dc54cc727e7bec5bd65c36c1a0754
> Author: Ingo Molnar <mingo@elte.hu>
> Date:   Wed Jul 9 15:42:09 2008 +0200
>
>     x86, paravirt-spinlocks: fix boot hang
>     
>     the paravirt-spinlock patches caused a boot hang with this config:
>     
>      http://redhat.com/~mingo/misc/config-Wed_Jul__9_14_47_04_CEST_2008.bad
>     
>     i have bisected it down to:
>     
>     |  commit e17b58c2e85bc2ad2afc07fb8d898017c2b75ed1
>     |  Author: Jeremy Fitzhardinge <jeremy@goop.org>
>     |  Date:   Mon Jul 7 12:07:53 2008 -0700
>     |
>     |      xen: implement Xen-specific spinlocks
>     
>     i.e. applying that patch alone causes the hang. The hang happens in the
>     ftrace self-test:
>     
>       initcall utsname_sysctl_init+0x0/0x19 returned 0 after 0 msecs
>       calling  init_sched_switch_trace+0x0/0x4c
>       Testing tracer sched_switch: PASSED
>       initcall init_sched_switch_trace+0x0/0x4c returned 0 after 167 msecs
>       calling  init_function_trace+0x0/0x12
>       Testing tracer ftrace:
>       [hard hang]
>     
>     it should have continued like this:
>     
>       Testing tracer ftrace: PASSED
>       initcall init_function_trace+0x0/0x12 returned 0 after 198 msecs
>       calling  init_irqsoff_tracer+0x0/0x14
>       Testing tracer irqsoff: PASSED
>       initcall init_irqsoff_tracer+0x0/0x14 returned 0 after 3 msecs
>       calling  init_mmio_trace+0x0/0x12
>       initcall init_mmio_trace+0x0/0x12 returned 0 after 0 msecs
>     
>     the problem is that such lowlevel primitives as spinlocks should never
>     be built with -pg (which ftrace does). Marking paravirt.o as non-pg and
>     marking all spinlock ops as always-inline solve the hang.
>    

Thanks Ingo, that would have taken me a while to work out.

Presumably that means that xen/smp.o should also be built without -pg.  
In fact, should I move the spinlock code into its own file, so that 
ftrace can cover as much as it can?

    J
