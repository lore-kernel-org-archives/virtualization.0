From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCHv2 0/3] qemu-kvm: vhost net support
Date: Thu, 13 Aug 2009 11:50:40 +0300
Message-ID: <20090813085040.GA4726__1923.19635903022$1250153563$gmane$org@redhat.com>
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
To: avi@redhat.com, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

This adds support for vhost-net virtio kernel backend.

This is RFC, but works without issues for me.

Still needs to be split up, tested and benchmarked properly,
but posting it here in case people want to test drive
the kernel bits I posted.

Changes since v1:
- rebased on top of 9dc275d9d660fe1cd64d36102d600885f9fdb88a

Michael S. Tsirkin (3):
  qemu-kvm: move virtio-pci.o to near pci.o
  virtio: move features to an inline function
  qemu-kvm: vhost-net implementation

 Makefile.hw         |    2 +-
 Makefile.target     |    3 +-
 hw/vhost_net.c      |  181 +++++++++++++++++++++++++++++++++++++++++++++++++++
 hw/vhost_net.h      |   30 +++++++++
 hw/virtio-balloon.c |    2 +-
 hw/virtio-blk.c     |    2 +-
 hw/virtio-console.c |    2 +-
 hw/virtio-net.c     |   34 +++++++++-
 hw/virtio-pci.c     |   43 +++++++++++-
 hw/virtio.c         |   19 ------
 hw/virtio.h         |   38 ++++++++++-
 net.c               |    5 ++
 net.h               |    1 +
 qemu-kvm.h          |    9 +++
 14 files changed, 339 insertions(+), 32 deletions(-)
 create mode 100644 hw/vhost_net.c
 create mode 100644 hw/vhost_net.h
