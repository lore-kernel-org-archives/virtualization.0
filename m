From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH RFC] paravirt_ops: refactor struct paravirt_ops into smaller
 pv_*_ops
Date: Sat, 29 Sep 2007 10:01:18 -0700
Message-ID: <46FE84DE.4090705@goop.org>
References: <46FD4388.6000106@goop.org> <97D612E30E1F88419025B06CB4CF1BE10396C957@scsmsx412.amr.corp.intel.com> <46FD8FE1.4090507@goop.org> <97D612E30E1F88419025B06CB4CF1BE1039B6D3E@scsmsx412.amr.corp.intel.com> <46FD9EFE.5040004@goop.org> <97D612E30E1F88419025B06CB4CF1BE1039B6DDB@scsmsx412.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757865AbXI2RBd@vger.kernel.org>
In-Reply-To: <97D612E30E1F88419025B06CB4CF1BE1039B6DDB@scsmsx412.amr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Nakajima, Jun" <jun.nakajima@intel.com>
Cc: Andi Kleen <ak@suse.de>, Zachary Amsden <zach@vmware.com>, Rusty Russell <rusty@rustcorp.com.au>, Avi Kivity <avi@qumranet.com>, Glauber de Oliveira Costa <glommer@gmail.com>, Anthony Liguori <anthony@codemonkey.ws>, Virtualization Mailing List <virtualization@lists.osdl.org>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: virtualization@lists.linuxfoundation.org

Nakajima, Jun wrote:
> To me such atomicity is provided by the "sti" instruction (i.e. the
> processor begins responding to external, maskable interrupts _after_ the
> next instruction is executed), and there is nothing special with that
> combination "sti; hlt" (you can also have like "sti; ret", for example).
>   

Sure, but there's no particular value in "sti; ret".  While the sti mask
window works everywhere, its only cases like "sti; hlt" where it's
needed to avoid a race condition.

> So if you define a PV ops like STI(next_instruction), "safe_halt" for
> the native should be defined as STI("hlt"), and inlined as "sti; hlt". 
>   

That's only meaningful if the pv_op is implemented directly in x86
instructions - ie, the native (or almost native) case.

> If it's hard or we don't need to expose the semantics of "sti" other
> than that, I think it's okay to have a PV operation for safe_halt.
>   

Yeah, the general form would be hard to support for a hypervisor.  Xen,
for example, has an "atomically enable events and block" operation, but
no other "atomically enable events and do X" operations.

    J
