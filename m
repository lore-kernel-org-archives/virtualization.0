From: Andrey Smetanin <asmetanin@virtuozzo.com>
Subject: [kvm-unit-tests PATCH] x86: hyperv_synic: Hyper-V SynIC test
Date: Mon, 26 Oct 2015 12:56:09 +0300
Message-ID: <1445853369-24435-1-git-send-email-asmetanin__18546.9770142392$1446420811$gmane$org@virtuozzo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: kvm@vger.kernel.org
Cc: Gleb Natapov <gleb@kernel.org>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, Roman Kagan <rkagan@virtuozzo.com>, Paolo Bonzini <pbonzini@redhat.com>, "Denis V. Lunev" <den@openvz.org>, Vitaly Kuznetsov <vkuznets@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Hyper-V SynIC is a Hyper-V synthetic interrupt controller.

The test runs on every vCPU and performs the following steps:
* read from all Hyper-V SynIC MSR's
* setup Hyper-V SynIC evt/msg pages
* setup SINT's routing
* inject SINT's into destination vCPU by 'hyperv-synic-test-device'
* wait for SINT's isr's completion
* clear Hyper-V SynIC evt/msg pages and destroy SINT's routing

Signed-off-by: Andrey Smetanin <asmetanin@virtuozzo.com>
Reviewed-by: Roman Kagan <rkagan@virtuozzo.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Vitaly Kuznetsov <vkuznets@redhat.com>
CC: "K. Y. Srinivasan" <kys@microsoft.com>
CC: Gleb Natapov <gleb@kernel.org>
CC: Paolo Bonzini <pbonzini@redhat.com>
CC: Roman Kagan <rkagan@virtuozzo.com>
CC: Denis V. Lunev <den@openvz.org>
CC: qemu-devel@nongnu.org
CC: virtualization@lists.linux-foundation.org
---
 config/config-x86-common.mak |   5 +-
 lib/x86/msr.h                |  23 +++++
 x86/hyperv_synic.c           | 229 +++++++++++++++++++++++++++++++++++++++++++
 x86/run                      |  10 +-
 x86/unittests.cfg            |   5 +
 5 files changed, 270 insertions(+), 2 deletions(-)
 create mode 100644 x86/hyperv_synic.c

diff --git a/config/config-x86-common.mak b/config/config-x86-common.mak
index c2f9908..dc80eaa 100644
--- a/config/config-x86-common.mak
+++ b/config/config-x86-common.mak
@@ -36,7 +36,8 @@ tests-common = $(TEST_DIR)/vmexit.flat $(TEST_DIR)/tsc.flat \
                $(TEST_DIR)/kvmclock_test.flat  $(TEST_DIR)/eventinj.flat \
                $(TEST_DIR)/s3.flat $(TEST_DIR)/pmu.flat \
                $(TEST_DIR)/tsc_adjust.flat $(TEST_DIR)/asyncpf.flat \
-               $(TEST_DIR)/init.flat $(TEST_DIR)/smap.flat
+               $(TEST_DIR)/init.flat $(TEST_DIR)/smap.flat \
+               $(TEST_DIR)/hyperv_synic.flat
 
 ifdef API
 tests-common += api/api-sample
@@ -108,6 +109,8 @@ $(TEST_DIR)/vmx.elf: $(cstart.o) $(TEST_DIR)/vmx.o $(TEST_DIR)/vmx_tests.o
 
 $(TEST_DIR)/debug.elf: $(cstart.o) $(TEST_DIR)/debug.o
 
