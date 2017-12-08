From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PULL] vhost: cleanups and fixes
Date: Fri, 8 Dec 2017 17:47:51 +0200
Message-ID: <20171208174751-mutt-send-email-mst__7565.72130271724$1512748113$gmane$org@kernel.org>
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
Cc: kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org, wangyunjian@huawei.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, zhangweiping@didichuxing.com
List-Id: virtualization@lists.linuxfoundation.org

The following changes since commit d9e427f6ab8142d6868eb719e6a7851aafea56b6:

  virtio_balloon: fix increment of vb->num_pfns in fill_balloon() (2017-12-01 16:55:45 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to 03e9f8a05bce7330bcd9c5cc54c8e42d0fcbf993:

  virtio_net: fix return value check in receive_mergeable() (2017-12-07 18:34:52 +0200)

----------------------------------------------------------------
virtio: bugfixes

A couple of minor bugfixes.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Yunjian Wang (1):
      virtio_net: fix return value check in receive_mergeable()

weiping zhang (2):
      virtio_mmio: add cleanup for virtio_mmio_probe
      virtio_mmio: add cleanup for virtio_mmio_remove

 drivers/net/virtio_net.c     |  2 +-
 drivers/virtio/virtio_mmio.c | 57 ++++++++++++++++++++++++++++++++++++--------
 2 files changed, 48 insertions(+), 11 deletions(-)
