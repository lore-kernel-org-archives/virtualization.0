From: yamahata@valinux.co.jp
Subject: [PATCH 22/28] ia64/xen: mca paravirtualization
Date: Thu, 21 Feb 2008 18:17:53 +0900
Message-ID: <20080221091905.408446000__38428.7829198458$1203636954$gmane$org@ls.local.valinux.co.jp>
References: <20080221091731.641745000@ls.local.valinux.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Resent-Message-ID: <20080221223141.GW17530%yamahata@valinux.co.jp>
Resent-To: linux-ia64@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        kvm-ia64-devel@lists.sourceforge.net
Content-Disposition: inline;
	filename=0022-ia64-xen-mca-paravirtualization.patch
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
Cc: xen-ia64-devel@lists.xensource.com, kvm-ia64-devel@lists.sourceforge.net, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org


Signed-off-by: Isaku Yamahata <yamahata@valinux.co.jp>
---
 arch/ia64/kernel/mca.c |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/arch/ia64/kernel/mca.c b/arch/ia64/kernel/mca.c
index 6e17aed..94f1023 100644
--- a/arch/ia64/kernel/mca.c
+++ b/arch/ia64/kernel/mca.c
@@ -339,11 +339,33 @@ typedef struct ia64_state_log_s
 
 static ia64_state_log_t ia64_state_log[IA64_MAX_LOG_TYPES];
 
+#ifdef CONFIG_XEN
+DEFINE_SPINLOCK(ia64_mca_xencomm_lock);
+LIST_HEAD(ia64_mca_xencomm_list);
+
+#define IA64_MCA_XENCOMM_ALLOCATE(rec, desc) \
+	if (is_running_on_xen()) { \
+		ia64_mca_xencomm_t *entry; \
+		entry = alloc_bootmem(sizeof(ia64_mca_xencomm_t)); \
+		entry->record = rec; \
+		entry->handle = desc; \
+		list_add(&entry->list, &ia64_mca_xencomm_list); \
+	}
+#define IA64_LOG_ALLOCATE(it, size) \
+	{ia64_err_rec_t *rec; \
+	ia64_state_log[it].isl_log[IA64_LOG_CURR_INDEX(it)] = rec = \
+		(ia64_err_rec_t *)alloc_bootmem(size); \
+	IA64_MCA_XENCOMM_ALLOCATE(rec, xencomm_map(rec, size)); \
+	ia64_state_log[it].isl_log[IA64_LOG_NEXT_INDEX(it)] = rec = \
+		(ia64_err_rec_t *)alloc_bootmem(size); \
+	IA64_MCA_XENCOMM_ALLOCATE(rec, xencomm_map(rec, size));}
+#else
 #define IA64_LOG_ALLOCATE(it, size) \
 	{ia64_state_log[it].isl_log[IA64_LOG_CURR_INDEX(it)] = \
 		(ia64_err_rec_t *)alloc_bootmem(size); \
 	ia64_state_log[it].isl_log[IA64_LOG_NEXT_INDEX(it)] = \
 		(ia64_err_rec_t *)alloc_bootmem(size);}
+#endif
 #define IA64_LOG_LOCK_INIT(it) spin_lock_init(&ia64_state_log[it].isl_lock)
 #define IA64_LOG_LOCK(it)      spin_lock_irqsave(&ia64_state_log[it].isl_lock, s)
 #define IA64_LOG_UNLOCK(it)    spin_unlock_irqrestore(&ia64_state_log[it].isl_lock,s)
-- 
1.5.3

-- 
yamahata
