From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 5/5] virtio-pci: switch to PM ops macro to initialise PM
	functions
Date: Thu, 29 Mar 2012 13:58:11 +0530
Message-ID: <4c2119cd05e09252e5359225cf009b5c02b7e000.1333008576.git.amit.shah@redhat.com>
References: <cover.1333008576.git.amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <cover.1333008576.git.amit.shah@redhat.com>
In-Reply-To: <cover.1333008576.git.amit.shah@redhat.com>
References: <cover.1333008576.git.amit.shah@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Virtualization List <virtualization@lists.linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Use the SET_SYSTEM_SLEEP_PM_OPS macro to initialise the suspend/resume
functions in the new PM API.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 drivers/virtio/virtio_pci.c |    7 +------
 1 files changed, 1 insertions(+), 6 deletions(-)

diff --git a/drivers/virtio/virtio_pci.c b/drivers/virtio/virtio_pci.c
index 0fa4f85..2e03d41 100644
--- a/drivers/virtio/virtio_pci.c
+++ b/drivers/virtio/virtio_pci.c
@@ -768,12 +768,7 @@ static int virtio_pci_restore(struct device *dev)
 }
 
 static const struct dev_pm_ops virtio_pci_pm_ops = {
-	.suspend	= virtio_pci_freeze,
-	.resume		= virtio_pci_restore,
-	.freeze		= virtio_pci_freeze,
-	.thaw		= virtio_pci_restore,
-	.restore	= virtio_pci_restore,
-	.poweroff	= virtio_pci_freeze,
+	SET_SYSTEM_SLEEP_PM_OPS(virtio_pci_freeze, virtio_pci_restore)
 };
 #endif
 
-- 
1.7.7.6
