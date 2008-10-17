From: Isaku Yamahata <yamahata@valinux.co.jp>
Subject: [PATCH 03/33] ia64/pv_ops: update native/inst.h to clobber predicate.
Date: Fri, 17 Oct 2008 11:17:43 +0900
Message-ID: <1224209893-2032-4-git-send-email-yamahata__13212.9322774292$1224210268$gmane$org@valinux.co.jp>
References: <1224209893-2032-1-git-send-email-yamahata@valinux.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1224209893-2032-1-git-send-email-yamahata@valinux.co.jp>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: tony.luck@intel.com, linux-ia64@vger.kernel.org
Cc: yamahata@valinux.co.jp, xen-ia64-devel@lists.xensource.com, mingo@elte.hu, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

add CLOBBER_PRED() to clobber predicate register.

Signed-off-by: Isaku Yamahata <yamahata@valinux.co.jp>
---
 arch/ia64/include/asm/native/inst.h |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/ia64/include/asm/native/inst.h b/arch/ia64/include/asm/native/inst.h
index c8efbf7..0a1026c 100644
--- a/arch/ia64/include/asm/native/inst.h
+++ b/arch/ia64/include/asm/native/inst.h
@@ -36,8 +36,13 @@
 	;;					\
 	movl clob = PARAVIRT_POISON;		\
 	;;
+# define CLOBBER_PRED(pred_clob)		\
+	;;					\
+	cmp.eq pred_clob, p0 = r0, r0		\
+	;;
 #else
-# define CLOBBER(clob)		/* nothing */
+# define CLOBBER(clob)			/* nothing */
+# define CLOBBER_PRED(pred_clob)	/* nothing */
 #endif
 
 #define MOV_FROM_IFA(reg)	\
@@ -136,7 +141,8 @@
 
 #define SSM_PSR_I(pred, pred_clob, clob)	\
 (pred)	ssm psr.i				\
-	CLOBBER(clob)
+	CLOBBER(clob)				\
+	CLOBBER_PRED(pred_clob)
 
 #define RSM_PSR_I(pred, clob0, clob1)	\
 (pred)	rsm psr.i			\
-- 
1.6.0.2