+$(TEST_DIR)/hyperv_synic.elf: $(cstart.o) $(TEST_DIR)/hyperv_synic.o
+
 arch_clean:
 	$(RM) $(TEST_DIR)/*.o $(TEST_DIR)/*.flat $(TEST_DIR)/*.elf \
 	$(TEST_DIR)/.*.d lib/x86/.*.d
diff --git a/lib/x86/msr.h b/lib/x86/msr.h
index 281255a..54da420 100644
--- a/lib/x86/msr.h
+++ b/lib/x86/msr.h
@@ -408,4 +408,27 @@
 #define MSR_VM_IGNNE                    0xc0010115
 #define MSR_VM_HSAVE_PA                 0xc0010117
 
+/* Define synthetic interrupt controller model specific registers. */
+#define HV_X64_MSR_SCONTROL                     0x40000080
+#define HV_X64_MSR_SVERSION                     0x40000081
+#define HV_X64_MSR_SIEFP                        0x40000082
+#define HV_X64_MSR_SIMP                         0x40000083
+#define HV_X64_MSR_EOM                          0x40000084
+#define HV_X64_MSR_SINT0                        0x40000090
+#define HV_X64_MSR_SINT1                        0x40000091
+#define HV_X64_MSR_SINT2                        0x40000092
+#define HV_X64_MSR_SINT3                        0x40000093
+#define HV_X64_MSR_SINT4                        0x40000094
+#define HV_X64_MSR_SINT5                        0x40000095
+#define HV_X64_MSR_SINT6                        0x40000096
+#define HV_X64_MSR_SINT7                        0x40000097
+#define HV_X64_MSR_SINT8                        0x40000098
+#define HV_X64_MSR_SINT9                        0x40000099
+#define HV_X64_MSR_SINT10                       0x4000009A
+#define HV_X64_MSR_SINT11                       0x4000009B
+#define HV_X64_MSR_SINT12                       0x4000009C
+#define HV_X64_MSR_SINT13                       0x4000009D
+#define HV_X64_MSR_SINT14                       0x4000009E
+#define HV_X64_MSR_SINT15                       0x4000009F
+
 #endif /* _ASM_X86_MSR_INDEX_H */
