From: Glauber Costa <gcosta@redhat.com>
Subject: [PATCH] fixup 3dnow! support
Date: Tue,  6 May 2008 13:27:42 -0300
Message-ID: <12100912622893-git-send-email-gcosta@redhat.com>
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
Cc: Glauber Costa <gcosta@redhat.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

qemu recently added support for 3dnow instructions. Because of
that, 3dnow will be featured among cpuid bits. But this will
break kvm in cpus that don't have those instructions (which includes
my laptop). So we fixup our cpuid before exposing it to the guest.

Signed-off-by: Glauber Costa <gcosta@redhat.com>
---
 arch/x86/kvm/x86.c           |   22 ++++++++++++++++++----
 include/asm-x86/cpufeature.h |    2 ++
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 979f983..e79fcd5 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -919,7 +919,7 @@ static int is_efer_nx(void)
 	return efer & EFER_NX;
 }
 
-static void cpuid_fix_nx_cap(struct kvm_vcpu *vcpu)
+static void cpuid_fix_caps(struct kvm_vcpu *vcpu)
 {
 	int i;
 	struct kvm_cpuid_entry2 *e, *entry;
@@ -932,6 +932,20 @@ static void cpuid_fix_nx_cap(struct kvm_vcpu *vcpu)
 			break;
 		}
 	}
+
+	/* 3DNOWEXT */
+	if (entry && (entry->edx & (1 << 30)) && !cpu_has_3dnowext) {
+		entry->edx &= ~(1 << 30);
+		printk(KERN_INFO "kvm: guest 3DNOWEXT capability removed\n");
+	}
+
+	/* 3DNOW */
+	if (entry && (entry->edx & (1 << 31)) && !cpu_has_3dnow) {
+		entry->edx &= ~(1 << 31);
+		printk(KERN_INFO "kvm: guest 3DNOW capability removed\n");
+	}
+
+	/* NX */
 	if (entry && (entry->edx & (1 << 20)) && !is_efer_nx()) {
 		entry->edx &= ~(1 << 20);
 		printk(KERN_INFO "kvm: guest NX capability removed\n");
@@ -970,7 +984,7 @@ static int kvm_vcpu_ioctl_set_cpuid(struct kvm_vcpu *vcpu,
 		vcpu->arch.cpuid_entries[i].padding[2] = 0;
 	}
 	vcpu->arch.cpuid_nent = cpuid->nent;
-	cpuid_fix_nx_cap(vcpu);
+	cpuid_fix_caps(vcpu);
 	r = 0;
 
 out_free:
@@ -1061,8 +1075,8 @@ static void do_cpuid_ent(struct kvm_cpuid_entry2 *entry, u32 function,
 		bit(X86_FEATURE_LM) |
 #endif
 		bit(X86_FEATURE_MMXEXT) |
-		bit(X86_FEATURE_3DNOWEXT) |
-		bit(X86_FEATURE_3DNOW);
+		(bit(X86_FEATURE_3DNOWEXT) && cpu_has_3dnowext) |
+		(bit(X86_FEATURE_3DNOW) && cpu_has_3dnow);
 	const u32 kvm_supported_word3_x86_features =
 		bit(X86_FEATURE_XMM3) | bit(X86_FEATURE_CX16);
 	const u32 kvm_supported_word6_x86_features =
diff --git a/include/asm-x86/cpufeature.h b/include/asm-x86/cpufeature.h
index 0d609c8..efbc5ce 100644
--- a/include/asm-x86/cpufeature.h
+++ b/include/asm-x86/cpufeature.h
@@ -187,6 +187,8 @@ extern const char * const x86_power_flags[32];
 #define cpu_has_gbpages		boot_cpu_has(X86_FEATURE_GBPAGES)
 #define cpu_has_arch_perfmon	boot_cpu_has(X86_FEATURE_ARCH_PERFMON)
 #define cpu_has_pat		boot_cpu_has(X86_FEATURE_PAT)
+#define cpu_has_3dnow		boot_cpu_has(X86_FEATURE_3DNOW)
+#define cpu_has_3dnowext	boot_cpu_has(X86_FEATURE_3DNOWEXT)
 
 #if defined(CONFIG_X86_INVLPG) || defined(CONFIG_X86_64)
 # define cpu_has_invlpg		1
-- 
1.5.0.6
