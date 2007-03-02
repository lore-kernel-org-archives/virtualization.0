From: Zachary Amsden <zach@vmware.com>
Subject: [PATCH 0/9] Bugfix patches for i386/vmi/paravirt-ops
Date: Thu, 1 Mar 2007 18:53:48 -0800
Message-ID: <200703020253.l222rm5N009643@zach-dev.vmware.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1422721AbXCBCyJ@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <ak@muc.de>, Linus Torvalds <torvalds@osdl.org>, Rusty Russell <rusty@rustcorp.com.au>, Jeremy Fitzhardinge <jeremy@goop.org>, Chris Wright <chrisw@sous-sol.org>, Dan Hecht <dhecht@vmware.com>, Dan Arai <arai@vmware.com>, Andrew Morton <akpm@osdl.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Zachary Amsden <zach@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org

Andi, Linus, we have some critical bugfixes for the VMI paravirt-ops code.
Please apply.  If there are objections to certain pieces, they can be
reworked, but they are pretty much all needed for correctness.  We are
hoping to get these in the next 2.6.21-rc release.

We had quite a few difficulties debugging after the integration of the
hrtimers code, which is why this took so long.  Andrew, add you on
the list in case any further hrtimers integration issues pop up.

Thanks,

Zach
