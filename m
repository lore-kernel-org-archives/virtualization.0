From: "Michael S. Tsirkin" <mst@kernel.org>
Subject: [PULL] vhost: cleanups and fixes
Date: Thu, 1 Jan 2015 14:26:34 +0200
Message-ID: <20150101122634.GA2670__9679.72748117081$1420223594$gmane$org@redhat.com>
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
Cc: kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

The following changes since commit b7392d2247cfe6771f95d256374f1a8e6a6f48d6:

  Linux 3.19-rc2 (2014-12-28 16:49:37 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to 5d9a07b0de512b77bf28d2401e5fe3351f00a240:

  vhost: relax used address alignment (2014-12-29 10:55:06 +0200)

----------------------------------------------------------------
vhost: virtio 1.0 bugfix

There's a single change here, fixing a vhost bug where vhost initialization
fails due to used ring alignment check being too strict.

Cc: Rusty Russell <rusty@rustcorp.com.au>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Michael S. Tsirkin (2):
      virtio_ring: document alignment requirements
      vhost: relax used address alignment

 include/uapi/linux/virtio_ring.h |  7 +++++++
 drivers/vhost/vhost.c            | 10 +++++++---
 2 files changed, 14 insertions(+), 3 deletions(-)
