From: ruslanpisarev@gmail.com
Subject: [PATCH 7/7] Xen: fix braces and tabs coding style issue in
	xenbus_probe.c This is a patch to the xenbus_probe.c file that
	fixed up braces and tabs errors found by the checkpatch.pl tools.
Date: Tue, 26 Jul 2011 14:17:23 +0300
Message-ID: <1311679043-16735-1-git-send-email-ruslan@rpisarev.org.ua>
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
To: jeremy.fitzhardinge@citrix.com
Cc: Ruslan Pisarev <ruslan@rpisarev.org.ua>, xen-devel@lists.xensource.com, virtualization@lists.linux-foundation.org, konrad.wilk@oracle.com
List-Id: virtualization@lists.linuxfoundation.org

From: Ruslan Pisarev <ruslan@rpisarev.org.ua>

Signed-off-by: Ruslan Pisarev <ruslan@rpisarev.org.ua>
---
 drivers/xen/xenbus/xenbus_probe.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/xen/xenbus/xenbus_probe.c b/drivers/xen/xenbus/xenbus_probe.c
index 7397695..3b53452 100644
--- a/drivers/xen/xenbus/xenbus_probe.c
+++ b/drivers/xen/xenbus/xenbus_probe.c
@@ -309,8 +309,7 @@ void xenbus_unregister_driver(struct xenbus_driver *drv)
 }
 EXPORT_SYMBOL_GPL(xenbus_unregister_driver);
 
-struct xb_find_info
-{
+struct xb_find_info {
 	struct xenbus_device *dev;
 	const char *nodename;
 };
@@ -651,7 +650,7 @@ int xenbus_dev_cancel(struct device *dev)
 EXPORT_SYMBOL_GPL(xenbus_dev_cancel);
 
 /* A flag to determine if xenstored is 'ready' (i.e. has started) */
-int xenstored_ready = 0;
+int xenstored_ready;
 
 
 int register_xenstore_notifier(struct notifier_block *nb)
@@ -774,7 +773,7 @@ static int __init xenbus_init(void)
 
 	return 0;
 
-  out_error:
+out_error:
 	if (page != 0)
 		free_page(page);
 
-- 
1.7.4.1
