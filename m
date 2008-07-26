From: Huang Weiyi <weiyi.huang@gmail.com>
Subject: drivers/xen/balloon.c: Removed duplicated include
Date: Sat, 26 Jul 2008 19:37:59 +0800
Message-ID: <20080726115509.F23D.WEIYI.HUANG@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: jeremy@xensource.com, chrisw@sous-sol.org
Cc: virtualization@lists.osdl.org, xen-devel@lists.xensource.com
List-Id: virtualization@lists.linuxfoundation.org

Removed duplicated include file <linux/highmem.h> in 
drivers/xen/balloon.c.

Signed-off-by: Huang Weiyi <weiyi.huang@gmail.com>

diff --git a/drivers/xen/balloon.c b/drivers/xen/balloon.c
index d4427cb..afdeac5 100644
--- a/drivers/xen/balloon.c
+++ b/drivers/xen/balloon.c
@@ -41,7 +41,6 @@
 #include <linux/pagemap.h>
 #include <linux/highmem.h>
 #include <linux/mutex.h>
-#include <linux/highmem.h>
 #include <linux/list.h>
 #include <linux/sysdev.h>
