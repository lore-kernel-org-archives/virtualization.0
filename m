From: Zachary Amsden <zach@vmware.com>
Subject: [PATCH 0/6] VMI paravirt-ops patches
Date: Thu, 14 Dec 2006 22:51:39 -0800
Message-ID: <200612150651.kBF6pdkl025501@zach-dev.vmware.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751158AbWLOGwe@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>, Virtualization Mailing List <virtualization@lists.osdl.org>, Zachary Amsden <zach@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org

These are the patches for the VMI backend to paravirt-ops.  Base
kernel where I tested them was 2.6.19-git20.

Basically, there are only a couple of hooks needed that were left
out of the initial paravirt-ops merge, and then the backend code
is a very straightforward implementation of the paravirt-ops
functions.

Andrew or Linus, please apply or shoot me nasty feedback that I
will promptly turn into marvelous looking code.  I've Cc'd Andi,
who originally was going to take up the patches, but seems to
have been snowed in.

Zach
