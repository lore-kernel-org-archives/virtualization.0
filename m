From: Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v2 0/3] vsock/virtio: several fixes in the .probe() and
	.remove()
Date: Fri, 28 Jun 2019 14:36:56 +0200
Message-ID: <20190628123659.139576-1-sgarzare__25853.7780771562$1561725465$gmane$org@redhat.com>
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
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Stefan Hajnoczi <stefanha@redhat.com>, "David S. Miller" <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

During the review of "[PATCH] vsock/virtio: Initialize core virtio vsock
before registering the driver", Stefan pointed out some possible issues
in the .probe() and .remove() callbacks of the virtio-vsock driver.

This series tries to solve these issues:
- Patch 1 adds RCU critical sections to avoid use-after-free of
  'the_virtio_vsock' pointer.
- Patch 2 stops workers before to call vdev->config->reset(vdev) to
  be sure that no one is accessing the device.
- Patch 3 moves the works flush at the end of the .remove() to avoid
  use-after-free of 'vsock' object.

v2:
- Patch 1: use RCU to protect 'the_virtio_vsock' pointer
- Patch 2: no changes
- Patch 3: flush works only at the end of .remove()
- Removed patch 4 because virtqueue_detach_unused_buf() returns all the buffers
  allocated.

v1: https://patchwork.kernel.org/cover/10964733/

Stefano Garzarella (3):
  vsock/virtio: use RCU to avoid use-after-free on the_virtio_vsock
  vsock/virtio: stop workers during the .remove()
  vsock/virtio: fix flush of works during the .remove()

 net/vmw_vsock/virtio_transport.c | 131 ++++++++++++++++++++++++-------
 1 file changed, 102 insertions(+), 29 deletions(-)

-- 
2.20.1
