From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH RFC v3 11/16] virtio_blk: use virtio v1.0 endian
Date: Wed, 22 Oct 2014 21:44:51 +0300
Message-ID: <1414003404-505-12-git-send-email-mst__47949.0516860553$1414003344$gmane$org@redhat.com>
References: <1414003404-505-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1414003404-505-1-git-send-email-mst@redhat.com>
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
Cc: David Hildenbrand <dahi@linux.vnet.ibm.com>, Thomas Huth <thuth@linux.vnet.ibm.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

From: Cornelia Huck <cornelia.huck@de.ibm.com>

Note that we care only about the fields still in use for virtio v1.0.

Reviewed-by: Thomas Huth <thuth@linux.vnet.ibm.com>
Reviewed-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/block/virtio_blk.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index c6a27d5..327e601 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -113,6 +113,10 @@ static int __virtblk_add_req(struct virtqueue *vq,
 	sg_init_one(&status, &vbr->status, sizeof(vbr->status));
 	sgs[num_out + num_in++] = &status;
 
+	/* we only care about fields valid for virtio-1 */
+	vbr->out_hdr.type = cpu_to_virtio32(vq->vdev, vbr->out_hdr.type);
+	vbr->out_hdr.sector = cpu_to_virtio64(vq->vdev, vbr->out_hdr.sector);
+
 	return virtqueue_add_sgs(vq, sgs, num_out, num_in, vbr, GFP_ATOMIC);
 }
 
-- 
MST
