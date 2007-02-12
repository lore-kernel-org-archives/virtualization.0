From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 3/7] cleanup: Make hvc_console.c compile on non-PowerPC
Date: Mon, 12 Feb 2007 14:34:18 +1100
Message-ID: <1171251258.10409.7.camel@localhost.localdomain>
References: <1171251120.10409.2.camel@localhost.localdomain>
	 <1171251185.10409.4.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932943AbXBLDfE@vger.kernel.org>
In-Reply-To: <1171251185.10409.4.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.osdl.org>, Paul Mackerras <paulus@samba.org>
List-Id: virtualization@lists.linuxfoundation.org

There's a really nice console helper (esp. for virtual console
drivers) in drivers/char/hvc_console.c.  It has only ever been used
for PowerPC, though, so it uses NO_IRQ which is only defined there.

Let's fix that so it's more widely useful.  By, say, lguest.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

===================================================================
--- a/drivers/char/hvc_console.c
+++ b/drivers/char/hvc_console.c
@@ -48,6 +48,10 @@
 #define HVC_MINOR	0
 
 #define TIMEOUT		(10)
+
+#ifndef NO_IRQ
+#define NO_IRQ 0
+#endif
 
 /*
  * Wait this long per iteration while trying to push buffered data to the
