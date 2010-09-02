From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 3/3] virtio: console: Send SIGIO in case of port unplug
Date: Thu,  2 Sep 2010 18:47:54 +0530
Message-ID: <04e7f90d7eed7f18c9f0cae4de96253d0a8dc532.1283433264.git.amit.shah@redhat.com>
References: <cover.1283433264.git.amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <cover.1283433264.git.amit.shah@redhat.com>
In-Reply-To: <cover.1283433264.git.amit.shah@redhat.com>
References: <cover.1283433264.git.amit.shah@redhat.com>
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

If a port has registered for SIGIO signals, let the application
know that the port is getting unplugged.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 drivers/char/virtio_console.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index a750d2b..f7adfd3 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -1244,6 +1244,9 @@ static void unplug_port(struct port *port)
 		port->guest_connected = false;
 		port->host_connected = false;
 		wake_up_interruptible(&port->waitqueue);
+
+		/* Let the app know the port is going down. */
+		send_sigio_to_port(port);
 	}
 
 	if (is_console_port(port)) {
-- 
1.7.2.2
