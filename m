From: Greg Kurz <gkurz@linux.vnet.ibm.com>
Subject: [PATCH 3/3] vhost_net: fix virtio_net header endianness
Date: Fri, 20 Feb 2015 11:15:05 +0100
Message-ID: <20150220101454.18608.64016.stgit__47325.9630417035$1424427342$gmane$org@bahia.local>
References: <20150220100724.18608.74654.stgit@bahia.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20150220100724.18608.74654.stgit@bahia.local>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Cedric Le Goater <clg@fr.ibm.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Without this patch, packets are being silently dropped by the tap backend.

Signed-off-by: Greg Kurz <gkurz@linux.vnet.ibm.com>
---
 drivers/vhost/net.c |   32 ++++++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index afa06d2..2923eee 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -288,6 +288,16 @@ static void vhost_zerocopy_callback(struct ubuf_info *ubuf, bool success)
 	rcu_read_unlock_bh();
 }
 
+static void fix_virtio_net_hdr(struct vhost_virtqueue *vq)
+{
+	struct virtio_net_hdr *hdr = vq->iov[0].iov_base;
+
+	hdr->hdr_len = vhost16_to_cpu(vq, hdr->hdr_len);
+	hdr->gso_size = vhost16_to_cpu(vq, hdr->gso_size);
+	hdr->csum_start  = vhost16_to_cpu(vq, hdr->csum_start);
+	hdr->csum_offset = vhost16_to_cpu(vq, hdr->csum_offset);
+}
+
 /* Expects to be always run from workqueue - which acts as
  * read-size critical section for our kind of RCU. */
 static void handle_tx(struct vhost_net *net)
@@ -352,6 +362,10 @@ static void handle_tx(struct vhost_net *net)
 			       "out %d, int %d\n", out, in);
 			break;
 		}
+
+		if (!hdr_size)
+			fix_virtio_net_hdr(vq);
+
 		/* Skip header. TODO: support TSO. */
 		len = iov_length(vq->iov, out);
 		iov_iter_init(&msg.msg_iter, WRITE, vq->iov, out, len);
@@ -609,12 +623,18 @@ static void handle_rx(struct vhost_net *net)
 			continue;
 		}
 		/* Supply virtio_net_hdr if VHOST_NET_F_VIRTIO_NET_HDR */
-		if (unlikely(vhost_hlen) &&
-		    copy_to_iter(&hdr, sizeof(hdr), &fixup) != sizeof(hdr)) {
-			vq_err(vq, "Unable to write vnet_hdr at addr %p\n",
-			       vq->iov->iov_base);
-			break;
-		}
+		if (unlikely(vhost_hlen)) {
+			size_t len = copy_to_iter(&hdr, sizeof(hdr), &fixup);
+
+			if (len != sizeof(hdr)) {
+				vq_err(vq,
+				       "Unable to write vnet_hdr at addr %p\n",
+				       vq->iov->iov_base);
+				break;
+			}
+		} else
+			fix_virtio_net_hdr(vq);
+
 		/* TODO: Should check and handle checksum. */
 
 		num_buffers = cpu_to_vhost16(vq, headcount);
