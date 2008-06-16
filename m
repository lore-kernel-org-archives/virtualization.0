From: Hugh Dickins <hugh@veritas.com>
Subject: Re: [PATCH 1 of 4] mm: add a ptep_modify_prot transaction abstraction
Date: Mon, 16 Jun 2008 19:13:48 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0806161906490.19564@blonde.site>
References: <b020e42384197b824320.1213615800@localhost>
 <alpine.LFD.1.10.0806161028080.2949@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755037AbYFPSPx@vger.kernel.org>
In-Reply-To: <alpine.LFD.1.10.0806161028080.2949@woody.linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Linus Torvalds <torvalds@linux-foundation.or>, Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>, x86@kernel.org, xen-devel <xen-devel@lists.xensource.com>, Thomas Gleixner <tglx@linutronix.de>, Zachary Amsden <zach@vmware.com>, kvm-devel <kvm-devel@lists.sourceforge.net>, Virtualization Mailing List <virtualization@lists.osdl.org>, Rusty Russell <rusty@rustcorp.com.au>, Peter Zijlstra <a.p.zijlstra@chello.nl>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 16 Jun 2008, Linus Torvalds wrote:
> On Mon, 16 Jun 2008, Jeremy Fitzhardinge wrote:
> >
> > ptep_modify_prot_start() returns the current pte value, and puts the
> >   pte entry into a state where either the hardware will not update the
> >   pte, or if it does, the updates will be preserved on commit.
> > 
> > ptep_modify_prot_commit() writes back the updated pte, makes sure that
> >   any hardware updates made since ptep_modify_prot_start() are
> >   preserved.
> 
> Ok, I'm fine with this now that it's renamed to be clearly about just 
> protection bits.
> 
> So 
> 
> 	Acked-by: Linus Torvalds <torvalds@linux-foundation.org>

And seems very reasonable (and exceptionally well described) to me too.

	Acked-by: Hugh Dickins <hugh@veritas.com>
