From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Subject: [PATCH RFC V8 12/17]  xen: Enable PV ticketlocks on HVM Xen
Date: Wed, 02 May 2012 15:38:40 +0530
Message-ID: <20120502100840.13206.44392.sendpatchset@codeblue.in.ibm.com>
References: <20120502100610.13206.40.sendpatchset@codeblue.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120502100610.13206.40.sendpatchset@codeblue.in.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jeremy Fitzhardinge <jeremy@goop.org>, Greg Kroah-Hartman <gregkh@suse.de>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "H. Peter Anvin" <hpa@zytor.com>, Marcelo Tosatti <mtosatti@redhat.com>, X86 <x86@kernel.org>, Gleb Natapov <gleb@redhat.com>, Ingo Molnar <mingo@redhat.com>, Avi Kivity <avi@redhat.com>
Cc: Xen Devel <xen-devel@lists.xensource.com>, KVM <kvm@vger.kernel.org>, linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>, Virtualization <virtualization@lists.linux-foundation.org>, Andi Kleen <andi@firstfloor.org>, Stephan Diestelhorst <stephan.diestelhorst@amd.com>, Attilio Rao <attilio.rao@citrix.com>, Linus Torvalds <torvalds@linux-foundation.org>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>
List-Id: virtualization@lists.linuxfoundation.org

From: Stefano Stabellini <stefano.stabellini@eu.citrix.com>

Signed-off-by: Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
---
 arch/x86/xen/smp.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)
diff --git a/arch/x86/xen/smp.c b/arch/x86/xen/smp.c
index 7dc400a..6a7a3da 100644
--- a/arch/x86/xen/smp.c
+++ b/arch/x86/xen/smp.c
@@ -589,4 +589,5 @@ void __init xen_hvm_smp_init(void)
 	smp_ops.cpu_die = xen_hvm_cpu_die;
 	smp_ops.send_call_func_ipi = xen_smp_send_call_function_ipi;
 	smp_ops.send_call_func_single_ipi = xen_smp_send_call_function_single_ipi;
+	xen_init_spinlocks();
 }
