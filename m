From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PULL] vhost: cleanups and fixes
Date: Mon, 10 Feb 2020 01:02:52 -0500
Message-ID: <20200210010252-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kvm@vger.kernel.org, tiny.windzz@gmail.com, netdev@vger.kernel.org, liang.z.li@intel.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, mst@redhat.com, "Cc:stable"@vger.kernel.org, hch@lst.de
List-Id: virtualization@lists.linuxfoundation.org

The following changes since commit d5226fa6dbae0569ee43ecfc08bdcd6770fc4755:

  Linux 5.5 (2020-01-26 16:23:03 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to 1ad6f58ea9364b0a5d8ae06249653ac9304a8578:

  virtio_balloon: Fix memory leaks on errors in virtballoon_probe() (2020-02-06 03:40:27 -0500)

----------------------------------------------------------------
virtio: fixes, cleanups

Some bug fixes/cleanups.
Deprecated scsi passthrough for blk removed.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Christoph Hellwig (1):
      virtio-blk: remove VIRTIO_BLK_F_SCSI support

Daniel Verkamp (2):
      virtio-balloon: initialize all vq callbacks
      virtio-pci: check name when counting MSI-X vectors

David Hildenbrand (2):
      virtio-balloon: Fix memory leak when unloading while hinting is in progress
      virtio_balloon: Fix memory leaks on errors in virtballoon_probe()

Michael S. Tsirkin (1):
      virtio_balloon: prevent pfn array overflow

Yangtao Li (1):
      virtio-mmio: convert to devm_platform_ioremap_resource

 arch/powerpc/configs/guest.config  |   1 -
 drivers/block/Kconfig              |  10 ----
 drivers/block/virtio_blk.c         | 115 +------------------------------------
 drivers/virtio/virtio_balloon.c    |  21 +++++--
 drivers/virtio/virtio_mmio.c       |  15 +----
 drivers/virtio/virtio_pci_common.c |   2 +-
 6 files changed, 22 insertions(+), 142 deletions(-)
