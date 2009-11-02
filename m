From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCHv4 0/6] qemu-kvm: vhost net support
Date: Tue, 3 Nov 2009 00:23:20 +0200
Message-ID: <20091102222320.GA15153__49721.4091629305$1257200877$gmane$org@redhat.com>
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

This is not intented for merge.  See vhost net patch description for
details.  This applies on top of commit
47e465f031fc43c53ea8f08fa55cc3482c6435c8 in Avi's tree.  It won't apply
to tree tip. TODO: rebase.

The patchset also includes raw socket backend since I find it useful for
testing vhost. When we get to merging, there's no reason to merge these
features together, and dependency between patches is minimal.

Changes since v3:
- changed option syntax
- filled in feature negotiation
Changes since v2:
- minor fixes
- added patch to build on RHEL5.3
Changes since v1:
- rebased on top of 9dc275d9d660fe1cd64d36102d600885f9fdb88a

Michael S. Tsirkin (5):
  qemu/virtio: move features to an inline function
  qemu/net: routines to get tap fd
  qemu/net: move typedef to qemu-common.h
  qemu/raw: add API to get raw socket
  qemu-kvm: vhost-net implementation

Or Gerlitz (1):
  qemu/net: add raw backend

 Makefile.target           |    3 +-
 hw/vhost_net.c            |  251 +++++++++++++++++++++++++++++++++++++++++++++
 hw/vhost_net.h            |   38 +++++++
 hw/virtio-balloon.c       |    2 +-
 hw/virtio-blk.c           |    2 +-
 hw/virtio-console.c       |    2 +-
 hw/virtio-net.c           |   68 ++++++++++--
 hw/virtio-pci.c           |   43 +++++++-
 hw/virtio.c               |   19 ----
 hw/virtio.h               |   38 ++++++-
 kvm/include/linux/vhost.h |  126 +++++++++++++++++++++++
 net.c                     |  217 +++++++++++++++++++++++++++++++++++++++
 net.h                     |    6 +-
 qemu-common.h             |    1 +
 qemu-kvm.c                |    8 --
 qemu-kvm.h                |    9 ++
 qemu-options.hx           |    4 +
 17 files changed, 787 insertions(+), 50 deletions(-)
 create mode 100644 hw/vhost_net.c
 create mode 100644 hw/vhost_net.h
 create mode 100644 kvm/include/linux/vhost.h
