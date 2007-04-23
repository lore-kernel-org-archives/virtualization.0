From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH 10/28] i386: map enough initial memory to create lowmem
 mappings
Date: Mon, 23 Apr 2007 09:34:47 -0700
Message-ID: <462CE027.4030302@goop.org>
References: <20070414204154.871250608@goop.org>	<200704192250.52633.ak@suse.de> <4627D756.5020405@zytor.com>	<200704192304.01053.ak@suse.de> <4627DB0C.2010804@zytor.com>	<4627DDAD.4070805@redhat.com> <4627E099.209@goop.org> <m1d51vxxm4.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754038AbXDWQe0@vger.kernel.org>
In-Reply-To: <m1d51vxxm4.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Chuck Ebbert <cebbert@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@suse.de>, Andrew Morton <akpm@linux-foundation.org>, virtualization@lists.osdl.org, lkml <linux-kernel@vger.kernel.org>, Zachary Amsden <zach@vmware.com>, Chris Wright <chrisw@sous-sol.org>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Eric W. Biederman wrote:
> The only way to ensure this will not happen is to do what we do
> on x86_64 and map the new page table page into our address space
> before we write to it.  Assuming the page we allocate is already
> mapped is simply not robust.
>   

So you mean make alloc_bootmem make sure there's a mapping for the
returned page?  That would be simple enough, though it might interact
strangely with the actual construction of the memory mappings (what if
the page alloc_bootmem just allocated for the pagetable is the page
pagetable_init is actually trying to map?).

I'm not sure about the issue with holes.  I assume you mean that just
because head.S maps a chunk of memory, it isn't necessarily available
for allocation because its a hole.  But does alloc_bootmem know to avoid
them anyway?  Has it already parsed e820 at that point?

    J
