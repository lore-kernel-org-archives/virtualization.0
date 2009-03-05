From: Hannes Eder <hannes@hanneseder.net>
Subject: [PATCH v2 03/15] NULL noise: arch/x86/xen/smp.c
Date: Thu, 05 Mar 2009 20:13:57 +0100
Message-ID: <20090305191350.30062.68789.stgit@f10box.hanneseder.net>
References: <20090305190954.30062.44759.stgit@f10box.hanneseder.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756000AbZCETO3@vger.kernel.org>
In-Reply-To: <20090305190954.30062.44759.stgit@f10box.hanneseder.net>
Sender: linux-kernel-owner@vger.kernel.org
To: trivial@kernel.org
Cc: Jeremy Fitzhardinge <jeremy@xensource.com>, Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, xen-devel@lists.xensource.com, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Fix this sparse warnings:
  arch/x86/xen/smp.c:316:52: warning: Using plain integer as NULL pointer
  arch/x86/xen/smp.c:421:60: warning: Using plain integer as NULL pointer

Signed-off-by: Hannes Eder <hannes@hanneseder.net>
---
v2: other subject, as suggested by Al Viro

 arch/x86/xen/smp.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/xen/smp.c b/arch/x86/xen/smp.c
index 035582a..7a1f00f 100644
--- a/arch/x86/xen/smp.c
+++ b/arch/x86/xen/smp.c
@@ -313,7 +313,7 @@ static int __cpuinit xen_cpu_up(unsigned int cpu)
 	BUG_ON(rc);
 
 	while(per_cpu(cpu_state, cpu) != CPU_ONLINE) {
-		HYPERVISOR_sched_op(SCHEDOP_yield, 0);
+		HYPERVISOR_sched_op(SCHEDOP_yield, NULL);
 		barrier();
 	}
 
@@ -418,7 +418,7 @@ static void xen_smp_send_call_function_ipi(const struct cpumask *mask)
 	/* Make sure other vcpus get a chance to run if they need to. */
 	for_each_cpu(cpu, mask) {
 		if (xen_vcpu_stolen(cpu)) {
-			HYPERVISOR_sched_op(SCHEDOP_yield, 0);
+			HYPERVISOR_sched_op(SCHEDOP_yield, NULL);
 			break;
 		}
 	}
