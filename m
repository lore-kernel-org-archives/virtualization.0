From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: [RFC 0/3] virtio: NUMA-aware memory allocation
Date: Thu, 25 Jun 2020 14:57:49 +0100
Message-ID: <20200625135752.227293-1-stefanha@redhat.com>
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
To: kvm@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

These patches are not ready to be merged because I was unable to measure a
performance improvement. I'm publishing them so they are archived in case
someone picks up this work again in the future.

The goal of these patches is to allocate virtqueues and driver state from the
device's NUMA node for optimal memory access latency. Only guests with a vNUMA
topology and virtio devices spread across vNUMA nodes benefit from this.  In
other cases the memory placement is fine and we don't need to take NUMA into
account inside the guest.

These patches could be extended to virtio_net.ko and other devices in the
future. I only tested virtio_blk.ko.

The benchmark configuration was designed to trigger worst-case NUMA placement:
 * Physical NVMe storage controller on host NUMA node 0
 * IOThread pinned to host NUMA node 0
 * virtio-blk-pci device in vNUMA node 1
 * vCPU 0 on host NUMA node 1 and vCPU 1 on host NUMA node 0
 * vCPU 0 in vNUMA node 0 and vCPU 1 in vNUMA node 1

The intent is to have .probe() code run on vCPU 0 in vNUMA node 0 (host NUMA
node 1) so that memory is in the wrong NUMA node for the virtio-blk-pci devic=
e.
Applying these patches fixes memory placement so that virtqueues and driver
state is allocated in vNUMA node 1 where the virtio-blk-pci device is located.

The fio 4KB randread benchmark results do not show a significant improvement:

Name                  IOPS   Error
virtio-blk        42373.79 =C2=B1 0.54%
virtio-blk-numa   42517.07 =C2=B1 0.79%

Stefan Hajnoczi (3):
  virtio-pci: use NUMA-aware memory allocation in probe
  virtio_ring: use NUMA-aware memory allocation in probe
  virtio-blk: use NUMA-aware memory allocation in probe

 include/linux/gfp.h                |  2 +-
 drivers/block/virtio_blk.c         |  7 +++++--
 drivers/virtio/virtio_pci_common.c | 16 ++++++++++++----
 drivers/virtio/virtio_ring.c       | 26 +++++++++++++++++---------
 mm/page_alloc.c                    |  2 +-
 5 files changed, 36 insertions(+), 17 deletions(-)

--=20
2.26.2
