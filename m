From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 2/3] Consolidate host virtualization support under
	Virtualization menu
Date: Fri, 14 Sep 2007 15:18:44 +1000
Message-ID: <1189747124.7262.36.camel__13421.5438542471$1189747270$gmane$org@localhost.localdomain>
References: <1189747054.7262.34.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1189747054.7262.34.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Anthony Liguori <aliguori@us.ibm.com>, virtualization <virtualization@lists.linux-foundation.org>, Chris Wright <chrisw@sous-sol.org>
List-Id: virtualization@lists.linuxfoundation.org

We turn "Virtualization" into a menu, not a config option, since it's
actually only used as a menu.  Then we move lguest under that menu.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

diff -r c2893801de2a drivers/Kconfig
--- a/drivers/Kconfig	Fri Sep 14 13:24:46 2007 +1000
+++ b/drivers/Kconfig	Fri Sep 14 13:24:49 2007 +1000
@@ -87,6 +87,4 @@ source "drivers/kvm/Kconfig"
 source "drivers/kvm/Kconfig"
 
 source "drivers/uio/Kconfig"
-
-source "drivers/lguest/Kconfig"
 endmenu
diff -r c2893801de2a drivers/kvm/Kconfig
--- a/drivers/kvm/Kconfig	Fri Sep 14 13:24:46 2007 +1000
+++ b/drivers/kvm/Kconfig	Fri Sep 14 13:32:22 2007 +1000
@@ -1,21 +1,12 @@
 #
 # KVM configuration
 #
-menuconfig VIRTUALIZATION
-	bool "Virtualization"
+menu "Virtualization"
 	depends on X86
-	default y
-	---help---
-	  Say Y here to get to see options for virtualization guest drivers.
-	  This option alone does not add any kernel code.
-
-	  If you say N, all options in this submenu will be skipped and disabled.
-
-if VIRTUALIZATION
 
 config KVM
 	tristate "Kernel-based Virtual Machine (KVM) support"
-	depends on X86 && EXPERIMENTAL
+	depends on EXPERIMENTAL
 	select ANON_INODES
 	---help---
 	  Support hosting fully virtualized guest machines using hardware
@@ -45,4 +36,8 @@ config KVM_AMD
 	  Provides support for KVM on AMD processors equipped with the AMD-V
 	  (SVM) extensions.
 
-endif # VIRTUALIZATION
+# OK, it's a little counter-intuitive to do this, but it puts it neatly under
+# the virtualization menu.
+source drivers/lguest/Kconfig
+
+endmenu
