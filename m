From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 1 of 4] mm: add a ptep_modify_prot transaction
 abstraction
Date: Fri, 20 Jun 2008 13:03:45 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0806201302350.3167@woody.linux-foundation.org>
References: <alpine.LFD.1.10.0806181723400.2907@woody.linux-foundation.org> <4859AA47.2020903@goop.org> <alpine.LFD.1.10.0806181743390.2907@woody.linux-foundation.org> <alpine.LFD.1.10.0806182050470.2907@woody.linux-foundation.org> <20080619115832.GM15228@elte.hu>
 <alpine.LFD.1.10.0806190928100.2907@woody.linux-foundation.org> <20080619164708.GA32190@elte.hu> <20080620101028.GA23664@elte.hu> <485BFFC4.3070902@goop.org> <alpine.LFD.1.10.0806201211560.3167@woody.linux-foundation.org> <20080620195620.GA20183@elte.hu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757591AbYFTUF3@vger.kernel.org>
In-Reply-To: <20080620195620.GA20183@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, benh@kernel.crashing.org, xen-devel <xen-devel@lists.xensource.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, kvm-devel <kvm-devel@lists.sourceforge.net>, x86@kernel.org, LKML <linux-kernel@vger.kernel.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, Hugh Dickins <hugh@veritas.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: virtualization@lists.linuxfoundation.org



On Fri, 20 Jun 2008, Ingo Molnar wrote:
> 
> okay - Jeremy, could you try the fix below? (or tip/master, i just 
> pushed this out)

Actually, don't try that one.

It needs to be a _byte_ registers, so "ir" was wrong. You need "iq".

		Linus
