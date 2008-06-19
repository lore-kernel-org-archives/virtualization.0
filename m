From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 1 of 4] mm: add a ptep_modify_prot transaction
	abstraction
Date: Thu, 19 Jun 2008 14:03:30 +0200
Message-ID: <20080619120330.GA3172@elte.hu>
References: <b020e42384197b824320.1213615800@localhost> <1213831403.8011.24.camel@pasglop> <4859A149.9090004@goop.org> <4859A528.1010107@goop.org> <alpine.LFD.1.10.0806181723400.2907@woody.linux-foundation.org> <4859AA47.2020903@goop.org> <alpine.LFD.1.10.0806181743390.2907@woody.linux-foundation.org> <alpine.LFD.1.10.0806182050470.2907@woody.linux-foundation.org> <20080619115832.GM15228@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756958AbYFSMEU@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20080619115832.GM15228@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, benh@kernel.crashing.org, xen-devel <xen-devel@lists.xensource.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, kvm-devel <kvm-devel@lists.sourceforge.net>, x86@kernel.org, LKML <linux-kernel@vger.kernel.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, Hugh Dickins <hugh@veritas.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: virtualization@lists.linuxfoundation.org


* Ingo Molnar <mingo@elte.hu> wrote:

> config and crashlog can be found at:
> 
>   http://redhat.com/~mingo/misc/config-Thu_Jun_19_13_45_21_CEST_2008.bad
>   http://redhat.com/~mingo/misc/crash-Thu_Jun_19_13_45_21_CEST_2008.log

just in case it helps, and for completeness, a 64-bit box blew up too:

  http://redhat.com/~mingo/misc/config-Thu_Jun_19_13_48_55_CEST_2008.bad

and another 32-bit box:

  http://redhat.com/~mingo/misc/config-Thu_Jun_19_13_48_32_CEST_2008.bad

	Ingo
