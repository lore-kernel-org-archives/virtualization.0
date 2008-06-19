From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 1 of 4] mm: add a ptep_modify_prot transaction abstraction
Date: Thu, 19 Jun 2008 09:30:20 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0806190928100.2907@woody.linux-foundation.org>
References: <b020e42384197b824320.1213615800@localhost>
	<1213831403.8011.24.camel@pasglop> <4859A149.9090004@goop.org>
	<4859A528.1010107@goop.org>
	<alpine.LFD.1.10.0806181723400.2907@woody.linux-foundation.org>
	<4859AA47.2020903@goop.org>
	<alpine.LFD.1.10.0806181743390.2907@woody.linux-foundation.org>
	<alpine.LFD.1.10.0806182050470.2907@woody.linux-foundation.org>
	<20080619115832.GM15228@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20080619115832.GM15228@elte.hu>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Ingo Molnar <mingo@elte.hu>
Cc: xen-devel <xen-devel@lists.xensource.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, kvm-devel <kvm-devel@lists.sourceforge.net>, benh@kernel.crashing.org, x86@kernel.org, LKML <linux-kernel@vger.kernel.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, Hugh Dickins <hugh@veritas.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: virtualization@lists.linuxfoundation.org



On Thu, 19 Jun 2008, Ingo Molnar wrote:
> 
> Below is the commit, it needed a small amount of massaging to apply the 
> void * -> unsigned long * change in the x86/bitops topic.

Well, that's your bug right there.

The macros very much depended on the pointers being "void *", due to the 
pointer arithmetic (which is a gcc extension that we use extensively - 
"void *" arithmetic works as if it was a byte pointer).

When you changed "addr" to "volatile unsigned long *", now the arithmetic 
ended up multiplying the offset by the size of "long" before adding it.

That said, the _original_ patch wasn't tested either, but quite frankly, 
looking over the patch one more time, I can't really see how it could 
break.

		Linus
