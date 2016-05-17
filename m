From: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
Subject: [PATCH v2 6/6] powerpc: pseries: pv-qspinlock build config/make
Date: Tue, 17 May 2016 15:49:47 +0800
Message-ID: <1463471387-5115-7-git-send-email-xinhui.pan__28209.8087868237$1463506614$gmane$org@linux.vnet.ibm.com>
References: <1463471387-5115-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1463471387-5115-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org
Cc: mnipxh@163.com, Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>, peterz@infradead.org, benh@kernel.crashing.org, boqun.feng@gmail.com, waiman.long@hpe.com, mingo@redhat.com, paulus@samba.org, mpe@ellerman.id.au, paulmck@linux.vnet.ibm.com
List-Id: virtualization@lists.linuxfoundation.org

pseries can use pv-qspinlock.

Signed-off-by: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/Makefile           | 1 +
 arch/powerpc/platforms/pseries/Kconfig | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 2da380f..ae7c2f1 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -50,6 +50,7 @@ obj-$(CONFIG_PPC_970_NAP)	+= idle_power4.o
 obj-$(CONFIG_PPC_P7_NAP)	+= idle_power7.o
 procfs-y			:= proc_powerpc.o
 obj-$(CONFIG_PROC_FS)		+= $(procfs-y)
+obj-$(CONFIG_PARAVIRT_SPINLOCKS)	+= paravirt.o
 rtaspci-$(CONFIG_PPC64)-$(CONFIG_PCI)	:= rtas_pci.o
 obj-$(CONFIG_PPC_RTAS)		+= rtas.o rtas-rtc.o $(rtaspci-y-y)
 obj-$(CONFIG_PPC_RTAS_DAEMON)	+= rtasd.o
diff --git a/arch/powerpc/platforms/pseries/Kconfig b/arch/powerpc/platforms/pseries/Kconfig
index f669323..46632e4 100644
--- a/arch/powerpc/platforms/pseries/Kconfig
+++ b/arch/powerpc/platforms/pseries/Kconfig
@@ -128,3 +128,11 @@ config HV_PERF_CTRS
 	  systems. 24x7 is available on Power 8 systems.
 
           If unsure, select Y.
+
+config PARAVIRT_SPINLOCKS
+	bool "Paravirtialization support for qspinlock"
+	depends on PPC_SPLPAR && QUEUED_SPINLOCKS
+	default y
+	help
+	  If platform supports virtualization, for example PowerVM, this option
+	  can let guest have a better performace.
-- 
1.9.1
