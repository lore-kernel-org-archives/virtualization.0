From: "Jan Beulich" <jbeulich@novell.com>
Subject: Re: [patch 05/21] Xen-paravirt: paravirt_ops:
	allocate a fixmap slot
Date: Wed, 14 Feb 2007 08:37:26 +0000
Message-ID: <45D2D856.76E4.0078.0@novell.com>
References: <20070213221729.772002682@goop.org>
	<20070213221829.845132535@goop.org> <45D2649D.4080508@vmware.com>
	<45D26797.5090600@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <45D26797.5090600@goop.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andrew Morton <akpm@osdl.org>, xen-devel@lists.xensource.com, Andi Kleen <ak@muc.de>, Dan Hecht <dhecht@vmware.com>, linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

>>> Jeremy Fitzhardinge <jeremy@goop.org> 14.02.07 02:36 >>>
>Dan Hecht wrote:
>> Why doesn't Xen allocate the shared_info page from the pseudo-physical
>> space?  Doesn't it already have to steal pages from the
>> pseudo-physical space for e.g. initial page tables, console, etc?  Why
>> not do the same for shared_info, and then you don't need a reserve the
>> fixmap slot.
>
>Unlike the pagetable pages or the console page, the shared info page
>doesn't have a pseudo-physical address, so in order to map it we need to
>directly construct a pte containing the mfn for that page.  Inserting
>this mapping into the fixmap space seems like the easiest way to do
>this.  It's not like a fixmap slot costs anything.

Otoh there are many fixmap slots not used under Xen, perhaps it would
be possible to use one of those... One slot certainly doesn't cost a lot,
but many (like the IO-APIC group) may already matter, especially on
PAE systems with lots of memory). Consequently, if these can't be
squeezed out as needed, re-using would seem more appropriate than
adding.
(I would certainly favor [conditionally] removing them, but can't easily
see how to do this under CONFIG_PARAVIRT. Background being that
we've already been hit by those [namely the LAPIC one] remaining
present, hence the build not being able to detect that accesses to the
LAPIC page can't work. While no such access was ever left in the base
kernel, modules are more susceptible to this, and in our case it was
the [native, i.e. pre-xenoprof] oprofile driver that had been forgotten
to be disabled.)

Jan
