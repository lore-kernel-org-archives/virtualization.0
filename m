From: Andrew Vagin <avagin@openvz.org>
Subject: [PATCH] virtio-pci: fix leaks of msix_affinity_masks
Date: Wed, 19 Jun 2013 19:59:48 +0400
Message-ID: <1371657588-2782922-1-git-send-email-avagin__7755.65974549881$1371679116$gmane$org@openvz.org>
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
To: virtualization@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org, Andrew Vagin <avagin@openvz.org>, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

vp_dev->msix_vectors should be initialized before allocating
msix_affinity_masks, otherwise vp_free_vectors will not free these
objects.

unreferenced object 0xffff88010f969d88 (size 512):
  comm "systemd-udevd", pid 158, jiffies 4294673645 (age 80.545s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff816e455e>] kmemleak_alloc+0x5e/0xc0
    [<ffffffff811aa7f1>] kmem_cache_alloc_node_trace+0x141/0x2c0
    [<ffffffff8133ba23>] alloc_cpumask_var_node+0x23/0x80
    [<ffffffff8133ba8e>] alloc_cpumask_var+0xe/0x10
    [<ffffffff813fdb3d>] vp_try_to_find_vqs+0x25d/0x810
    [<ffffffff813fe171>] vp_find_vqs+0x81/0xb0
    [<ffffffffa00d2a05>] init_vqs+0x85/0x120 [virtio_balloon]
    [<ffffffffa00d2c29>] virtballoon_probe+0xf9/0x1a0 [virtio_balloon]
    [<ffffffff813fb61e>] virtio_dev_probe+0xde/0x140
    [<ffffffff814452b8>] driver_probe_device+0x98/0x3a0
    [<ffffffff8144566b>] __driver_attach+0xab/0xb0
    [<ffffffff814432f4>] bus_for_each_dev+0x94/0xb0
    [<ffffffff81444f4e>] driver_attach+0x1e/0x20
    [<ffffffff81444910>] bus_add_driver+0x200/0x280
    [<ffffffff81445c14>] driver_register+0x74/0x160
    [<ffffffff813fb7d0>] register_virtio_driver+0x20/0x40

Cc: Rusty Russell <rusty@rustcorp.com.au>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Signed-off-by: Andrew Vagin <avagin@openvz.org>
---
 drivers/virtio/virtio_pci.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/virtio/virtio_pci.c b/drivers/virtio/virtio_pci.c
index a7ce730..3c0a6ef 100644
--- a/drivers/virtio/virtio_pci.c
+++ b/drivers/virtio/virtio_pci.c
@@ -309,6 +309,8 @@ static int vp_request_msix_vectors(struct virtio_device *vdev, int nvectors,
 	unsigned i, v;
 	int err = -ENOMEM;
 
+	vp_dev->msix_vectors = nvectors;
+
 	vp_dev->msix_entries = kmalloc(nvectors * sizeof *vp_dev->msix_entries,
 				       GFP_KERNEL);
 	if (!vp_dev->msix_entries)
@@ -336,7 +338,6 @@ static int vp_request_msix_vectors(struct virtio_device *vdev, int nvectors,
 		err = -ENOSPC;
 	if (err)
 		goto error;
-	vp_dev->msix_vectors = nvectors;
 	vp_dev->msix_enabled = 1;
 
 	/* Set the vector used for configuration */
-- 
1.7.1
