From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Subject: [PATCH RFC V4 3/5] kvm guest : Added configuration support to enable
	debug information for KVM Guests
Date: Sat, 14 Jan 2012 23:56:20 +0530
Message-ID: <20120114182619.8604.383.sendpatchset@oc5400248562.ibm.com>
References: <20120114182501.8604.68416.sendpatchset@oc5400248562.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120114182501.8604.68416.sendpatchset@oc5400248562.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jeremy Fitzhardinge <jeremy@goop.org>, Randy Dunlap <rdunlap@xenotime.net>, linux-doc@vger.kernel.org, KVM <kvm@vger.kernel.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Glauber Costa <glommer@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>, Rik van Riel <riel@redhat.com>, Dave Jiang <dave.jiang@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Rob Landley <rlandley@parallels.com>, X86 <x86@kernel.org>, Gleb Natapov <gleb@redhat.com>, Avi Kivity <avi@redhat.com>, Alexander Graf <agraf@suse.de>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Paul Mackerras <paulus@samba.org>, Sedat Dilek <sedat.dilek@gmail.com>, Ingo Molnar <mingo@redhat.com>, LKML <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@suse.de>, Virtualization <virtualization@lists.linux-foundation.org>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>, Dave Hansen <dave@linux.vnet.ibm.com>, Suzuki Poulose <suzuki@linux.vnet.ibm.com>, Sasha Levin <levinsasha928@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

Added configuration support to enable debug information
for KVM Guests in debugfs
    
Signed-off-by: Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>
Signed-off-by: Suzuki Poulose <suzuki@in.ibm.com>
Signed-off-by: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
---
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 72e8b64..344a7db 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -565,6 +565,15 @@ config KVM_GUEST
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
