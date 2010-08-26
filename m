From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 1/4] virtio: console: Un-block reads on chardev close
Date: Thu, 26 Aug 2010 10:34:05 +0530
Message-ID: <c532756703e7e8fc26fc75c391ff92b4a52a321b.1282798831.git.amit.shah@redhat.com>
References: <cover.1282798831.git.amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <cover.1282798831.git.amit.shah@redhat.com>
In-Reply-To: <cover.1282798831.git.amit.shah@redhat.com>
References: <cover.1282798831.git.amit.shah@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Amit Shah <amit.shah@redhat.com>, Virtualization List <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

If a chardev is closed, any blocked read / poll calls should just return
and not attempt to use other state.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 drivers/char/virtio_console.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 942a982..92ae3f8 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -522,6 +522,10 @@ static ssize_t fill_readbuf(struct port *port, char *out_buf, size_t out_count,
 /* The condition that must be true for polling to end */
 static bool will_read_block(struct port *port)
 {
+	if (!port->guest_connected) {
+		/* Port got hot-unplugged. Let's exit. */
+		return false;
+	}
 	return !port_has_data(port) && port->host_connected;
 }
 
-- 
1.7.2.2
