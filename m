From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCHv6 0/4] virtio: MSI-X support
Date: Thu, 14 May 2009 13:54:53 +0300
Message-ID: <20090514105453.GA3120__30703.4100908369$1242298703$gmane$org@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Christian Borntraeger <borntraeger@de.ibm.com>, virtualization@lists.linux-foundation.org, Anthony Liguori <anthony@codemonkey.ws>, kvm@vger.kernel.org, avi@redha
List-Id: virtualization@lists.linuxfoundation.org

Here's the latest draft of virtio patches.
This is on top of Rusty's recent virtqueue list + name patch,
which is included in series for completeness.

Changelog:
	changes since v5: fix build on s390 (only patch 2/4 modified)

Michael S. Tsirkin (3):
  virtio: find_vqs/del_vqs virtio operations
  virtio_pci: split up vp_interrupt
  virtio_pci: optional MSI-X support

Rusty Russell (1):
  virtio: add names to virtqueue struct, mapping from devices to
    queues.

 drivers/block/virtio_blk.c          |    6 +-
 drivers/char/hw_random/virtio-rng.c |    6 +-
 drivers/char/virtio_console.c       |   26 ++--
 drivers/lguest/lguest_device.c      |   41 +++++-
 drivers/net/virtio_net.c            |   45 ++---
 drivers/s390/kvm/kvm_virtio.c       |   43 +++++-
 drivers/virtio/virtio.c             |    2 +
 drivers/virtio/virtio_balloon.c     |   27 ++--
 drivers/virtio/virtio_pci.c         |  306 ++++++++++++++++++++++++++++++-----
 drivers/virtio/virtio_ring.c        |   25 +++-
 include/linux/virtio.h              |   12 +-
 include/linux/virtio_config.h       |   45 ++++-
 include/linux/virtio_pci.h          |   10 +-
 include/linux/virtio_ring.h         |    3 +-
 net/9p/trans_virtio.c               |    2 +-
 15 files changed, 465 insertions(+), 134 deletions(-)