diff --git a/x86/hyperv_synic.c b/x86/hyperv_synic.c
new file mode 100644
index 0000000..5c5a43a
--- /dev/null
+++ b/x86/hyperv_synic.c
@@ -0,0 +1,229 @@
+#include "libcflat.h"
+#include "processor.h"
+#include "msr.h"
+#include "isr.h"
+#include "vm.h"
+#include "apic.h"
+#include "desc.h"
+#include "io.h"
+#include "smp.h"
+#include "atomic.h"
+
+#define MAX_CPUS 4
+#define HYPERV_CPUID_FEATURES                   0x40000003
+#define HV_X64_MSR_SYNIC_AVAILABLE              (1 << 2)
+#define HV_SYNIC_CONTROL_ENABLE                 (1ULL << 0)
+#define HV_SYNIC_SIMP_ENABLE                    (1ULL << 0)
+#define HV_SYNIC_SIEFP_ENABLE                   (1ULL << 0)
+#define HV_SYNIC_SINT_MASKED                    (1ULL << 16)
+#define HV_SYNIC_SINT_AUTO_EOI                  (1ULL << 17)
+#define HV_SYNIC_SINT_VECTOR_MASK               (0xFF)
+#define HV_SYNIC_SINT_COUNT                     16
+
+enum {
+    HV_TEST_DEV_SINT_ROUTE_CREATE = 1,
+    HV_TEST_DEV_SINT_ROUTE_DESTROY,
+    HV_TEST_DEV_SINT_ROUTE_SET_SINT
+};
+
+static atomic_t isr_enter_count[MAX_CPUS];
+static atomic_t cpus_comp_count;
+
+static bool synic_supported(void)
+{
+   return cpuid(HYPERV_CPUID_FEATURES).a & HV_X64_MSR_SYNIC_AVAILABLE;
+}
+
+static void synic_sint_auto_eoi_isr(isr_regs_t *regs)
+{
+    atomic_inc(&isr_enter_count[smp_id()]);
+}
+
+static void synic_sint_isr(isr_regs_t *regs)
+{
+    atomic_inc(&isr_enter_count[smp_id()]);
+    eoi();
+}
+
+static void synic_ctl(u8 ctl, u8 vcpu_id, u8 sint)
+{
+    outl((ctl << 16)|((vcpu_id) << 8)|sint, 0x3000);
+}
+
+struct sint_vec_entry {
+    int vec;
+    bool auto_eoi;
+};
+
+struct sint_vec_entry sint_vecs[HV_SYNIC_SINT_COUNT] = {
+    {0xB0, false},
+    {0xB1, false},
+    {0xB2, false},
+    {0xB3, true},
+    {0xB4, false},
+    {0xB5, false},
+    {0xB6, false},
+    {0xB7, false},
+    {0xB8, true},
+    {0xB9, false},
+    {0xBA, true},
+    {0xBB, false},
+    {0xBC, false},
+    {0xBD, false},
+    {0xBE, true},
+    {0xBF, false},
+};
+
+static void synic_prepare_sint_vecs(void)
+{
+    bool auto_eoi;
+    int i, vec;
+
+    for (i = 0; i < HV_SYNIC_SINT_COUNT; i++) {
+        vec = sint_vecs[i].vec;
+        auto_eoi = sint_vecs[i].auto_eoi;
+        handle_irq(vec, (auto_eoi) ? synic_sint_auto_eoi_isr : synic_sint_isr);
+    }
+}
+
+static void synic_sints_prepare(u8 vcpu)
+{
+    bool auto_eoi;
+    int i, vec;
+
+    for (i = 0; i < HV_SYNIC_SINT_COUNT; i++) {
+        vec = sint_vecs[i].vec;
+        auto_eoi = sint_vecs[i].auto_eoi;
+        wrmsr(HV_X64_MSR_SINT0 + i,
+                (u64)vec | ((auto_eoi) ? HV_SYNIC_SINT_AUTO_EOI : 0));
+        synic_ctl(HV_TEST_DEV_SINT_ROUTE_CREATE, vcpu, i);
+    }
+}
+
+static void synic_test_prepare(void *ctx)
+{
+    u64 r;
+    int i = 0;
+
+    write_cr3((ulong)ctx);
+    irq_enable();
+
+    rdmsr(HV_X64_MSR_SVERSION);
+    rdmsr(HV_X64_MSR_SIMP);
+    rdmsr(HV_X64_MSR_SIEFP);
+    rdmsr(HV_X64_MSR_SCONTROL);
+    for (i = 0; i < HV_SYNIC_SINT_COUNT; i++) {
+        rdmsr(HV_X64_MSR_SINT0 + i);
+    }
+    r = rdmsr(HV_X64_MSR_EOM);
+    if (r != 0) {
+        report("Hyper-V SynIC test, EOM read 0x%llx", false, r);
+        goto ret;
+    }
+
+    wrmsr(HV_X64_MSR_SIMP, (u64)virt_to_phys(alloc_page()) |
+            HV_SYNIC_SIMP_ENABLE);
+    wrmsr(HV_X64_MSR_SIEFP, (u64)virt_to_phys(alloc_page())|
+            HV_SYNIC_SIEFP_ENABLE);
+    wrmsr(HV_X64_MSR_SCONTROL, HV_SYNIC_CONTROL_ENABLE);
+
+    synic_sints_prepare(smp_id());
+ret:
+    atomic_inc(&cpus_comp_count);
+}
+
+static void synic_sints_test(u8 dst_vcpu)
+{
+    int i;
+
+    atomic_set(&isr_enter_count[dst_vcpu], 0);
+    for (i = 0; i < HV_SYNIC_SINT_COUNT; i++) {
+        synic_ctl(HV_TEST_DEV_SINT_ROUTE_SET_SINT, dst_vcpu, i);
+    }
+
+    while (atomic_read(&isr_enter_count[dst_vcpu]) != HV_SYNIC_SINT_COUNT) {
+        pause();
+    }
+}
+
+static void synic_test(void *ctx)
+{
+    u8 dst_vcpu = (ulong)ctx;
+
+    irq_enable();
+    synic_sints_test(dst_vcpu);
+    atomic_inc(&cpus_comp_count);
+}
+
+static void synic_test_cleanup(void *ctx)
+{
+    u8 vcpu = smp_id();
+    int i;
+
+    irq_enable();
+    for (i = 0; i < HV_SYNIC_SINT_COUNT; i++) {
+        synic_ctl(HV_TEST_DEV_SINT_ROUTE_DESTROY, vcpu, i);
+        wrmsr(HV_X64_MSR_SINT0 + i, 0xFF|HV_SYNIC_SINT_MASKED);
+    }
+
+    wrmsr(HV_X64_MSR_SCONTROL, 0);
+    wrmsr(HV_X64_MSR_SIMP, 0);
+    wrmsr(HV_X64_MSR_SIEFP, 0);
+    atomic_inc(&cpus_comp_count);
+}
+
+int main(int ac, char **av)
+{
+
+    if (synic_supported()) {
+        int ncpus, i;
+
+        setup_vm();
+        smp_init();
+        setup_idt();
+        enable_apic();
+
+        synic_prepare_sint_vecs();
+
+        ncpus = cpu_count();
+        if (ncpus > MAX_CPUS) {
+            ncpus = MAX_CPUS;
+        }
+        printf("ncpus = %d\n", ncpus);
+
+        atomic_set(&cpus_comp_count, 0);
+        for (i = 0; i < ncpus; i++) {
+                on_cpu_async(i, synic_test_prepare, (void *)read_cr3());
+        }
+        while (atomic_read(&cpus_comp_count) != ncpus) {
+            pause();
+        }
+
+        atomic_set(&cpus_comp_count, 0);
+        for (i = 0; i < ncpus; i++) {
+                on_cpu_async(i, synic_test, (void *)(ulong)(ncpus - 1 - i));
+        }
+        while (atomic_read(&cpus_comp_count) != ncpus) {
+            pause();
+        }
+
+        atomic_set(&cpus_comp_count, 0);
+        for (i = 0; i < ncpus; i++) {
+                on_cpu_async(i, synic_test_cleanup, NULL);
+        }
+        while (atomic_read(&cpus_comp_count) != ncpus) {
+            pause();
+        }
+
+        for (i = 0; i < ncpus; ++i) {
+            printf("isr_enter_count[%d] = %d\n",
+                   i, atomic_read(&isr_enter_count[i]));
+        }
+
+        report("Hyper-V SynIC test", true);
+    } else {
+        report("Hyper-V SynIC is not supported", true);
+    }
+
+    return report_summary();
+}
diff --git a/x86/run b/x86/run
index b4a35b2..e50ce5f 100755
--- a/x86/run
+++ b/x86/run
@@ -42,7 +42,15 @@ else
 	pc_testdev="-device testdev,chardev=testlog -chardev file,id=testlog,path=msr.out"
 fi
 
-command="${qemu} -enable-kvm $pc_testdev -vnc none -serial stdio $pci_testdev -kernel"
+if
+	${qemu} -device '?' 2>&1 | grep -F "hyperv-testdev" > /dev/null;
+then
+	hyperv_testdev="-device hyperv-testdev"
+else
+	hyperv_testdev=""
+fi
+
+command="${qemu} -enable-kvm $pc_testdev -vnc none -serial stdio $pci_testdev $hyperv_testdev -kernel"
 echo ${command} "$@"
 
 if [ "$DRYRUN" != "yes" ]; then
diff --git a/x86/unittests.cfg b/x86/unittests.cfg
index a38544f..6b19f42 100644
--- a/x86/unittests.cfg
+++ b/x86/unittests.cfg
@@ -166,3 +166,8 @@ arch = x86_64
 [debug]
 file = debug.flat
 arch = x86_64
+
+[hyperv_synic]
+file = hyperv_synic.flat
+smp = 2
+extra_params = -cpu host,hv_synic
-- 
2.4.3
