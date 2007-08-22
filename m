From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH] Add I/O hypercalls for i386 paravirt
Date: Wed, 22 Aug 2007 16:14:41 -0700
Message-ID: <46CCC361.6020600@goop.org>
References: <46CBC842.4070100@vmware.com> <46CCB088.8070606@goop.org> <46CCB56F.8090308@superbug.co.uk> <20070822222036.GD3672@sequoia.sous-sol.org> <46CCB8BA.6060007@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S934311AbXHVXOx@vger.kernel.org>
In-Reply-To: <46CCB8BA.6060007@superbug.demon.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: Chris Wright <chrisw@sous-sol.org>, Zachary Amsden <zach@vmware.com>, Andrew Morton <akpm@osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, Rusty Russell <rusty@rustcorp.com.au>, Avi Kivity <avi@qumranet.com>
List-Id: virtualization@lists.linuxfoundation.org

James Courtier-Dutton wrote:
> Ok, so I need to get a new CPU like the Intel Core Duo that has VT
> features? I have an old Pentium 4 at the moment, without any VT features.
>   

No, VT-d (as opposed to VT) is a chipset feature which allows the
hypervisor to control who's allowed to DMA where.  So you'd need a very
new machine with a VT-d capable chipset (which would also have VT, since
all new processors do).

    J
