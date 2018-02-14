From: Jason Wang <jasowang@redhat.com>
Subject: [PATCH RFC 0/2] Packed ring for vhost
Date: Wed, 14 Feb 2018 10:37:07 +0800
Message-ID: <1518575829-1431-1-git-send-email-jasowang@redhat.com>
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
To: mst@redhat.com, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: wexu@redhat.com, tiwei.bie@intel.com
List-Id: virtualization@lists.linuxfoundation.org

Hi all:

This RFC implement a subset of packed ring which was described at
https://github.com/oasis-tcs/virtio-docs/blob/master/virtio-v1.1-packed-wd07.pdf
. The code were tested with pmd implement by Jens at
http://dpdk.org/ml/archives/dev/2018-January/089417.html. Minor
change was needed for pmd codes to kick virtqueue since it assumes a
busy polling backend.

Test were done between localhost and guest. Testpmd (rxonly) in guest
reports 2.4Mpps. Testpmd (txonly) repots about 2.1Mpps.

It's not a complete implemention, here's what were missed:

- Device Area
- Driver Area
- Descriptor indirection
- Zerocopy may not be functional
- Migration path is not tested
- Vhost devices except for net
- vIOMMU can not work (mainly because the metadata prefetch is not
  implemented).
- See FIXME/TODO in the codes for more details
- No batching or other optimizations were implemented

For a quick prototype, this series open code the tracking of warp
counter and descriptor index at net device. This will be addressed in
the future by:

- Move get_rx_bufs() from net.c to vhost.c
- Let vhost_get_vq_desc() returns vring_used_elem instad of head id

With the above, we can hide the internal (at least part of) vring
layout from specific device.

Please review.

Thanks

Jason Wang (2):
  virtio: introduce packed ring defines
  vhost: packed ring support

 drivers/vhost/net.c                |  14 +-
 drivers/vhost/vhost.c              | 351 ++++++++++++++++++++++++++++++++++---
 drivers/vhost/vhost.h              |   6 +-
 include/uapi/linux/virtio_config.h |   9 +
 include/uapi/linux/virtio_ring.h   |  17 ++
 5 files changed, 369 insertions(+), 28 deletions(-)

-- 
2.7.4
