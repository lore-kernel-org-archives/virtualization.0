From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: proposed interface change for setting the ldt
Date: Sat, 19 Aug 2006 03:39:41 +0100
Message-ID: <44E679ED.6010300@goop.org>
References: <44E599A3.6020907@goop.org> <44E621BA.6090001@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <44E621BA.6090001@vmware.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Zachary Amsden <zach@vmware.com>
Cc: Chris Wright <chrisw@sous-sol.org>, Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

Zachary Amsden wrote:
> This interface doesn't work for anything other than Xen.

It works OK for native.  It's a very simple rolling together of two =

operations which always happen together anyway.

> It is impossible to implement it without specific knowledge of kernel =

> internals, since it doesn't provide the GDT selector for the LDT.

Neither does the previous interface.  load_ldt_desc needs to have the =

specific LDT entry hardcoded into it.

>   Now everything that looks like real hardware needs to move the =

> knowledge of the LDT structure into paravirt-ops, =


Do you mean the GDT structure?

> and it has no clear calling convention, so you've now got to reason =

> about SMP preemption correctness inside the paravirt-op, instead of at =

> the higher level where it should be done.

The previous interface already required that preempt be disabled around =

those functions.  In the previous interface, set_ldt_desc takes a cpu =

number, but it is required to equal the current cpu; load_ldt_desc =

always operates on the current CPU.  It therefore requires that those =

two ops be paired with preempt disabled.  The new interface is simpler, =

but still requires preempt disabled around it.

In general, the set_ldt interface is cleaner for the base kernel, and =

much cleaner for Xen, while being trivial to implement for native =

hardware or something which looks like it.

    J
