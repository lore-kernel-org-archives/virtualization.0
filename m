From: Halil Pasic <pasic@linux.vnet.ibm.com>
Subject: [PATCH] vhost: fix initialization for vq->is_le
Date: Mon, 30 Jan 2017 11:09:36 +0100
Message-ID: <20170130100936.17065-1-pasic@linux.vnet.ibm.com>
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
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: "Michael A. Tebolt" <miket@us.ibm.com>, kvm@vger.kernel.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Greg Kurz <groug@kaod.org>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Currently, under certain circumstances vhost_init_is_le does just a part
of the initialization job, and depends on vhost_reset_is_le being called
too. For this reason vhost_vq_init_access used to call vhost_reset_is_le
when vq->private_data is NULL. This is not only counter intuitive, but
also real a problem because it breaks vhost_net. The bug was introduced to
vhost_net with commit 2751c9882b94 ("vhost: cross-endian support for
legacy devices"). The symptom is corruption of the vq's used.idx field
(virtio) after VHOST_NET_SET_BACKEND was issued as a part of the vhost
shutdown on a vq with pending descriptors.

Let us make sure the outcome of vhost_init_is_le never depend on the state
it is actually supposed to initialize, and fix virtio_net by removing the
reset from vhost_vq_init_access.

With the above, there is no reason for vhost_reset_is_le to do just half
of the job. Let us make vhost_reset_is_le reinitialize is_le.

Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Reported-by: Michael A. Tebolt <miket@us.ibm.com>
Reported-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Fixes: commit 2751c9882b94 ("vhost: cross-endian support for legacy devices")
---

The bug was already discussed here: 
http://www.spinics.net/lists/kvm/msg144365.html
This is a follow up patch.

---
 drivers/vhost/vhost.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index d643260..8f99fe0 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -130,14 +130,14 @@ static long vhost_get_vring_endian(struct vhost_virtqueue *vq, u32 idx,
 
 static void vhost_init_is_le(struct vhost_virtqueue *vq)
 {
-	if (vhost_has_feature(vq, VIRTIO_F_VERSION_1))
-		vq->is_le = true;
+	vq->is_le = vhost_has_feature(vq, VIRTIO_F_VERSION_1)
+		|| virtio_legacy_is_little_endian();
 }
 #endif /* CONFIG_VHOST_CROSS_ENDIAN_LEGACY */
 
 static void vhost_reset_is_le(struct vhost_virtqueue *vq)
 {
-	vq->is_le = virtio_legacy_is_little_endian();
+	vhost_init_is_le(vq);
 }
 
 struct vhost_flush_struct {
@@ -1714,10 +1714,8 @@ int vhost_vq_init_access(struct vhost_virtqueue *vq)
 	int r;
 	bool is_le = vq->is_le;
 
-	if (!vq->private_data) {
-		vhost_reset_is_le(vq);
+	if (!vq->private_data)
 		return 0;
-	}
 
 	vhost_init_is_le(vq);
 
-- 
2.8.4
