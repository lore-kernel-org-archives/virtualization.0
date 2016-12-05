From: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
Subject: [PATCH v8 5/6] powerpc: pSeries: Add pv-qspinlock build config/make
Date: Mon,  5 Dec 2016 10:19:25 -0500
Message-ID: <1480951166-44830-6-git-send-email-xinhui.pan@linux.vnet.ibm.com>
References: <1480951166-44830-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1480951166-44830-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org
Cc: xinhui.pan@linux.vnet.ibm.com, peterz@infradead.org, benh@kernel.crashing.org, boqun.feng@gmail.com, waiman.long@hpe.com, virtualization@lists.linux-foundation.org, mingo@redhat.com, paulus@samba.org, mpe@ellerman.id.au, paulmck@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: virtualization@lists.linuxfoundation.org

pSeries run as a guest and might need pv-qspinlock.

Signed-off-by: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/Makefile           | 1 +
 arch/powerpc/platforms/pseries/Kconfig | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 1925341..4780415 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -53,6 +53,7 @@ obj-$(CONFIG_PPC_970_NAP)	+= idle_power4.o
 obj-$(CONFIG_PPC_P7_NAP)	+= idle_book3s.o
 procfs-y			:= proc_powerpc.o
 obj-$(CONFIG_PROC_FS)		+= $(procfs-y)
+obj-$(CONFIG_PARAVIRT_SPINLOCKS)	+= paravirt.o
 rtaspci-$(CONFIG_PPC64)-$(CONFIG_PCI)	:= rtas_pci.o
 obj-$(CONFIG_PPC_RTAS)		+= rtas.o rtas-rtc.o $(rtaspci-y-y)
 obj-$(CONFIG_PPC_RTAS_DAEMON)	+= rtasd.o
diff --git a/arch/powerpc/platforms/pseries/Kconfig b/arch/powerpc/platforms/pseries/Kconfig
index 8a87d06..0288c78 100644
--- a/arch/powerpc/platforms/pseries/Kconfig
+++ b/arch/powerpc/platforms/pseries/Kconfig
@@ -31,6 +31,14 @@ config ARCH_USE_QUEUED_SPINLOCKS
 	  fairlock.  It has shown a good performance improvement on x86 and also ppc
 	  especially in high contention cases.
 
+config PARAVIRT_SPINLOCKS
+       bool "Paravirtialization support for qspinlock"
+       depends on PPC_SPLPAR && QUEUED_SPINLOCKS
+       default y
+       help
+         If kernel need run as a guest then enable this option.
+         Generally it can let kernel have a better performace.
+
 config PPC_SPLPAR
 	depends on PPC_PSERIES
 	bool "Support for shared-processor logical partitions"
-- 
2.4.11
