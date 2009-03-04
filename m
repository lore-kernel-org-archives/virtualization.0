From: Isaku Yamahata <yamahata@valinux.co.jp>
Subject: [PATCH 06/15] ia64/pv_ops/pvchecker: support mov = ar.itc
	paravirtualization
Date: Wed,  4 Mar 2009 21:05:37 +0900
Message-ID: <1236168346-29788-7-git-send-email-yamahata__12686.040721792$1236168662$gmane$org@valinux.co.jp>
References: <1236168346-29788-1-git-send-email-yamahata@valinux.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1236168346-29788-1-git-send-email-yamahata@valinux.co.jp>
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
Cc: yamahata@valinux.co.jp, xen-ia64-devel@lists.xensource.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

add suport for mov = ar.itc to pvchecker.

Signed-off-by: Isaku Yamahata <yamahata@valinux.co.jp>
---
 arch/ia64/include/asm/native/pvchk_inst.h |    5 +++++
 arch/ia64/scripts/pvcheck.sed             |    1 +
 2 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/ia64/include/asm/native/pvchk_inst.h b/arch/ia64/include/asm/native/pvchk_inst.h
index b8e6eb1..13b289e 100644
--- a/arch/ia64/include/asm/native/pvchk_inst.h
+++ b/arch/ia64/include/asm/native/pvchk_inst.h
@@ -180,6 +180,11 @@
 	IS_PRED_IN(pred)			\
 	IS_RREG_OUT(reg)			\
 	IS_RREG_CLOB(clob)
+#define MOV_FROM_ITC(pred, pred_clob, reg, clob)	\
+	IS_PRED_IN(pred)				\
+	IS_PRED_CLOB(pred_clob)				\
+	IS_RREG_OUT(reg)				\
+	IS_RREG_CLOB(clob)
 #define MOV_TO_IFA(reg, clob)			\
 	IS_RREG_IN(reg)				\
 	IS_RREG_CLOB(clob)
diff --git a/arch/ia64/scripts/pvcheck.sed b/arch/ia64/scripts/pvcheck.sed
index ba66ac2..e59809a 100644
--- a/arch/ia64/scripts/pvcheck.sed
+++ b/arch/ia64/scripts/pvcheck.sed
@@ -17,6 +17,7 @@ s/mov.*=.*cr\.iip/.warning \"cr.iip should not used directly\"/g
 s/mov.*=.*cr\.ivr/.warning \"cr.ivr should not used directly\"/g
 s/mov.*=[^\.]*psr/.warning \"psr should not used directly\"/g	# avoid ar.fpsr
 s/mov.*=.*ar\.eflags/.warning \"ar.eflags should not used directly\"/g
+s/mov.*=.*ar\.itc.*/.warning \"ar.itc should not used directly\"/g
 s/mov.*cr\.ifa.*=.*/.warning \"cr.ifa should not used directly\"/g
 s/mov.*cr\.itir.*=.*/.warning \"cr.itir should not used directly\"/g
 s/mov.*cr\.iha.*=.*/.warning \"cr.iha should not used directly\"/g
-- 
1.6.0.2
