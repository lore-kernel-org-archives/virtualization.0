From: Zachary Amsden <zach@vmware.com>
Subject: [PATCH 0/9] i386 MMU paravirtualization patches
Date: Fri, 11 Aug 2006 02:16:26 -0700
Message-ID: <200608110916.k7B9GQWw023318@zach-dev.vmware.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1750939AbWHKJQ3@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>, Zachary Amsden <zach@vmware.com>, Chris Wright <chrisw@osdl.org>, Rusty Russell <rusty@rustcorp.com.au>, Jeremy Fitzhardinge <jeremy@goop.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>Zachary Amsden <zach@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org

These patches provide the infrastructure for paravirtualized MMU operations
while at the same time cleaning up and optimizing the pagetable accessors for
i386.  They should be largely uncontroversial and are well tested.  There are
still some performance gains to be had for paravirtualization, but it is more
important to get the native code base that will enable them checked in first.

Zach
