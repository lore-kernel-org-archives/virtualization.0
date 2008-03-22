From: Carsten Otte <cotte@de.ibm.com>
Subject: [RFC/PATCH 14/15 v2] guest: detect when running on kvm
Date: Sat, 22 Mar 2008 18:03:03 +0100
Message-ID: <1206205383.7177.96.camel__17325.9693234742$1206224714$gmane$org@cotte.boeblingen.de.ibm.com>
References: <1206030270.6690.51.camel@cotte.boeblingen.de.ibm.com>
	<1206203560.7177.45.camel@cotte.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1206203560.7177.45.camel@cotte.boeblingen.de.ibm.com>
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
Cc: aliguori@us.ibm.com, EHRHARDT@de.ibm.com, arnd@arndb.de, hollisb@us.ibm.com, heiko.carstens@de.ibm.com, jeroney@us.ibm.com, borntraeger@de.ibm.com, schwidefsky@de.ibm.com, rvdheij@gmail.com, os@de.ibm.com, jblunck@suse.de, "Zhang,
	Xiantao" <xiantao.zhang@intel.com>
List-Id: virtualization@lists.linuxfoundation.org

From: Christian Borntraeger <borntraeger@de.ibm.com>
From: Carsten Otte <cotte@de.ibm.com>

This patch adds functionality to detect if the kernel runs under the KVM
hypervisor. A macro MACHINE_IS_KVM is exported for device drivers. This
allows drivers to skip device detection if the systems runs non-virtualized.
We also define a preferred console to avoid having the ttyS0, which is a line
mode only console.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Acked-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Carsten Otte <cotte@de.ibm.com>
---
 arch/s390/Kconfig        |    7 +++++++
 arch/s390/kernel/early.c |    4 ++++
 arch/s390/kernel/setup.c |   10 +++++++---
 include/asm-s390/setup.h |    1 +
 4 files changed, 19 insertions(+), 3 deletions(-)

Index: kvm/arch/s390/Kconfig
===================================================================
--- kvm.orig/arch/s390/Kconfig
+++ kvm/arch/s390/Kconfig
@@ -533,6 +533,13 @@ config ZFCPDUMP
 	  Select this option if you want to build an zfcpdump enabled kernel.
 	  Refer to <file:Documentation/s390/zfcpdump.txt> for more details on this.
 
+config S390_GUEST
+bool "s390 guest support (EXPERIMENTAL)"
+	depends on 64BIT && EXPERIMENTAL
+	select VIRTIO
+	select VIRTIO_RING
+	help
+	  Select this option if you want to run the kernel under s390 linux
 endmenu
 
 source "net/Kconfig"
Index: kvm/arch/s390/kernel/early.c
===================================================================
--- kvm.orig/arch/s390/kernel/early.c
+++ kvm/arch/s390/kernel/early.c
@@ -143,6 +143,10 @@ static noinline __init void detect_machi
 	/* Running on a P/390 ? */
 	if (cpuinfo->cpu_id.machine == 0x7490)
 		machine_flags |= 4;
+
+	/* Running under KVM ? */
+	if (cpuinfo->cpu_id.version == 0xfe)
+		machine_flags |= 64;
 }
 
 #ifdef CONFIG_64BIT
Index: kvm/arch/s390/kernel/setup.c
===================================================================
--- kvm.orig/arch/s390/kernel/setup.c
+++ kvm/arch/s390/kernel/setup.c
@@ -793,9 +793,13 @@ setup_arch(char **cmdline_p)
 	       "This machine has an IEEE fpu\n" :
 	       "This machine has no IEEE fpu\n");
 #else /* CONFIG_64BIT */
-	printk((MACHINE_IS_VM) ?
-	       "We are running under VM (64 bit mode)\n" :
-	       "We are running native (64 bit mode)\n");
+	if (MACHINE_IS_VM)
+		printk("We are running under VM (64 bit mode)\n");
+	else if (MACHINE_IS_KVM) {
+		printk("We are running under KVM (64 bit mode)\n");
+		add_preferred_console("ttyS", 1, NULL);
+	} else
+		printk("We are running native (64 bit mode)\n");
 #endif /* CONFIG_64BIT */
 
 	/* Save unparsed command line copy for /proc/cmdline */
Index: kvm/include/asm-s390/setup.h
===================================================================
--- kvm.orig/include/asm-s390/setup.h
+++ kvm/include/asm-s390/setup.h
@@ -62,6 +62,7 @@ extern unsigned long machine_flags;
 #define MACHINE_IS_VM		(machine_flags & 1)
 #define MACHINE_IS_P390		(machine_flags & 4)
 #define MACHINE_HAS_MVPG	(machine_flags & 16)
+#define MACHINE_IS_KVM		(machine_flags & 64)
 #define MACHINE_HAS_IDTE	(machine_flags & 128)
 #define MACHINE_HAS_DIAG9C	(machine_flags & 256)
