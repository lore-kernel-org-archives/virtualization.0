From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] Simplify smp_call_function*() by using common implementation
Date: Wed, 28 Mar 2007 21:22:22 +0200
Message-ID: <200703282122.22869.ak@suse.de>
References: <46099709.2000304@goop.org> <200703282103.50191.ak@suse.de> <460ABF84.5060201@goop.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752630AbXC1TW1@vger.kernel.org>
In-Reply-To: <460ABF84.5060201@goop.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, Jan Beulich <jbeulich@novell.com>, Stephane Eranian <eranian@hpl.hp.com>, Ingo Molnar <mingo@elte.hu>, "Randy.Dunlap" <rdunlap@xenotime.net>
List-Id: virtualization@lists.linuxfoundation.org

On Wednesday 28 March 2007 21:18, Jeremy Fitzhardinge wrote:
> Andi Kleen wrote:
> > On Wednesday 28 March 2007 00:13, Jeremy Fitzhardinge wrote:
> >   
> >> smp_call_function and smp_call_function_single are almost complete
> >> duplicates of the same logic.  This patch combines them by
> >> implementing them in terms of the more general
> >> smp_call_function_mask().
> >>     
> >
> > I think I got those already.
> >   
> 
> OK.  Do you have smp_ops and machine_ops?

Not yet. Can you resend the current set?

> There's a doc update patch too:

Can you send that separately after i sync out please?

Thanks

-Andi
