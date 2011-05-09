From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 158/206] Staging: hv: Include the contents of logging.h
Date: Mon,  9 May 2011 14:57:20 -0700
Message-ID: <1304978288-22999-158-git-send-email-kys@microsoft.com>
References: <1304978242-22958-1-git-send-email-kys@microsoft.com>
	<1304978288-22999-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1304978288-22999-1-git-send-email-kys@microsoft.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: Haiyang Zhang <haiyangz@microsoft.com>, Abhishek Kane <v-abkane@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

The subject line says it all.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 include/linux/hyperv.h |   70 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 70 insertions(+), 0 deletions(-)

diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index 37fe93e..2e72a47 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -636,4 +636,74 @@ extern void vmbus_get_debug_info(struct vmbus_channel *channel,
 
 extern void vmbus_ontimer(unsigned long data);
 
+
+#define LOWORD(dw) ((unsigned short)(dw))
+#define HIWORD(dw) ((unsigned short)(((unsigned int) (dw) >> 16) & 0xFFFF))
+
+
+
+#define VMBUS				0x0001
+#define STORVSC				0x0002
+#define NETVSC				0x0004
+#define INPUTVSC			0x0008
+#define BLKVSC				0x0010
+#define VMBUS_DRV			0x0100
+#define STORVSC_DRV			0x0200
+#define NETVSC_DRV			0x0400
+#define INPUTVSC_DRV		0x0800
+#define BLKVSC_DRV			0x1000
+
+#define ALL_MODULES			(VMBUS		|\
+							STORVSC		|\
+							NETVSC		|\
+							INPUTVSC	|\
+							BLKVSC		|\
+							VMBUS_DRV	|\
+							STORVSC_DRV	|\
+							NETVSC_DRV	|\
+							INPUTVSC_DRV|\
+							BLKVSC_DRV)
+
+/* Logging Level */
+#define ERROR_LVL				3
+#define WARNING_LVL				4
+#define INFO_LVL				6
+#define DEBUG_LVL				7
+#define DEBUG_LVL_ENTEREXIT			8
+#define DEBUG_RING_LVL				9
+
+extern unsigned int vmbus_loglevel;
+
+#define DPRINT(mod, lvl, fmt, args...) do {\
+	if ((mod & (HIWORD(vmbus_loglevel))) &&	\
+	    (lvl <= LOWORD(vmbus_loglevel)))	\
+		printk(KERN_DEBUG #mod": %s() " fmt "\n", __func__, ## args);\
+	} while (0)
+
+#define DPRINT_DBG(mod, fmt, args...) do {\
+	if ((mod & (HIWORD(vmbus_loglevel))) &&		\
+	    (DEBUG_LVL <= LOWORD(vmbus_loglevel)))	\
+		printk(KERN_DEBUG #mod": %s() " fmt "\n", __func__, ## args);\
+	} while (0)
+
+#define DPRINT_INFO(mod, fmt, args...) do {\
+	if ((mod & (HIWORD(vmbus_loglevel))) &&		\
+	    (INFO_LVL <= LOWORD(vmbus_loglevel)))	\
+		printk(KERN_INFO #mod": " fmt "\n", ## args);\
+	} while (0)
+
+#define DPRINT_WARN(mod, fmt, args...) do {\
+	if ((mod & (HIWORD(vmbus_loglevel))) &&		\
+	    (WARNING_LVL <= LOWORD(vmbus_loglevel)))	\
+		printk(KERN_WARNING #mod": WARNING! " fmt "\n", ## args);\
+	} while (0)
+
+#define DPRINT_ERR(mod, fmt, args...) do {\
+	if ((mod & (HIWORD(vmbus_loglevel))) &&		\
+	    (ERROR_LVL <= LOWORD(vmbus_loglevel)))	\
+		printk(KERN_ERR #mod": %s() ERROR!! " fmt "\n",	\
+		       __func__, ## args);\
+	} while (0)
+
+
 #endif /* _HYPERV_H_ */
-- 
1.7.4.1
