From: Zachary Amsden <zach@vmware.com>
Subject: Re: [PATCH] x86: let 32bit use apic_ops too - fix
Date: Tue, 15 Jul 2008 12:24:41 -0700
Message-ID: <1216149881.6620.197.camel@bodhitayantram.eng.vmware.com>
References: <1216147130.6620.184.camel@bodhitayantram.eng.vmware.com>
	 <20080715185123.GA31445@linux-os.sc.intel.com>
	 <86802c440807151222o541514c5n33c4179b84457637@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1762262AbYGOTZv@vger.kernel.org>
In-Reply-To: <86802c440807151222o541514c5n33c4179b84457637@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yinghai Lu <yhlu.kernel@gmail.com>
Cc: Suresh Siddha <suresh.b.siddha@intel.com>, Jeremy Fitzhardinge <jeremy@goop.org>, Chris Wright <chrisw@sous-sol.org>, Rusty Russell <rusty@rustcorp.com.au>, virtualization <virtualization@lists.osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 2008-07-15 at 12:22 -0700, Yinghai Lu wrote:
> On Tue, Jul 15, 2008 at 11:51 AM, Suresh Siddha
> <suresh.b.siddha@intel.com> wrote:
> > On Tue, Jul 15, 2008 at 11:38:50AM -0700, Zachary Amsden wrote:
> >>
> >> Nacked-by: Zachary Amsden <zach@vmware.com>
> >>
> >> What are you doing here and why aren't you cc-ing the maintainers?
> >
> > Sorry. I was about to bring you into the loop.
> >
> > Yinghai posted 32bit native apic_ops(similar to my 64bit apic ops patch, which
> > is different from pv_apic_ops) which is in tip/x86/x2apic and proposed a fix
> > for VMI case aswell.
> >
> > Based on my understanding, tip/x86/x2apic git commit
> > 94a8c3c2437c8946f1b6c8e0b2c560a7db8ed3c6 is wrong and it should be fixed with
> > something like
> > http://marc.info/?l=linux-kernel&m=121614328831237&w=2
> >
> > Can you please check and Ack/Nack this fix?
> 
> how about xen pv with icr related?

Xen doesn't have an APIC; they should be fine as is I think.

Zach
