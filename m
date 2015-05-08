From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] virtio_console: use snprintf() for safety
Date: Fri, 8 May 2015 09:19:02 +0300
Message-ID: <20150508061902.GA14769__38259.2126880356$1431065977$gmane$org@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Amit Shah <amit.shah@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kernel-janitors@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

My static checker complains that this sprintf() can overflow.

vdev->index is selected by ida_simple_get() in register_virtio_device()
so my reading of the code is that this overflow is theoretically
possible.  The max value of "id" is configurable and I'm not sure what
typical values are.

Anyway, it's simple enough to make the buffer larger and I changed it to
snprintf() as well.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 50754d20..8283989 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -1389,7 +1389,7 @@ static void send_sigio_to_port(struct port *port)
 
 static int add_port(struct ports_device *portdev, u32 id)
 {
-	char debugfs_name[16];
+	char debugfs_name[28];
 	struct port *port;
 	struct port_buffer *buf;
 	dev_t devt;
@@ -1492,8 +1492,8 @@ static int add_port(struct ports_device *portdev, u32 id)
 		 * Finally, create the debugfs file that we can use to
 		 * inspect a port's state at any time
 		 */
-		sprintf(debugfs_name, "vport%up%u",
-			port->portdev->vdev->index, id);
+		snprintf(debugfs_name, sizeof(debugfs_name), "vport%up%u",
+			 port->portdev->vdev->index, id);
 		port->debugfs_file = debugfs_create_file(debugfs_name, 0444,
 							 pdrvdata.debugfs_dir,
 							 port,
