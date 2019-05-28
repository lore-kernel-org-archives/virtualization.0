From: Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH 0/4] vsock/virtio: several fixes in the .probe() and .remove()
Date: Tue, 28 May 2019 12:56:19 +0200
Message-ID: <20190528105623.27983-1-sgarzare__45455.6611295388$1559041050$gmane$org@redhat.com>
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
Cc: kvm@vger.kernel.org, "Michael S . Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Stefan Hajnoczi <stefanha@redhat.com>, "David S. Miller" <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

During the review of "[PATCH] vsock/virtio: Initialize core virtio vsock
before registering the driver", Stefan pointed out some possible issues
in the .probe() and .remove() callbacks of the virtio-vsock driver.

This series tries to solve these issues:
- Patch 1 postpones the 'the_virtio_vsock' assignment at the end of the
  .probe() to avoid that some sockets queue works when the initialization
  is not finished.
- Patches 2 and 3 stop workers before to call vdev->config->reset(vdev) to
  be sure that no one is accessing the device, and adds another flush at the
  end of the .remove() to avoid use after free.
- Patch 4 free also used buffers in the virtqueues during the .remove().

Stefano Garzarella (4):
  vsock/virtio: fix locking around 'the_virtio_vsock'
  vsock/virtio: stop workers during the .remove()
  vsock/virtio: fix flush of works during the .remove()
  vsock/virtio: free used buffers during the .remove()

 net/vmw_vsock/virtio_transport.c | 105 ++++++++++++++++++++++++++-----
 1 file changed, 90 insertions(+), 15 deletions(-)

-- 
2.20.1
