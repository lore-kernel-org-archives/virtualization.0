From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PULL] virtio,vhost: fixes, tweaks
Date: Thu, 23 Aug 2018 20:42:24 +0300
Message-ID: <20180823204224-mutt-send-email-mst__10483.2037156031$1535046031$gmane$org@kernel.org>
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
Cc: peter.maydell@linaro.org, cdall@kernel.org, kvm@vger.kernel.org, mst@redhat.com, jean-philippe.brucker@arm.com, netdev@vger.kernel.org, penguin-kernel@i-love.sakura.ne.jp, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, marc.zyngier@arm.com, akpm@linux-foundation.org, mhocko@kernel.org, suzuki.poulose@arm.com
List-Id: virtualization@lists.linuxfoundation.org

The following changes since commit 94710cac0ef4ee177a63b5227664b38c95bbf703:

  Linux 4.18 (2018-08-12 13:41:04 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to 864d39df09b43f9d09d80bc29d8e8888294b3c4b:

  vhost/scsi: increase VHOST_SCSI_PREALLOC_PROT_SGLS to 2048 (2018-08-22 01:01:47 +0300)

----------------------------------------------------------------
virtio, vhost: fixes, tweaks

No new features but a bunch of tweaks such as
switching balloon from oom notifier to shrinker.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Greg Edwards (2):
      vhost: allow vhost-scsi driver to be built-in
      vhost/scsi: increase VHOST_SCSI_PREALLOC_PROT_SGLS to 2048

Suzuki K Poulose (2):
      virtio: mmio-v1: Validate queue PFN
      virtio: pci-legacy: Validate queue pfn

Wei Wang (3):
      virtio-balloon: remove BUG() in init_vqs
      virtio-balloon: kzalloc the vb struct
      virtio_balloon: replace oom notifier with shrinker

 drivers/vhost/Kconfig              |   2 +-
 drivers/vhost/scsi.c               |   2 +-
 drivers/virtio/virtio_balloon.c    | 125 ++++++++++++++++++++-----------------
 drivers/virtio/virtio_mmio.c       |  20 +++++-
 drivers/virtio/virtio_pci_legacy.c |  14 ++++-
 5 files changed, 99 insertions(+), 64 deletions(-)
