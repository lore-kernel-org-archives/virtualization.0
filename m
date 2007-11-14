From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [stable] [PATCH 00/12] xen/paravirt_ops patches for
	2.6.24
Date: Wed, 14 Nov 2007 11:53:38 -0800
Message-ID: <473B5242.5050606@goop.org>
References: <20071015204840.074767068@goop.org>	<20071015215406.GA1588@kroah.com>
	<4713E2D6.90801@goop.org>	<20071113232258.GA10338@kroah.com>
	<473B4132.5030402@goop.org> <20071114190335.GA10024@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <20071114190335.GA10024@kroah.com>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Greg KH <greg@kroah.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, xen-devel@lists.xensource.com, Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>, Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, Andrew Morton <akpm@linux-foundation.org>, Keir Fraser <keir@xensource.com>, Stable Kernel <stable@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Greg KH wrote:
> Ok, that's fine, but can you send some patches that I can apply?  :)

The patches you've already queued for stable are all that's needed. 
Including the xfs one, despite Andi's reservations about it; Dave
Chinner has a better fix, but as far as I know he hasn't submitted it
for stable, and the workaround is enough to get things going.

I have one additional patch; I'll send it shortly (once Linus picks it
up...).

    J
