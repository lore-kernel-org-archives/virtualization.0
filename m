From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH RFC] paravirt_ops: refactor struct paravirt_ops into smaller
 pv_*_ops
Date: Fri, 28 Sep 2007 17:40:30 -0700
Message-ID: <46FD9EFE.5040004@goop.org>
References: <46FD4388.6000106@goop.org> <97D612E30E1F88419025B06CB4CF1BE10396C957@scsmsx412.amr.corp.intel.com> <46FD8FE1.4090507@goop.org> <97D612E30E1F88419025B06CB4CF1BE1039B6D3E@scsmsx412.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756941AbXI2Akp@vger.kernel.org>
In-Reply-To: <97D612E30E1F88419025B06CB4CF1BE1039B6D3E@scsmsx412.amr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Nakajima, Jun" <jun.nakajima@intel.com>
Cc: Andi Kleen <ak@suse.de>, Zachary Amsden <zach@vmware.com>, Rusty Russell <rusty@rustcorp.com.au>, Avi Kivity <avi@qumranet.com>, Glauber de Oliveira Costa <glommer@gmail.com>, Anthony Liguori <anthony@codemonkey.ws>, Virtualization Mailing List <virtualization@lists.osdl.org>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: virtualization@lists.linuxfoundation.org

Nakajima, Jun wrote:
> Yes. For the native, "safe_halt" is "sti; hlt". The "native_halt" is
> just "hlt". So the para_virt part of "hlt" could be moved to pv_cpu_ops,
> and the "sti" part stays in pv_irq_ops.
>   

By "sti part", you mean the full "sti; hlt" sequence of safe_halt,
right?  Since it needs to be an atomic sequence to avoid race
conditions, so the native sequence has to be precisely "sti; hlt" to
take advantage of the sti shadow, and other pv-backends will need their
own way to guarantee this atomicity.

But I'm quite happy to put plain "hlt" into cpu_ops as halt_cpu() or
something (and perhaps rename safe_halt to something a bit more
descriptive).

> Actually my concern was that such misc ops might grow to include the
> things don't fit well anywhere else. To me, then pv_lazy_ops (with just
> .set_mode) might be better.
>   

The lazy interface has needed a rethink anyway.

    J
