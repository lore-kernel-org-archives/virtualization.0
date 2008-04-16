From: Glauber Costa <gcosta@redhat.com>
Subject: [PATCH] kvm: move kvmclock initialization inside kvm_guest_init
Date: Wed, 16 Apr 2008 13:59:38 -0300
Message-ID: <12083651781498-git-send-email-gcosta__34977.6152208962$1208367530$gmane$org@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: kvm-devel@lists.sourceforge.net
Cc: Glauber Costa <gcosta@redhat.com>, anthony@codemonkey.ws, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

It makes no sense for the clock initialization to be
hanging around in setup_32.c when we have a generic kvm guest
initialization function available. So, we move kvmclock_init()
inside such a function, leading to a cleaner code.

Signed-off-by: Glauber Costa <gcosta@redhat.com>
---
 arch/x86/kernel/kvm.c      |    2 ++
 arch/x86/kernel/setup_32.c |    4 ----
 include/linux/kvm_para.h   |    5 +++++
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index d9121f9..5cad368 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -210,6 +210,8 @@ static void paravirt_ops_setup(void)
 	pv_info.name = "KVM";
 	pv_info.paravirt_enabled = 1;
 
+	kvmclock_init();
+
 	if (kvm_para_has_feature(KVM_FEATURE_NOP_IO_DELAY))
 		pv_cpu_ops.io_delay = kvm_io_delay;
 
diff --git a/arch/x86/kernel/setup_32.c b/arch/x86/kernel/setup_32.c
index 65f3a23..029350c 100644
--- a/arch/x86/kernel/setup_32.c
+++ b/arch/x86/kernel/setup_32.c
@@ -771,10 +771,6 @@ void __init setup_arch(char **cmdline_p)
 
 	max_low_pfn = setup_memory();
 
-#ifdef CONFIG_KVM_CLOCK
-	kvmclock_init();
-#endif
-
 #ifdef CONFIG_VMI
 	/*
 	 * Must be after max_low_pfn is determined, and before kernel
diff --git a/include/linux/kvm_para.h b/include/linux/kvm_para.h
index 3ddce03..c5e662c 100644
--- a/include/linux/kvm_para.h
+++ b/include/linux/kvm_para.h
@@ -28,6 +28,11 @@ void __init kvm_guest_init(void);
 #else
 #define kvm_guest_init() do { } while (0)
 #endif
+#ifdef CONFIG_KVM_CLOCK
+void kvmclock_init(void);
+#else
+#define kvmclock_init() do { } while (0)
+#endif
 
 static inline int kvm_para_has_feature(unsigned int feature)
 {
-- 
1.5.0.6
