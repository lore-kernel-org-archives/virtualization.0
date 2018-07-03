From: Jason Wang <jasowang@redhat.com>
Subject: [PATCH net-next 0/8] Packed virtqueue for vhost
Date: Tue,  3 Jul 2018 13:37:56 +0800
Message-ID: <1530596284-4101-1-git-send-email-jasowang@redhat.com>
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
To: mst@redhat.com, jasowang@redhat.com, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: maxime.coquelin@redhat.com, wexu@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

Hi all:

This series implements packed virtqueues. The code were tested with
Tiwei's RFC V6 at https://lkml.org/lkml/2018/6/5/120.

Pktgen test for both RX and TX does not show obvious difference with
split virtqueues. The main bottleneck is the guest Linux driver, since
it can not stress vhost for a 100% CPU utilization. A full TCP
benchmark is ongoing. Will test virtio-net pmd as well when it was
ready.

This version were tested with:

- Zerocopy (Out of Order) support
- vIOMMU support
- mergeable buffer on/off
- busy polling on/off

Changes from RFC V5:

- save unnecessary barriers during vhost_add_used_packed_n()
- more compact math for event idx
- fix failure of SET_VRING_BASE when avail_wrap_counter is true
- fix not copy avail_wrap_counter during GET_VRING_BASE
- introduce SET_VRING_USED_BASE/GET_VRING_USED_BASE for syncing last_used_idx
- rename used_wrap_counter to last_used_wrap_counter
- rebase to net-next

Changes from RFC V4:

- fix signalled_used index recording
- track avail index correctly
- various minor fixes

Changes from RFC V3:

- Fix math on event idx checking
- Sync last avail wrap counter through GET/SET_VRING_BASE
- remove desc_event prefix in the driver/device structure

Changes from RFC V2:

- do not use & in checking desc_event_flags
- off should be most significant bit
- remove the workaround of mergeable buffer for dpdk prototype
- id should be in the last descriptor in the chain
- keep _F_WRITE for write descriptor when adding used
- device flags updating should use ADDR_USED type
- return error on unexpected unavail descriptor in a chain
- return false in vhost_ve_avail_empty is descriptor is available
- track last seen avail_wrap_counter
- correctly examine available descriptor in get_indirect_packed()
- vhost_idx_diff should return u16 instead of bool

Changes from RFC V1:

- Refactor vhost used elem code to avoid open coding on used elem
- Event suppression support (compile test only).
- Indirect descriptor support (compile test only).
- Zerocopy support.
- vIOMMU support.
- SCSI/VSOCK support (compile test only).
- Fix several bugs

Jason Wang (8):
  vhost: move get_rx_bufs to vhost.c
  vhost: hide used ring layout from device
  vhost: do not use vring_used_elem
  vhost_net: do not explicitly manipulate vhost_used_elem
  vhost: vhost_put_user() can accept metadata type
  virtio: introduce packed ring defines
  vhost: packed ring support
  vhost: event suppression for packed ring

 drivers/vhost/net.c                | 144 ++----
 drivers/vhost/scsi.c               |  62 +--
 drivers/vhost/vhost.c              | 996 +++++++++++++++++++++++++++++++++----
 drivers/vhost/vhost.h              |  52 +-
 drivers/vhost/vsock.c              |  42 +-
 include/uapi/linux/vhost.h         |   7 +
 include/uapi/linux/virtio_config.h |   2 +
 include/uapi/linux/virtio_ring.h   |  32 ++
 8 files changed, 1070 insertions(+), 267 deletions(-)

-- 
2.7.4
