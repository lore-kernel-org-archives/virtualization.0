From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 1/3] virtio: console: Resize console port 0 on config intr
	only if multiport is off
Date: Thu,  6 May 2010 02:05:07 +0530
Message-ID: <1273091709-19963-2-git-send-email-amit.shah__3159.3257830993$1273094791$gmane$org@redhat.com>
References: <1273091709-19963-1-git-send-email-amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1273091709-19963-1-git-send-email-amit.shah@redhat.com>
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
Cc: Amit Shah <amit.shah@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Kusanagi Kouichi <slash@ac.auone-net.jp>, linuxppc-dev@ozlabs.org, Virtualization List <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

When using multiport, we'll use control messages. Ensure we don't
accidentally update port 0 size on config interrupts.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
CC: Christian Borntraeger <borntraeger@de.ibm.com>
CC: linuxppc-dev@ozlabs.org
CC: Kusanagi Kouichi <slash@ac.auone-net.jp>
---
 drivers/char/virtio_console.c |   17 ++++++++++-------
 1 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index a64558f..e2d05ea 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -1319,13 +1319,16 @@ static void config_intr(struct virtio_device *vdev)
 
 	portdev = vdev->priv;
 
-	/*
-	 * We'll use this way of resizing only for legacy support.
-	 * For newer userspace (VIRTIO_CONSOLE_F_MULTPORT+), use
-	 * control messages to indicate console size changes so that
-	 * it can be done per-port
-	 */
-	resize_console(find_port_by_id(portdev, 0));
+	if (!use_multiport(portdev)) {
+		/*
+		 * We'll use this way of resizing only for legacy
+		 * support.  For newer userspace
+		 * (VIRTIO_CONSOLE_F_MULTPORT+), use control messages
+		 * to indicate console size changes so that it can be
+		 * done per-port.
+		 */
+		resize_console(find_port_by_id(portdev, 0));
+	}
 }
 
 static int init_vqs(struct ports_device *portdev)
-- 
1.6.2.5
