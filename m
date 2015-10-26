From: Andrey Smetanin <asmetanin@virtuozzo.com>
Subject: [PATCH 2/7] target-i386/kvm: Hyper-V SynIC MSR's support
Date: Mon, 26 Oct 2015 12:50:55 +0300
Message-ID: <1445853060-24201-3-git-send-email-asmetanin__36234.441251918$1446420881$gmane$org@virtuozzo.com>
References: <1445853060-24201-1-git-send-email-asmetanin@virtuozzo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1445853060-24201-1-git-send-email-asmetanin@virtuozzo.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, Gleb Natapov <gleb@kernel.org>, virtualization@lists.linux-foundation.org, Roman Kagan <rkagan@virtuozzo.com>, Paolo Bonzini <pbonzini@redhat.com>, "Denis V. Lunev" <den@openvz.org>, Vitaly Kuznetsov <vkuznets@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Hyper-V SynIC MSR's support and MSR's migration.

Signed-off-by: Andrey Smetanin <asmetanin@virtuozzo.com>
Reviewed-by: Roman Kagan <rkagan@virtuozzo.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Vitaly Kuznetsov <vkuznets@redhat.com>
CC: "K. Y. Srinivasan" <kys@microsoft.com>
CC: Gleb Natapov <gleb@kernel.org>
CC: Paolo Bonzini <pbonzini@redhat.com>
CC: Roman Kagan <rkagan@virtuozzo.com>
CC: Denis V. Lunev <den@openvz.org>
CC: kvm@vger.kernel.org
CC: virtualization@lists.linux-foundation.org

---
 target-i386/cpu-qom.h |  1 +
 target-i386/cpu.c     |  1 +
 target-i386/cpu.h     |  5 +++++
 target-i386/kvm.c     | 62 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 target-i386/machine.c | 39 ++++++++++++++++++++++++++++++++
 5 files changed, 107 insertions(+), 1 deletion(-)

diff --git a/target-i386/cpu-qom.h b/target-i386/cpu-qom.h
index e3bfe9d..7ea5b34 100644
--- a/target-i386/cpu-qom.h
+++ b/target-i386/cpu-qom.h
@@ -94,6 +94,7 @@ typedef struct X86CPU {
     bool hyperv_reset;
     bool hyperv_vpindex;
     bool hyperv_runtime;
+    bool hyperv_synic;
     bool check_cpuid;
     bool enforce_cpuid;
     bool expose_kvm;
diff --git a/target-i386/cpu.c b/target-i386/cpu.c
index c1a9e09..ff1c0a9 100644
--- a/target-i386/cpu.c
+++ b/target-i386/cpu.c
@@ -3141,6 +3141,7 @@ static Property x86_cpu_properties[] = {
     DEFINE_PROP_BOOL("hv-reset", X86CPU, hyperv_reset, false),
     DEFINE_PROP_BOOL("hv-vpindex", X86CPU, hyperv_vpindex, false),
     DEFINE_PROP_BOOL("hv-runtime", X86CPU, hyperv_runtime, false),
+    DEFINE_PROP_BOOL("hv-synic", X86CPU, hyperv_synic, false),
     DEFINE_PROP_BOOL("check", X86CPU, check_cpuid, false),
     DEFINE_PROP_BOOL("enforce", X86CPU, enforce_cpuid, false),
     DEFINE_PROP_BOOL("kvm", X86CPU, expose_kvm, true),
diff --git a/target-i386/cpu.h b/target-i386/cpu.h
index 62f7879..8611015 100644
--- a/target-i386/cpu.h
+++ b/target-i386/cpu.h
@@ -915,6 +915,11 @@ typedef struct CPUX86State {
     uint64_t msr_hv_tsc;
     uint64_t msr_hv_crash_params[HV_X64_MSR_CRASH_PARAMS];
     uint64_t msr_hv_runtime;
+    uint64_t msr_hv_synic_control;
+    uint64_t msr_hv_synic_version;
+    uint64_t msr_hv_synic_evt_page;
+    uint64_t msr_hv_synic_msg_page;
+    uint64_t msr_hv_synic_sint[HV_SYNIC_SINT_COUNT];
 
     /* exception/interrupt handling */
     int error_code;
diff --git a/target-i386/kvm.c b/target-i386/kvm.c
index 64046cb..325dfec 100644
--- a/target-i386/kvm.c
+++ b/target-i386/kvm.c
@@ -86,6 +86,7 @@ static bool has_msr_hv_crash;
 static bool has_msr_hv_reset;
 static bool has_msr_hv_vpindex;
 static bool has_msr_hv_runtime;
+static bool has_msr_hv_synic;
 static bool has_msr_mtrr;
 static bool has_msr_xss;
 
@@ -476,7 +477,8 @@ static bool hyperv_enabled(X86CPU *cpu)
             cpu->hyperv_crash ||
             cpu->hyperv_reset ||
             cpu->hyperv_vpindex ||
-            cpu->hyperv_runtime);
+            cpu->hyperv_runtime ||
+            cpu->hyperv_synic);
 }
 
 static Error *invtsc_mig_blocker;
