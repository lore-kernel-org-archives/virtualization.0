From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCHv5 0/3] virtio: MSI-X support
Date: Wed, 13 May 2009 22:08:27 +0300
Message-ID: <20090513190827.GA3945__38792.0871995904$1242241955$gmane$org@redhat.com>
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
This is on top of Rusty's recent virtqueue list + name patch.

Michael S. Tsirkin (3):
  virtio: find_vqs/del_vqs virtio operations
  virtio_pci: split up vp_interrupt
  virtio_pci: optional MSI-X support

 drivers/block/virtio_blk.c          |    6 +-
 drivers/char/hw_random/virtio-rng.c |    6 +-
 drivers/char/virtio_console.c       |   26 ++--
 drivers/lguest/lguest_device.c      |   36 ++++-
 drivers/net/virtio_net.c            |   45 ++---
 drivers/s390/kvm/kvm_virtio.c       |   36 ++++-
 drivers/virtio/virtio_balloon.c     |   27 ++--
 drivers/virtio/virtio_pci.c         |  301 ++++++++++++++++++++++++++++++-----
 include/linux/virtio_config.h       |   46 ++++--
 include/linux/virtio_pci.h          |   10 +-
 net/9p/trans_virtio.c               |    2 +-
 11 files changed, 423 insertions(+), 118 deletions(-)
