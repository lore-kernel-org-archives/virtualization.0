From: Andi Kleen <ak@suse.de>
Subject: Re: [patch 17/24] Xen-paravirt_ops: avoid having a bad
	selector in %gs during context switch
Date: Wed, 21 Feb 2007 23:10:02 +0100
Message-ID: <200702212310.02218.ak@suse.de>
References: <20070221205254.169835700@goop.org>
	<20070221205323.770169136@goop.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <20070221205323.770169136@goop.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: virtualization@lists.osdl.org
Cc: Chris Wright <chrisw@sous-sol.org>, Jeremy Fitzhardinge <jeremy@goop.org>, xen-devel@lists.xensource.com, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org


>  	/*
> +	 * Temporary hack: zero gs now that we've saved it so that Xen
> +	 * doesn't try to reload the old value after changing the GDT
> +	 * during the context switch.  This can go away once Xen has
> +	 * been taught to only reload %gs when it absolutely must.
> +	 */
> +	loadsegment(gs, 0);

Sorry, but i don't really want that unconditionally in the context switch.
Adding a paravirt ops for it would be also ugly. Can Xen be fixed?

-Andi
