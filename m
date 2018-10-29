From: Juergen Gross <jgross@suse.com>
Subject: [PATCH] x86/paravirt: pv_ops isn't GPL only
Date: Mon, 29 Oct 2018 16:01:16 +0100
Message-ID: <20181029150116.25372-1-jgross__5170.6888051287$1540825159$gmane$org@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org, x86@kernel.org, virtualization@lists.linux-foundation.org
Cc: Juergen Gross <jgross@suse.com>, boris.ostrovsky@oracle.com, rusty@rustcorp.com.au, mingo@redhat.com, hpa@zytor.com, akataria@vmware.com, tglx@linutronix.de
List-Id: virtualization@lists.linuxfoundation.org

Commit 5c83511bdb9832 ("x86/paravirt: Use a single ops structure")
introduced a regression for out-of-tree modules using spinlocks, as
pv_lock_ops was exported via EXPORT_SYMBOL(), while the new pv_ops
structure now containing the pv lock operations is exported via
EXPORT_SYMBOL_GPL().

Change that by using EXPORT_SYMBOL(pv_ops).

Fixes: 5c83511bdb9832 ("x86/paravirt: Use a single ops structure")
Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/kernel/paravirt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index e4d4df37922a..45123b116c05 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -483,5 +483,5 @@ NOKPROBE_SYMBOL(native_set_debugreg);
 NOKPROBE_SYMBOL(native_load_idt);
 #endif
 
-EXPORT_SYMBOL_GPL(pv_ops);
+EXPORT_SYMBOL(pv_ops);
 EXPORT_SYMBOL_GPL(pv_info);
-- 
2.16.4
