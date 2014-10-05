From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 16/16] virtio_net: fix use after free on allocation failure
Date: Sun, 5 Oct 2014 19:07:38 +0300
Message-ID: <1412525038-15871-17-git-send-email-mst__4689.16474278576$1412525144$gmane$org@redhat.com>
References: <1412525038-15871-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1412525038-15871-1-git-send-email-mst@redhat.com>
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
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

In the extremely unlikely event that driver initialization fails after
RX buffers are added, virtio net frees RX buffers while VQs are
still active, potentially causing device to use a freed buffer.

To fix, reset device first - same as we do on device removal.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/net/virtio_net.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 7afc990..85e6098 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1830,6 +1830,8 @@ static int virtnet_probe(struct virtio_device *vdev)
 	return 0;
 
 free_recv_bufs:
+	vi->vdev->config->reset(vdev);
+
 	free_receive_bufs(vi);
 	unregister_netdev(dev);
 free_vqs:
-- 
MST
