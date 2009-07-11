From: Huang Weiyi <weiyi.huang@gmail.com>
Subject: [PATCH 13/15] xen: remove duplicated #include
Date: Sat, 11 Jul 2009 09:33:31 +0800
Message-ID: <1247276011-1140-1-git-send-email-weiyi.huang@gmail.com>
Return-path: <xen-devel-bounces@lists.xensource.com>
List-Unsubscribe: <http://lists.xensource.com/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: jeremy.fitzhardinge@citrix.com
Cc: virtualization@lists.osdl.org, xen-devel@lists.xensource.com, Huang Weiyi <weiyi.huang@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

Remove duplicated #include('s) in
  drivers/xen/evtchn.c

Signed-off-by: Huang Weiyi <weiyi.huang@gmail.com>
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
1.6.1.2
