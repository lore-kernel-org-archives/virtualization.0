From: rusty@rustcorp.com.au
Subject: [patch 26/43] lguest: guest.h declares a struct timespec,
	make it include linux/time.h
Date: Wed, 26 Sep 2007 16:36:44 +1000
Message-ID: <20070926063649.803988147@rustcorp.com.au>
References: <20070926063618.956228976@rustcorp.com.au>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline; filename=lg-lguest-timespec.diff
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: lguest@ozlabs.org
Cc: Jes Sorensen <jes@sgi.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Signed-off-by: Jes Sorensen <jes@sgi.com>
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 include/linux/lguest.h |    1 +
 1 file changed, 1 insertion(+)

===================================================================
--- linux-2.6.23-rc4.orig/include/linux/lguest.h
+++ linux-2.6.23-rc4/include/linux/lguest.h
@@ -4,6 +4,7 @@
 #define _LINUX_LGUEST_H
 
 #ifndef __ASSEMBLY__
+#include <linux/time.h>
 #include <asm/irq.h>
 #include <asm/lguest_hcall.h>
 

--
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy
