From: Jens Osterkamp <jens@linux.vnet.ibm.com>
Subject: [PATCH 1/3] consolidation of MIN and MAX macros in common.h
Date: Tue,  4 May 2010 13:47:47 +0200
Message-ID: <1272973669-6694-2-git-send-email-jens@linux.vnet.ibm.com>
References: <1272973669-6694-1-git-send-email-jens@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1272973669-6694-1-git-send-email-jens@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: e1000-eedc@lists.sourceforge.net, virtualization@lists.linux-foundation.org, evb@yahoogroups.com
Cc: chrisw@redhat.com, Jens Osterkamp <jens@linux.vnet.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

This patch consolidates a modified version of the already existing MIN
macro in lldpad to include/common.h and add a MAX macro.

Signed-off-by: Jens Osterkamp <jens@linux.vnet.ibm.com>
---
 include/common.h       |   14 ++++++++++++++
 include/dcb_protocol.h |    4 ----
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/include/common.h b/include/common.h
index 01746ea..ab07dc2 100644
--- a/include/common.h
+++ b/include/common.h
@@ -387,4 +387,18 @@ typedef int socklen_t;
 
 const char * wpa_ssid_txt(u8 *ssid, size_t ssid_len);
 
+#define MIN(x,y) \
+	({	\
+		typeof (x) __x = (x);	\
+		typeof (y) __y = (y);	\
+		__x < __y ? __x : __y;	\
+	 })
+
+#define MAX(x,y) \
+	({	\
+		typeof (x) __x = (x);	\
+		typeof (y) __y = (y);	\
+		__x > __y ? __x : __y;	\
+	 })
+
 #endif /* COMMON_H */
diff --git a/include/dcb_protocol.h b/include/dcb_protocol.h
index 67f653c..c7b856f 100644
--- a/include/dcb_protocol.h
+++ b/include/dcb_protocol.h
@@ -58,10 +58,6 @@ typedef enum {
 #define DUP_DCBX_TLV_LLINK         0x0020
 #define TOO_MANY_NGHBRS            0x0040
 
-//#ifndef min /*todo: change to min()
-	#define MIN(x, y) ((x) < (y) ? x : y)
-//#endif
-
 #define INIT_DCB_OUI                    {0x00,0x1b,0x21}
 
 bool add_adapter(char *device_name);
-- 
1.7.0.1
