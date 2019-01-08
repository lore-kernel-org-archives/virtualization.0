From: Wei Wang <wei.w.wang@intel.com>
Subject: [PATCH v4 3/3] virtio_balloon: remove the unnecessary 0-initialization
Date: Tue,  8 Jan 2019 12:50:05 +0800
Message-ID: <1546923005-40517-4-git-send-email-wei.w.wang__28684.1566944078$1546925055$gmane$org@intel.com>
References: <1546923005-40517-1-git-send-email-wei.w.wang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1546923005-40517-1-git-send-email-wei.w.wang@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, mst@redhat.com, cohuck@redhat.com
Cc: pasic@linux.ibm.com, dgilbert@redhat.com, pbonzini@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

We've changed to kzalloc the vb struct, so no need to 0-initialize
this field one more time.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
---
 drivers/virtio/virtio_balloon.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index d48c12c..048959a 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -925,7 +925,6 @@ static int virtballoon_probe(struct virtio_device *vdev)
 						  VIRTIO_BALLOON_CMD_ID_STOP);
 		vb->cmd_id_stop = cpu_to_virtio32(vb->vdev,
 						  VIRTIO_BALLOON_CMD_ID_STOP);
-		vb->num_free_page_blocks = 0;
 		spin_lock_init(&vb->free_page_list_lock);
 		INIT_LIST_HEAD(&vb->free_page_list);
 		if (virtio_has_feature(vdev, VIRTIO_BALLOON_F_PAGE_POISON)) {
-- 
2.7.4
