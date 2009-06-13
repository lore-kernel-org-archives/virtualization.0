From: Huang Weiyi <weiyi.huang@gmail.com>
Subject: [PATCH 3/3] xen/dev-evtchn: remove duplicated #include
Date: Sat, 13 Jun 2009 20:21:39 +0800
Message-ID: <1244895699-264-1-git-send-email-weiyi.huang@gmail.com>
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
Cc: virtualization@lists.osdl.org, xen-devel@lists.xensource.com, Huang Weiyi <weiyi.huang@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

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
