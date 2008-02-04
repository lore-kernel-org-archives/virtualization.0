From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PULL] virtio updates
Date: Tue, 5 Feb 2008 00:08:13 +1100
Message-ID: <200802050008.13834.rusty__47886.8383718238$1202130626$gmane$org@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
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
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

The following changes since commit 9135f1901ee6449dfe338adf6e40e9c2025b8150:
  Linus Torvalds (1):
        Merge git://git.kernel.org/.../bart/ide-2.6

are available in the git repository at:

  ssh://master.kernel.org/pub/scm/linux/kernel/git/rusty/linux-2.6-for-linus master

Anthony Liguori (4):
      virtio: Fix vring_init/vring_size to take unsigned long
      virtio: Put the virtio under the virtualization menu
      virtio: PCI device
      virtio: Use PCI revision field to indicate virtio PCI ABI version

Christian Borntraeger (4):
      virtnet: remove double ether_setup
      virtio_blk: provide getgeo
      virtio_blk: Dont waste major numbers
      virtio_blk: implement naming for vda-vdz,vdaa-vdzz,vdaaa-vdzzz

Dor Laor (1):
      virtio_net: parametrize the napi_weight for virtio receive queue.

Rusty Russell (16):
      virtio: Implement skb_partial_csum_set, for setting partial csums on untrusted packets.
      virtio: simplify config mechanism.
      virtio: explicit enable_cb/disable_cb rather than callback return.
      virtio: configuration change callback
      virtio: clarify NO_NOTIFY flag usage
      virtio: remove unused id field from struct virtio_blk_outhdr
      virtio: Net header needs hdr_len
      virtio: Tweak virtio_net defines
      virtio: populate network rings in the probe routine, not open
      virtio: reset function
      virtio: handle interrupts after callbacks turned off
      virtio: Use the sg_phys convenience function.
      virtio: Allow virtio to be modular and used by modules
      virtio: flush buffers on open
      virtio: free transmit skbs when notified, not on next xmit.
      virtio: balloon driver

 Documentation/lguest/lguest.c   |  231 ++++++++++++++-------
 arch/x86/kvm/Kconfig            |    1 +
 drivers/Kconfig                 |    2 -
 drivers/block/Kconfig           |    3 +-
 drivers/block/virtio_blk.c      |  106 ++++++----
 drivers/char/virtio_console.c   |    4 +-
 drivers/lguest/lguest_device.c  |  146 ++++++++-----
 drivers/net/Kconfig             |    3 +-
 drivers/net/virtio_net.c        |  155 ++++++++------
 drivers/virtio/Kconfig          |   31 +++-
 drivers/virtio/Makefile         |    2 +
 drivers/virtio/virtio.c         |   65 ++----
 drivers/virtio/virtio_balloon.c |  284 +++++++++++++++++++++++++
 drivers/virtio/virtio_pci.c     |  446 +++++++++++++++++++++++++++++++++++++++
 drivers/virtio/virtio_ring.c    |   51 +++--
 include/linux/lguest_launcher.h |    9 +-
 include/linux/skbuff.h          |    1 +
 include/linux/virtio.h          |   19 +-
 include/linux/virtio_balloon.h  |   18 ++
 include/linux/virtio_blk.h      |   22 +-
 include/linux/virtio_config.h   |  104 +++++-----
 include/linux/virtio_net.h      |   32 ++--
 include/linux/virtio_pci.h      |   57 +++++
 include/linux/virtio_ring.h     |   14 +-
 net/9p/trans_virtio.c           |    8 +-
 net/core/skbuff.c               |   29 +++
 26 files changed, 1422 insertions(+), 421 deletions(-)
 create mode 100644 drivers/virtio/virtio_balloon.c
 create mode 100644 drivers/virtio/virtio_pci.c
 create mode 100644 include/linux/virtio_balloon.h
 create mode 100644 include/linux/virtio_pci.h
