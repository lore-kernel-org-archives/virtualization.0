From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 2/6] virtio: console: Check if port is valid in resize_console
Date: Fri, 19 Mar 2010 17:36:44 +0530
Message-ID: <1269000408-29962-3-git-send-email-amit.shah@redhat.com>
References: <1269000408-29962-1-git-send-email-amit.shah@redhat.com>
	<1269000408-29962-2-git-send-email-amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1269000408-29962-2-git-send-email-amit.shah@redhat.com>
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
Cc: Amit Shah <amit.shah@redhat.com>, quintela@redhat.com, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

The console port could have been hot-unplugged. Check if it is valid
before working on it.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 drivers/char/virtio_console.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 67b474b..44288ce 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -681,6 +681,10 @@ static void resize_console(struct port *port)
 	struct virtio_device *vdev;
 	struct winsize ws;
 
+	/* The port could have been hot-unplugged */
+	if (!port)
+		return;
+
 	vdev = port->portdev->vdev;
 	if (virtio_has_feature(vdev, VIRTIO_CONSOLE_F_SIZE)) {
 		vdev->config->get(vdev,
-- 
1.6.2.5
