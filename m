From: Greg KH <greg@kroah.com>
Subject: Re: [stable] [PATCH 00/12] xen/paravirt_ops patches for 2.6.24
Date: Wed, 14 Nov 2007 14:01:16 -0800
Message-ID: <20071114220116.GC19850@kroah.com>
References: <20071015204840.074767068@goop.org> <20071015215406.GA1588@kroah.com> <4713E2D6.90801@goop.org> <20071113232258.GA10338@kroah.com> <473B4132.5030402@goop.org> <20071114190335.GA10024@kroah.com> <473B5242.5050606@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1765078AbXKNWD5@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <473B5242.5050606@goop.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: xen-devel@lists.xensource.com, Keir Fraser <keir@xensource.com>, LKML <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>, Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Stable Kernel <stable@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Nov 14, 2007 at 11:53:38AM -0800, Jeremy Fitzhardinge wrote:
> Greg KH wrote:
> > Ok, that's fine, but can you send some patches that I can apply?  :)
> 
> The patches you've already queued for stable are all that's needed. 
> Including the xfs one, despite Andi's reservations about it; Dave
> Chinner has a better fix, but as far as I know he hasn't submitted it
> for stable, and the workaround is enough to get things going.

Great, thanks for verifying.

greg k-h
