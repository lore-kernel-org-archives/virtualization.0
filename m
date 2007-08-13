From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: [PATCH] [545/2many] MAINTAINERS - XEN HYPERVISOR INTERFACE
Date: Mon, 13 Aug 2007 12:10:05 -0700
Message-ID: <20070813121005.af159d1d.randy.dunlap@oracle.com>
References: <46bffcb5.o/KKCq3EZH4S47k3%joe@perches.com>
	<20070813185536.GH3672@sequoia.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S947802AbXHMTGy@vger.kernel.org>
In-Reply-To: <20070813185536.GH3672@sequoia.sous-sol.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Chris Wright <chrisw@sous-sol.org>
Cc: joe@perches.com, xen-devel@lists.xensource.com, virtualization@lists.osdl.org, torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, jeremy@xensource.com, akpm@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 13 Aug 2007 11:55:36 -0700 Chris Wright wrote:

> * joe@perches.com (joe@perches.com) wrote:
> > Add file pattern to MAINTAINER entry
> > 
> > Signed-off-by: Joe Perches <joe@perches.com>
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index e4e1cc3..8395aba 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -5153,6 +5153,11 @@ M:	chrisw@sous-sol.org
> >  L:	virtualization@lists.osdl.org
> >  L:	xen-devel@lists.xensource.com
> >  S:	Supported
> > +F:	arch/i386/xen/
> > +F:	drivers/*/xen-*front.c
> > +F:	drivers/xen/
> > +F:	include/asm-i386/xen/
> > +F:	include/xen/
> 
> I think this data will easily become stale.  What is the point again?

Agreed.  But not everyone wants to or should have to use git,
so what are the alternatives?


---
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
