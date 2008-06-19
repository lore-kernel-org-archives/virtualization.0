From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 1 of 4] mm: add a ptep_modify_prot
	transaction abstraction
Date: Thu, 19 Jun 2008 18:47:08 +0200
Message-ID: <20080619164708.GA32190@elte.hu>
References: <b020e42384197b824320.1213615800@localhost>
	<1213831403.8011.24.camel@pasglop> <4859A149.9090004@goop.org>
	<4859A528.1010107@goop.org>
	<alpine.LFD.1.10.0806181723400.2907@woody.linux-foundation.org>
	<4859AA47.2020903@goop.org>
	<alpine.LFD.1.10.0806181743390.2907@woody.linux-foundation.org>
	<alpine.LFD.1.10.0806182050470.2907@woody.linux-foundation.org>
	<20080619115832.GM15228@elte.hu>
	<alpine.LFD.1.10.0806190928100.2907@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <xen-devel-bounces@lists.xensource.com>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0806190928100.2907@woody.linux-foundation.org>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, xen-devel <xen-devel@lists.xensource.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, kvm-devel <kvm-devel@lists.sourceforge.net>, benh@kernel.crashing.org, x86@kernel.org, LKML <linux-kernel@vger.kernel.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, Hugh Dickins <hugh@veritas.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: virtualization@lists.linuxfoundation.org


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Thu, 19 Jun 2008, Ingo Molnar wrote:
> > 
> > Below is the commit, it needed a small amount of massaging to apply the 
> > void * -> unsigned long * change in the x86/bitops topic.
> 
> Well, that's your bug right there.
> 
> The macros very much depended on the pointers being "void *", due to 
> the pointer arithmetic (which is a gcc extension that we use 
> extensively - "void *" arithmetic works as if it was a byte pointer).

duh, yeah - of course. Will retry with that fixed :)

	Ingo
