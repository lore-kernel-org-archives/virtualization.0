From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: Per-cpu patches on top of PDA stuff...
Date: Tue, 19 Sep 2006 13:39:21 -0700
Message-ID: <45105579.1070901@goop.org>
References: <1158635617.21726.8.camel@localhost.localdomain>
	<1158653031.23629.1.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <1158653031.23629.1.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Andrew Morton <akpm@osdl.org>, virtualization <virtualization@lists.osdl.org>, Ingo Molnar <mingo@elte.hu>, Andi Kleen <ak@muc.de>
List-Id: virtualization@lists.linuxfoundation.org

Rusty Russell wrote:
> This patch uses the "gs" segment register which Jeremy Fitzhardinge
> freed up for kernel use, for the per-cpu section.  This means that
> instead of having a special per-cpu struct which we can access in a
> single instruction, any per-cpu variable can be accessed in a single
> instruction.  In addition, it avoids introducing the concept of a
> "pda" into the kernel, in favour of the well-known "percpu" concept.
>   =


The PDA is well established in the x86-64 tree; one of the reasons for =

having an x86-32 PDA was to make the trees a bit more similar.

> More cleanups/optimizations are possible:
> 1) Don't save/restore %gs on UP.  The cost is measurable, and we don't us=
e it.
>   =


You need to make sure the userspace %gs gets saved/restored for context =

switch.  If you don't do it in entry.S, you need to have two versions of =

the %gs-handling code in a number of places around the kernel =

(__switch_to, vm86, ptrace).

> 2) Remove early_smp_processor_id(), by setting up the per-cpu
>    processor_id field correctly before starting a CPU.
> 3) Similarly, get rid of early_current().
>   =


I've already submitted a patch to do this.  In fact, it would help if =

you could rebase against my most recent patches (which I think Andrew =

has queued for the next -mm, and are in the paravirt patch queue).

Also, does this patch address the problem of percpu module variables?  =

That was the only real sticking point with my previous percpu-in-pda patch.

I can't say this patch fills me with joy.

    J
