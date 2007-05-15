From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 2/6] lguest: kbuild tidyups
Date: Tue, 15 May 2007 11:18:08 +1000
Message-ID: <1179191888.10836.26.camel__42129.2773368352$1179191997$gmane$org@localhost.localdomain>
References: <1179191827.10836.24.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1179191827.10836.24.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Sam Ravnborg <sam@ravnborg.org>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Sam Ravnborg says lg-objs is deprecated, use lg-y.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 drivers/lguest/Makefile |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

===================================================================
--- a/drivers/lguest/Makefile
+++ b/drivers/lguest/Makefile
@@ -3,5 +3,5 @@ obj-$(CONFIG_LGUEST_GUEST) += lguest.o l
 
 # Host requires the other files, which can be a module.
 obj-$(CONFIG_LGUEST)	+= lg.o
-lg-objs := core.o hypercalls.o page_tables.o interrupts_and_traps.o \
+lg-y := core.o hypercalls.o page_tables.o interrupts_and_traps.o \
 	segments.o io.o lguest_user.o switcher.o
