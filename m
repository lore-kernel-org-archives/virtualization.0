From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PULL] vhost: cleanups and fixes
Date: Mon, 11 Jun 2018 19:23:53 +0300
Message-ID: <20180611192353-mutt-send-email-mst@kernel.org>
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
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ohad@wizery.com, kevin@guarana.org, kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org, liang.z.li@intel.com, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, bjorn.andersson@linaro.org, mhocko@kernel.org, mhocko@suse.com, syzbot+87cfa083e727a224754b@syzkaller.appspotmail.com, akpm@linux-foundation.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

The following changes since commit 29dcea88779c856c7dc92040a0c01233263101d4:

  Linux 4.17 (2018-06-03 14:15:21 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to aa15783ee62d57d69433101ede3e3ed11e48161d:

  virtio: update the comments for transport features (2018-06-07 22:17:40 +0300)

----------------------------------------------------------------
virtio, vhost: features, fixes

VF support for virtio.
Free page hint request support for VM migration.
DMA barriers for virtio strong barriers.
Bugfixes.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Michael S. Tsirkin (2):
      virtio_ring: switch to dma_XX barriers for rpmsg
      vhost: fix info leak due to uninitialized memory

Tiwei Bie (2):
      virtio_pci: support enabling VFs
      virtio: update the comments for transport features

Wei Wang (4):
      mm: support reporting free page blocks
      virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT
      mm/page_poison: expose page_poisoning_enabled to kernel modules
      virtio-balloon: VIRTIO_BALLOON_F_PAGE_POISON

 drivers/vhost/vhost.c               |   3 +
 drivers/virtio/virtio_balloon.c     | 298 +++++++++++++++++++++++++++++++-----
 drivers/virtio/virtio_pci_common.c  |  30 ++++
 drivers/virtio/virtio_pci_modern.c  |  14 ++
 include/linux/mm.h                  |   6 +
 include/linux/virtio_ring.h         |   4 +-
 include/uapi/linux/virtio_balloon.h |   7 +
 include/uapi/linux/virtio_config.h  |  16 +-
 mm/page_alloc.c                     |  97 ++++++++++++
 mm/page_poison.c                    |   6 +
 10 files changed, 439 insertions(+), 42 deletions(-)
