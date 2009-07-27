From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 2/3] vnc: add a is_vnc_active() helper
Date: Mon, 27 Jul 2009 23:34:35 +0530
Message-ID: <1248717876-17630-4-git-send-email-amit.shah__30386.9579489858$1248718068$gmane$org@redhat.com>
References: <1248717876-17630-1-git-send-email-amit.shah@redhat.com>
	<1248717876-17630-2-git-send-email-amit.shah@redhat.com>
	<1248717876-17630-3-git-send-email-amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1248717876-17630-3-git-send-email-amit.shah@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org
Cc: Amit Shah <amit.shah@redhat.com>, qemu-devel@nongnu.org, kvm@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

This helper is introduced to query the status of vnc.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 vnc.c |   10 +++++++++-
 vnc.h |    2 +-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/vnc.c b/vnc.c
index de0ff87..e4e78dc 100644
--- a/vnc.c
+++ b/vnc.c
@@ -176,9 +176,17 @@ static void do_info_vnc_client(Monitor *mon, VncState *client)
 #endif
 }
 
-void do_info_vnc(Monitor *mon)
+int is_vnc_active(void)
 {
     if (vnc_display == NULL || vnc_display->display == NULL) {
+        return 0;
+    }
+    return 1;
+}
+
+void do_info_vnc(Monitor *mon)
+{
+    if (!is_vnc_active()) {
         monitor_printf(mon, "Server: disabled\n");
     } else {
         char *serverAddr = vnc_socket_local_addr("     address: %s:%s\n",
diff --git a/vnc.h b/vnc.h
index 3ae95f3..9739c35 100644
--- a/vnc.h
+++ b/vnc.h
@@ -313,7 +313,7 @@ void buffer_append(Buffer *buffer, const void *data, size_t len);
 
 /* Misc helpers */
 
+int is_vnc_active(void);
 char *vnc_socket_local_addr(const char *format, int fd);
 char *vnc_socket_remote_addr(const char *format, int fd);
-
 #endif /* __QEMU_VNC_H */
-- 
1.6.2.5
