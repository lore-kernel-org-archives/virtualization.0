From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] Add machine_ops interface  to abstract halting and rebooting
Date: Wed, 28 Mar 2007 21:54:04 +0200
Message-ID: <200703282154.04245.ak@suse.de>
References: <46099709.2000304@goop.org> <200703282143.53037.ak@suse.de> <460AC665.2090705@goop.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S965736AbXC1TyK@vger.kernel.org>
In-Reply-To: <460AC665.2090705@goop.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, Jan Beulich <jbeulich@novell.com>, Stephane Eranian <eranian@hpl.hp.com>, Ingo Molnar <mingo@elte.hu>, "Randy.Dunlap" <rdunlap@xenotime.net>
List-Id: virtualization@lists.linuxfoundation.org

On Wednesday 28 March 2007 21:47, Jeremy Fitzhardinge wrote:
> Andi Kleen wrote:
> > On Wednesday 28 March 2007 21:32, Jeremy Fitzhardinge wrote:
> >   
> >> machine_ops is an interface for the machine_* functions defined in
> >> <linux/reboot.h>.  This is intended to allow hypervisors to intercept
> >> the reboot process, but it could be used to implement other x86
> >> subarchtecture reboots.
> >>     
> >
> > Both patches added thanks
> >   
> 
> I presume you've also got the reboot-fixups cleanup patch?

No, please resend too

-Andi
