From: Andi Kleen <ak@suse.de>
Subject: Re: [stable] [PATCH 00/12] xen/paravirt_ops patches for
	2.6.24
Date: Wed, 14 Nov 2007 00:53:33 +0100
Message-ID: <200711140053.33584.ak@suse.de>
References: <20071015204840.074767068@goop.org> <4713E2D6.90801@goop.org>
	<20071113232258.GA10338@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <20071113232258.GA10338@kroah.com>
Content-Disposition: inline
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Greg KH <greg@kroah.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, xen-devel@lists.xensource.com, Keir Fraser <keir@xensource.com>, LKML <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Stable Kernel <stable@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org


> > Subject: [PATCH 12/12] xfs: eagerly remove vmap mappings to avoid
> > upsetting Xen

This patch was the wrong fix anyways as discussed; David Chinner
finally came up with a better one.

-Andi
