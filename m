From: rusty@rustcorp.com.au
Subject: [patch 04/43] lguest: Consolidate host virtualization support under
	Virtualization menu
Date: Wed, 26 Sep 2007 16:36:22 +1000
Message-ID: <20070926063645.637566207@rustcorp.com.au>
References: <20070926063618.956228976@rustcorp.com.au>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline; filename=kconfig-virtualization.patch
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: lguest@ozlabs.org
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Move lguest under the virtualization menu.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
Cc: Avi Kivity <avi@qumranet.com>
---
 drivers/Kconfig     |    2 --
 drivers/kvm/Kconfig |    6 +++++-
 2 files changed, 5 insertions(+), 3 deletions(-)

===================================================================
--- a/drivers/Kconfig
+++ b/drivers/Kconfig
@@ -87,6 +87,4 @@ source "drivers/kvm/Kconfig"
 source "drivers/kvm/Kconfig"
 
 source "drivers/uio/Kconfig"
-
-source "drivers/lguest/Kconfig"
 endmenu
===================================================================
--- a/drivers/kvm/Kconfig
+++ b/drivers/kvm/Kconfig
@@ -45,4 +36,8 @@ config KVM_AMD
 	  Provides support for KVM on AMD processors equipped with the AMD-V
 	  (SVM) extensions.
 
-endif # VIRTUALIZATION
+# OK, it's a little counter-intuitive to do this, but it puts it neatly under
+# the virtualization menu.
+source drivers/lguest/Kconfig
+
+endif # VIRTUALIZATION

--
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy
