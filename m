From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PULL] virtio, lguest and module comment fixes
Date: Mon, 19 Nov 2007 11:22:42 +1100
Message-ID: <200711191122.42767.rusty__1138.27961399711$1195432058$gmane$org@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: lguest <lguest@ozlabs.org>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

The following changes since commit 2ffbb8377c7a0713baf6644e285adc27a5654582:
  Linus Torvalds (1):
        Merge branch 'master' of git://git.kernel.org/.../x86/linux-2.6-x86

are available in the git repository at:

  ssh://master.kernel.org/pub/scm/linux/kernel/git/rusty/linux-2.6-for-linus master

Matti Linnanvuori (1):
      module: fix and elaborate comments

Rusty Russell (3):
      lguest: Fix uninitialized members in example launcher
      virtio: fix module/device unloading
      virtio: fix net driver loop case where we fail to restart

 Documentation/lguest/lguest.c  |    9 ++++++---
 drivers/block/virtio_blk.c     |   10 +++++++---
 drivers/lguest/lguest_device.c |    2 ++
 drivers/net/virtio_net.c       |   12 ++++++++----
 drivers/virtio/virtio.c        |   13 +++++++++++++
 kernel/module.c                |    8 +++++---
 6 files changed, 41 insertions(+), 13 deletions(-)
