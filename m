From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 2/3] virtio: virtio_pci should not set bus_id.
Date: Thu, 22 May 2008 21:48:10 -0500
Message-ID: <200805231248.11321.rusty__12543.7410934412$1211511021$gmane$org@rustcorp.com.au>
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

The common virtio code sets the bus_id, overriding anything virtio_pci
sets anyway.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Carsten Otte <cotte@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Chris Lalancette <clalance@redhat.com>
Cc: Anthony Liguori <anthony@codemonkey.ws>
---
 drivers/virtio/virtio_pci.c |    1 -
 1 file changed, 1 deletion(-)

diff -r 2f0d0ce2adbf drivers/virtio/virtio_pci.c
--- a/drivers/virtio/virtio_pci.c	Fri May 23 11:55:02 2008 +1000
+++ b/drivers/virtio/virtio_pci.c	Fri May 23 12:23:39 2008 +1000
@@ -325,7 +322,6 @@ static int __devinit virtio_pci_probe(st
 	if (vp_dev == NULL)
 		return -ENOMEM;
 
-	snprintf(vp_dev->vdev.dev.bus_id, BUS_ID_SIZE, "virtio%d", dev_index);
 	vp_dev->vdev.index = dev_index;
 	dev_index++;
