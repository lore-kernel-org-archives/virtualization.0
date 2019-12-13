From: Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH net 0/2] vsock/virtio: fix null-pointer dereference and
 related precautions
Date: Fri, 13 Dec 2019 19:47:59 +0100
Message-ID: <20191213184801.486675-1-sgarzare__7483.82913168229$1576262901$gmane$org@redhat.com>
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
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: davem@davemloft.net
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Stefan Hajnoczi <stefanha@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

This series mainly solves a possible null-pointer dereference in
virtio_transport_recv_listen() introduced with the multi-transport
support [PATCH 1].

PATCH 2 adds a WARN_ON check for the same potential issue
and a returned error in the virtio_transport_send_pkt_info() function
to avoid crashing the kernel.

Stefano Garzarella (2):
  vsock/virtio: fix null-pointer dereference in
    virtio_transport_recv_listen()
  vsock/virtio: add WARN_ON check on virtio_transport_get_ops()

 net/vmw_vsock/virtio_transport_common.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

-- 
2.23.0
