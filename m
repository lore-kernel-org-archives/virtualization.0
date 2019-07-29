From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PULL] vhost,virtio: cleanups and fixes
Date: Mon, 29 Jul 2019 12:16:05 -0400
Message-ID: <20190729121605-mutt-send-email-mst__38748.486996495$1564417118$gmane$org@kernel.org>
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
Cc: jean-philippe@linaro.org, jroedel@suse.de, kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, eric.auger@redhat.com, namit@vmware.com
List-Id: virtualization@lists.linuxfoundation.org

The following changes since commit 5f9e832c137075045d15cd6899ab0505cfb2ca4b:

  Linus 5.3-rc1 (2019-07-21 14:05:38 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to 73f628ec9e6bcc45b77c53fe6d0c0ec55eaf82af:

  vhost: disable metadata prefetch optimization (2019-07-26 07:49:29 -0400)

----------------------------------------------------------------
virtio, vhost: bugfixes

Fixes in the iommu and balloon devices.
Disable the meta-data optimization for now - I hope we can get it fixed
shortly, but there's no point in making users suffer crashes while we
are working on that.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Jean-Philippe Brucker (1):
      iommu/virtio: Update to most recent specification

Michael S. Tsirkin (2):
      balloon: fix up comments
      vhost: disable metadata prefetch optimization

Wei Wang (1):
      mm/balloon_compaction: avoid duplicate page removal

 drivers/iommu/virtio-iommu.c      | 40 ++++++++++++++++-------
 drivers/vhost/vhost.h             |  2 +-
 include/uapi/linux/virtio_iommu.h | 32 ++++++++++--------
 mm/balloon_compaction.c           | 69 +++++++++++++++++++++++----------------
 4 files changed, 89 insertions(+), 54 deletions(-)
