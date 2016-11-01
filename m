From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PULL] virtio: tests, cleanups and fixes
Date: Tue, 1 Nov 2016 02:11:25 +0200
Message-ID: <20161101021125-mutt-send-email-mst__41926.6019519002$1477959591$gmane$org@kernel.org>
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
Cc: jgross@suse.com, lprosek@redhat.com, kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org, kneumoin@virtuozzo.com, will.deacon@arm.com, linux-kernel@vger.kernel.org, stable@vger.kernel.org, virtualization@lists.linux-foundation.org, luto@kernel.org, pbonzini@redhat.com, den@openvz.org, matt.redfearn@imgtec.com, elfring@users.sourceforge.net
List-Id: virtualization@lists.linuxfoundation.org

The following changes since commit a909d3e636995ba7c349e2ca5dbb528154d4ac30:

  Linux 4.9-rc3 (2016-10-29 13:52:02 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to 75bfa81bf0897ba87f1e1b9b576a07536029b86a:

  virtio_ring: mark vring_dma_dev inline (2016-10-31 00:40:08 +0200)

----------------------------------------------------------------
virtio: tests, fixes and cleanups

Just minor tweaks, there's nothing major in this cycle.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Juergen Gross (1):
      virtio: remove config.c

Konstantin Neumoin (1):
      virtio: update balloon size in balloon "probe"

Ladi Prosek (1):
      virtio_ring: Make interrupt suppression spec compliant

Markus Elfring (2):
      virtio_blk: Use kmalloc_array() in init_vq()
      virtio_blk: Delete an unnecessary initialisation in init_vq()

Matt Redfearn (1):
      virtio: console: Unlock vqs while freeing buffers

Michael S. Tsirkin (2):
      virtio/vhost: add Jason to list of maintainers
      virtio_ring: mark vring_dma_dev inline

Paolo Bonzini (3):
      ringtest: use link-time optimization
      ringtest: commonize implementation of poll_avail/poll_used
      ringtest: poll for new buffers once before updating event index

Will Deacon (1):
      virtio_pci: Limit DMA mask to 44 bits for legacy virtio devices

 tools/virtio/ringtest/main.h            |  4 +--
 drivers/block/virtio_blk.c              | 10 +++---
 drivers/char/virtio_console.c           | 22 ++++++++----
 drivers/virtio/config.c                 | 12 -------
 drivers/virtio/virtio_balloon.c         |  2 ++
 drivers/virtio/virtio_pci_legacy.c      | 16 ++++++---
 drivers/virtio/virtio_ring.c            | 16 +++++----
 tools/virtio/ringtest/main.c            | 20 ++++++++---
 tools/virtio/ringtest/noring.c          |  6 ++--
 tools/virtio/ringtest/ptr_ring.c        | 22 +++---------
 tools/virtio/ringtest/ring.c            | 18 ++++------
 tools/virtio/ringtest/virtio_ring_0_9.c | 64 ++++++++-------------------------
 MAINTAINERS                             |  2 ++
 tools/virtio/ringtest/Makefile          |  4 +--
 14 files changed, 96 insertions(+), 122 deletions(-)
 delete mode 100644 drivers/virtio/config.c
