From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCHv2 0/2] vhost: a kernel-level virtio server
Date: Wed, 12 Aug 2009 00:27:43 +0300
Message-ID: <20090811212743.GA26309__3356.43883231587$1250030490$gmane$org@redhat.com>
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
To: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, mingo@elte.hu, linux-mm@kvack.org, akpm@linux-founda
List-Id: virtualization@lists.linuxfoundation.org

This implements vhost: a kernel-level backend for virtio,
The main motivation for this work is to reduce virtualization
overhead for virtio by removing system calls on data path,
without guest changes. For virtio-net, this removes up to
4 system calls per packet: vm exit for kick, reentry for kick,
iothread wakeup for packet, interrupt injection for packet.

Some more detailed description attached to the patch itself.

The patches are against 2.6.31-rc4.  I'd like them to go into linux-next
and down the road 2.6.32 if possible.  Please comment.

Changes from v1:
- Move use_mm/unuse_mm from fs/aio.c to mm instead of copying.
- Reorder code to avoid need for forward declarations
- Kill a couple of debugging printks

Michael S. Tsirkin (2):
  mm: export use_mm/unuse_mm to modules
  vhost_net: a kernel-level virtio server

 MAINTAINERS                 |   10 +
 arch/x86/kvm/Kconfig        |    1 +
 drivers/Makefile            |    1 +
 drivers/vhost/Kconfig       |   11 +
 drivers/vhost/Makefile      |    2 +
 drivers/vhost/net.c         |  411 +++++++++++++++++++++++++++
 drivers/vhost/vhost.c       |  663 +++++++++++++++++++++++++++++++++++++++++++
 drivers/vhost/vhost.h       |  108 +++++++
 fs/aio.c                    |   47 +---
 include/linux/Kbuild        |    1 +
 include/linux/miscdevice.h  |    1 +
 include/linux/mmu_context.h |    9 +
 include/linux/vhost.h       |  100 +++++++
 mm/Makefile                 |    2 +-
 mm/mmu_context.c            |   58 ++++
 15 files changed, 1378 insertions(+), 47 deletions(-)
 create mode 100644 drivers/vhost/Kconfig
 create mode 100644 drivers/vhost/Makefile
 create mode 100644 drivers/vhost/net.c
 create mode 100644 drivers/vhost/vhost.c
 create mode 100644 drivers/vhost/vhost.h
 create mode 100644 include/linux/mmu_context.h
 create mode 100644 include/linux/vhost.h
 create mode 100644 mm/mmu_context.c
