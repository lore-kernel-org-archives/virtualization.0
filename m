From: Chris Wright <chrisw@sous-sol.org>
Subject: Re: [PATCH] Add I/O hypercalls for i386 paravirt
Date: Wed, 22 Aug 2007 15:34:24 -0700
Message-ID: <20070822223424.GE3672@sequoia.sous-sol.org>
References: <46CBC842.4070100@vmware.com> <46CCB088.8070606@goop.org> <46CCB56F.8090308@superbug.co.uk> <20070822222036.GD3672@sequoia.sous-sol.org> <46CCB8BA.6060007@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S934308AbXHVWfK@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <46CCB8BA.6060007@superbug.demon.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: Chris Wright <chrisw@sous-sol.org>, Jeremy Fitzhardinge <jeremy@goop.org>, Zachary Amsden <zach@vmware.com>, Andrew Morton <akpm@osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, Rusty Russell <rusty@rustcorp.com.au>, Avi Kivity <avi@qumranet.com>
List-Id: virtualization@lists.linuxfoundation.org

* James Courtier-Dutton (James@superbug.demon.co.uk) wrote:
> Ok, so I need to get a new CPU like the Intel Core Duo that has VT
> features? I have an old Pentium 4 at the moment, without any VT features.

Depends on your goals.  You can certainly give a paravirt Xen guest[1]
physical hardware without any VT extentions.  But that guest will be
able to DMA anywhere in memory without VT-d, so if it's an untrusted
guest you'd be taking a huge risk.

thanks,
-chris

[1] Note: this is with the xenbits.xensource.com kernel, not with a
kernel you'll get from kernel.org ATM.
