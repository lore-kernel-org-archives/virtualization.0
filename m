From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 14/14] virtio: console: Reference counting portdev structs is
	not needed
Date: Thu,  2 Sep 2010 18:38:30 +0530
Message-ID: <81f52fde226c957e04f8cd97e4b62e5c6bab096e.1283430900.git.amit.shah@redhat.com>
References: <cover.1283430900.git.amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <cover.1283430900.git.amit.shah@redhat.com>
In-Reply-To: <cover.1283430900.git.amit.shah@redhat.com>
References: <cover.1283430900.git.amit.shah@redhat.com>
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

Explain in a comment why there's no need to reference-count the portdev
struct: when a device is yanked out, we can't do anything more with it
anyway so just give up doing anything more with the data or the vqs and
exit cleanly.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 drivers/char/virtio_console.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 1e00221..793817b 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -1723,6 +1723,14 @@ static void virtcons_remove(struct virtio_device *vdev)
 
 	unregister_chrdev(portdev->chr_major, "virtio-portsdev");
 
+	/*
+	 * When yanking out a device, we immediately lose the
+	 * (device-side) queues.  So there's no point in keeping the
+	 * guest side around till we drop our final reference.  This
+	 * also means that any ports which are in an open state will
+	 * have to just stop using the port, as the vqs are going
+	 * away.
+	 */
 	if (use_multiport(portdev)) {
 		struct port_buffer *buf;
 		unsigned int len;
-- 
1.7.2.2
