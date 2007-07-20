From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 2/3] lguest: trivial: We now have asm/processor-flags.h, so
	use it.
Date: Fri, 20 Jul 2007 22:12:56 +1000
Message-ID: <1184933576.10380.299.camel__4702.0468548455$1184933749$gmane$org@localhost.localdomain>
References: <1184933473.10380.296.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1184933473.10380.296.camel@localhost.localdomain>
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
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

diff -r f41cd1b8d7ef drivers/lguest/lguest_asm.S
--- a/drivers/lguest/lguest_asm.S	Fri Jul 20 13:46:40 2007 +1000
+++ b/drivers/lguest/lguest_asm.S	Fri Jul 20 14:17:04 2007 +1000
@@ -2,9 +2,7 @@
 #include <linux/lguest.h>
 #include <asm/asm-offsets.h>
 #include <asm/thread_info.h>
-
-/* FIXME: Once asm/processor-flags.h goes in, include that */
-#define X86_EFLAGS_IF 0x00000200
+#include <asm/processor-flags.h>
 
 /*
  * This is where we begin: we have a magic signature which the launcher looks
