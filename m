From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v2 00/15] virtio: fix spec compliance issues
Date: Mon, 6 Oct 2014 18:10:37 +0300
Message-ID: <1412608214-31944-1-git-send-email-mst@redhat.com>
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
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Rusty, I have a mind to include this patchset for this merge window.
Any input on this?

This fixes the following virtio spec compliance issues:
1. on restore, drivers use device before setting ACKNOWLEDGE and DRIVER bits
2. on probe, drivers aren't prepared to handle config interrupts
   arriving before probe returns
3. on probe, drivers use device before DRIVER_OK it set

Note that 1 is a clear violation of virtio spec 0.9 and 1.0,
so I am proposing the fix for stable. OTOH 2 is against 1.0 rules but
is a known documented bug in many drivers, so let's fix it going
forward, but it does not seem to be worth it to backport
the changes.

An error handling bugfix for virtio-net is also included.

2 is merely a theoretical race condition, but it seems important
to address to make sure that changes to address 3 do not introduce
instability.

Michael S. Tsirkin (15):
  virtio_pci: fix virtio spec compliance on restore
  virtio: unify config_changed handling
  virtio-pci: move freeze/restore to virtio core
  virtio: defer config changed notifications
  virtio_blk: drop config_enable
  virtio-blk: drop config_mutex
  virtio_net: drop config_enable
  virtio-net: drop config_mutex
  virtio_net: minor cleanup
  virtio: add API to enable VQs early
  virtio_net: enable VQs early
  virtio_blk: enable VQs early
  virtio_console: enable VQs early
  9p/trans_virtio: enable VQs early
  virtio_net: fix use after free on allocation failure

 include/linux/virtio.h             |  14 +++++
 include/linux/virtio_config.h      |  17 +++++++
 drivers/block/virtio_blk.c         |  31 ++----------
 drivers/char/virtio_console.c      |   2 +
 drivers/misc/mic/card/mic_virtio.c |   6 +--
 drivers/net/virtio_net.c           |  42 ++++-----------
 drivers/s390/kvm/kvm_virtio.c      |   9 +---
 drivers/s390/kvm/virtio_ccw.c      |   6 +--
 drivers/virtio/virtio.c            | 101 +++++++++++++++++++++++++++++++++++++
 drivers/virtio/virtio_mmio.c       |   7 +--
 drivers/virtio/virtio_pci.c        |  33 ++----------
 net/9p/trans_virtio.c              |   2 +
 12 files changed, 159 insertions(+), 111 deletions(-)

-- 
MST
