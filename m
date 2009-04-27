From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH RFC 0/8] virtio: add guest MSI-X support
Date: Mon, 27 Apr 2009 15:31:36 +0300
Message-ID: <20090427123136.GA1152__34162.7589580186$1240855542$gmane$org@redhat.com>
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
To: Rusty Russell <rusty@rustcorp.com.au>, virtualization@lists.linux-foundation.org, Anthony Liguori <anthony@codemonkey.ws>, kvm@vger.kernel.org, avi@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

Add optional MSI-X support: use a vector per virtqueue with
fallback to a common vector and finally to regular interrupt.
Teach all drivers to use it.

I added 2 new virtio operations: request_vqs/free_vqs because MSI
needs to know the total number of vectors upfront.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

---

Here's a draft set of patches for MSI-X support in the guest.  It still
needs to be tested properly, and performance impact measured, but I
thought I'd share it here in the hope of getting some very early
feedback/flames.

Michael S. Tsirkin (8):
  virtio: add request_vqs/free_vqs virtio operations
  virtio_blk: add request_vqs/free_vqs calls
  virtio-rng: add request_vqs/free_vqs calls
  virtio_console: add request_vqs/free_vqs calls
  virtio_net: add request_vqs/free_vqs calls
  virtio_balloon: add request_vqs/free_vqs calls
  virtio_pci: split up vp_interrupt
  virtio_pci: optional MSI-X support

 drivers/block/virtio_blk.c          |    9 ++-
 drivers/char/hw_random/virtio-rng.c |   10 ++-
 drivers/char/virtio_console.c       |    8 ++-
 drivers/net/virtio_net.c            |   16 +++-
 drivers/virtio/virtio_balloon.c     |    9 ++-
 drivers/virtio/virtio_pci.c         |  192 ++++++++++++++++++++++++++++++-----
 include/linux/virtio_config.h       |   35 +++++++
 7 files changed, 247 insertions(+), 32 deletions(-)
