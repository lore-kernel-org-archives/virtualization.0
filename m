From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 1/2] virtio: console: Fix poll blocking even though there is
	data to read
Date: Thu, 16 Sep 2010 14:43:08 +0530
Message-ID: <6c7c2590a114d65ec52689be7cda7ada5ee876d5.1284628364.git.amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
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
Cc: Amit Shah <amit.shah@redhat.com>, Hans de Goede <hdegoede@redhat.com>, Virtualization List <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

From: Hans de Goede <hdegoede@redhat.com>

I found this while working on a Linux agent for spice, the symptom I was
seeing was select blocking on the spice vdagent virtio serial port even
though there were messages queued up there.

virtio_console's port_fops_poll checks port->inbuf != NULL to determine
if read won't block. However if an application reads enough bytes from
inbuf through port_fops_read, to empty the current port->inbuf,
port->inbuf will be NULL even though there may be buffers left in the
virtqueue.

This causes poll() to block even though there is data to be read,
this patch fixes this by using will_read_block(port) instead of the
port->inbuf != NULL check.

Signed-off-By: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 drivers/char/virtio_console.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index be67d6b..2dbcd41 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -710,7 +710,7 @@ static unsigned int port_fops_poll(struct file *filp, poll_table *wait)
 		return POLLHUP;
 	}
 	ret = 0;
-	if (port->inbuf)
+	if (!will_read_block(port))
 		ret |= POLLIN | POLLRDNORM;
 	if (!will_write_block(port))
 		ret |= POLLOUT;
-- 
1.7.2.3
