From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 1 of 4] mm: add a ptep_modify_prot
	transaction abstraction
Date: Mon, 16 Jun 2008 20:49:50 +0200
Message-ID: <20080616184949.GA14182@elte.hu>
References: <b020e42384197b824320.1213615800@localhost>
	<alpine.LFD.1.10.0806161028080.2949@woody.linux-foundation.org>
	<Pine.LNX.4.64.0806161906490.19564@blonde.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <xen-devel-bounces@lists.xensource.com>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0806161906490.19564@blonde.site>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Hugh Dickins <hugh@veritas.com>
Cc: Zachary Amsden <zach@vmware.com>, Jeremy Fitzhardinge <jeremy@goop.org>, xen-devel <xen-devel@lists.xensource.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, kvm-devel <kvm-devel@lists.sourceforge.net>, x86@kernel.org, LKML <linux-kernel@vger.kernel.org>, Rusty Russell <rusty@rustcorp.com.au>, Virtualization Mailing List <virtualization@lists.osdl.org>, Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.or>
List-Id: virtualization@lists.linuxfoundation.org


* Hugh Dickins <hugh@veritas.com> wrote:

> On Mon, 16 Jun 2008, Linus Torvalds wrote:
> > On Mon, 16 Jun 2008, Jeremy Fitzhardinge wrote:
> > >
> > > ptep_modify_prot_start() returns the current pte value, and puts the
> > >   pte entry into a state where either the hardware will not update the
> > >   pte, or if it does, the updates will be preserved on commit.
> > > 
> > > ptep_modify_prot_commit() writes back the updated pte, makes sure that
> > >   any hardware updates made since ptep_modify_prot_start() are
> > >   preserved.
> > 
> > Ok, I'm fine with this now that it's renamed to be clearly about just 
> > protection bits.
> > 
> > So 
> > 
> > 	Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
> 
> And seems very reasonable (and exceptionally well described) to me too.
> 
> 	Acked-by: Hugh Dickins <hugh@veritas.com>

thanks guys, i've added the Acked-by's and added a new -tip topic for 
this.

The dependencies are a bit tricky and the changes contain mm/ and 
include/asm-generic/ bits so lets try a new Git trick here to keep it 
all tidy and disciplined for v2.6.27 merging.

So i've created a new tip/mm/xen topic branch (the 85th -tip topic 
branch ;-), which is COW-ed off the current tip/x86/xen topic branch [on 
which branch these changes have some dependencies], and added these 4 
changes to that. The tip/x86/xen (append-only-) topic will continue to 
advance as usual, and we likely wont have dependencies on the stuff in 
tip/mm/xen. (if there will be such dependencies we can handle that too)

In v2.6.27 we can then offer up the two branches separately for upstream 
merge, and tip/x86/xen will still only have x86 and xen changes, not any 
mm changes. (Obviously tip/mm/xen will be offered after tip/x86/xen has 
gone upstream - so that it will only contain these 4 patches ontop of 
already-upstream changes)

it will all be auto-merged into linux-next so there this internal 
structure is not visible, all the changes are available for wide testing 
of course.

i've added these mm/ changes to auto-core-next (not auto-x86-next), if 
that is fine by Andrew.

	Ingo
