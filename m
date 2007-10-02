From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH RFC] paravirt: cleanup lazy mode handling
Date: Mon, 01 Oct 2007 23:29:38 -0700
Message-ID: <4701E552.3070501@goop.org>
References: <470186C4.5080208@goop.org> <1191288858.6979.20.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754514AbXJBG3t@vger.kernel.org>
In-Reply-To: <1191288858.6979.20.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Virtualization Mailing List <virtualization@lists.osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>, Zachary Amsden <zach@vmware.com>, Avi Kivity <avi@qumranet.com>, Anthony Liguori <anthony@codemonkey.ws>, Glauber de Oliveira Costa <glommer@gmail.com>, "Nakajima, Jun" <jun.nakajima@intel.com>
List-Id: virtualization@lists.linuxfoundation.org

Rusty Russell wrote:
> That's good, but this code does lose on native because we no longer
> simply replace the entire thing with noops.
>
> Perhaps inverting this and having (inline) helpers is the way to go?
>   

I'm thinking that the overhead will be unmeasurably small, and its not
really worth any more complexity.  That's almost certainly true for lazy
mmu mode, but lazy cpu is used in the middle of a context switch, so
it's probably worth a bit more attention.

> I'm thinking something like:
>
> static inline void paravirt_enter_lazy(enum paravirt_lazy_mode mode)
> {
> 	BUG_ON(x86_read_percpu(paravirt_lazy_mode) != PARAVIRT_LAZY_NONE);
> 	BUG_ON(preemptible());
>
> 	x86_write_percpu(paravirt_lazy_mode, mode);
> }
>
> static inline void paravirt_exit_lazy(enum paravirt_lazy_mode mode)
> {
> 	BUG_ON(x86_read_percpu(paravirt_lazy_mode) != mode);
> 	BUG_ON(preemptible());
>
> 	x86_write_percpu(paravirt_lazy_mode, PARAVIRT_LAZY_NONE);
> }
>   

Er, they should probably call something to make the switch actually
happen, no?

> The only trick would be that the flushes are so rarely required it's
> probably worth putting the unlikely() in the top level:
>   

Sure, I guess.  Would it make any difference?  (I've never personally
noticed likely/unlikely change the generated code in any seriously
positive way.)

    J
