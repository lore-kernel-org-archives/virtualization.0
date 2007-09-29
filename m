From: "Nakajima, Jun" <jun.nakajima@intel.com>
Subject: RE: [PATCH RFC] paravirt_ops: refactor struct paravirt_ops into smaller pv_*_ops
Date: Sat, 29 Sep 2007 09:55:05 -0700
Message-ID: <97D612E30E1F88419025B06CB4CF1BE1039B6DDB@scsmsx412.amr.corp.intel.com>
References: <46FD4388.6000106@goop.org> <97D612E30E1F88419025B06CB4CF1BE10396C957@scsmsx412.amr.corp.intel.com> <46FD8FE1.4090507@goop.org> <97D612E30E1F88419025B06CB4CF1BE1039B6D3E@scsmsx412.amr.corp.intel.com> <46FD9EFE.5040004@goop.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757871AbXI2QzX@vger.kernel.org>
Content-class: urn:content-classes:message
In-Reply-To: <46FD9EFE.5040004@goop.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andi Kleen <ak@suse.de>, Zachary Amsden <zach@vmware.com>, Rusty Russell <rusty@rustcorp.com.au>, Avi Kivity <avi@qumranet.com>, Glauber de Oliveira Costa <glommer@gmail.com>, Anthony Liguori <anthony@codemonkey.ws>, Virtualization Mailing List <virtualization@lists.osdl.org>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: virtualization@lists.linuxfoundation.org

Jeremy Fitzhardinge wrote:
> Nakajima, Jun wrote:
> > Yes. For the native, "safe_halt" is "sti; hlt". The "native_halt" is
> > just "hlt". So the para_virt part of "hlt" could be moved to
pv_cpu_ops,
> > and the "sti" part stays in pv_irq_ops.
> > 
> 
> By "sti part", you mean the full "sti; hlt" sequence of safe_halt,
> right?  Since it needs to be an atomic sequence to avoid race
> conditions, so the native sequence has to be precisely "sti; hlt" to
> take advantage of the sti shadow, and other pv-backends will need
their
> own way to guarantee this atomicity.

To me such atomicity is provided by the "sti" instruction (i.e. the
processor begins responding to external, maskable interrupts _after_ the
next instruction is executed), and there is nothing special with that
combination "sti; hlt" (you can also have like "sti; ret", for example).
So if you define a PV ops like STI(next_instruction), "safe_halt" for
the native should be defined as STI("hlt"), and inlined as "sti; hlt". 

If it's hard or we don't need to expose the semantics of "sti" other
than that, I think it's okay to have a PV operation for safe_halt.

Jun
---
Intel Open Source Technology Center
