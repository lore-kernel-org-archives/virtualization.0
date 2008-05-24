From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 0 of 4] mm+paravirt+xen: add pte read-modify-write
 abstraction
Date: Sat, 24 May 2008 10:25:43 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0805241022210.3081@woody.linux-foundation.org>
References: <patchbomb.1211552448@localhost> <alpine.LFD.1.10.0805231133130.3081@woody.linux-foundation.org> <48372C2F.1090704@goop.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1761200AbYEXR1S@vger.kernel.org>
In-Reply-To: <48372C2F.1090704@goop.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>, xen-devel <xen-devel@lists.xensource.com>, Thomas Gleixner <tglx@linutronix.de>, Hugh Dickins <hugh@veritas.com>, Zachary Amsden <zach@vmware.com>, kvm-devel <kvm-devel@lists.sourceforge.net>, Virtualization Mailing List <virtualization@lists.osdl.org>, Rusty Russell <rusty@rustcorp.com.au>, Peter Zijlstra <a.p.zijlstra@chello.nl>
List-Id: virtualization@lists.linuxfoundation.org



On Fri, 23 May 2008, Jeremy Fitzhardinge wrote:
> 
> Well, you could use it to update the page and protection bits while preserving
> the AD bits, but I don't think that's very useful.

It's not that it's not "very useful" - it's that it would be TOTALLY 
WRONG.

If you change the page and the AD bits can change randomly while you do 
so, that means that the AD bits are now _undefined_. Which of the two 
pages did it happen to? The old one? The new one? Nobody can know. So 
you'd effectively have dirty bits that could be associated with the wrong 
physical page, which means that some page may be dirty, but the kernel 
would have it marked clean.

That would be beyond bad. That would be a *serious* VM bug, with very 
subtle data corruption issues.

So no, you cannot, and absolutely must not use this to update the actual 
page mapping. Ever. It is only valid for the protection bits.

		Linus
