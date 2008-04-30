From: Glauber Costa <gcosta@redhat.com>
Subject: [PATCH] make setup_secondary_clock definition dependent on local apic
Date: Wed, 30 Apr 2008 12:39:05 -0300
Message-ID: <12095699453538-git-send-email-gcosta__45851.3278434568$1209570483$gmane$org@redhat.com>
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
Cc: Glauber Costa <gcosta@redhat.com>, mingo@elte.hu, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

since the pv_apic_ops are only present if CONFIG_X86_LOCAL_APIC is compiled
in, kvmclock failed to build without this option. This patch fixes this

Signed-off-by: Glauber Costa <gcosta@redhat.com>
---
 arch/x86/kernel/kvmclock.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index ddee040..4bc1be5 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -133,6 +133,7 @@ static int kvm_register_clock(void)
 	return native_write_msr_safe(MSR_KVM_SYSTEM_TIME, low, high);
 }
 
+#ifdef CONFIG_X86_LOCAL_APIC
 static void kvm_setup_secondary_clock(void)
 {
 	/*
@@ -143,6 +144,7 @@ static void kvm_setup_secondary_clock(void)
 	/* ok, done with our trickery, call native */
 	setup_secondary_APIC_clock();
 }
+#endif
 
 /*
  * After the clock is registered, the host will keep writing to the
@@ -177,7 +179,9 @@ void __init kvmclock_init(void)
 		pv_time_ops.get_wallclock = kvm_get_wallclock;
 		pv_time_ops.set_wallclock = kvm_set_wallclock;
 		pv_time_ops.sched_clock = kvm_clock_read;
+#ifdef CONFIG_X86_LOCAL_APIC
 		pv_apic_ops.setup_secondary_clock = kvm_setup_secondary_clock;
+#endif
 		machine_ops.shutdown  = kvm_shutdown;
 #ifdef CONFIG_KEXEC
 		machine_ops.crash_shutdown  = kvm_crash_shutdown;
-- 
1.5.0.6
