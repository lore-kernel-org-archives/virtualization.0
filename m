From: Andi Kleen <ak@muc.de>
Subject: Re: Re: [patch 05/21] Xen-paravirt: paravirt_ops:
	allocate a fixmap slot
Date: 14 Feb 2007 10:15:04 +0100
Message-ID: <20070214091504.GA68112@muc.de>
References: <20070213221729.772002682@goop.org>
	<20070213221829.845132535@goop.org>
	<45D2649D.4080508@vmware.com> <45D26797.5090600@goop.org>
	<45D2D856.76E4.0078.0@novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <xen-devel-bounces@lists.xensource.com>
Date: Wed, 14 Feb 2007 10:15:04 +0100
Content-Disposition: inline
In-Reply-To: <45D2D856.76E4.0078.0@novell.com>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Jan Beulich <jbeulich@novell.com>
Cc: Andrew Morton <akpm@osdl.org>, Jeremy Fitzhardinge <jeremy@goop.org>, xen-devel@lists.xensource.com, Dan Hecht <dhecht@vmware.com>, linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Feb 14, 2007 at 08:37:26AM +0000, Jan Beulich wrote:
> >>> Jeremy Fitzhardinge <jeremy@goop.org> 14.02.07 02:36 >>>
> >Dan Hecht wrote:
> >> Why doesn't Xen allocate the shared_info page from the pseudo-physical
> >> space?  Doesn't it already have to steal pages from the
> >> pseudo-physical space for e.g. initial page tables, console, etc?  Why
> >> not do the same for shared_info, and then you don't need a reserve the
> >> fixmap slot.
> >
> >Unlike the pagetable pages or the console page, the shared info page
> >doesn't have a pseudo-physical address, so in order to map it we need to
> >directly construct a pte containing the mfn for that page.  Inserting
> >this mapping into the fixmap space seems like the easiest way to do
> >this.  It's not like a fixmap slot costs anything.
> 
> Otoh there are many fixmap slots not used under Xen, perhaps it would
> be possible to use one of those... One slot certainly doesn't cost a lot,

I don't have a problem with reserving one page for this.

-Andi
