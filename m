From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] Fix preemptible lazy mode bug
Date: Thu, 6 Sep 2007 06:41:36 +0100
Message-ID: <200709060641.36855.ak@suse.de>
References: <46CE70C8.2030005@vmware.com> <1189024666.10802.197.camel@localhost.localdomain> <1189036175.21516.31.camel@bodhitayantram.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758050AbXIFFmy@vger.kernel.org>
In-Reply-To: <1189036175.21516.31.camel@bodhitayantram.eng.vmware.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Zachary Amsden <zach@vmware.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Linus Torvalds <torvalds@osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>, Jeremy Fitzhardinge <jeremy@goop.org>, Chris Wright <chrisw@sous-sol.org>, stable@kernel.org, Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

>I agree.  The patch is a nop.  I just got overly paranoid.  The whole
>thing is just very prone to bugs.
So do we need a patch for .23 or not?

>; it does
> seem perfectly acceptable though for the mm code to use kmap or vmap
> (not kmap_atomic) internally somewhere in the pagetable code.

i386 does it all the time for highmem pagetables in fact.

-Andi
