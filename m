From: Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH net 0/2] vsock/virtio: make the credit mechanism more robust
Date: Thu, 17 Oct 2019 14:44:01 +0200
Message-ID: <20191017124403.266242-1-sgarzare@redhat.com>
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
To: netdev@vger.kernel.org
Cc: virtualization@lists.linux-foundation.org, Stefan Hajnoczi <stefanha@redhat.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

This series makes the credit mechanism implemented in the
virtio-vsock devices more robust.
Patch 1 sends an update to the remote peer when the buf_alloc
change.
Patch 2 prevents a malicious peer (especially the guest) can
consume all the memory of the other peer, discarding packets
when the credit available is not respected.

Stefano Garzarella (2):
  vsock/virtio: send a credit update when buffer size is changed
  vsock/virtio: discard packets if credit is not respected

 net/vmw_vsock/virtio_transport_common.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

-- 
2.21.0
