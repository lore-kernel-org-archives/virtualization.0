From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] Define EFLAGS_IF
Date: Fri, 06 Apr 2007 12:24:08 +1000
Message-ID: <1175826248.12230.668.camel@localhost.localdomain>
References: <1174533374.2713.104.camel@localhost.localdomain>
	 <46159256.1040705@zytor.com> <461592AA.4060103@goop.org>
	 <46159480.20108@zytor.com> <20070406004839.GA27668@one.firstfloor.org>
	 <46159D08.9030400@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1767498AbXDFCYk@vger.kernel.org>
In-Reply-To: <46159D08.9030400@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andi Kleen <andi@firstfloor.org>, Jeremy Fitzhardinge <jeremy@goop.org>, virtualization <virtualization@lists.osdl.org>, Andrew Morton <akpm@linux-foundation.org>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 2007-04-05 at 18:06 -0700, H. Peter Anvin wrote:
> Andi Kleen wrote:
> > 
> > No processor.h is such a hodgepodge of unrelated stuff that any
> > splitting up is a good thing.
> > 
> 
> Fair enough.  However, I'd still like to see the X86_CR* constants 
> moved, too (and constants added for at least CR0 as well.)

Agreed.  This was on theory of minimum damage, but since it seems to
have received a warm reception, I'd say moving the rest to
processor-flags.h would be a welcome addition.

Cheers,
Rusty.
