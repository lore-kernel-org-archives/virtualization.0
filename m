From: Zachary Amsden <zach@vmware.com>
Subject: [PATCH 0/4] i386 - pte update optimizations
Date: Wed, 11 Apr 2007 22:30:16 -0700
Message-ID: <200704120530.l3C5UGbv022814@zach-dev.vmware.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1422692AbXDLFdL@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@muc.de>, Jeremy Fitzhardinge <jeremy@goop.org>, Rusty Russell <rusty@rustcorp.com.au>, Chris Wright <chrisw@sous-sol.org>, Hugh Dickins <hugh@veritas.com>, David Rientjes <rientjes@google.com>, Michel Lespinasse <walken@vmware.com>, Virtualization Mailing List <virtualization@lists.osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Zachary Amsden <zach@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org

Some PTE optimizations for native and paravirt-ops kernels; this
provides a huge win for shadow mode hypervisors and gets rid of
some unnecessary atomic instructions in native kernels, saving
even more on UP by getting rid of implicit LOCK on xchg instruction.

Zach
