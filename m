From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 4/5] vnc: add a is_vnc_active() helper
Date: Wed,  9 Sep 2009 13:42:04 +0530
Message-ID: <1252483925-26336-6-git-send-email-amit.shah__16705.9809821241$1252484084$gmane$org@redhat.com>
References: <1252483925-26336-1-git-send-email-amit.shah@redhat.com>
	<1252483925-26336-2-git-send-email-amit.shah@redhat.com>
	<1252483925-26336-3-git-send-email-amit.shah@redhat.com>
	<1252483925-26336-4-git-send-email-amit.shah@redhat.com>
	<1252483925-26336-5-git-send-email-amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1252483925-26336-5-git-send-email-amit.shah@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: qemu-devel@nongnu.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
Cc: Amit Shah <amit.shah@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

This helper is introduced to query the status of vnc.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 vnc.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/vnc.c b/vnc.c
index 5eaef6a..ff2d4a8 100644
--- a/vnc.c
+++ b/vnc.c
@@ -178,9 +178,17 @@ static void do_info_vnc_client(Monitor *mon, VncState *client)
 #endif
 }
 
-void do_info_vnc(Monitor *mon)
+static int is_vnc_active(void)
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
-- 
1.6.2.5
