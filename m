From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH 6/10] lguest code: the little linux hypervisor.
Date: Fri, 9 Feb 2007 15:17:28 +0100
Message-ID: <20070209141728.GA26749@uranus.ravnborg.org>
References: <1171012296.2718.26.camel@localhost.localdomain> <1171012761.2718.40.camel@localhost.localdomain> <1171012827.2718.42.camel@localhost.localdomain> <200702091109.20061.ak@muc.de> <1171024771.2718.129.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1946472AbXBIORN@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1171024771.2718.129.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Andi Kleen <ak@muc.de>, virtualization@lists.osdl.org, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Feb 09, 2007 at 11:39:31PM +1100, Rusty Russell wrote:
> On Fri, 2007-02-09 at 11:09 +0100, Andi Kleen wrote:
> > On Friday 09 February 2007 10:20, Rusty Russell wrote:
> > > Unfortunately, we don't have the build infrastructure for "private"
> > > asm-offsets.h files, so there's a not-so-neat include in
> > > arch/i386/kernel/asm-offsets.c.
> > 
> > Ask the kbuild people to fix that? 
> > 
> > It indeed looks ugly.
> > 
> > I bet Xen et.al. could make good use of that too.
> 
> Yes.   I originally had the constants #defined in the header and a whole
> heap of BUILD_BUG_ON(XYZ_offset != offsetof(xyz)) in my module, which
> was even uglier (but at least contained in my code).
I do not quite see what you ask for.
Care to try to describe the problem a bit then I may look at it sometime.

[Heading for vacation in a few hours so no prompt reply]

	Sam
