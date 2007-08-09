From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH 3/5 -v2] Remove __pa() use in hvc_lguest
Date: Thu, 09 Aug 2007 00:36:29 -0400
Message-ID: <20070809044125.276249230__22415.7003839084$1186634958$gmane$org@goodmis.org>
References: <20070809043626.830486783@goodmis.org>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline; filename=0003-Remove-__pa-use-in-hvc_lguest.txt
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Carsten Otte <cotte@de.ibm.com>, lguest <lguest@ozlabs.org>, Jes Sorensen <jes@sgi.com>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

The hvc_lguest uses __pa in the const initialization.
In some architectures, __pa() is not constant so this fails in compiles.

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 drivers/char/hvc_lguest.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/drivers/char/hvc_lguest.c b/drivers/char/hvc_lguest.c
index feeccba..c7d7d4c 100644
--- a/drivers/char/hvc_lguest.c
+++ b/drivers/char/hvc_lguest.c
@@ -42,7 +42,6 @@
  * use of physical address for the buffer itself. */
 static char inbuf[256];
 static struct lguest_dma cons_input = { .used_len = 0,
-					.addr[0] = __pa(inbuf),
 					.len[0] = sizeof(inbuf),
 					.len[1] = 0 };
 
@@ -114,6 +113,13 @@ static struct hv_ops lguest_cons = {
  * (0), and the struct hv_ops containing the put_chars() function. */
 static int __init cons_init(void)
 {
+	/*
+	 * We can't initialize using __pa in const declarations,
+	 * since __pa(inbuf) does not evaluate into a constant on
+	 * all architectures (namely x86_64).
+	 */
+	cons_input.addr[0] = __pa(inbuf);
+
 	if (strcmp(paravirt_ops.name, "lguest") != 0)
 		return 0;
 
-- 
1.4.4.4

-- 