@@ -565,6 +567,9 @@ int kvm_arch_init_vcpu(CPUState *cs)
         if (cpu->hyperv_runtime && has_msr_hv_runtime) {
             c->eax |= HV_X64_MSR_VP_RUNTIME_AVAILABLE;
         }
+        if (cpu->hyperv_synic && has_msr_hv_synic) {
+            c->eax |= HV_X64_MSR_SYNIC_AVAILABLE;
+        }
         c = &cpuid_data.entries[cpuid_i++];
         c->function = HYPERV_CPUID_ENLIGHTMENT_INFO;
         if (cpu->hyperv_relaxed_timing) {
@@ -905,6 +910,10 @@ static int kvm_get_supported_msrs(KVMState *s)
                     has_msr_hv_runtime = true;
                     continue;
                 }
+                if (kvm_msr_list->indices[i] == HV_X64_MSR_SCONTROL) {
+                    has_msr_hv_synic = true;
+                    continue;
+                }
             }
         }
 
@@ -1466,6 +1475,31 @@ static int kvm_put_msrs(X86CPU *cpu, int level)
             kvm_msr_entry_set(&msrs[n++], HV_X64_MSR_VP_RUNTIME,
                               env->msr_hv_runtime);
         }
+        if (has_msr_hv_synic) {
+            int j;
+
+            if (!env->msr_hv_synic_version) {
+                /* First time initialization */
+                env->msr_hv_synic_version = HV_SYNIC_VERSION_1;
+                for (j = 0; j < ARRAY_SIZE(env->msr_hv_synic_sint); j++) {
+                    env->msr_hv_synic_sint[j] = HV_SYNIC_SINT_MASKED;
+                }
+            }
+
+            kvm_msr_entry_set(&msrs[n++], HV_X64_MSR_SCONTROL,
+                              env->msr_hv_synic_control);
+            kvm_msr_entry_set(&msrs[n++], HV_X64_MSR_SVERSION,
+                              env->msr_hv_synic_version);
+            kvm_msr_entry_set(&msrs[n++], HV_X64_MSR_SIEFP,
+                              env->msr_hv_synic_evt_page);
+            kvm_msr_entry_set(&msrs[n++], HV_X64_MSR_SIMP,
+                              env->msr_hv_synic_msg_page);
+
+            for (j = 0; j < ARRAY_SIZE(env->msr_hv_synic_sint); j++) {
+                kvm_msr_entry_set(&msrs[n++], HV_X64_MSR_SINT0 + j,
+                                  env->msr_hv_synic_sint[j]);
+            }
+        }
         if (has_msr_mtrr) {
             kvm_msr_entry_set(&msrs[n++], MSR_MTRRdefType, env->mtrr_deftype);
             kvm_msr_entry_set(&msrs[n++],
@@ -1834,6 +1868,17 @@ static int kvm_get_msrs(X86CPU *cpu)
     if (has_msr_hv_runtime) {
         msrs[n++].index = HV_X64_MSR_VP_RUNTIME;
     }
+    if (has_msr_hv_synic) {
+        uint32_t msr;
+
+        msrs[n++].index = HV_X64_MSR_SCONTROL;
+        msrs[n++].index = HV_X64_MSR_SVERSION;
+        msrs[n++].index = HV_X64_MSR_SIEFP;
+        msrs[n++].index = HV_X64_MSR_SIMP;
+        for (msr = HV_X64_MSR_SINT0; msr <= HV_X64_MSR_SINT15; msr++) {
+            msrs[n++].index = msr;
+        }
+    }
     if (has_msr_mtrr) {
         msrs[n++].index = MSR_MTRRdefType;
         msrs[n++].index = MSR_MTRRfix64K_00000;
@@ -1990,6 +2035,21 @@ static int kvm_get_msrs(X86CPU *cpu)
         case HV_X64_MSR_VP_RUNTIME:
             env->msr_hv_runtime = msrs[i].data;
             break;
+        case HV_X64_MSR_SCONTROL:
+            env->msr_hv_synic_control = msrs[i].data;
+            break;
+        case HV_X64_MSR_SVERSION:
+            env->msr_hv_synic_version = msrs[i].data;
+            break;
+        case HV_X64_MSR_SIEFP:
+            env->msr_hv_synic_evt_page = msrs[i].data;
+            break;
+        case HV_X64_MSR_SIMP:
+            env->msr_hv_synic_msg_page = msrs[i].data;
+            break;
+        case HV_X64_MSR_SINT0 ... HV_X64_MSR_SINT15:
+            env->msr_hv_synic_sint[index - HV_X64_MSR_SINT0] = msrs[i].data;
+            break;
         case MSR_MTRRdefType:
             env->mtrr_deftype = msrs[i].data;
             break;
diff --git a/target-i386/machine.c b/target-i386/machine.c
index a18e16e..bdb2997 100644
--- a/target-i386/machine.c
+++ b/target-i386/machine.c
@@ -710,6 +710,44 @@ static const VMStateDescription vmstate_msr_hyperv_runtime = {
     }
 };
 
+static bool hyperv_synic_enable_needed(void *opaque)
+{
+    X86CPU *cpu = opaque;
+    CPUX86State *env = &cpu->env;
+    int i;
+
+    if (env->msr_hv_synic_control != 0 ||
+        env->msr_hv_synic_version != 0 ||
+        env->msr_hv_synic_evt_page != 0 ||
+        env->msr_hv_synic_msg_page != 0) {
+        return true;
+    }
+
+    for (i = 0; i < ARRAY_SIZE(env->msr_hv_synic_sint); i++) {
+        if (env->msr_hv_synic_sint[i] != 0) {
+            return true;
+        }
+    }
+
+    return false;
+}
+
+static const VMStateDescription vmstate_msr_hyperv_synic = {
+    .name = "cpu/msr_hyperv_synic",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = hyperv_synic_enable_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT64(env.msr_hv_synic_control, X86CPU),
+        VMSTATE_UINT64(env.msr_hv_synic_version, X86CPU),
+        VMSTATE_UINT64(env.msr_hv_synic_evt_page, X86CPU),
+        VMSTATE_UINT64(env.msr_hv_synic_msg_page, X86CPU),
+        VMSTATE_UINT64_ARRAY(env.msr_hv_synic_sint, X86CPU,
+                             HV_SYNIC_SINT_COUNT),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static bool avx512_needed(void *opaque)
 {
     X86CPU *cpu = opaque;
@@ -893,6 +931,7 @@ VMStateDescription vmstate_x86_cpu = {
         &vmstate_msr_hyperv_time,
         &vmstate_msr_hyperv_crash,
         &vmstate_msr_hyperv_runtime,
+        &vmstate_msr_hyperv_synic,
         &vmstate_avx512,
         &vmstate_xss,
         NULL
-- 
2.4.3
