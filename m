From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 1/5] char: Emit 'OPENED' events on char device open
Date: Wed,  9 Sep 2009 13:42:01 +0530
Message-ID: <1252483925-26336-3-git-send-email-amit.shah__2037.8316090957$1252484061$gmane$org@redhat.com>
References: <1252483925-26336-1-git-send-email-amit.shah@redhat.com>
	<1252483925-26336-2-git-send-email-amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1252483925-26336-2-git-send-email-amit.shah@redhat.com>
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
opened.

The existing RESET event is triggered when the qemu char state is reset
as well; which may not be as interesting as char device open events.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 qemu-char.c |   14 +++++++++++++-
 qemu-char.h |    1 +
 2 files changed, 14 insertions(+), 1 deletions(-)

diff --git a/qemu-char.c b/qemu-char.c
index c25ed1c..5fe882a 100644
--- a/qemu-char.c
+++ b/qemu-char.c
@@ -474,6 +474,8 @@ static CharDriverState *qemu_chr_open_mux(CharDriverState *drv)
     chr->chr_write = mux_chr_write;
     chr->chr_update_read_handler = mux_chr_update_read_handler;
     chr->chr_accept_input = mux_chr_accept_input;
+
+    qemu_chr_event(chr, CHR_EVENT_OPENED);
     return chr;
 }
 
@@ -622,6 +624,7 @@ static CharDriverState *qemu_chr_open_fd(int fd_in, int fd_out)
     chr->chr_close = fd_chr_close;
 
     qemu_chr_reset(chr);
+    qemu_chr_event(chr, CHR_EVENT_OPENED);
 
     return chr;
 }
@@ -913,8 +916,10 @@ static void pty_chr_state(CharDriverState *chr, int connected)
          * the virtual device linked to our pty. */
         qemu_mod_timer(s->timer, qemu_get_clock(rt_clock) + 1000);
     } else {
-        if (!s->connected)
+        if (!s->connected) {
             qemu_chr_reset(chr);
+            qemu_chr_event(chr, CHR_EVENT_OPENED);
+        }
         s->connected = 1;
     }
 }
@@ -1152,6 +1157,7 @@ static CharDriverState *qemu_chr_open_tty(const char *filename)
     }
     chr->chr_ioctl = tty_serial_ioctl;
     qemu_chr_reset(chr);
+    qemu_chr_event(chr, CHR_EVENT_OPENED);
     return chr;
 }
 #else  /* ! __linux__ && ! __sun__ */
@@ -1297,6 +1303,7 @@ static CharDriverState *qemu_chr_open_pp(const char *filename)
     chr->opaque = drv;
 
     qemu_chr_reset(chr);
+    qemu_chr_event(chr, CHR_EVENT_OPENED);
 
     return chr;
 }
@@ -1576,6 +1583,7 @@ static CharDriverState *qemu_chr_open_win(const char *filename)
         return NULL;
     }
     qemu_chr_reset(chr);
+    qemu_chr_event(chr, CHR_EVENT_OPENED);
     return chr;
 }
 
@@ -1675,6 +1683,7 @@ static CharDriverState *qemu_chr_open_win_pipe(const char *filename)
         return NULL;
     }
     qemu_chr_reset(chr);
+    qemu_chr_event(chr, CHR_EVENT_OPENED);
     return chr;
 }
 
@@ -1689,6 +1698,7 @@ static CharDriverState *qemu_chr_open_win_file(HANDLE fd_out)
     chr->opaque = s;
     chr->chr_write = win_chr_write;
     qemu_chr_reset(chr);
+    qemu_chr_event(chr, CHR_EVENT_OPENED);
     return chr;
 }
 
@@ -1823,6 +1833,7 @@ static CharDriverState *qemu_chr_open_udp(const char *def)
     chr->chr_write = udp_chr_write;
     chr->chr_update_read_handler = udp_chr_update_read_handler;
     chr->chr_close = udp_chr_close;
+    qemu_chr_event(chr, CHR_EVENT_OPENED);
     return chr;
 
 return_err:
@@ -2029,6 +2040,7 @@ static void tcp_chr_connect(void *opaque)
     qemu_set_fd_handler2(s->fd, tcp_chr_read_poll,
                          tcp_chr_read, NULL, chr);
     qemu_chr_reset(chr);
+    qemu_chr_event(chr, CHR_EVENT_OPENED);
 }
 
 #define IACSET(x,a,b,c) x[0] = a; x[1] = b; x[2] = c;
diff --git a/qemu-char.h b/qemu-char.h
index df620bc..d725d48 100644
--- a/qemu-char.h
+++ b/qemu-char.h
@@ -12,6 +12,7 @@
 #define CHR_EVENT_MUX_IN  3 /* mux-focus was set to this terminal */
 #define CHR_EVENT_MUX_OUT 4 /* mux-focus will move on */
 #define CHR_EVENT_CLOSED  5 /* connection closed */
+#define CHR_EVENT_OPENED  6 /* connection opened */
 
 
 #define CHR_IOCTL_SERIAL_SET_PARAMS   1
-- 
1.6.2.5
