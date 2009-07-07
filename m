From: Mark McLoughlin <markmc@redhat.com>
Subject: [PATCH] virtio-pci: correctly unregister root device on error
Date: Tue, 07 Jul 2009 08:26:45 +0100
Message-ID: <1246951605.2836.8.camel__8655.25933118097$1246951676$gmane$org@blaa>
Reply-To: Mark McLoughlin <markmc@redhat.com>
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
Cc: Don Zickus <dzickus@redhat.com>, linux-kernel <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

If pci_register_driver() fails we're incorrectly unregistering the root
device with device_unregister() rather than root_device_unregister().

Reported-by: Don Zickus <dzickus@redhat.com>
Signed-off-by: Mark McLoughlin <markmc@redhat.com>
---
 drivers/virtio/virtio_pci.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/virtio/virtio_pci.c b/drivers/virtio/virtio_pci.c
index 330aacb..2cafa62 100644
--- a/drivers/virtio/virtio_pci.c
+++ b/drivers/virtio/virtio_pci.c
@@ -440,7 +440,7 @@ static int __init virtio_pci_init(void)
 
 	err = pci_register_driver(&virtio_pci_driver);
 	if (err)
-		device_unregister(virtio_pci_root);
+		root_device_unregister(virtio_pci_root);
 
 	return err;
 }
-- 
1.6.2.5
