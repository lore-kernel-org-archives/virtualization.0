From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PULL] virtio & lguest changes for 2.6.26
Date: Fri, 2 May 2008 21:54:17 +1000
Message-ID: <200805022154.18177.rusty__49334.838128607$1209729478$gmane$org@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
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
Cc: lguest <lguest@ozlabs.org>, Marcelo Tosatti <marcelo@kvack.org>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, Harvey Harrison <harvey.harrison@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

The following changes since commit 886c35fbcf6fb2eee15687efc2d64d99b6ad9a4a:
  Linus Torvalds (1):
        Merge branch 'for-linus' of git://git.kernel.org/.../ieee1394/linux1394-2.6

are available in the git repository at:

  ssh://master.kernel.org/pub/scm/linux/kernel/git/rusty/linux-2.6-for-linus.git master

Christian Borntraeger (1):
      virtio: export more headers to userspace

Harvey Harrison (1):
      virtio: fix sparse return void-valued expression warnings

Marcelo Tosatti (1):
      virtio-blk: fix remove oops

Rusty Russell (11):
      virtio: ignore corrupted virtqueues rather than spinning.
      virtio: fix tx_ stats in virtio_net
      virtio: de-structify virtio_block status byte
      virtio: fix scatterlist sizing in net driver.
      virtio: wean net driver off NETDEV_TX_BUSY
      virtio: finer-grained features for virtio_net
      virtio: change config to guest endian.
      virtio: explicit advertisement of driver features
      lguest: avoid using NR_CPUS as a bounds check.
      lguest: remove bogus NULL cpu check
      lguest: make Launcher see device status updates

Ryan Harper (1):
      virtio: add virtio disk geometry feature

 Documentation/lguest/lguest.c   |   62 +++++++++++++++++---------
 drivers/block/virtio_blk.c      |   44 +++++++++++++-----
 drivers/lguest/lguest_device.c  |   68 +++++++++++++++++-----------
 drivers/lguest/lguest_user.c    |    4 +-
 drivers/net/virtio_net.c        |   96 +++++++++++++++++++++++++++-----------
 drivers/virtio/virtio.c         |   38 +++++++++++++++-
 drivers/virtio/virtio_balloon.c |   12 +++--
 drivers/virtio/virtio_pci.c     |   34 +++++++-------
 drivers/virtio/virtio_ring.c    |    5 ++
 include/linux/Kbuild            |    5 ++
 include/linux/virtio.h          |    7 +++
 include/linux/virtio_blk.h      |   14 +++---
 include/linux/virtio_config.h   |   81 ++++++++++++++++++---------------
 include/linux/virtio_net.h      |   13 +++++-
 14 files changed, 324 insertions(+), 159 deletions(-)
