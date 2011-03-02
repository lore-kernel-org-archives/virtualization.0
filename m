From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 1/2] virtio: console: Don't access vqs if device was unplugged
Date: Wed,  2 Mar 2011 13:53:07 +0530
Message-ID: <3427b13fbaeeb6e0ac0430169bdce957e7871918.1299054025.git.amit.shah__47455.1849918955$1299054271$gmane$org@redhat.com>
References: <cover.1299054025.git.amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <cover.1299054025.git.amit.shah@redhat.com>
In-Reply-To: <cover.1299054025.git.amit.shah@redhat.com>
References: <cover.1299054025.git.amit.shah@redhat.com>
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
Cc: Amit Shah <amit.shah@redhat.com>, stable@kernel.org
List-Id: virtualization@lists.linuxfoundation.org

If a virtio-console device gets unplugged while a port is open, a
subsequent close() call on the port accesses vqs to free up buffers.
This can lead to a crash.

The buffers are already freed up as a result of the call to
unplug_ports() from virtcons_remove().  The fix is to simply not access
vq information if port->portdev is NULL.

Reported-by: juzhang <juzhang@redhat.com>
CC: stable@kernel.org
Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 drivers/char/virtio_console.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 4903931..84b164d 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -388,6 +388,10 @@ static void discard_port_data(struct port *port)
 	unsigned int len;
 	int ret;
 
+	if (!port->portdev) {
+		/* Device has been unplugged.  vqs are already gone. */
+		return;
+	}
 	vq = port->in_vq;
 	if (port->inbuf)
 		buf = port->inbuf;
@@ -470,6 +474,10 @@ static void reclaim_consumed_buffers(struct port *port)
 	void *buf;
 	unsigned int len;
 
+	if (!port->portdev) {
+		/* Device has been unplugged.  vqs are already gone. */
+		return;
+	}
 	while ((buf = virtqueue_get_buf(port->out_vq, &len))) {
 		kfree(buf);
 		port->outvq_full = false;
-- 
1.7.4
