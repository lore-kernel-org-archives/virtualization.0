From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Subject: [PATCH RFC V3 3/4] kvm guest : Added configuration support to enable
	debug information for KVM Guests
Date: Wed, 30 Nov 2011 14:30:19 +0530
Message-ID: <20111130090019.23386.95844.sendpatchset__34091.2085412585$1322669480$gmane$org@oc5400248562.ibm.com>
References: <20111130085921.23386.89708.sendpatchset@oc5400248562.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20111130085921.23386.89708.sendpatchset@oc5400248562.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Greg Kroah-Hartman <gregkh@suse.de>, "H. Peter Anvin" <hpa@zytor.com>, Gleb Natapov <gleb@redhat.com>, Virtualization <virtualization@lists.linux-foundation.org>, Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>, x86@kernel.org, KVM <kvm@vger.kernel.org>, Dave Jiang <dave.jiang@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Xen <xen-devel@lists.xensource.com>, Sedat Dilek <sedat.dilek@gmail.com>, Yinghai Lu <yinghai@kernel.org>, Marcelo Tosatti <mtosatti@redhat.com>, Ingo Molnar <mingo@redhat.com>, Avi Kivity <avi@redhat.com>, Rik van Riel <riel@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>, Dave Hansen <dave@linux.vnet.ibm.com>, Suzuki Poulose <suzuki@linux.vnet.ibm.com>, Sasha Levin <levinsasha928@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

Added configuration support to enable debug information
for KVM Guests in debugfs
    
Signed-off-by: Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>
Signed-off-by: Suzuki Poulose <suzuki@in.ibm.com>
Signed-off-by: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
---
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 5d8152d..526e3ae 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -561,6 +561,15 @@ config KVM_GUEST
 	  This option enables various optimizations for running under the KVM
 	  hypervisor.
 
+config KVM_DEBUG_FS
+	bool "Enable debug information for KVM Guests in debugfs"
+	depends on KVM_GUEST && DEBUG_FS
+	default n
+	---help---
+	  This option enables collection of various statistics for KVM guest.
+   	  Statistics are displayed in debugfs filesystem. Enabling this option
+	  may incur significant overhead.
+
 source "arch/x86/lguest/Kconfig"
 
 config PARAVIRT
