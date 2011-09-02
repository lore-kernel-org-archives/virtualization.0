From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 1/1] Staging: hv: Update TODO file
Date: Fri,  2 Sep 2011 08:55:41 -0700
Message-ID: <1314978941-8942-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Based on input from Greg, update the TODO file.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/staging/hv/TODO |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/hv/TODO b/drivers/staging/hv/TODO
index 582fd4a..7c9a93f 100644
--- a/drivers/staging/hv/TODO
+++ b/drivers/staging/hv/TODO
@@ -1,14 +1,11 @@
 TODO:
-	- fix remaining checkpatch warnings and errors
 	- audit the vmbus to verify it is working properly with the
 	  driver model
-	- see if the vmbus can be merged with the other virtual busses
-	  in the kernel
 	- audit the network driver
 	  - checking for carrier inside open is wrong, network device API
             confusion??
-	- audit the block driver
 	- audit the scsi driver
 
 Please send patches for this code to Greg Kroah-Hartman <gregkh@suse.de>,
-Hank Janssen <hjanssen@microsoft.com>, and Haiyang Zhang <haiyangz@microsoft.com>.
+Hank Janssen <hjanssen@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
+K. Y. Srinivasan <kys@microsoft.com>
-- 
1.7.4.1
