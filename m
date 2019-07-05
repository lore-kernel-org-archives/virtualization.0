From: Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v3 0/3] vsock/virtio: several fixes in the .probe() and
	.remove()
Date: Fri,  5 Jul 2019 13:04:51 +0200
Message-ID: <20190705110454.95302-1-sgarzare__4797.23025798506$1562324740$gmane$org@redhat.com>
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

v3:
- Patch 1: use rcu_dereference_protected() to get the_virtio_vosck value in
           the virtio_vsock_probe() [Jason]

v2: https://patchwork.kernel.org/cover/11022343/

v1: https://patchwork.kernel.org/cover/10964733/

Before this series the guest crashes in a few second. After this series the
test runs (~12h) without issues.
Tested on an SMP guest (-smp 4 -monitor tcp:127.0.0.1:1234,server,nowait)
with these scripts to stress the .probe()/.remove() path:

- guest
  while true; do
      cat /dev/urandom | nc-vsock -l 4321 > /dev/null &
      cat /dev/urandom | nc-vsock -l 5321 > /dev/null &
      cat /dev/urandom | nc-vsock -l 6321 > /dev/null &
      cat /dev/urandom | nc-vsock -l 7321 > /dev/null &
      wait
  done

- host
  while true; do
      cat /dev/urandom | nc-vsock 3 4321 > /dev/null &
      cat /dev/urandom | nc-vsock 3 5321 > /dev/null &
      cat /dev/urandom | nc-vsock 3 6321 > /dev/null &
      cat /dev/urandom | nc-vsock 3 7321 > /dev/null &
      sleep 2
      echo "device_del v1" | nc 127.0.0.1 1234
      sleep 1
      echo "device_add vhost-vsock-pci,id=v1,guest-cid=3" | nc 127.0.0.1 1234
      sleep 1
  done

Stefano Garzarella (3):
  vsock/virtio: use RCU to avoid use-after-free on the_virtio_vsock
  vsock/virtio: stop workers during the .remove()
  vsock/virtio: fix flush of works during the .remove()

 net/vmw_vsock/virtio_transport.c | 134 ++++++++++++++++++++++++-------
 1 file changed, 104 insertions(+), 30 deletions(-)

-- 
2.20.1
