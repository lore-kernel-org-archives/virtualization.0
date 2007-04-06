From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH] Define EFLAGS_IF
Date: Fri, 6 Apr 2007 02:48:39 +0200
Message-ID: <20070406004839.GA27668@one.firstfloor.org>
References: <1174533374.2713.104.camel@localhost.localdomain> <46159256.1040705@zytor.com> <461592AA.4060103@goop.org> <46159480.20108@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1767451AbXDFAsn@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <46159480.20108@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Rusty Russell <rusty@rustcorp.com.au>, virtualization <virtualization@lists.osdl.org>, Andrew Morton <akpm@linux-foundation.org>, Andi Kleen <andi@firstfloor.org>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Apr 05, 2007 at 05:29:52PM -0700, H. Peter Anvin wrote:
> Jeremy Fitzhardinge wrote:
> >
> >That patch got dropped, and replaced by one which pulled all the flags
> >definitions out of <asm/processor.h>
> >
> 
> Saw that a little too late :)
> 
> In general, it would be nice if the various CPU constants were all 
> defined in one place, so I'd rather suggest protecting the appropriate 
> parts of asm/processor.h with #ifndef __ASSEMBLY__.

No processor.h is such a hodgepodge of unrelated stuff that any
splitting up is a good thing.

-Andi
