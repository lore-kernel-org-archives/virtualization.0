From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Subject: [PATCH V13 04/14] xen: Defer spinlock setup until boot CPU setup
Date: Fri,  9 Aug 2013 19:51:52 +0530
Message-ID: <1376058122-8248-5-git-send-email-raghavendra.kt@linux.vnet.ibm.com>
References: <y>
	<1376058122-8248-1-git-send-email-raghavendra.kt@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1376058122-8248-1-git-send-email-raghavendra.kt@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: mingo@redhat.com, hpa@zytor.com, x86@kernel.org, jeremy@goop.org, konrad.wilk@oracle.com, gleb@redhat.com, pbonzini@redhat.com
Cc: kvm@vger.kernel.org, linux-doc@vger.kernel.org, peterz@infradead.org, drjones@redhat.com, virtualization@lists.linux-foundation.org, andi@firstfloor.org, xen-devel@lists.xensource.com, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, habanero@linux.vnet.ibm.com, riel@redhat.com, stefano.stabellini@eu.citrix.com, ouyang@cs.pitt.edu, avi.kivity@gmail.com, tglx@linutronix.de, chegu_vinod@hp.com, gregkh@suse.de, linux-kernel@vger.kernel.org, srivatsa.vaddagiri@gmail.com, attilio.rao@citrix.com, torvalds@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

From: Jeremy Fitzhardinge <jeremy@goop.org>

There's no need to do it at very early init, and doing it there
makes it impossible to use the jump_label machinery.

Signed-off-by: Jeremy Fitzhardinge <jeremy@goop.org>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Acked-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/xen/smp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/xen/smp.c b/arch/x86/xen/smp.c
index ca92754..3b52d80 100644
--- a/arch/x86/xen/smp.c
+++ b/arch/x86/xen/smp.c
@@ -279,6 +279,7 @@ static void __init xen_smp_prepare_boot_cpu(void)
 
 	xen_filter_cpu_maps();
 	xen_setup_vcpu_info_placement();
+	xen_init_spinlocks();
 }
 
 static void __init xen_smp_prepare_cpus(unsigned int max_cpus)
@@ -680,7 +681,6 @@ void __init xen_smp_init(void)
 {
 	smp_ops = xen_smp_ops;
 	xen_fill_possible_map();
-	xen_init_spinlocks();
 }
 
 static void __init xen_hvm_smp_prepare_cpus(unsigned int max_cpus)
-- 
1.7.11.7
