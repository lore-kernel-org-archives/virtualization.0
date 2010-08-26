From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 4/4] virtio: console: Send SIGIO on new data arrival on ports
Date: Thu, 26 Aug 2010 10:34:08 +0530
Message-ID: <f4a194ea20c82ee34c532f0cda074faaed3c9fde.1282798831.git.amit.shah@redhat.com>
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

Send a SIGIO signal when new data arrives on a port. This is sent only
when the process has requested for the signal to be sent using fcntl().

Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 drivers/char/virtio_console.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index b74d097..be0a8e4 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -1350,6 +1350,10 @@ static void in_intr(struct virtqueue *vq)
 
 	wake_up_interruptible(&port->waitqueue);
 
+	/* Send a SIGIO indicating new data in case the process asked for it */
+	if (port->async_queue && port->guest_connected)
+		kill_fasync(&port->async_queue, SIGIO, POLL_IN);
+
 	if (is_console_port(port) && hvc_poll(port->cons.hvc))
 		hvc_kick();
 }
-- 
1.7.2.2
