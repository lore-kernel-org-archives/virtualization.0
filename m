From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 2/3] Virtualization config cleanup: move lgeust under
	virtualization menu
Date: Tue, 25 Sep 2007 13:59:59 +1000
Message-ID: <1190692799.27805.279.camel__43948.6141353429$1190692919$gmane$org@localhost.localdomain>
References: <1190692688.27805.276.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1190692688.27805.276.camel@localhost.localdomain>
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
Cc: Andi Kleen <ak@muc.de>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Move lguest under the virtualization menu.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
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
