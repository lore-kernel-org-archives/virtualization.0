From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [stable] [PATCH 00/12] xen/paravirt_ops patches for 2.6.24
Date: Wed, 14 Nov 2007 10:40:50 -0800
Message-ID: <473B4132.5030402@goop.org>
References: <20071015204840.074767068@goop.org> <20071015215406.GA1588@kroah.com> <4713E2D6.90801@goop.org> <20071113232258.GA10338@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1763160AbXKNSlR@vger.kernel.org>
In-Reply-To: <20071113232258.GA10338@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, xen-devel@lists.xensource.com, LKML <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>, Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, Andrew Morton <akpm@linux-foundation.org>, Keir Fraser <keir@xensource.com>, Stable Kernel <stable@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Greg KH wrote:
> These don't apply now due to the x86 merge.  Care to backport them and
> send them to the stable@kernel.org address so we can apply them
> properly?

I'm a bit confused.  The patches you mailed out are against arch/i386. 
Won't they apply to the stable tree as-is?

> Although, it's not like anyone actually uses the in-kernel Xen on
> 2.6.23, so it's probably not really worth it.
>   

To be fair, those fixes were in response to bug reports raised on the
released 2.6.23 kernel.  But it isn't screamingly urgent.

    J
