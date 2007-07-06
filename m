From: Chris Wright <chrisw@sous-sol.org>
Subject: Re: [PATCH] VMI: remove CONFIG_DEBUG_PAGE_TYPE and associated
	bitrotted code
Date: Fri, 6 Jul 2007 13:40:38 -0700
Message-ID: <20070706204038.GU4306@sequoia.sous-sol.org>
References: <Pine.LNX.4.64.0707060847470.23786@localhost.localdomain> <468E890A.1070504@s5r6.in-berlin.de> <20070706201625.GT4306@sequoia.sous-sol.org> <468EA27C.9060401@vmware.com> <468EA5E0.4070501@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1762950AbXGFUlV@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <468EA5E0.4070501@goop.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Zachary Amsden <zach@vmware.com>, Chris Wright <chrisw@sous-sol.org>, Andrew Morton <akpm@osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization@lists.osdl.org, Stefan Richter <stefanr@s5r6.in-berlin.de>, "Robert P. J. Day" <rpjday@mindspring.com>
List-Id: virtualization@lists.linuxfoundation.org

* Jeremy Fitzhardinge (jeremy@goop.org) wrote:
> Zachary Amsden wrote:
> >I'd rather keep it, even with bitrot - it was non-trivial to get 
> >correct, and found many surprises in the code; most notably, it can 
> >detect
> >
> >1) PTE writes to pages not declared as page tables
> >2) Failure to allocate or de-allocate page tables using the 
> >paravirt-ops API
> >3) PTE writes using the wrong level operations
> >
> >These are most useful properties; in fact, I would like to extend the 
> >code for 64-bit paravirt-ops and 4-level paging, so rather not kill it 
> >until then.
> >
> >I never merged the whole bit upstream because it added a field to 
> >struct page. 
> 
> Hm, is that a big problem?  It would be OK for a debug config option, 
> wouldn't it?  Also, it doesn't seem particularly vmi-specific.  Could it 
> be made part of the pvops infrastructure?

I'm pretty sure lguest64 hit some of the problems Zach is trying to
catch, so should generalize well-enough.

thanks,
-chris
