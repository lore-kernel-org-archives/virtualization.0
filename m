From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH RFC 00/11] linux: towards virtio-1 guest support
Date: Tue,  7 Oct 2014 16:39:41 +0200
Message-ID: <1412692792-12325-1-git-send-email-cornelia.huck__48466.6557320908$1412704943$gmane$org@de.ibm.com>
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
To: virtualization@lists.linux-foundation.org, qemu-devel@nongnu.org, kvm@vger.kernel.org
Cc: thuth@linux.vnet.ibm.com
List-Id: virtualization@lists.linuxfoundation.org

This patchset tries to go towards implementing both virtio-1 compliant and
transitional virtio drivers in Linux. Branch available at

git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux virtio-1

This is based on some old patches by Rusty to handle extended feature bits
and endianness conversions. Thomas implemented the new virtio-ccw transport
revision command, and I hacked up some further endianness stuff and
virtio-ccw enablement. Probably a lot still missing, but I can run a
virtio-ccw guest that enables virtio-1 accesses if the host supports it
(via the qemu host patchset) - virtio-net and virtio-blk only so far.

I consider this patchset a starting point for further discussions.

Cornelia Huck (5):
  virtio: endianess conversion helpers
  virtio: allow transports to get avail/used addresses
  virtio_blk: use virtio v1.0 endian
  KVM: s390: virtio-ccw revision 1 SET_VQ
  KVM: s390: enable virtio-ccw revision 1

Rusty Russell (5):
  virtio: use u32, not bitmap for struct virtio_device's features
  virtio: add support for 64 bit features.
  virtio_ring: implement endian reversal based on VERSION_1 feature.
  virtio_config: endian conversion for v1.0.
  virtio_net: use v1.0 endian.

Thomas Huth (1):
  KVM: s390: Set virtio-ccw transport revision

 drivers/block/virtio_blk.c             |    4 +
 drivers/char/virtio_console.c          |    2 +-
 drivers/lguest/lguest_device.c         |   16 +--
 drivers/net/virtio_net.c               |   31 +++--
 drivers/remoteproc/remoteproc_virtio.c |    7 +-
 drivers/s390/kvm/kvm_virtio.c          |   10 +-
 drivers/s390/kvm/virtio_ccw.c          |  165 ++++++++++++++++++++-----
 drivers/virtio/virtio.c                |   22 ++--
 drivers/virtio/virtio_mmio.c           |   20 +--
 drivers/virtio/virtio_pci.c            |    8 +-
 drivers/virtio/virtio_ring.c           |  213 +++++++++++++++++++++++---------
 include/linux/virtio.h                 |   46 ++++++-
 include/linux/virtio_config.h          |   17 +--
 include/uapi/linux/virtio_config.h     |    3 +
 tools/virtio/linux/virtio.h            |   22 +---
 tools/virtio/linux/virtio_config.h     |    2 +-
 tools/virtio/virtio_test.c             |    5 +-
 tools/virtio/vringh_test.c             |   16 +--
 18 files changed, 428 insertions(+), 181 deletions(-)

-- 
1.7.9.5
