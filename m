From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCHv2 0/3] virtio: add guest MSI-X support
Date: Thu, 7 May 2009 17:08:38 +0300
Message-ID: <20090507140838.GA1516__20027.212604373$1241705508$gmane$org@redhat.com>
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
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: avi@redhat.com, kvm@vger.kernel.org, Anthony Liguori <anthony@codemonkey.ws>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Add optional MSI-X support: use a vector per virtqueue with
fallback to a common vector and finally to regular interrupt.
Teach all drivers to use it.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

---

Here's a draft set of patches for MSI-X support in the guest.  It still
needs to be tested properly, and performance impact measured, but I
thought I'd share it here in the hope of getting some very early
feedback/flames.

Changelog since v1:
- Per Avi's suggestion, let guest configure virtqueue to vector mapping
- Per Rusty's suggestion, replace API with find_vqs/del_vqs.

Michael S. Tsirkin (3):
  virtio: find_vqs/del_vqs virtio operations
  virtio_pci: split up vp_interrupt
  virtio_pci: optional MSI-X support

 drivers/block/virtio_blk.c          |   11 +-
 drivers/char/hw_random/virtio-rng.c |   11 +-
 drivers/char/virtio_console.c       |   27 ++--
 drivers/lguest/lguest_device.c      |   49 ++++++-
 drivers/net/virtio_net.c            |   47 +++----
 drivers/s390/kvm/kvm_virtio.c       |   64 ++++++++-
 drivers/virtio/virtio_balloon.c     |   31 ++--
 drivers/virtio/virtio_pci.c         |  283 ++++++++++++++++++++++++++++++-----
 include/linux/virtio_config.h       |   29 +++-
 include/linux/virtio_pci.h          |    8 +-
 10 files changed, 440 insertions(+), 120 deletions(-)
