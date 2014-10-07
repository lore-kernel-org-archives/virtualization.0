From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH RFC 08/11] virtio_blk: use virtio v1.0 endian
Date: Tue,  7 Oct 2014 16:39:49 +0200
Message-ID: <1412692792-12325-9-git-send-email-cornelia.huck__17058.7790817537$1412704546$gmane$org@de.ibm.com>
References: <1412692792-12325-1-git-send-email-cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1412692792-12325-1-git-send-email-cornelia.huck@de.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org, qemu-devel@nongnu.org, kvm@vger.kernel.org
Cc: thuth@linux.vnet.ibm.com
List-Id: virtualization@lists.linuxfoundation.org

Note that we care only about the fields still in use for virtio v1.0.

Reviewed-by: Thomas Huth <thuth@linux.vnet.ibm.com>
Reviewed-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 drivers/block/virtio_blk.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 0a58140..08a8012 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -119,6 +119,10 @@ static int __virtblk_add_req(struct virtqueue *vq,
 	sg_init_one(&status, &vbr->status, sizeof(vbr->status));
 	sgs[num_out + num_in++] = &status;
 
+	/* we only care about fields valid for virtio-1 */
+	vbr->out_hdr.type = cpu_to_virtio_u32(vq->vdev, vbr->out_hdr.type);
+	vbr->out_hdr.sector = cpu_to_virtio_u64(vq->vdev, vbr->out_hdr.sector);
+
 	return virtqueue_add_sgs(vq, sgs, num_out, num_in, vbr, GFP_ATOMIC);
 }
 
-- 
1.7.9.5
