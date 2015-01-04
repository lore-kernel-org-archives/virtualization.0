From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 3/3] virtio_pci: document why we defer kfree
Date: Sun, 4 Jan 2015 18:02:27 +0200
Message-ID: <1420386340-7719-4-git-send-email-mst@redhat.com>
References: <1420386340-7719-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1420386340-7719-1-git-send-email-mst@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org
Cc: sasha.levin@oracle.com, stable@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

The reason we defer kfree until release function is because it's a
general rule for kobjects: kfree of the reference counter itself is only
legal in the release function.

Previous patch didn't make this clear, document this in code.

Cc: stable@vger.kernel.org
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio_pci_legacy.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/virtio/virtio_pci_legacy.c b/drivers/virtio/virtio_pci_legacy.c
index 4beaee3..a5486e6 100644
--- a/drivers/virtio/virtio_pci_legacy.c
+++ b/drivers/virtio/virtio_pci_legacy.c
@@ -216,6 +216,9 @@ static void virtio_pci_release_dev(struct device *_d)
 	struct virtio_device *vdev = dev_to_virtio(_d);
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
 
+	/* As struct device is a kobject, it's not safe to
+	 * free the memory (including the reference counter itself)
+	 * until it's release callback. */
 	kfree(vp_dev);
 }
 
-- 
MST
