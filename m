From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 1/3] char: Emit 'CLOSED' events on char device close
Date: Tue, 25 Aug 2009 11:47:22 +0530
Message-ID: <1251181044-3696-3-git-send-email-amit.shah__46747.6564379924$1251181332$gmane$org@redhat.com>
References: <1251181044-3696-1-git-send-email-amit.shah@redhat.com>
	<1251181044-3696-2-git-send-email-amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1251181044-3696-2-git-send-email-amit.shah@redhat.com>
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

Notify users of the char interface whenever the file / connection is
closed.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 qemu-char.c |   10 ++++++++++
 qemu-char.h |    1 +
 2 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/qemu-char.c b/qemu-char.c
index be27994..c25ed1c 100644
--- a/qemu-char.c
+++ b/qemu-char.c
@@ -570,6 +570,7 @@ static void fd_chr_read(void *opaque)
     if (size == 0) {
         /* FD has been closed. Remove it from the active list.  */
         qemu_set_fd_handler2(s->fd_in, NULL, NULL, NULL, NULL);
+        qemu_chr_event(chr, CHR_EVENT_CLOSED);
         return;
     }
     if (size > 0) {
@@ -602,6 +603,7 @@ static void fd_chr_close(struct CharDriverState *chr)
     }
 
     qemu_free(s);
+    qemu_chr_event(chr, CHR_EVENT_CLOSED);
 }
 
 /* open a character device to a unix fd */
@@ -690,6 +692,7 @@ static void stdio_read(void *opaque)
     if (size == 0) {
         /* stdin has been closed. Remove it from the active list.  */
         qemu_set_fd_handler2(0, NULL, NULL, NULL, NULL);
+        qemu_chr_event(chr, CHR_EVENT_CLOSED);
         return;
     }
     if (size > 0) {
@@ -943,6 +946,7 @@ static void pty_chr_close(struct CharDriverState *chr)
     qemu_del_timer(s->timer);
     qemu_free_timer(s->timer);
     qemu_free(s);
+    qemu_chr_event(chr, CHR_EVENT_CLOSED);
 }
 
 static CharDriverState *qemu_chr_open_pty(void)
@@ -1264,6 +1268,7 @@ static void pp_close(CharDriverState *chr)
     ioctl(fd, PPRELEASE);
     close(fd);
     qemu_free(drv);
+    qemu_chr_event(chr, CHR_EVENT_CLOSED);
 }
 
 static CharDriverState *qemu_chr_open_pp(const char *filename)
@@ -1390,6 +1395,8 @@ static void win_chr_close(CharDriverState *chr)
         qemu_del_polling_cb(win_chr_pipe_poll, chr);
     else
         qemu_del_polling_cb(win_chr_poll, chr);
+
+    qemu_chr_event(chr, CHR_EVENT_CLOSED);
 }
 
 static int win_chr_init(CharDriverState *chr, const char *filename)
@@ -1779,6 +1786,7 @@ static void udp_chr_close(CharDriverState *chr)
         closesocket(s->fd);
     }
     qemu_free(s);
+    qemu_chr_event(chr, CHR_EVENT_CLOSED);
 }
 
 static CharDriverState *qemu_chr_open_udp(const char *def)
@@ -1999,6 +2007,7 @@ static void tcp_chr_read(void *opaque)
         qemu_set_fd_handler(s->fd, NULL, NULL, NULL);
         closesocket(s->fd);
         s->fd = -1;
+        qemu_chr_event(chr, CHR_EVENT_CLOSED);
     } else if (size > 0) {
         if (s->do_telnetopt)
             tcp_chr_process_IAC_bytes(chr, s, buf, &size);
@@ -2095,6 +2104,7 @@ static void tcp_chr_close(CharDriverState *chr)
         closesocket(s->listen_fd);
     }
     qemu_free(s);
+    qemu_chr_event(chr, CHR_EVENT_CLOSED);
 }
 
 static CharDriverState *qemu_chr_open_tcp(const char *host_str,
diff --git a/qemu-char.h b/qemu-char.h
index 77d4eda..df620bc 100644
--- a/qemu-char.h
+++ b/qemu-char.h
@@ -11,6 +11,7 @@
 #define CHR_EVENT_RESET   2 /* new connection established */
 #define CHR_EVENT_MUX_IN  3 /* mux-focus was set to this terminal */
 #define CHR_EVENT_MUX_OUT 4 /* mux-focus will move on */
+#define CHR_EVENT_CLOSED  5 /* connection closed */
 
 
 #define CHR_IOCTL_SERIAL_SET_PARAMS   1
-- 
1.6.2.5
