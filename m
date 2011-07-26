From: ruslanpisarev@gmail.com
Subject: [PATCH 6/7] Xen: fix braces coding style issue in xenbus_probe.h
Date: Tue, 26 Jul 2011 14:17:01 +0300
Message-ID: <1311679021-16691-1-git-send-email-ruslan@rpisarev.org.ua>
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

This is a patch to the xenbus_probe.h file that fixed up braces errors found by the checkpatch.pl tools.

Signed-off-by: Ruslan Pisarev <ruslan@rpisarev.org.ua>
---
 drivers/xen/xenbus/xenbus_probe.h |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/xen/xenbus/xenbus_probe.h b/drivers/xen/xenbus/xenbus_probe.h
index 888b990..22dfd4e 100644
--- a/drivers/xen/xenbus/xenbus_probe.h
+++ b/drivers/xen/xenbus/xenbus_probe.h
@@ -36,8 +36,7 @@
 
 #define XEN_BUS_ID_SIZE			20
 
-struct xen_bus_type
-{
+struct xen_bus_type {
 	char *root;
 	unsigned int levels;
 	int (*get_bus_id)(char bus_id[XEN_BUS_ID_SIZE], const char *nodename);
-- 
1.7.4.1
