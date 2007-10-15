From: Zachary Amsden <zach@vmware.com>
Subject: Re: [stable] [PATCH 00/12] xen/paravirt_ops patches for 2.6.24
Date: Mon, 15 Oct 2007 16:48:44 -0700
Message-ID: <1192492124.17375.62.camel@bodhitayantram.eng.vmware.com>
References: <20071015204840.074767068@goop.org>
	 <20071015215406.GA1588@kroah.com> <4713E2D6.90801@goop.org>
	 <200710160003.13189.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1763057AbXJOXtX@vger.kernel.org>
In-Reply-To: <200710160003.13189.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, xen-devel@lists.xensource.com, Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>, Stable Kernel <stable@kernel.org>, Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Keir Fraser <keir@xensource.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 2007-10-16 at 00:03 +0200, Andi Kleen wrote:
> > Subject: [PATCH 12/12] xfs: eagerly remove vmap mappings to avoid
> > upsetting Xen
> 
> This should be probably done unconditionally because it's a undefined
> dangerous condition everywhere.

Should be done unconditionally.  One could remap the underlying physical
space to include an MMIO region, and speculative reads from the
cacheable virtual mapping of that region could move the robot arm,
destroying the world.

Zach
