From: Zachary Amsden <zach@vmware.com>
Subject: Re: PATCH: Fix VMI and COMPAT_VDSO for 2.6.21
Date: Sat, 10 Mar 2007 02:32:39 -0800
Message-ID: <45F28947.30406@vmware.com>
References: <45F2578E.3060907@vmware.com> <45F257C1.4070904@vmware.com> <20070310084750.GA15647@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752322AbXCJKcl@vger.kernel.org>
In-Reply-To: <20070310084750.GA15647@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>, Rusty Russell <rusty@rustcorp.com.au>, Jeremy Fitzhardinge <jeremy@goop.org>, Chris Wright <chrisw@sous-sol.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

Ingo Molnar wrote:
> makes sense. We can do Jan's relocatable-COMPAT_VDSO thing in v2.6.22, 
> but for v2.6.21 that's way too intrusive.
>   

Agree.  I think we can clean up some of the strange build magic though, 
by adding boot time ELF magic instead.  We'll see which works out better.

Zach
