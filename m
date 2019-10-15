From: Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH] vsock/virtio: remove unused 'work' field from 'struct
	virtio_vsock_pkt'
Date: Tue, 15 Oct 2019 17:00:51 +0200
Message-ID: <20191015150051.104631-1-sgarzare__21315.9855034732$1571151673$gmane$org@redhat.com>
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
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

The 'work' field was introduced with commit 06a8fc78367d0
("VSOCK: Introduce virtio_vsock_common.ko")
but it is never used in the code, so we can remove it to save
memory allocated in the per-packet 'struct virtio_vsock_pkt'

Suggested-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 include/linux/virtio_vsock.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
index 4c7781f4b29b..07875ccc7bb5 100644
--- a/include/linux/virtio_vsock.h
+++ b/include/linux/virtio_vsock.h
@@ -48,7 +48,6 @@ struct virtio_vsock_sock {
 
 struct virtio_vsock_pkt {
 	struct virtio_vsock_hdr	hdr;
-	struct work_struct work;
 	struct list_head list;
 	/* socket refcnt not held, only use for cancellation */
 	struct vsock_sock *vsk;
-- 
2.21.0
