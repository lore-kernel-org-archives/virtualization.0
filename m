From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PULL] vhost: cleanups and fixes
Date: Wed, 9 Sep 2015 12:15:36 +0300
Message-ID: <20150909121536-mutt-send-email-mst__31282.6187503108$1441823875$gmane$org@redhat.com>
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
Cc: famz@redhat.com, graeme.gregory@linaro.org, kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, pbonzini@redhat.com, den@openvz.org
List-Id: virtualization@lists.linuxfoundation.org

The following changes since commit 64291f7db5bd8150a74ad2036f1037e6a0428df2:

  Linux 4.2 (2015-08-30 11:34:09 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to 997e120843e82609c8d99a9d5714e6cf91e14cbe:

  virtio_balloon: do not change memory amount visible via /proc/meminfo (2015-09-08 13:32:11 +0300)

----------------------------------------------------------------
virtio: fixes and features 4.3

virtio-mmio can now be auto-loaded through acpi.
virtio blk supports extended partitions.
total memory is better reported when using virtio balloon with auto-deflate.
cache control is re-enabled when using virtio-blk in modern mode.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Denis V. Lunev (2):
      virtio_ballon: change stub of release_pages_by_pfn
      virtio_balloon: do not change memory amount visible via /proc/meminfo

Fam Zheng (1):
      virtio-blk: Allow extended partitions

Graeme Gregory (1):
      virtio_mmio: add ACPI probing

Paolo Bonzini (1):
      virtio-blk: use VIRTIO_BLK_F_WCE and VIRTIO_BLK_F_CONFIG_WCE in virtio1

 drivers/block/virtio_blk.c      |  6 +++---
 drivers/virtio/virtio_balloon.c | 16 ++++++++++------
 drivers/virtio/virtio_mmio.c    | 10 ++++++++++
 3 files changed, 23 insertions(+), 9 deletions(-)
