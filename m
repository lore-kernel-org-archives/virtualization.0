From: Chris Wright <chrisw@sous-sol.org>
Subject: Re: [PATCH] [545/2many] MAINTAINERS - XEN HYPERVISOR
	INTERFACE
Date: Mon, 13 Aug 2007 12:19:38 -0700
Message-ID: <20070813191938.GI3672@sequoia.sous-sol.org>
References: <46bffcb5.o/KKCq3EZH4S47k3%joe@perches.com>
	<20070813185536.GH3672@sequoia.sous-sol.org>
	<20070813121005.af159d1d.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <xen-devel-bounces@lists.xensource.com>
Content-Disposition: inline
In-Reply-To: <20070813121005.af159d1d.randy.dunlap@oracle.com>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: xen-devel@lists.xensource.com, jeremy@xensource.com, linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, joe@perches.com, akpm@linux-foundation.org, torvalds@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

* Randy Dunlap (randy.dunlap@oracle.com) wrote:
> On Mon, 13 Aug 2007 11:55:36 -0700 Chris Wright wrote:
> > * joe@perches.com (joe@perches.com) wrote:
> > > +F:	arch/i386/xen/
> > > +F:	drivers/*/xen-*front.c
> > > +F:	drivers/xen/
> > > +F:	include/asm-i386/xen/
> > > +F:	include/xen/
> > 
> > I think this data will easily become stale.  What is the point again?
> 
> Agreed.  But not everyone wants to or should have to use git,
> so what are the alternatives?

Between git (or gitweb), existing MAINTAINERS and a bit of common
sense (or extra sleuthing), I never perceived a significant problem.
Alternative could be to place info directly in source files.  If not
all of MAINTAINERS info, it could be a tag to reference the relevant
MAINTAINERS entry.

thanks,
-chris
