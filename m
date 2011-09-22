From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 1/1] Staging: hv: Update the TODO file
Date: Thu, 22 Sep 2011 12:40:50 -0700
Message-ID: <1316720450-26106-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Now that all vmbus audit related comments have been addressed,
update the TODO file to reflect this.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/staging/hv/TODO |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/hv/TODO b/drivers/staging/hv/TODO
index 7c9a93f..fcc57c2 100644
--- a/drivers/staging/hv/TODO
+++ b/drivers/staging/hv/TODO
@@ -1,6 +1,4 @@
 TODO:
-	- audit the vmbus to verify it is working properly with the
-	  driver model
 	- audit the network driver
 	  - checking for carrier inside open is wrong, network device API
             confusion??
-- 
1.7.4.1
