From: Jeremy Fitzhardinge <jeremy@xensource.com>
Subject: Re: [PATCH 10/28] i386: map enough initial memory to create lowmem
 mappings
Date: Mon, 23 Apr 2007 11:06:48 -0700
Message-ID: <462CF5B8.4070708@xensource.com>
References: <20070414204154.871250608@goop.org>	<200704192250.52633.ak@suse.de> <4627D756.5020405@zytor.com>	<200704192304.01053.ak@suse.de> <4627DB0C.2010804@zytor.com>	<4627DDAD.4070805@redhat.com> <4627E099.209@goop.org>	<m1d51vxxm4.fsf@ebiederm.dsl.xmission.com> <462CE027.4030302@goop.org>	<462CE1E0.9060007@zytor.com> <m1zm4zvwfr.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1161205AbXDWSH2@vger.kernel.org>
In-Reply-To: <m1zm4zvwfr.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, lkml <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, Chuck Ebbert <cebbert@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Eric W. Biederman wrote:
> Consider a memory hole of size 8M immediately after our bootmem bitmap.
> head.S which knows nothing of holes will map the pages of the hole
> into the initial page tables assuming that is where the page tables
> will live.
>   

Sure, but considering we're only talking about mapping an additional *2*
pages, the chances are that it will affect a kernel as much as the early
head.S mapping.  It's well within the variability of fairly similar
kernel configs.

> As for how to fix this, we need to call boot_ioremap or better
> bt_ioremap on the address returned from alloc_bootmem_pages_low to
> force the allocated page into the page table.  After we have setup
> the page table page we can call unmap the page to free up the scarce
> early mapping resource.
>   

Would that be necessary?  Is there any need to remap it?  Couldn't you
just do the straightforward phys->virt mapping and use the page where it
lies?

    J
