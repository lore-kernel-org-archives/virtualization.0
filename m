From: rusty@rustcorp.com.au
Subject: [patch 08/43] lguest: Lguest currently depends on 32-bit x86,
	not just x86.
Date: Wed, 26 Sep 2007 16:36:26 +1000
Message-ID: <20070926063646.359822883@rustcorp.com.au>
References: <20070926063618.956228976@rustcorp.com.au>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline; filename=lg-kconfig-32bit-only-fix.patch
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

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

---
 drivers/lguest/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

===================================================================
--- a/drivers/lguest/Kconfig
+++ b/drivers/lguest/Kconfig
@@ -1,6 +1,6 @@ config LGUEST
 config LGUEST
 	tristate "Linux hypervisor example code"
-	depends on X86 && EXPERIMENTAL && !X86_PAE && FUTEX && !(X86_VISWS || X86_VOYAGER)
+	depends on X86_32 && EXPERIMENTAL && !X86_PAE && FUTEX && !(X86_VISWS || X86_VOYAGER)
 	select HVC_DRIVER
 	---help---
 	  This is a very simple module which allows you to run

--
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy
