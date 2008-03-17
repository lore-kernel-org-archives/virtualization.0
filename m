From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PULL] 2.6.25 virtio fixes
Date: Mon, 17 Mar 2008 23:10:22 +1100
Message-ID: <200803172310.22732.rusty__36965.8924792477$1205756082$gmane$org@rustcorp.com.au>
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
Cc: Anthony Liguori <aliguori@us.ibm.com>, Amit Shah <amitshah@gmx.net>, Jeremy Katz <katzj@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

The following changes since commit a978b30af3bab0dd9af9350eeda25e76123fa28e:
  Linus Torvalds (1):
        Linux 2.6.25-rc6

are available in the git repository at:

  ssh://master.kernel.org/pub/scm/linux/kernel/git/rusty/linux-2.6-for-linus.git master

Amit Shah (1):
      virtio: Enable netpoll interface for netconsole logging

Anthony Liguori (1):
      virtio: Use spin_lock_irqsave/restore for virtio-pci

Christian Borntraeger (1):
      virtio: fix race in enable_cb

Jeremy Katz (1):
      virtio: Fix sysfs bits to have proper block symlink

Rusty Russell (1):
      virtio: handle > 2 billion page balloon targets

 drivers/block/virtio_blk.c      |    1 +
 drivers/net/virtio_net.c        |   22 +++++++++++++++++++---
 drivers/virtio/virtio_balloon.c |    4 ++--
 drivers/virtio/virtio_pci.c     |   15 +++++++++------
 drivers/virtio/virtio_ring.c    |    1 -
 include/linux/virtio.h          |    5 +++--
 6 files changed, 34 insertions(+), 14 deletions(-)
