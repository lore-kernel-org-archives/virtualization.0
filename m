From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 0/10] lguest
Date: Fri, 09 Feb 2007 20:11:36 +1100
Message-ID: <1171012296.2718.26.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1946238AbXBIJMV@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@muc.de>, virtualization <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

This patch series is against 2.6.20; some things are in flux, so there
might be issues as other things flow into the latest -git tree.

From the documentation:

Lguest is designed to be a minimal hypervisor for the Linux kernel, for
Linux developers and users to experiment with virtualization with the
minimum of complexity.  Nonetheless, it should have sufficient
features to make it useful for specific tasks, and, of course, you are
encouraged to fork and enhance it.

Features:

- Kernel module which runs in a normal kernel.
- Simple I/O model for communication.
- Simple program to create new guests.
- Logo contains cute puppies: http://lguest.ozlabs.org

Developer features:

- Fun to hack on.
- No ABI: being tied to a specific kernel anyway, you can change
anything.
- Many opportunities for improvement or feature implementation.

Cheers!
Rusty
