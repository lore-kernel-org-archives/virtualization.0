From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 3/3] Time to make CONFIG_PARAVIRT non-experimental.
Date: Fri, 14 Sep 2007 15:21:20 +1000
Message-ID: <1189747280.7262.39.camel__29345.758239697$1189747417$gmane$org@localhost.localdomain>
References: <1189747054.7262.34.camel@localhost.localdomain>
	<1189747124.7262.36.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1189747124.7262.36.camel@localhost.localdomain>
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

It's pretty widely used, and the distributions will turn it on.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au> 

diff -r b546335d7e75 arch/i386/Kconfig
--- a/arch/i386/Kconfig	Fri Sep 14 13:24:49 2007 +1000
+++ b/arch/i386/Kconfig	Fri Sep 14 13:27:13 2007 +1000
@@ -215,8 +215,8 @@ endchoice
 endchoice
 
 menuconfig PARAVIRT
-	bool "Paravirtualized guest support (EXPERIMENTAL)"
-	depends on EXPERIMENTAL
+	bool "Paravirtualized guest support"
+	default y
 	depends on !(X86_VISWS || X86_VOYAGER)
 	help
 	  Paravirtualization is a way of running multiple instances of
@@ -224,7 +224,7 @@ menuconfig PARAVIRT
 	  changes the kernel so it can modify itself when it is run
 	  under a hypervisor, improving performance significantly.
 	  However, when run without a hypervisor the kernel is
-	  theoretically slower.  If in doubt, say N.
+	  theoretically slower.  If in doubt, say Y.
 
 if PARAVIRT
