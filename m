From: Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH net v2 0/2] vsock/virtio: fixes about packet delivery to
 monitoring devices
Date: Fri, 24 Apr 2020 17:08:28 +0200
Message-ID: <20200424150830.183113-1-sgarzare@redhat.com>
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
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Stefan Hajnoczi <stefanha@redhat.com>, Jakub Kicinski <kuba@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

During the review of v1, Stefan pointed out an issue introduced by
that patch, where replies can appear in the packet capture before
the transmitted packet.

While fixing my patch, reverting it and adding a new flag in
'struct virtio_vsock_pkt' (patch 2/2), I found that we already had
that issue in vhost-vsock, so I fixed it (patch 1/2).

v1 -> v2:
- reverted the v1 patch, to avoid that replies can appear in the
  packet capture before the transmitted packet [Stefan]
- added patch to fix packet delivering to monitoring devices in
  vhost-vsock
- added patch to check if the packet is already delivered to
  monitoring devices

v1: https://patchwork.ozlabs.org/project/netdev/patch/20200421092527.41651-1-sgarzare@redhat.com/

Stefano Garzarella (2):
  vhost/vsock: fix packet delivery order to monitoring devices
  vsock/virtio: fix multiple packet delivery to monitoring devices

 drivers/vhost/vsock.c                   | 16 +++++++++++-----
 include/linux/virtio_vsock.h            |  1 +
 net/vmw_vsock/virtio_transport_common.c |  4 ++++
 3 files changed, 16 insertions(+), 5 deletions(-)

-- 
2.25.3
