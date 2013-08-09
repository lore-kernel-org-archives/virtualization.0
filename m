From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Subject: [PATCH V13 13/14] kvm guest : Add configuration support to enable
	debug information for KVM Guests
Date: Fri,  9 Aug 2013 19:52:01 +0530
Message-ID: <1376058122-8248-14-git-send-email-raghavendra.kt__18218.0892945782$1376058052$gmane$org@linux.vnet.ibm.com>
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
Cc: kvm@vger.kernel.org, linux-doc@vger.kernel.org, peterz@infradead.org, drjones@redhat.com, Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>, andi@firstfloor.org, xen-devel@lists.xensource.com, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, Suzuki Poulose <suzuki@in.ibm.com>, habanero@linux.vnet.ibm.com, riel@redhat.com, stefano.stabellini@eu.citrix.com, ouyang@cs.pitt.edu, avi.kivity@gmail.com, tglx@linutronix.de, virtualization@lists.linux-foundation.org, chegu_vinod@hp.com, gregkh@suse.de, linux-kernel@vger.kernel.org, srivatsa.vaddagiri@gmail.com, attilio.rao@citrix.com, torvalds@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

From: Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>

Signed-off-by: Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>
Signed-off-by: Suzuki Poulose <suzuki@in.ibm.com>
Signed-off-by: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Acked-by: Gleb Natapov <gleb@redhat.com>
Acked-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/Kconfig | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 724ce55..f108f00 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -688,6 +688,15 @@ config KVM_GUEST
 	  underlying device model, the host provides the guest with
 	  timing infrastructure such as time of day, and system time
 
+config KVM_DEBUG_FS
+	bool "Enable debug information for KVM Guests in debugfs"
+	depends on KVM_GUEST && DEBUG_FS
+	default n
+	---help---
+	  This option enables collection of various statistics for KVM guest.
+	  Statistics are displayed in debugfs filesystem. Enabling this option
+	  may incur significant overhead.
+
 source "arch/x86/lguest/Kconfig"
 
 config PARAVIRT_TIME_ACCOUNTING
-- 
1.7.11.7
