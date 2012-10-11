From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH] virtio-pci: use module_pci_driver to simplify the code
Date: Thu, 11 Oct 2012 09:10:53 +0800
Message-ID: <CAPgLHd-GzSDQ+E-zboLA8RfbOVk5bHFK+NTDe2WkWihVFVCtmA__16348.008105024$1349917883$gmane$org@mail.gmail.com>
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
To: rusty@rustcorp.com.au, mst@redhat.com
Cc: yongjun_wei@trendmicro.com.cn, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Use the module_pci_driver() macro to make the code simpler
by eliminating module_init and module_exit calls.

dpatch engine is used to auto generate this patch.
(https://github.com/weiyj/dpatch)

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/virtio/virtio_pci.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/virtio/virtio_pci.c b/drivers/virtio/virtio_pci.c
index c33aea3..b59237c 100644
--- a/drivers/virtio/virtio_pci.c
+++ b/drivers/virtio/virtio_pci.c
@@ -830,16 +830,4 @@ static struct pci_driver virtio_pci_driver = {
 #endif
 };
 
-static int __init virtio_pci_init(void)
-{
-	return pci_register_driver(&virtio_pci_driver);
-}
-
-module_init(virtio_pci_init);
-
-static void __exit virtio_pci_exit(void)
-{
-	pci_unregister_driver(&virtio_pci_driver);
-}
-
-module_exit(virtio_pci_exit);
+module_pci_driver(virtio_pci_driver);
