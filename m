From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 2/2] lguest: handle new paravirt lazy mode (fix userspace
	segfaults)
Date: Sun, 29 Apr 2007 23:36:58 +1000
Message-ID: <1177853818.30071.182.camel@localhost.localdomain>
References: <1177853697.30071.179.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1177853697.30071.179.camel@localhost.localdomain>
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
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

There's a new paravirt_lazy_mode mode in town.

Well, it's spelled "mode", but it's pronounced "hack".

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 drivers/lguest/lguest.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

===================================================================
--- a/drivers/lguest/lguest.c
+++ b/drivers/lguest/lguest.c
@@ -59,9 +59,13 @@ static enum paravirt_lazy_mode lazy_mode
 static enum paravirt_lazy_mode lazy_mode;
 static void lguest_lazy_mode(enum paravirt_lazy_mode mode)
 {
-	lazy_mode = mode;
-	if (mode == PARAVIRT_LAZY_NONE)
+	if (mode == PARAVIRT_LAZY_FLUSH)
 		hcall(LHCALL_FLUSH_ASYNC, 0, 0, 0);
+	else {
+		lazy_mode = mode;
+		if (mode == PARAVIRT_LAZY_NONE)
+			hcall(LHCALL_FLUSH_ASYNC, 0, 0, 0);
+	}
 }
 
 static void lazy_hcall(unsigned long call,
