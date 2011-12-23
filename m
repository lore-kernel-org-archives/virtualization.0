From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [RESENDx2] [PULL] virtio: fix barriers for virtio-mmio
Date: Fri, 23 Dec 2011 15:46:17 +1030
Message-ID: <8739cbkgv2.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

This one as a signed tag on github, in case the inline patch was
the reason you dropped this.

virtio-mmio in new 3.2, and they found a corruption bug.  Please apply.

 * [new tag]         rusty@rustcorp.com.au -> rusty@rustcorp.com.au
The following changes since commit b3b1b70e62a603f473619dbebc3b3d23f535e6f8:

  Merge branch 'usb-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb (2011-12-22 12:59:47 -0800)

are available in the git repository at:

  git://github.com/rustyrussell/linux.git master

Rusty Russell (1):
      virtio: harsher barriers for virtio-mmio.

 drivers/lguest/lguest_device.c |    8 +++++---
 drivers/s390/kvm/kvm_virtio.c  |    2 +-
 drivers/virtio/virtio_mmio.c   |    7 ++++---
 drivers/virtio/virtio_pci.c    |    4 ++--
 drivers/virtio/virtio_ring.c   |   34 +++++++++++++++++++++-------------
 include/linux/virtio_ring.h    |    1 +
 tools/virtio/linux/virtio.h    |    1 +
 tools/virtio/virtio_test.c     |    3 ++-
 8 files changed, 37 insertions(+), 23 deletions(-)

commit ef3a731beb9a030e552945a734dc898b5525e2f7
Author: Rusty Russell <rusty@rustcorp.com.au>
Date:   Fri Dec 23 15:07:56 2011 +1030

    virtio: harsher barriers for virtio-mmio.
    
    We were cheating with our barriers; using the smp ones rather than the
    real device ones.  That was fine, until virtio-mmio came along, which
    could be talking to a real device (a non-SMP CPU).
    
    Unfortunately, just putting back the real barriers (reverting
    d57ed95d) causes a performance regression on virtio-pci.  In
    particular, Amos reports netbench's TCP_RR over virtio_net CPU
    utilization increased up to 35% while throughput went down by up to
    14%.
    
    By comparison, this branch is in the noise.
    
    Reference: https://lkml.org/lkml/2011/12/11/22
    
    Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

 drivers/lguest/lguest_device.c |    8 +++++---
 drivers/s390/kvm/kvm_virtio.c  |    2 +-
 drivers/virtio/virtio_mmio.c   |    7 ++++---
 drivers/virtio/virtio_pci.c    |    4 ++--
 drivers/virtio/virtio_ring.c   |   34 +++++++++++++++++++++-------------
 include/linux/virtio_ring.h    |    1 +
 tools/virtio/linux/virtio.h    |    1 +
 tools/virtio/virtio_test.c     |    3 ++-
 8 files changed, 37 insertions(+), 23 deletions(-)
