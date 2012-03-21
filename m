From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Subject: [PATCH RFC V6 11/11]  xen: enable PV ticketlocks on HVM Xen
Date: Wed, 21 Mar 2012 15:52:44 +0530
Message-ID: <20120321102244.473.80310.sendpatchset@codeblue.in.ibm.com>
References: <20120321102041.473.61069.sendpatchset@codeblue.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120321102041.473.61069.sendpatchset@codeblue.in.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>
Cc: the arch/x86 maintainers <x86@kernel.org>, KVM <kvm@vger.kernel.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Peter Zijlstra <peterz@infradead.org>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, LKML <linux-kernel@vger.kernel.org>, Virtualization <virtualization@lists.linux-foundation.org>, Andi Kleen <andi@firstfloor.org>, Avi Kivity <avi@redhat.com>, Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>, Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>, Attilio Rao <attilio.rao@citrix.com>, Linus Torvalds <torvalds@linux-foundation.org>, Xen Devel <xen-devel@lists.xensource.com>, Stephan Diestelhorst <stephan.diestelhorst@amd.com>
List-Id: virtualization@lists.linuxfoundation.org

From: Stefano Stabellini <stefano.stabellini@eu.citrix.com>

Signed-off-by: Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
---
 arch/x86/xen/smp.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)
diff --git a/arch/x86/xen/smp.c b/arch/x86/xen/smp.c
index e85d3ee..8dc2574 100644
--- a/arch/x86/xen/smp.c
+++ b/arch/x86/xen/smp.c
@@ -568,4 +568,5 @@ void __init xen_hvm_smp_init(void)
 	smp_ops.cpu_die = xen_hvm_cpu_die;
 	smp_ops.send_call_func_ipi = xen_smp_send_call_function_ipi;
 	smp_ops.send_call_func_single_ipi = xen_smp_send_call_function_single_ipi;
+	xen_init_spinlocks();
 }
