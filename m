From: Amit Shah <amit.shah@redhat.com>
Subject: [RFC PATCH 4/8] virtio: console: Ignore port name update request if
	name already set
Date: Thu, 28 Jul 2011 20:05:09 +0530
Message-ID: <eb5ef73c21ccdd2700bc56014a90c878c0540326.1311863438.git.amit.shah@redhat.com>
References: <cover.1311863438.git.amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <cover.1311863438.git.amit.shah@redhat.com>
In-Reply-To: <cover.1311863438.git.amit.shah@redhat.com>
References: <cover.1311863438.git.amit.shah@redhat.com>
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

We don't allow port name changes dynamically for a port.  So any
requests by the host to change the name are ignored.

Before this patch, if the hypervisor sent a port name while we had one
set already, we would leak memory equivalent to the size of the old
name.

This scenario wasn't expected so far, but with the suspend-resume
support, we'll send the VIRTIO_CONSOLE_PORT_READY message after restore,
which can get us into this situation.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 drivers/char/virtio_console.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index fb68b12..3c10b10 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -1394,6 +1394,13 @@ static void handle_control_message(struct ports_device *portdev,
 		break;
 	case VIRTIO_CONSOLE_PORT_NAME:
 		/*
+		 * If we woke up after hibernation, we can get this
+		 * again.  Skip it in that case.
+		 */
+		if (port->name)
+			break;
+
+		/*
 		 * Skip the size of the header and the cpkt to get the size
 		 * of the name that was sent
 		 */
-- 
1.7.6
