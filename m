From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PULL] vhost: regression fixes
Date: Fri, 15 Dec 2017 20:19:39 +0200
Message-ID: <20171215201939-mutt-send-email-mst@kernel.org>
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
Cc: mark.rutland@arm.com, kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org, cohuck@redhat.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, zhangweiping@didichuxing.com
List-Id: virtualization@lists.linuxfoundation.org

The following changes since commit 03e9f8a05bce7330bcd9c5cc54c8e42d0fcbf993:

  virtio_net: fix return value check in receive_mergeable() (2017-12-07 18:34:52 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to c2e90800aef22e7ea14ea7560ba99993f11d3616:

  virtio_mmio: fix devm cleanup (2017-12-14 21:01:40 +0200)

----------------------------------------------------------------
virtio: regression fixes

Fixes two issues in the latest kernel.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Mark Rutland (1):
      virtio_mmio: fix devm cleanup

Michael S. Tsirkin (1):
      ptr_ring: fix up after recent ptr_ring changes

 drivers/virtio/virtio_mmio.c     | 43 +++++++++-------------------------------
 tools/virtio/ringtest/ptr_ring.c | 29 +++++++++++++++++++++------
 2 files changed, 32 insertions(+), 40 deletions(-)
