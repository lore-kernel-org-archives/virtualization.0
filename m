From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 08/14] virtio: console: remove_port() should return void
Date: Thu,  2 Sep 2010 18:11:47 +0530
Message-ID: <c27febd39ab0051c886449b36fd0d48d3e8843fd.1283430900.git.amit.shah@redhat.com>
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

When a port is removed, we have to assume the port is gone. So a
success/failure return value doesn't make sense.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 drivers/char/virtio_console.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index ecadfa2..0c4ee9b1 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -1116,7 +1116,7 @@ fail:
 }
 
 /* Remove all port-specific data. */
-static int remove_port(struct port *port)
+static void remove_port(struct port *port)
 {
 	struct port_buffer *buf;
 
@@ -1166,7 +1166,6 @@ static int remove_port(struct port *port)
 	debugfs_remove(port->debugfs_file);
 
 	kfree(port);
-	return 0;
 }
 
 /* Any private messages that the Host and Guest want to share */
-- 
1.7.2.2
