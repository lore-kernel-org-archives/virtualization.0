From: Juergen Gross <jgross@suse.com>
Subject: [PATCH] x86/paravirt: remove unused operation
Date: Thu,  6 Aug 2015 13:55:27 +0200
Message-ID: <1438862127-19674-1-git-send-email-jgross__46490.6112327755$1438862160$gmane$org@suse.com>
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
To: linux-kernel@vger.kernel.org, jeremy@goop.org, chrisw@sous-sol.org, akataria@vmware.com, rusty@rustcorp.com.au, virtualization@lists.linux-foundation.org
Cc: Juergen Gross <jgross@suse.com>
List-Id: virtualization@lists.linuxfoundation.org

Remove the paravirt operation "get_tsc_khz" as it is used nowhere.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/include/asm/paravirt_types.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index a6b8f9f..5a18a66 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -97,7 +97,6 @@ struct pv_lazy_ops {
 struct pv_time_ops {
 	unsigned long long (*sched_clock)(void);
 	unsigned long long (*steal_clock)(int cpu);
-	unsigned long (*get_tsc_khz)(void);
 };
 
 struct pv_cpu_ops {
-- 
2.1.4
