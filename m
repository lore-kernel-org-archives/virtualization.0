From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PULL v2] vhost, virtio
Date: Thu, 14 Jun 2018 02:45:06 +0300
Message-ID: <20180614024506-mutt-send-email-mst@kernel.org>
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
Cc: ohad@wizery.com, kevin@guarana.org, kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, bjorn.andersson@linaro.org, syzbot+87cfa083e727a224754b@syzkaller.appspotmail.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Page hints are reworked - I dropped them for now.

The following changes since commit 29dcea88779c856c7dc92040a0c01233263101d4:

  Linux 4.17 (2018-06-03 14:15:21 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to 2eb98105f8c7f4b867f7f714a998f5b8c1bb009b:

  virtio: update the comments for transport features (2018-06-12 04:59:29 +0300)

----------------------------------------------------------------
virtio, vhost: features, fixes

VF support for virtio.
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

 drivers/vhost/vhost.c              |  3 +++
 drivers/virtio/virtio_pci_common.c | 30 ++++++++++++++++++++++++++++++
 drivers/virtio/virtio_pci_modern.c | 14 ++++++++++++++
 include/linux/virtio_ring.h        |  4 ++--
 include/uapi/linux/virtio_config.h | 16 ++++++++++++----
 5 files changed, 61 insertions(+), 6 deletions(-)
