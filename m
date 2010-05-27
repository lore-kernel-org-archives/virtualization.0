From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 2/2] virtio: console: Fix crash when port is unplugged and
	blocked for write
Date: Thu, 27 May 2010 13:24:40 +0530
Message-ID: <db3f30b6211d5a0b4d4e0acaddc6cedf9018e749.1274946878.git.amit.shah@redhat.com>
References: <712d1fa57175fb900ca6ebb133849497f4c2448b.1274946878.git.amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <712d1fa57175fb900ca6ebb133849497f4c2448b.1274946878.git.amit.shah@redhat.com>
In-Reply-To: <712d1fa57175fb900ca6ebb133849497f4c2448b.1274946878.git.amit.shah@redhat.com>
References: <712d1fa57175fb900ca6ebb133849497f4c2448b.1274946878.git.amit.shah@redhat.com>
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

When a program that has a virtio port opened and blocked for a write
operation, a port hot-unplug event will later led to a crash when
SIGTERM was sent to the program. Fix that.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 drivers/char/virtio_console.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index e3fb529..942a982 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -529,6 +529,10 @@ static bool will_write_block(struct port *port)
 {
 	bool ret;
 
+	if (!port->guest_connected) {
+		/* Port got hot-unplugged. Let's exit. */
+		return false;
+	}
 	if (!port->host_connected)
 		return true;
 
-- 
1.7.0.1
