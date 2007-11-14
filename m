From: Greg KH <greg@kroah.com>
Subject: Re: [stable] [PATCH 00/12] xen/paravirt_ops patches for 2.6.24
Date: Tue, 13 Nov 2007 16:00:30 -0800
Message-ID: <20071114000030.GA30402@kroah.com>
References: <20071015204840.074767068@goop.org> <4713E2D6.90801@goop.org> <20071113232258.GA10338@kroah.com> <200711140053.33584.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1762040AbXKNAL2@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200711140053.33584.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Linus Torvalds <torvalds@linux-foundation.org>, xen-devel@lists.xensource.com, LKML <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, Andrew Morton <akpm@linux-foundation.org>, Keir Fraser <keir@xensource.com>, Stable Kernel <stable@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Nov 14, 2007 at 12:53:33AM +0100, Andi Kleen wrote:
> 
> > > Subject: [PATCH 12/12] xfs: eagerly remove vmap mappings to avoid
> > > upsetting Xen
> 
> This patch was the wrong fix anyways as discussed; David Chinner
> finally came up with a better one.

Ok, that's good to know, if someone wants to send me the correct one,
that would be appreciated.

Although, it's not like anyone actually uses the in-kernel Xen on
2.6.23, so it's probably not really worth it.

thanks,

greg k-h
