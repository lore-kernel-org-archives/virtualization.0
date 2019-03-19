From: Pankaj Gupta <pagupta@redhat.com>
Subject: [PATCH] virtio_console: initialize vtermno value for ports
Date: Tue, 19 Mar 2019 11:34:06 +0530
Message-ID: <20190319060406.26863-1-pagupta__7355.41779301769$1552975586$gmane$org@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
Cc: pagupta@redhat.com, arnd@arndb.de, mst@redhat.com, gregkh@linuxfoundation.org, amit@kernel.org, siliu@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

For regular serial ports we do not initialize value of vtermno 
variable. A garbage value is assigned for non console ports.
The value can be observed as a random integer with [1]. 

[1] vim /sys/kernel/debug/virtio-ports/vport*p*

This patch initialize the value of vtermno for console serial 
ports to '1' and regular serial ports are initiaized to '0'.

Reported-by: siliu@redhat.com
Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
---
 drivers/char/virtio_console.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index fbeb71953526..05dbfdb9f4af 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -75,7 +75,7 @@ struct ports_driver_data {
 	/* All the console devices handled by this driver */
 	struct list_head consoles;
 };
-static struct ports_driver_data pdrvdata;
+static struct ports_driver_data pdrvdata = { .next_vtermno = 1};
 
 static DEFINE_SPINLOCK(pdrvdata_lock);
 static DECLARE_COMPLETION(early_console_added);
@@ -1394,6 +1394,7 @@ static int add_port(struct ports_device *portdev, u32 id)
 	port->async_queue = NULL;
 
 	port->cons.ws.ws_row = port->cons.ws.ws_col = 0;
+	port->cons.vtermno = 0;
 
 	port->host_connected = port->guest_connected = false;
 	port->stats = (struct port_stats) { 0 };
-- 
2.20.1
