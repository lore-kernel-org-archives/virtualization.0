From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 1/3] virtio: bus_id for devices should contain 'virtio'
Date: Thu, 22 May 2008 21:47:50 -0500
Message-ID: <200805231247.50751.rusty__27683.725502766$1211510999$gmane$org@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org
Cc: Carsten Otte <cotte@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, Anthony Liguori <anthony@codemonkey.ws>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

Chris Lalancette <clalance@redhat.com> points out that virtio.c sets all device
names to '0', '1', etc, which looks silly in /proc/interrupts.  We change this
from '%d' to 'virtio%d'.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Carsten Otte <cotte@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Chris Lalancette <clalance@redhat.com>
Cc: Anthony Liguori <anthony@codemonkey.ws>
---
 drivers/virtio/virtio.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -r 2f0d0ce2adbf drivers/virtio/virtio.c
--- a/drivers/virtio/virtio.c	Fri May 23 11:55:02 2008 +1000
+++ b/drivers/virtio/virtio.c	Fri May 23 12:23:39 2008 +1000
@@ -166,7 +169,7 @@ int register_virtio_device(struct virtio
 	int err;
 
 	dev->dev.bus = &virtio_bus;
-	sprintf(dev->dev.bus_id, "%u", dev->index);
+	sprintf(dev->dev.bus_id, "virtio%u", dev->index);
 
 	/* We always start by resetting the device, in case a previous
 	 * driver messed it up.  This also tests that code path a little. */
