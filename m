From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [patch 10/21] Xen-paravirt: Name: dont export paravirt_ops structure, do individual functions
Date: Wed, 14 Feb 2007 19:36:26 +0000
Message-ID: <20070214193626.GA18405@infradead.org>
References: <20070213221729.772002682@goop.org> <20070213221830.238235953@goop.org> <45D260A2.4010200@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932449AbXBNThF@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <45D260A2.4010200@vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zachary Amsden <zach@vmware.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Andi Kleen <ak@muc.de>, Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, xen-devel@lists.xensource.com, Chris Wright <chrisw@sous-sol.org>, Rusty Russell <rusty@rustcorp.com.au>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Feb 13, 2007 at 05:06:42PM -0800, Zachary Amsden wrote:
> >I moved drm_follow_page into the core, to avoid having to wrap the
> >various pte ops.  Unlining kernel_fpu_end and using that in the RAID6
> >code would remove the need to export clts/read_cr0/write_cr0 too.

Please don't push the drm_follow_page part.  Dave and I fixed drm
to not need this junk anymore, and it should be part of the next drm merge.
