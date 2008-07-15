From: Zachary Amsden <zach@vmware.com>
Subject: Re: [PATCH] x86: let 32bit use apic_ops too - fix
Date: Tue, 15 Jul 2008 12:19:42 -0700
Message-ID: <1216149582.6620.194.camel@bodhitayantram.eng.vmware.com>
References: <1216147130.6620.184.camel@bodhitayantram.eng.vmware.com>
	 <20080715185123.GA31445@linux-os.sc.intel.com>
	 <1216148658.6620.192.camel@bodhitayantram.eng.vmware.com>
	 <86802c440807151210m37398d7es2e07f9d9b834363@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1762994AbYGOTVA@vger.kernel.org>
In-Reply-To: <86802c440807151210m37398d7es2e07f9d9b834363@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yinghai Lu <yhlu.kernel@gmail.com>
Cc: Suresh Siddha <suresh.b.siddha@intel.com>, Chris Wright <chrisw@sous-sol.org>, Jeremy Fitzhardinge <jeremy@goop.org>, Rusty Russell <rusty@rustcorp.com.au>, virtualization <virtualization@lists.osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 2008-07-15 at 12:10 -0700, Yinghai Lu wrote:
> On Tue, Jul 15, 2008 at 12:04 PM, Zachary Amsden <zach@vmware.com> wrote:
> > On Tue, 2008-07-15 at 11:51 -0700, Suresh Siddha wrote:
> >> On Tue, Jul 15, 2008 at 11:38:50AM -0700, Zachary Amsden wrote:
> >> >
> >> > Nacked-by: Zachary Amsden <zach@vmware.com>
> >> >
> >> > What are you doing here and why aren't you cc-ing the maintainers?
> >>
> >> Sorry. I was about to bring you into the loop.
> >>
> >> Yinghai posted 32bit native apic_ops(similar to my 64bit apic ops patch, which
> >> is different from pv_apic_ops) which is in tip/x86/x2apic and proposed a fix
> >> for VMI case aswell.
> >>
> >> Based on my understanding, tip/x86/x2apic git commit
> >> 94a8c3c2437c8946f1b6c8e0b2c560a7db8ed3c6 is wrong and it should be fixed with
> >> something like
> >> http://marc.info/?l=linux-kernel&m=121614328831237&w=2


Suresh's patch looks good.  Thanks Suresh!

Acked-by: Zachary Amsden <zach@vmware.com>
