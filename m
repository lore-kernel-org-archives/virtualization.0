From: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
Subject: [PATCH v9 2/6] powerpc: platforms/Kconfig: Add qspinlock build config
Date: Tue,  6 Dec 2016 13:09:23 -0500
Message-ID: <1481047767-60255-3-git-send-email-xinhui.pan@linux.vnet.ibm.com>
References: <1481047767-60255-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1481047767-60255-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: xinhui.pan@linux.vnet.ibm.com, peterz@infradead.org, benh@kernel.crashing.org, boqun.feng@gmail.com, virtualization@lists.linux-foundation.org, mingo@redhat.com, paulus@samba.org, mpe@ellerman.id.au, longman@redhat.com, paulmck@linux.vnet.ibm.com
List-Id: virtualization@lists.linuxfoundation.org

pSeries/powerNV will use qspinlock from now on.

Signed-off-by: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/Kconfig | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/powerpc/platforms/Kconfig b/arch/powerpc/platforms/Kconfig
index fbdae83..3559bbf 100644
--- a/arch/powerpc/platforms/Kconfig
+++ b/arch/powerpc/platforms/Kconfig
@@ -20,6 +20,15 @@ source "arch/powerpc/platforms/44x/Kconfig"
 source "arch/powerpc/platforms/40x/Kconfig"
 source "arch/powerpc/platforms/amigaone/Kconfig"
 
+config ARCH_USE_QUEUED_SPINLOCKS
+        depends on PPC_PSERIES || PPC_POWERNV
+        bool "Enable qspinlock"
+        default y
+        help
+	  Enabling this option will let kernel use qspinlock which is a kind of
+	  fairlock.  It has shown a good performance improvement on x86 and also
+	  ppc especially in high contention cases.
+
 config KVM_GUEST
 	bool "KVM Guest support"
 	default n
-- 
2.4.11
