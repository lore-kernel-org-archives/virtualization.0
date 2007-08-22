From: Chris Wright <chrisw@sous-sol.org>
Subject: Re: [PATCH] Add I/O hypercalls for i386 paravirt
Date: Wed, 22 Aug 2007 15:20:36 -0700
Message-ID: <20070822222036.GD3672@sequoia.sous-sol.org>
References: <46CBC842.4070100@vmware.com> <46CCB088.8070606@goop.org> <46CCB56F.8090308@superbug.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S934453AbXHVWVe@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <46CCB56F.8090308@superbug.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: James Courtier-Dutton <James@superbug.co.uk>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Zachary Amsden <zach@vmware.com>, Andrew Morton <akpm@osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, Rusty Russell <rusty@rustcorp.com.au>, Chris Wright <chrisw@sous-sol.org>, Avi Kivity <avi@qumranet.com>
List-Id: virtualization@lists.linuxfoundation.org

* James Courtier-Dutton (James@superbug.co.uk) wrote:
> If one could directly expose a device to the guest, this feature could
> be extremely useful for me.
> Is it possible? How would it manage to handle the DMA bus mastering?

Yes it's possible (Xen supports pci pass through).  Without an IOMMU
(like Intel VT-d or AMD IOMMU) it's not DMA safe.

thanks,
-chris
