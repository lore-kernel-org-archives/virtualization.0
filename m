From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 0 of 7]  lguest host code
Date: Sat, 10 Feb 2007 01:59:06 +1100
Message-ID: <1171033146.2718.157.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1946494AbXBIPAB@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Andi Kleen <ak@muc.de>, Andrew Morton <akpm@linux-foundation.org>, virtualization <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

These seven patches replace [PATCH 6/10], or in the second send, patches
6a. 6b, 6c and 6d.

There are more patches because Andi hassled me about extern decls, so I
had to expose some things.  Tiny patches, but worth separating because
you never know when such changes will break something.  Compiles and
runs here...

Thanks,
Rusty.
