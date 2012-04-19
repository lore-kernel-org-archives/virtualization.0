From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Subject: [PATCH RFC V7 2/12] x86/ticketlock: don't inline _spin_unlock when
	using paravirt spinlocks
Date: Fri, 20 Apr 2012 01:42:59 +0530
Message-ID: <20120419201256.5411.59675.sendpatchset@codeblue>
References: <20120419201209.5411.43877.sendpatchset@codeblue>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120419201209.5411.43877.sendpatchset@codeblue>
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
Cc: Andrew Jones <drjones@redhat.com>, Xen Devel <xen-devel@lists.xensource.com>, KVM <kvm@vger.kernel.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Stephan Diestelhorst <stephan.diestelhorst@amd.com>, the arch/x86 maintainers <x86@kernel.org>, Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>, Virtualization <virtualization@lists.linux-foundation.org>, Andi Kleen <andi@firstfloor.org>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>, Attilio Rao <attilio.rao@citrix.com>, Linus Torvalds <torvalds@linux-foundation.org>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Avi Kivity <avi@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com> 

The code size expands somewhat, and its better to just call
a function rather than inline it.

Thanks Jeremy for original version of ARCH_NOINLINE_SPIN_UNLOCK config patch, 
which is simplified.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
---
 arch/x86/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 1d14cc6..35eb2e4 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -597,6 +597,7 @@ config PARAVIRT
 config PARAVIRT_SPINLOCKS
 	bool "Paravirtualization layer for spinlocks"
 	depends on PARAVIRT && SMP && EXPERIMENTAL
+	select UNINLINE_SPIN_UNLOCK
 	---help---
 	  Paravirtualized spinlocks allow a pvops backend to replace the
 	  spinlock implementation with something virtualization-friendly
