From: Isaku Yamahata <yamahata@valinux.co.jp>
Subject: [PATCH 22/50] ia64/pv_ops: paravirtualize minstate.h.
Date: Thu,  6 Mar 2008 03:18:37 +0900
Message-ID: <12047411463391-git-send-email-yamahata__47297.3531614572$1204745951$gmane$org@valinux.co.jp>
References: <12047411453864-git-send-email-yamahata@valinux.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <12047411453864-git-send-email-yamahata@valinux.co.jp>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-ia64@vger.kernel.org
Cc: yamahata@valinux.co.jp, virtualization@lists.linux-foundation.org, kvm-ia64-devel@lists.sourceforge.net, xen-ia64-devel@lists.xensource.com
List-Id: virtualization@lists.linuxfoundation.org

This isn't necessary because xen defines its own DO_SAVE_MIN.
But this makes the difference of them smaller.

Signed-off-by: Isaku Yamahata <yamahata@valinux.co.jp>
---
 arch/ia64/kernel/minstate.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/ia64/kernel/minstate.h b/arch/ia64/kernel/minstate.h
index fc99141..10a412c 100644
--- a/arch/ia64/kernel/minstate.h
+++ b/arch/ia64/kernel/minstate.h
@@ -34,9 +34,9 @@
 	mov r27=ar.rsc;			/* M */							\
 	mov r20=r1;			/* A */							\
 	mov r25=ar.unat;		/* M */							\
-	mov r29=cr.ipsr;		/* M */							\
+	MOV_FROM_IPSR(r29);		/* M */							\
 	mov r26=ar.pfs;			/* I */							\
-	mov r28=cr.iip;			/* M */							\
+	MOV_FROM_IIP(r28);		/* M */							\
 	mov r21=ar.fpsr;		/* M */							\
 	__COVER;			/* B;; (or nothing) */					\
 	;;											\
-- 
1.5.3
