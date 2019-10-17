From: Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH net 1/2] vsock/virtio: send a credit update when buffer size
	is changed
Date: Thu, 17 Oct 2019 14:44:02 +0200
Message-ID: <20191017124403.266242-2-sgarzare__26996.0775550985$1571316265$gmane$org@redhat.com>
References: <20191017124403.266242-1-sgarzare@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20191017124403.266242-1-sgarzare@redhat.com>
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
Cc: virtualization@lists.linux-foundation.org, Stefan Hajnoczi <stefanha@redhat.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

When the user application set a new buffer size value, we should
update the remote peer about this change, since it uses this
information to calculate the credit available.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 net/vmw_vsock/virtio_transport_common.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index a666ef8fc54e..db127a69f5c3 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -458,6 +458,9 @@ void virtio_transport_set_buffer_size(struct vsock_sock *vsk, u64 val)
 		vvs->buf_size_max = val;
 	vvs->buf_size = val;
 	vvs->buf_alloc = val;
+
+	virtio_transport_send_credit_update(vsk, VIRTIO_VSOCK_TYPE_STREAM,
+					    NULL);
 }
 EXPORT_SYMBOL_GPL(virtio_transport_set_buffer_size);
 
-- 
2.21.0
