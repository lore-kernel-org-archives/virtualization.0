From: ruslanpisarev@gmail.com
Subject: [PATCH 5/7] Xen: fix whitespaces,
	tabs coding style issue in drivers/xen/xenbus/xenbus_client.c
Date: Tue, 26 Jul 2011 14:16:49 +0300
Message-ID: <1311679009-16659-1-git-send-email-ruslan@rpisarev.org.ua>
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

This is a patch to the xenbus_client.c file that fixed up whitespaces, tabs errors found by the checkpatch.pl tools.

Signed-off-by: Ruslan Pisarev <ruslan@rpisarev.org.ua>
---
 drivers/xen/xenbus/xenbus_client.c |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/xen/xenbus/xenbus_client.c b/drivers/xen/xenbus/xenbus_client.c
index cdacf92..ff4f03c 100644
--- a/drivers/xen/xenbus/xenbus_client.c
+++ b/drivers/xen/xenbus/xenbus_client.c
@@ -43,15 +43,15 @@
 const char *xenbus_strstate(enum xenbus_state state)
 {
 	static const char *const name[] = {
-		[ XenbusStateUnknown      ] = "Unknown",
-		[ XenbusStateInitialising ] = "Initialising",
-		[ XenbusStateInitWait     ] = "InitWait",
-		[ XenbusStateInitialised  ] = "Initialised",
-		[ XenbusStateConnected    ] = "Connected",
-		[ XenbusStateClosing      ] = "Closing",
-		[ XenbusStateClosed	  ] = "Closed",
-		[XenbusStateReconfiguring] = "Reconfiguring",
-		[XenbusStateReconfigured] = "Reconfigured",
+		[XenbusStateUnknown] =		"Unknown",
+		[XenbusStateInitialising] =	"Initialising",
+		[XenbusStateInitWait] =		"InitWait",
+		[XenbusStateInitialised] =	"Initialised",
+		[XenbusStateConnected] =	"Connected",
+		[XenbusStateClosing] =		"Closing",
+		[XenbusStateClosed] =		"Closed",
+		[XenbusStateReconfiguring] =	"Reconfiguring",
+		[XenbusStateReconfigured] =	"Reconfigured",
 	};
 	return (state < ARRAY_SIZE(name)) ? name[state] : "INVALID";
 }
-- 
1.7.4.1
