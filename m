From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v2] virtio_net: CTRL_GUEST_OFFLOADS depends on CTRL_VQ
Date: Sun, 5 Jan 2020 08:22:07 -0500
Message-ID: <20200105132120.92370-1-mst__42528.4326005325$1578230548$gmane$org@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: linux-kernel@vger.kernel.org
Cc: Alistair Delva <adelva@google.com>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, "David S. Miller" <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

The only way for guest to control offloads (as enabled by
VIRTIO_NET_F_CTRL_GUEST_OFFLOADS) is by sending commands
through CTRL_VQ. So it does not make sense to
acknowledge VIRTIO_NET_F_CTRL_GUEST_OFFLOADS without
VIRTIO_NET_F_CTRL_VQ.

The spec does not outlaw devices with such a configuration, so we have
to support it. Simply clear VIRTIO_NET_F_CTRL_GUEST_OFFLOADS.
Note that Linux is still crashing if it tries to
change the offloads when there's no control vq.
That needs to be fixed by another patch.

Reported-by: Alistair Delva <adelva@google.com>
Reported-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Fixes: 3f93522ffab2 ("virtio-net: switch off offloads on demand if possible on XDP set")
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

Same patch as v1 but update documentation so it's clear it's not
enough to fix the crash.

 drivers/net/virtio_net.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 4d7d5434cc5d..7b8805b47f0d 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2971,6 +2971,15 @@ static int virtnet_validate(struct virtio_device *vdev)
 	if (!virtnet_validate_features(vdev))
 		return -EINVAL;
 
+	/* VIRTIO_NET_F_CTRL_GUEST_OFFLOADS does not work without
+	 * VIRTIO_NET_F_CTRL_VQ. Unfortunately spec forgot to
+	 * specify that VIRTIO_NET_F_CTRL_GUEST_OFFLOADS depends
+	 * on VIRTIO_NET_F_CTRL_VQ so devices can set the later but
+	 * not the former.
+	 */
+	if (!virtio_has_feature(vdev, VIRTIO_NET_F_CTRL_VQ))
+			__virtio_clear_bit(vdev, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS);
+
 	if (virtio_has_feature(vdev, VIRTIO_NET_F_MTU)) {
 		int mtu = virtio_cread16(vdev,
 					 offsetof(struct virtio_net_config,
-- 
MST
