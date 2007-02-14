From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [patch 05/21] Xen-paravirt: paravirt_ops: allocate
	a fixmap slot
Date: Tue, 13 Feb 2007 17:36:23 -0800
Message-ID: <45D26797.5090600@goop.org>
References: <20070213221729.772002682@goop.org>
	<20070213221829.845132535@goop.org> <45D2649D.4080508@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <45D2649D.4080508@vmware.com>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Dan Hecht <dhecht@vmware.com>
Cc: Andrew Morton <akpm@osdl.org>, xen-devel@lists.xensource.com, virtualization@lists.osdl.org, linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>, Andi Kleen <ak@muc.de>
List-Id: virtualization@lists.linuxfoundation.org

Dan Hecht wrote:
> Why doesn't Xen allocate the shared_info page from the pseudo-physical
> space?  Doesn't it already have to steal pages from the
> pseudo-physical space for e.g. initial page tables, console, etc?  Why
> not do the same for shared_info, and then you don't need a reserve the
> fixmap slot.

Unlike the pagetable pages or the console page, the shared info page
doesn't have a pseudo-physical address, so in order to map it we need to
directly construct a pte containing the mfn for that page.  Inserting
this mapping into the fixmap space seems like the easiest way to do
this.  It's not like a fixmap slot costs anything.

    J
