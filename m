From: Jaswinder Singh Rajput <jaswinder@kernel.org>
Subject: [PATCH] XEN: includecheck fix for drivers/xen/evtchn.c
Date: Sun, 09 Aug 2009 20:07:41 +0530
Message-ID: <1249828661.2957.18.camel@ht.satnam>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
List-Unsubscribe: <http://lists.xensource.com/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Jeremy Fitzhardinge <jeremy@xensource.com>, Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, xen-devel@lists.xensource.com
List-Id: virtualization@lists.linuxfoundation.org


fix the following 'make includecheck' warning:

  drivers/xen/evtchn.c: linux/errno.h is included more than once.

Signed-off-by: Jaswinder Singh Rajput <jaswinderrajput@gmail.com>
---
 drivers/xen/evtchn.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/xen/evtchn.c b/drivers/xen/evtchn.c
index af03195..79bedba 100644
--- a/drivers/xen/evtchn.c
+++ b/drivers/xen/evtchn.c
@@ -38,7 +38,6 @@
 #include <linux/string.h>
 #include <linux/errno.h>
 #include <linux/fs.h>
-#include <linux/errno.h>
 #include <linux/miscdevice.h>
 #include <linux/major.h>
 #include <linux/proc_fs.h>
-- 
1.6.0.6
