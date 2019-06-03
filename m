From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PULL] vhost: cleanups and fixes
Date: Mon, 3 Jun 2019 10:30:27 -0400
Message-ID: <20190603103027-mutt-send-email-mst@kernel.org>
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
Cc: fabrizio.castro@bp.renesas.com, igor.stoppa@huawei.com, kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, stefanha@redhat.com, pbonzini@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

The following changes since commit cd6c84d8f0cdc911df435bb075ba22ce3c605b07:

  Linux 5.2-rc2 (2019-05-26 16:49:19 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to c1ea02f15ab5efb3e93fc3144d895410bf79fcf2:

  vhost: scsi: add weight support (2019-05-27 11:08:23 -0400)

----------------------------------------------------------------
virtio: fixes

several fixes, some of them for CVEs.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Fabrizio Castro (1):
      virtio: Fix indentation of VIRTIO_MMIO

Igor Stoppa (1):
      virtio: add unlikely() to WARN_ON_ONCE()

Jason Wang (4):
      vhost: introduce vhost_exceeds_weight()
      vhost_net: fix possible infinite loop
      vhost: vsock: add weight support
      vhost: scsi: add weight support

 drivers/vhost/net.c         | 41 ++++++++++++++---------------------------
 drivers/vhost/scsi.c        | 21 ++++++++++++++-------
 drivers/vhost/vhost.c       | 20 +++++++++++++++++++-
 drivers/vhost/vhost.h       |  5 ++++-
 drivers/vhost/vsock.c       | 28 +++++++++++++++++++++-------
 drivers/virtio/Kconfig      |  8 ++++----
 tools/virtio/linux/kernel.h |  2 +-
 7 files changed, 77 insertions(+), 48 deletions(-)
