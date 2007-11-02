From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [Lguest] [PATCH 3/16] read/write_crX, clts and wbinvd for	64-bit
 paravirt
Date: Thu, 01 Nov 2007 18:21:25 -0700
Message-ID: <472A7B95.2030001__13832.6594759294$1193966626$gmane$org@goop.org>
References: <C34FAA4C.17CA9%Keir.Fraser@cl.cam.ac.uk>	<472A0FBF.6040907@goop.org>
	<1193936113.29447.56.camel@bodhitayantram.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1193936113.29447.56.camel@bodhitayantram.eng.vmware.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Zachary Amsden <zach@vmware.com>
Cc: kvm-devel@lists.sourceforge.net, mingo@elte.hu, ak@suse.de, linux-kernel@vger.kernel.org, Keir Fraser <Keir.Fraser@cl.cam.ac.uk>, tglx@linutronix.de, anthony@codemonkey.ws, lguest@ozlabs.org, Glauber de Oliveira Costa <gcosta@redhat.com>, virtualization@lists.linux-foundation.org, akpm@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Zachary Amsden wrote:
> I understood it as reordering was permitted, but no re-ordering across
> another volatile load, store, or asm was permitted.

It doesn't say that, so I wouldn't assume it.  Certainly we had problems
with the pda code; until I added the _proxy_pda dependency variable, the
only fix Andi could find was adding both "volatile" and a memory clobber.

>   And of course, as
> long as input and output constraints are written properly, the
> re-ordering should not be vulnerable to pathological movement causing
> the code to malfunction.
>   

Yes.  I think constraints are the only way to control ordering (even if
it's as heavy-handed as a memory clobber).  It would be nice if gcc had
a constraint which was only used for ordering, and never generated a
reference.  Then you could make up pseudo-variables in order to express
dependencies without having the risk that the compiler would generate
references.

> It seems that CPU state side effects which can't be expressed in C need
> special care - FPU is certainly one example.
>   

Not an immediate problem, fortunately.

> Also, memory clobber on a volatile asm should stop invalid movement
> across TLB flushes and other problems areas.

Yes.  Any asm which has global effects on how addresses are interpreted
(like tlbflush, reloading the pagetable base, changing modes, etc) needs
to have a memory clobber.

>   Even memory fences should
> have memory clobber in order to stop movement of loads and stores across
> the fence by the compiler.
>   

Pretty sure they do.  A normal compiler barrier is *just* a memory clobber.

    J
