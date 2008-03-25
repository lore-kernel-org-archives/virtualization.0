From: Carsten Otte <cotte@de.ibm.com>
Subject: [RFC/PATCH 11/15 v3] kvm-s390: add kvm to kconfig on s390
Date: Tue, 25 Mar 2008 18:47:36 +0100
Message-ID: <1206467256.6507.47.camel__42231.8066739992$1206467880$gmane$org@cotte.boeblingen.de.ibm.com>
References: <1206030270.6690.51.camel@cotte.boeblingen.de.ibm.com>
	<1206205354.7177.82.camel@cotte.boeblingen.de.ibm.com>
	<1206458154.6217.12.camel@cotte.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1206458154.6217.12.camel@cotte.boeblingen.de.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org, kvm-devel@lists.sourceforge.net, Avi Kivity <avi@qumranet.com>
Cc: aliguori@us.ibm.com, EHRHARDT@de.ibm.com, arnd@arndb.de, hollisb@us.ibm.com, heiko.carstens@de.ibm.com, jeroney@us.ibm.com, borntraeger@de.ibm.com, oliver.paukstadt@millenux.com, schwidefsky@de.ibm.com, rvdheij@gmail.com, os@de.ibm.com, jblunck@suse.de, "Zhang, Xiantao" <xiantao.zhang@intel.com>
List-Id: virtualization@lists.linuxfoundation.org

From: Carsten Otte <cotte@de.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>

This patch adds the virtualization submenu and the kvm option to the kernel
config. It also defines HAVE_KVM for 64bit kernels.

Acked-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Carsten Otte <cotte@de.ibm.com>
---
 arch/s390/Kconfig     |    3 +++
 arch/s390/kvm/Kconfig |   43 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+)

Index: kvm/arch/s390/Kconfig
===================================================================
--- kvm.orig/arch/s390/Kconfig
+++ kvm/arch/s390/Kconfig
@@ -66,6 +66,7 @@ config S390
 	select HAVE_OPROFILE
 	select HAVE_KPROBES
 	select HAVE_KRETPROBES
+	select HAVE_KVM if 64BIT
 
 source "init/Kconfig"
 
@@ -553,3 +554,5 @@ source "security/Kconfig"
 source "crypto/Kconfig"
 
 source "lib/Kconfig"
+
+source "arch/s390/kvm/Kconfig"
Index: kvm/arch/s390/kvm/Kconfig
===================================================================
--- /dev/null
+++ kvm/arch/s390/kvm/Kconfig
@@ -0,0 +1,43 @@
+#
+# KVM configuration
+#
+config HAVE_KVM
+       bool
+
+menuconfig VIRTUALIZATION
+	bool "Virtualization"
+	default y
+	---help---
+	  Say Y here to get to see options for using your Linux host to run other
+	  operating systems inside virtual machines (guests).
+	  This option alone does not add any kernel code.
+
+	  If you say N, all options in this submenu will be skipped and disabled.
+
+if VIRTUALIZATION
+
+config KVM
+	tristate "Kernel-based Virtual Machine (KVM) support"
+	depends on HAVE_KVM && EXPERIMENTAL
+	select PREEMPT_NOTIFIERS
+	select ANON_INODES
+	select S390_SWITCH_AMODE
+	select PREEMPT
+	---help---
+	  Support hosting paravirtualized guest machines using the SIE
+	  virtualization capability on the mainframe. This should work
+	  on any 64bit machine.
+
+	  This module provides access to the hardware capabilities through
+	  a character device node named /dev/kvm.
+
+	  To compile this as a module, choose M here: the module
+	  will be called kvm.
+
+	  If unsure, say N.
+
+# OK, it's a little counter-intuitive to do this, but it puts it neatly under
+# the virtualization menu.
+source drivers/virtio/Kconfig
+
+endif # VIRTUALIZATION
