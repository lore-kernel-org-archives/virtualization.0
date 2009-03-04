From: Isaku Yamahata <yamahata@valinux.co.jp>
Subject: [PATCH 01/15] ia64/pv_ops/xen: use __initconst instead of __initdata
	for const data
Date: Wed,  4 Mar 2009 21:05:32 +0900
Message-ID: <1236168346-29788-2-git-send-email-yamahata__40300.5327134908$1236170439$gmane$org@valinux.co.jp>
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

use __initconst instead of __initdata for const data like
ec8148de85a73a3be397a59b6d8f4f32cf2dd254

Signed-off-by: Isaku Yamahata <yamahata@valinux.co.jp>
---
 arch/ia64/xen/xen_pv_ops.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/ia64/xen/xen_pv_ops.c b/arch/ia64/xen/xen_pv_ops.c
index 936cff3..fa3b967 100644
--- a/arch/ia64/xen/xen_pv_ops.c
+++ b/arch/ia64/xen/xen_pv_ops.c
@@ -260,7 +260,7 @@ xen_intrin_local_irq_restore(unsigned long mask)
 		xen_rsm_i();
 }
 
-static const struct pv_cpu_ops xen_cpu_ops __initdata = {
+static const struct pv_cpu_ops xen_cpu_ops __initconst = {
 	.fc		= xen_fc,
 	.thash		= xen_thash,
 	.get_cpuid	= xen_get_cpuid,
-- 
1.6.0.2
