From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH 10/28] i386: map enough initial memory to create lowmem
 mappings
Date: Mon, 23 Apr 2007 10:02:22 -0700
Message-ID: <462CE69E.8040207@goop.org>
References: <20070414204154.871250608@goop.org>	<200704192250.52633.ak@suse.de> <4627D756.5020405@zytor.com>	<200704192304.01053.ak@suse.de> <4627DB0C.2010804@zytor.com>	<4627DDAD.4070805@redhat.com> <4627E099.209@goop.org> <m1d51vxxm4.fsf@ebiederm.dsl.xmission.com> <462CE027.4030302@goop.org> <462CE1E0.9060007@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1030506AbXDWRCA@vger.kernel.org>
In-Reply-To: <462CE1E0.9060007@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Chuck Ebbert <cebbert@redhat.com>, Andi Kleen <ak@suse.de>, Andrew Morton <akpm@linux-foundation.org>, virtualization@lists.osdl.org, lkml <linux-kernel@vger.kernel.org>, Zachary Amsden <zach@vmware.com>, Chris Wright <chrisw@sous-sol.org>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

H. Peter Anvin wrote:
> Since we allocate the maximum possible memory statically, I fail to
> see how holes could make the situation any worse, or better. 

No, we map enough space to map 4G (~4 pages), but we don't actually map
4G.  If a hole happened to start within that 4 page mapping, then the
memory still wouldn't be available for allocation.

I think this is a bit of a spurious argument though, since if it were
really a problem we'd have to worry about holes hitting the kernel image
too.  As far as I can see, that's not considered to be a problem.

I think the real point is that there's currently a subtle dependency
between head.S and bootmem allocation which happens between start_kernel
and pagetable_init.  Your patch preventing over-mapping should make them
easier to smoke out as it currently stands, but eliminating the problem
by making alloc_bootmem create the mappings for itself does have
appeal.  There would still be the dependency on head.S to map the kernel
itself and the bootmem allocator bitmap.

    J
