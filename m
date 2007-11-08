From: Anthony Liguori <aliguori-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 2/3] Put the virtio under the virtualization menu
Date: Wed,  7 Nov 2007 20:46:31 -0600
Message-ID: <11944900152750-git-send-email-aliguori@us.ibm.com>
References: <11944899922822-git-send-email-aliguori@us.ibm.com>
	<11944900141678-git-send-email-aliguori@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kvm-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <11944900141678-git-send-email-aliguori-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/kvm-devel>,
	<mailto:kvm-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=kvm-devel>
List-Post: <mailto:kvm-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:kvm-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/kvm-devel>,
	<mailto:kvm-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: kvm-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: kvm-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Rusty Russell <rusty-PBSTF//UHa40n/F98K4Iww@public.gmane.org>, virtualization-qjLDD68F18O7TbgM5vRIOg@public.gmane.org, Anthony Liguori <aliguori-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>, kvm-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: virtualization@lists.linuxfoundation.org

This patch moves virtio under the virtualization menu and changes virtio
devices to not claim to only be for lguest.

Signed-off-by: Anthony Liguori <aliguori-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>

diff --git a/drivers/Kconfig b/drivers/Kconfig
index f4076d9..d945ffc 100644
--- a/drivers/Kconfig
+++ b/drivers/Kconfig
@@ -93,6 +93,4 @@ source "drivers/auxdisplay/Kconfig"
 source "drivers/kvm/Kconfig"
 
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
-	  This is the virtual block driver for lguest.  Say Y or M.
+	  This is the virtual block driver for virtio.  It can be used with
+          lguest or QEMU based VMMs (like KVM or Xen).  Say Y or M.
 
 endif # BLK_DEV
diff --git a/drivers/kvm/Kconfig b/drivers/kvm/Kconfig
index 6569206..ac4bcdf 100644
--- a/drivers/kvm/Kconfig
+++ b/drivers/kvm/Kconfig
@@ -50,5 +50,6 @@ config KVM_AMD
 # OK, it's a little counter-intuitive to do this, but it puts it neatly under
 # the virtualization menu.
 source drivers/lguest/Kconfig
+source drivers/virtio/Kconfig
 
 endif # VIRTUALIZATION
diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index 86b8641..e66aec4 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -3107,6 +3107,7 @@ config VIRTIO_NET
 	tristate "Virtio network driver (EXPERIMENTAL)"
 	depends on EXPERIMENTAL && VIRTIO
 	---help---
-	  This is the virtual network driver for lguest.  Say Y or M.
+	  This is the virtual network driver for virtio.  It can be used with
+          lguest or QEMU based VMMs (like KVM or Xen).  Say Y or M.
 
 endif # NETDEVICES

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
