From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH 2/7] Added generic lg.h in lguest directory.
Date: Wed, 08 Aug 2007 20:32:13 -0400
Message-ID: <20070809003343.310187242__20140.2218117893$1186619804$gmane$org@goodmis.org>
References: <20070809003211.373543702@goodmis.org>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline;
	filename=0002-Added-generic-lg.h-in-lguest-directory.txt
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

Add a generic lg.h file to call the architecture specific one.

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 drivers/lguest/lg.h |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/lguest/lg.h b/drivers/lguest/lg.h
new file mode 100644
index 0000000..4c4356e
--- /dev/null
+++ b/drivers/lguest/lg.h
@@ -0,0 +1,3 @@
+#ifdef CONFIG_X86_32
+#include "i386/lg.h"
+#endif
-- 
1.4.4.4

-- 
