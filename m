From: Dor Laor <dor.laor@gmail.com>
Subject: [kvm-devel] [Virtio-for-kvm] [PATCH 4/13] [Mostly resend] virtio
 additions
Date: Fri, 21 Dec 2007 17:18:40 +0200
Message-ID: <476BD950.5070007__30758.9037264281$1198250436$gmane$org@qumranet.com>
Reply-To: dor.laor@qumranet.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
To: kvm-devel <kvm-devel@lists.sourceforge.net>, virtualization <virtualization@lists.linux-foundation.org>, Rusty Russell <rusty@rustcorp.com.au>Anthony Liguori <a>
List-Id: virtualization@lists.linuxfoundation.org

 From 2813e9d7766846b5489ec17bfe85e40ee026ef10 Mon Sep 17 00:00:00 2001
From: Anthony Liguori <aliguori@us.ibm.com>
Date: Wed, 7 Nov 2007 20:46:31 -0600
Subject: [PATCH] virtio: Put the virtio under the virtualization menu

This patch moves virtio under the virtualization menu and changes virtio
devices to not claim to only be for lguest.

Signed-off-by: Anthony Liguori <aliguori@us.ibm.com>
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 arch/x86/kvm/Kconfig  |    1 +
 drivers/Kconfig       |    2 --
 drivers/block/Kconfig |    3 ++-
 drivers/net/Kconfig   |    3 ++-
 4 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
index 4086080..6f1414b 100644
--- a/arch/x86/kvm/Kconfig
+++ b/arch/x86/kvm/Kconfig
@@ -50,5 +50,6 @@ config KVM_AMD
 # OK, it's a little counter-intuitive to do this, but it puts it neatly 
under
 # the virtualization menu.
 source drivers/lguest/Kconfig
+source drivers/virtio/Kconfig
 
 endif # VIRTUALIZATION
diff --git a/drivers/Kconfig b/drivers/Kconfig
index 08d4ae2..3f8a231 100644
--- a/drivers/Kconfig
+++ b/drivers/Kconfig
@@ -91,6 +91,4 @@ source "drivers/dca/Kconfig"
 source "drivers/auxdisplay/Kconfig"
 
 source "drivers/uio/Kconfig"
-
-source "drivers/virtio/Kconfig"
 endmenu
diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
index 4d0119e..be4b224 100644
--- a/drivers/block/Kconfig
+++ b/drivers/block/Kconfig
@@ -429,6 +429,7 @@ config VIRTIO_BLK
     tristate "Virtio block driver (EXPERIMENTAL)"
     depends on EXPERIMENTAL && VIRTIO
     ---help---
-      This is the virtual block driver for lguest.  Say Y or M.
+      This is the virtual block driver for virtio.  It can be used with
+          lguest or QEMU based VMMs (like KVM or Xen).  Say Y or M.
 
 endif # BLK_DEV
diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index d9107e5..1113caf 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -3070,6 +3070,7 @@ config VIRTIO_NET
     tristate "Virtio network driver (EXPERIMENTAL)"
     depends on EXPERIMENTAL && VIRTIO
     ---help---
-      This is the virtual network driver for lguest.  Say Y or M.
+      This is the virtual network driver for virtio.  It can be used with
+          lguest or QEMU based VMMs (like KVM or Xen).  Say Y or M.
 
 endif # NETDEVICES
-- 
1.5.3.3
