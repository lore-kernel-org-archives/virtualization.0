From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCHv3 0/3] virtio: MSI-X support
Date: Tue, 12 May 2009 01:19:24 +0300
Message-ID: <20090511221924.GA22911__17349.376253742$1242080979$gmane$org@redhat.com>
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
To: Christian Borntraeger <borntraeger@de.ibm.com>, Rusty Russell <rusty@rustcorp.com.au>, virtualization@lists.linux-foundation.org, Anthony Liguori <anthony@codemon>
List-Id: virtualization@lists.linuxfoundation.org

Here's an updated draft of virtio patches which work with the qemu-kvm
code that I just posted. This still needs to be rebased on top of
Rusty's recent virtqueue list patch. I am posting it in case people
want to start trying MSI-X out.

Michael S. Tsirkin (3):
  virtio: find_vqs/del_vqs virtio operations
  virtio_pci: split up vp_interrupt
  virtio_pci: optional MSI-X support

 drivers/block/virtio_blk.c          |   11 +-
 drivers/char/hw_random/virtio-rng.c |   11 +-
 drivers/char/virtio_console.c       |   27 ++--
 drivers/lguest/lguest_device.c      |   49 ++++++-
 drivers/net/virtio_net.c            |   48 +++----
 drivers/s390/kvm/kvm_virtio.c       |   64 ++++++++-
 drivers/virtio/virtio_balloon.c     |   29 ++--
 drivers/virtio/virtio_pci.c         |  291 ++++++++++++++++++++++++++++++-----
 include/linux/virtio_config.h       |   29 +++-
 include/linux/virtio_pci.h          |    8 +-
 net/9p/trans_virtio.c               |    7 +-
 11 files changed, 450 insertions(+), 124 deletions(-)
