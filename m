From: jiangyiwen <jiangyiwen@huawei.com>
Subject: [PATCH 0/5] VSOCK: support mergeable rx buffer in vhost-vsock
Date: Mon, 5 Nov 2018 15:43:24 +0800
Message-ID: <5BDFF49C.3040603__49836.2032617026$1541403690$gmane$org@huawei.com>
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
To: stefanha@redhat.com, Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Now vsock only support send/receive small packet, it can't achieve
high performance. As previous discussed with Jason Wang, I revisit the
idea of vhost-net about mergeable rx buffer and implement the mergeable
rx buffer in vhost-vsock, it can allow big packet to be scattered in
into different buffers and improve performance obviously.

I write a tool to test the vhost-vsock performance, mainly send big
packet(64K) included guest->Host and Host->Guest. The result as
follows:

Before performance:
              Single socket            Multiple sockets(Max Bandwidth)
Guest->Host   ~400MB/s                 ~480MB/s
Host->Guest   ~1450MB/s                ~1600MB/s

After performance:
              Single socket            Multiple sockets(Max Bandwidth)
Guest->Host   ~1700MB/s                ~2900MB/s
Host->Guest   ~1700MB/s                ~2900MB/s

From the test results, the performance is improved obviously, and guest
memory will not be wasted.

---

Yiwen Jiang (5):
  VSOCK: support fill mergeable rx buffer in guest
  VSOCK: support fill data to mergeable rx buffer in host
  VSOCK: support receive mergeable rx buffer in guest
  VSOCK: modify default rx buf size to improve performance
  VSOCK: batch sending rx buffer to increase bandwidth

 drivers/vhost/vsock.c                   | 135 +++++++++++++++++++++++------
 include/linux/virtio_vsock.h            |  15 +++-
 include/uapi/linux/virtio_vsock.h       |   5 ++
 net/vmw_vsock/virtio_transport.c        | 147 ++++++++++++++++++++++++++------
 net/vmw_vsock/virtio_transport_common.c |  59 +++++++++++--
 5 files changed, 300 insertions(+), 61 deletions(-)

-- 
1.8.3.1
