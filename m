From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH] Enable lguest drivers in Kconfig
Date: Mon, 06 Aug 2007 10:48:18 +1000
Message-ID: <1186361298.32112.32.camel__26842.9942116656$1186361438$gmane$org@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
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
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: lguest <lguest@ozlabs.org>, Andrew Morton <akpm@linux-foundation.org>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Lguest drivers need to default to "Y" otherwise they're never selected
for new builds.  (We don't bother prompting, because they're less than
4k combined, and implied by selecting lguest support).

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 drivers/lguest/Kconfig |    2 ++
 1 file changed, 2 insertions(+)

===================================================================
--- a/drivers/lguest/Kconfig
+++ b/drivers/lguest/Kconfig
@@ -21,8 +21,10 @@ config LGUEST_GUEST
 
 config LGUEST_NET
 	tristate
+	default y
 	depends on LGUEST_GUEST && NET
 
 config LGUEST_BLOCK
 	tristate
+	default y
 	depends on LGUEST_GUEST && BLOCK
