From: Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH RFC 4/4] vsock/virtio: increase RX buffer size to 64 KiB
Date: Thu,  4 Apr 2019 12:58:38 +0200
Message-ID: <20190404105838.101559-5-sgarzare__40128.2428226963$1555717856$gmane$org@redhat.com>
References: <20190404105838.101559-1-sgarzare@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190404105838.101559-1-sgarzare@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: netdev@vger.kernel.org
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Stefan Hajnoczi <stefanha@redhat.com>, "David S. Miller" <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

In order to increase host -> guest throughput with large packets,
we can use 64 KiB RX buffers.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 include/linux/virtio_vsock.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
index 6d7a22cc20bf..43cce304408e 100644
--- a/include/linux/virtio_vsock.h
+++ b/include/linux/virtio_vsock.h
@@ -10,7 +10,7 @@
 #define VIRTIO_VSOCK_DEFAULT_MIN_BUF_SIZE	128
 #define VIRTIO_VSOCK_DEFAULT_BUF_SIZE		(1024 * 256)
 #define VIRTIO_VSOCK_DEFAULT_MAX_BUF_SIZE	(1024 * 256)
-#define VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE	(1024 * 4)
+#define VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE	(1024 * 64)
 #define VIRTIO_VSOCK_MAX_BUF_SIZE		0xFFFFFFFFUL
 #define VIRTIO_VSOCK_MAX_PKT_BUF_SIZE		(1024 * 64)
 
-- 
2.20.1
