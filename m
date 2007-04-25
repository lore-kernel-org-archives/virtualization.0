From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH 10/28] i386: map enough initial memory to create lowmem
 mappings
Date: Wed, 25 Apr 2007 14:31:57 -0700
Message-ID: <462FC8CD.1030505@goop.org>
References: <20070414204154.871250608@goop.org>	<200704192250.52633.ak@suse.de> <4627D756.5020405@zytor.com>	<200704192304.01053.ak@suse.de> <4627DB0C.2010804@zytor.com>	<4627DDAD.4070805@redhat.com> <4627E099.209@goop.org> <m1abwwqiof.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754273AbXDYVbX@vger.kernel.org>
In-Reply-To: <m1abwwqiof.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Chuck Ebbert <cebbert@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@suse.de>, Andrew Morton <akpm@linux-foundation.org>, virtualization@lists.osdl.org, lkml <linux-kernel@vger.kernel.org>, Zachary Amsden <zach@vmware.com>, Chris Wright <chrisw@sous-sol.org>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Eric W. Biederman wrote:
> Jeremy did your kernel have PAE enabled?
>
> It just occurred to me that we have at all of the memory below 1M (say about
> 512K) mapped and available to setup new mappings.
>
> The only way I can see a page fault happening is if you were using a PAE
> enabled kernel (so you were not updating the current page tables) and
> you have more than 256M of low memory, and we don't get any much extra
> from always mapping 4M at a time.

Yes, that's the situation.  PAE enabled, ~768MB of memory and a large
kernel which mostly fills the 8M mapping.

    J
