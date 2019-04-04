From: Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH RFC 0/4] vsock/virtio: optimizations to increase the throughput
Date: Thu,  4 Apr 2019 12:58:34 +0200
Message-ID: <20190404105838.101559-1-sgarzare__2445.60501757718$1555717807$gmane$org@redhat.com>
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

This series tries to increase the throughput of virtio-vsock with slight
changes:
 - patch 1/4: reduces the number of credit update messages sent to the
              transmitter
 - patch 2/4: allows the host to split packets on multiple buffers,
              in this way, we can remove the packet size limit to
              VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE
 - patch 3/4: uses VIRTIO_VSOCK_MAX_PKT_BUF_SIZE as the max packet size
              allowed
 - patch 4/4: increases RX buffer size to 64 KiB (affects only host->guest)

RFC:
 - maybe patch 4 can be replaced with multiple queues with different
   buffer sizes or using EWMA to adapt the buffer size to the traffic

 - as Jason suggested in a previous thread [1] I'll evaluate to use
   virtio-net as transport, but I need to understand better how to
   interface with it, maybe introducing sk_buff in virtio-vsock.

Any suggestions?

Here some benchmarks step by step. I used iperf3 [2] modified with VSOCK
support:

                        host -> guest [Gbps]
pkt_size    before opt.   patch 1   patches 2+3   patch 4
  64            0.060       0.102       0.102       0.096
  256           0.22        0.40        0.40        0.36
  512           0.42        0.82        0.85        0.74
  1K            0.7         1.6         1.6         1.5
  2K            1.5         3.0         3.1         2.9
  4K            2.5         5.2         5.3         5.3
  8K            3.9         8.4         8.6         8.8
  16K           6.6        11.1        11.3        12.8
  32K           9.9        15.8        15.8        18.1
  64K          13.5        17.4        17.7        21.4
  128K         17.9        19.0        19.0        23.6
  256K         18.0        19.4        19.8        24.4
  512K         18.4        19.6        20.1        25.3

                        guest -> host [Gbps]
pkt_size    before opt.   patch 1   patches 2+3
  64            0.088       0.100       0.101
  256           0.35        0.36        0.41
  512           0.70        0.74        0.73
  1K            1.1         1.3         1.3
  2K            2.4         2.4         2.6
  4K            4.3         4.3         4.5
  8K            7.3         7.4         7.6
  16K           9.2         9.6        11.1
  32K           8.3         8.9        18.1
  64K           8.3         8.9        25.4
  128K          7.2         8.7        26.7
  256K          7.7         8.4        24.9
  512K          7.7         8.5        25.0

Thanks,
Stefano

[1] https://www.spinics.net/lists/netdev/msg531783.html
[2] https://github.com/stefano-garzarella/iperf/

Stefano Garzarella (4):
  vsock/virtio: reduce credit update messages
  vhost/vsock: split packets to send using multiple buffers
  vsock/virtio: change the maximum packet size allowed
  vsock/virtio: increase RX buffer size to 64 KiB

 drivers/vhost/vsock.c                   | 35 ++++++++++++++++++++-----
 include/linux/virtio_vsock.h            |  3 ++-
 net/vmw_vsock/virtio_transport_common.c | 18 +++++++++----
 3 files changed, 44 insertions(+), 12 deletions(-)

-- 
2.20.1
