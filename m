From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 03/10] virtio: console: Return -EPIPE to hvc_console if we
	lost the connection
Date: Mon,  5 Apr 2010 19:24:07 +0530
Message-ID: <1270475654-399-4-git-send-email-amit.shah@redhat.com>
References: <1270475654-399-1-git-send-email-amit.shah@redhat.com>
	<1270475654-399-2-git-send-email-amit.shah@redhat.com>
	<1270475654-399-3-git-send-email-amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1270475654-399-3-git-send-email-amit.shah@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Virtualization List <virtualization@lists.linux-foundation.org>
Cc: Amit Shah <amit.shah@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

hvc_console handles -EPIPE properly when the connection to the host is
lost.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 drivers/char/virtio_console.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 1ae11f4..733276d 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -660,7 +660,7 @@ static int put_chars(u32 vtermno, const char *buf, int count)
 
 	port = find_port_by_vtermno(vtermno);
 	if (!port)
-		return 0;
+		return -EPIPE;
 
 	return send_buf(port, (void *)buf, count);
 }
@@ -676,9 +676,13 @@ static int get_chars(u32 vtermno, char *buf, int count)
 {
 	struct port *port;
 
+	/* If we've not set up the port yet, we have no input to give. */
+	if (unlikely(early_put_chars))
+		return 0;
+
 	port = find_port_by_vtermno(vtermno);
 	if (!port)
-		return 0;
+		return -EPIPE;
 
 	/* If we don't have an input queue yet, we can't get input. */
 	BUG_ON(!port->in_vq);
-- 
1.6.2.5
