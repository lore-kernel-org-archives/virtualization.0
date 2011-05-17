From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 1/2] Connector: Set the CN_NETLINK_USERS correctly
Date: Tue, 17 May 2011 15:25:37 -0700
Message-ID: <1305671138-19443-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

The CN_NETLINK_USERS must be set to the highest valid index +1.
Thanks to Evgeniy for pointing this out.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
---
 include/linux/connector.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/linux/connector.h b/include/linux/connector.h
index 7c60d09..f696bcc 100644
--- a/include/linux/connector.h
+++ b/include/linux/connector.h
@@ -44,7 +44,7 @@
 #define CN_VAL_DRBD			0x1
 #define CN_KVP_IDX			0x9	/* HyperV KVP */
 
-#define CN_NETLINK_USERS		9
+#define CN_NETLINK_USERS		10	/* Highest index + 1 */
 
 /*
  * Maximum connector's message size.
-- 
1.7.4.1
