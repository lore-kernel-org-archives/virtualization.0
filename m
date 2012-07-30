From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PULL] virtio
Date: Mon, 30 Jul 2012 13:33:10 +0930
Message-ID: <871ujtnbep.fsf@rustcorp.com.au>
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
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org, Amit Shah <amit.shah@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

The following changes since commit f7da9cdf45cbbad5029d4858dcbc0134e06084ed:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net (2012-07-28 06:00:39 -0700)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rusty/linux-2.6-for-linus.git tags/virtio-for-linus

for you to fetch changes up to 6a743897144500fb4c4566ced3a498d5180fbb5b:

  virtio-blk: return VIRTIO_BLK_F_FLUSH to header. (2012-07-30 13:30:52 +0930)

----------------------------------------------------------------
Virtio patches, mainly hotplugging fixes.

----------------------------------------------------------------
Amit Shah (5):
      virtio ids: fix comment for virtio-rng
      virtio: rng: allow tasks to be killed that are waiting for rng input
      virtio: rng: don't wait on host when module is going away
      virtio: rng: split out common code in probe / remove for s3/s4 ops
      virtio: rng: s3/s4 support

Asias He (3):
      virtio-blk: Call del_gendisk() before disable guest kick
      virtio-blk: Reset device after blk_cleanup_queue()
      virtio-blk: Use block layer provided spinlock

Paolo Bonzini (1):
      virtio-blk: allow toggling host cache between writeback and writethrough

Rusty Russell (1):
      virtio-blk: return VIRTIO_BLK_F_FLUSH to header.

 drivers/block/virtio_blk.c          |  115 ++++++++++++++++++++++++++++-------
 drivers/char/hw_random/virtio-rng.c |   37 ++++++++++-
 include/linux/virtio_blk.h          |   10 ++-
 include/linux/virtio_ids.h          |    2 +-
 4 files changed, 137 insertions(+), 27 deletions(-)
