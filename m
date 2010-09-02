From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 03/14] virtio: console: Check if portdev is valid in
	send_control_msg()
Date: Thu,  2 Sep 2010 18:11:42 +0530
Message-ID: <0d1071314f4858dd2daaace27abadc0b43059d05.1283430900.git.amit.shah@redhat.com>
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

A portdev may have been hot-unplugged while a port was open()ed.  Skip
sending control messages when the portdev isn't valid.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 drivers/char/virtio_console.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 0f115b4..5cd5374 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -410,7 +410,10 @@ static ssize_t __send_control_msg(struct ports_device *portdev, u32 port_id,
 static ssize_t send_control_msg(struct port *port, unsigned int event,
 				unsigned int value)
 {
-	return __send_control_msg(port->portdev, port->id, event, value);
+	/* Did the port get unplugged before userspace closed it? */
+	if (port->portdev)
+		return __send_control_msg(port->portdev, port->id, event, value);
+	return 0;
 }
 
 /* Callers must take the port->outvq_lock */
-- 
1.7.2.2
