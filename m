From: Stefano Garzarella <sgarzare@redhat.com>
Subject: [RFC PATCH 0/3] vsock: support network namespace
Date: Thu, 28 Nov 2019 18:15:16 +0100
Message-ID: <20191128171519.203979-1-sgarzare__1434.9310238444$1574961347$gmane$org@redhat.com>
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
To: netdev@vger.kernel.org
Cc: linux-hyperv@vger.kernel.org, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, Dexuan Cui <decui@microsoft.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Stefan Hajnoczi <stefanha@redhat.com>, "David S. Miller" <davem@davemloft.net>, Jorgen Hansen <jhansen@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org

Hi,
now that we have multi-transport upstream, I started to take a look to
support network namespace (netns) in vsock.

As we partially discussed in the multi-transport proposal [1], it could
be nice to support network namespace in vsock to reach the following
goals:
- isolate host applications from guest applications using the same ports
  with CID_ANY
- assign the same CID of VMs running in different network namespaces
- partition VMs between VMMs or at finer granularity

This preliminary implementation provides the following behavior:
- packets received from the host (received by G2H transports) are
  assigned to the default netns (init_net)
- packets received from the guest (received by H2G - vhost-vsock) are
  assigned to the netns of the process that opens /dev/vhost-vsock
  (usually the VMM, qemu in my tests, opens the /dev/vhost-vsock)
    - for vmci I need some suggestions, because I don't know how to do
      and test the same in the vmci driver, for now vmci uses the
      init_net
- loopback packets are exchanged only in the same netns

Questions:
1. Should we make configurable the netns (now it is init_net) where
   packets from the host should be delivered?
2. Should we provide an ioctl in vhost-vsock to configure the netns
   to use? (instead of using the netns of the process that opens
   /dev/vhost-vsock)
3. Should we provide a way to disable the netns support in vsock?
4. Jorgen: Do you think can be useful support it in vmci host
   driver?

I tested the series in this way:
l0_host$ qemu-system-x86_64 -m 4G -M accel=kvm -smp 4 \
            -drive file=/tmp/vsockvm0.img,if=virtio --nographic \
            -device vhost-vsock-pci,guest-cid=3

l1_vm$ ip netns add ns1
l1_vm$ ip netns add ns2
 # same CID on different netns
l1_vm$ ip netns exec ns1 qemu-system-x86_64 -m 1G -M accel=kvm -smp 2 \
            -drive file=/tmp/vsockvm1.img,if=virtio --nographic \
            -device vhost-vsock-pci,guest-cid=4
l1_vm$ ip netns exec ns2 qemu-system-x86_64 -m 1G -M accel=kvm -smp 2 \
            -drive file=/tmp/vsockvm2.img,if=virtio --nographic \
            -device vhost-vsock-pci,guest-cid=4

 # all iperf3 listen on CID_ANY and port 5201, but in different netns
l1_vm$ ./iperf3 --vsock -s # connection from l0 or guests started
                           # on default netns (init_net)
l1_vm$ ip netns exec ns1 ./iperf3 --vsock -s
l1_vm$ ip netns exec ns1 ./iperf3 --vsock -s

l0_host$ ./iperf3 --vsock -c 3
l2_vm1$ ./iperf3 --vsock -c 2
l2_vm2$ ./iperf3 --vsock -c 2

This series is on top of the vsock-loopback series (not yet merged),
and it is available in the Git repository at:

  git://github.com/stefano-garzarella/linux.git vsock-netns

Any comments are really appreciated!

Thanks,
Stefano

[1] https://www.spinics.net/lists/netdev/msg575792.html

Stefano Garzarella (3):
  vsock: add network namespace support
  vsock/virtio_transport_common: handle netns of received packets
  vhost/vsock: use netns of process that opens the vhost-vsock device

 drivers/vhost/vsock.c                   | 29 ++++++++++++++++-------
 include/linux/virtio_vsock.h            |  2 ++
 include/net/af_vsock.h                  |  6 +++--
 net/vmw_vsock/af_vsock.c                | 31 ++++++++++++++++++-------
 net/vmw_vsock/hyperv_transport.c        |  5 ++--
 net/vmw_vsock/virtio_transport.c        |  2 ++
 net/vmw_vsock/virtio_transport_common.c | 12 ++++++++--
 net/vmw_vsock/vmci_transport.c          |  5 ++--
 8 files changed, 67 insertions(+), 25 deletions(-)

-- 
2.23.0
