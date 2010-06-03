From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PULL] virtio fixes
Date: Thu, 3 Jun 2010 22:43:53 +0930
Message-ID: <201006032243.54702.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
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
Cc: Amit Shah <amit.shah@redhat.com>, Christoph Hellwig <hch@lst.de>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

The following changes since commit aef4b9aaae1decc775778903922bd0075cce7a88:
  Linus Torvalds (1):
        Merge branch 'next' of git://git.kernel.org/.../benh/powerpc

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rusty/linux-2.6-for-linus.git virtio

Amit Shah (2):
      virtio: console: Fix crash when hot-unplugging a port and read is blocked
      virtio: console: Fix crash when port is unplugged and blocked for write

Christoph Hellwig (1):
      virtio-blk: fix minimum number of S/G elements

 drivers/block/virtio_blk.c    |    4 +++-
 drivers/char/virtio_console.c |   14 +++++++++++---
 2 files changed, 14 insertions(+), 4 deletions(-)

commit a5b365a652206ca300256974ed9301a7d241a6ed
Author: Christoph Hellwig <hch@lst.de>
Date:   Tue May 25 14:17:54 2010 +0200

    virtio-blk: fix minimum number of S/G elements
    
    We need at least one S/G element to operate properly, as does the block
    layer which increments it to one anyway.  We hit this due to a qemu
    bug which advertises a sg_elements of 0 under some circumstances.
    
    Signed-off-by: Christoph Hellwig <hch@lst.de>
    Signed-off-by: Rusty Russell <rusty@rustcorp.com.au> (tweaked logic)

 drivers/block/virtio_blk.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

commit 0047634d3daebca9e99a22eb89167bf77f35cdfa
Author: Amit Shah <amit.shah@redhat.com>
Date:   Thu May 27 13:24:39 2010 +0530

    virtio: console: Fix crash when hot-unplugging a port and read is blocked
    
    When removing a port we don't check if a program was blocked for read.
    This leads to a crash when SIGTERM is sent to the program after
    hot-unplugging the port.
    
    Signed-off-by: Amit Shah <amit.shah@redhat.com>
    Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

 drivers/char/virtio_console.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

commit 60e5e0b84045ce0f6ab07a02c7fcd6627b53d2d3
Author: Amit Shah <amit.shah@redhat.com>
Date:   Thu May 27 13:24:40 2010 +0530

    virtio: console: Fix crash when port is unplugged and blocked for write
    
    When a program that has a virtio port opened and blocked for a write
    operation, a port hot-unplug event will later led to a crash when
    SIGTERM was sent to the program. Fix that.
    
    Signed-off-by: Amit Shah <amit.shah@redhat.com>
    Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

 drivers/char/virtio_console.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)
