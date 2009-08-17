From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCHv3 1/4] qemu-kvm: move virtio-pci.o to near pci.o
Date: Mon, 17 Aug 2009 15:37:08 +0300
Message-ID: <20090817123708.GB10700__48680.8846392252$1250513165$gmane$org@redhat.com>
References: <cover.1250512448.git.mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <cover.1250512448.git.mst@redhat.com>
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

virtio-pci depends, and will always depend, on pci.c
so it makes sense to keep it in the same makefile,
(unlike the rest of virtio files which should eventually
 be moved out to Makefile.hw).

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 Makefile.hw     |    2 +-
 Makefile.target |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile.hw b/Makefile.hw
index 139412e..6472ec1 100644
--- a/Makefile.hw
+++ b/Makefile.hw
@@ -11,7 +11,7 @@ VPATH=$(SRC_PATH):$(SRC_PATH)/hw
 QEMU_CFLAGS+=-I.. -I$(SRC_PATH)/fpu
 
 obj-y =
-obj-y += virtio.o virtio-pci.o
+obj-y += virtio.o
 obj-y += fw_cfg.o
 obj-y += watchdog.o
 obj-y += nand.o ecc.o
diff --git a/Makefile.target b/Makefile.target
index aeda3fe..f6d9708 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -170,7 +170,7 @@ obj-y = vl.o osdep.o monitor.o pci.o loader.o isa_mmio.o machine.o \
         gdbstub.o gdbstub-xml.o msix.o ioport.o qemu-config.o
 # virtio has to be here due to weird dependency between PCI and virtio-net.
 # need to fix this properly
-obj-y += virtio-blk.o virtio-balloon.o virtio-net.o virtio-console.o
+obj-y += virtio-blk.o virtio-balloon.o virtio-net.o virtio-console.o virtio-pci.o
 obj-$(CONFIG_KVM) += kvm.o kvm-all.o
 
 LIBS+=-lz
-- 
1.6.2.5
