From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 1 of 4] mm: add a ptep_modify_prot transaction
 abstraction
Date: Wed, 18 Jun 2008 17:49:51 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0806181743390.2907@woody.linux-foundation.org>
References: <b020e42384197b824320.1213615800@localhost> <1213831403.8011.24.camel@pasglop> <4859A149.9090004@goop.org> <4859A528.1010107@goop.org> <alpine.LFD.1.10.0806181723400.2907@woody.linux-foundation.org> <4859AA47.2020903@goop.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757412AbYFSAvX@vger.kernel.org>
In-Reply-To: <4859AA47.2020903@goop.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: benh@kernel.crashing.org, xen-devel <xen-devel@lists.xensource.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, kvm-devel <kvm-devel@lists.sourceforge.net>, x86@kernel.org, LKML <linux-kernel@vger.kernel.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, Hugh Dickins <hugh@veritas.com>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>
List-Id: virtualization@lists.linuxfoundation.org



On Wed, 18 Jun 2008, Jeremy Fitzhardinge wrote:
>
> It's not cmpxchg, just xchg. 
> In other words, is:
> 
> 	lock btr $_PAGE_BIT_RW, (%rbx)

Well, we can actually do it as

	lock andl $~_PAGE_RW,(%rbx)

although we haven't bothered (I've wanted several times to make 
clear_bit() do that, but have never gotten around to it - mainly because 
old gcc versions didn't work with __builtin_constant_p() in inline 
functions - so you have to do the macro from hell)

And yes, the "lock andl" should be noticeably faster than the xchgl.

			Linus
