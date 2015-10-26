From: Andrey Smetanin <asmetanin@virtuozzo.com>
Subject: [PATCH 6/7] target-i386/hyperv: Hyper-V SynIC SINT routing and vCPU
	exit
Date: Mon, 26 Oct 2015 12:50:59 +0300
Message-ID: <1445853060-24201-7-git-send-email-asmetanin__23519.9066148654$1446420877$gmane$org@virtuozzo.com>
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

Hyper-V SynIC(synthetic interrupt controller) API for
irq routing setup, irq injection, irq ack notifications and
event/message pages changes tracking for future use.

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
 target-i386/Makefile.objs |   2 +-
 target-i386/hyperv.c      | 127 ++++++++++++++++++++++++++++++++++++++++++++++
 target-i386/hyperv.h      |  42 +++++++++++++++
 target-i386/kvm.c         |   4 ++
 4 files changed, 174 insertions(+), 1 deletion(-)
 create mode 100644 target-i386/hyperv.c
 create mode 100644 target-i386/hyperv.h

diff --git a/target-i386/Makefile.objs b/target-i386/Makefile.objs
index 437d997..2255f46 100644
--- a/target-i386/Makefile.objs
+++ b/target-i386/Makefile.objs
@@ -3,5 +3,5 @@ obj-y += excp_helper.o fpu_helper.o cc_helper.o int_helper.o svm_helper.o
 obj-y += smm_helper.o misc_helper.o mem_helper.o seg_helper.o
 obj-y += gdbstub.o
 obj-$(CONFIG_SOFTMMU) += machine.o arch_memory_mapping.o arch_dump.o monitor.o
-obj-$(CONFIG_KVM) += kvm.o
+obj-$(CONFIG_KVM) += kvm.o hyperv.o
 obj-$(call lnot,$(CONFIG_KVM)) += kvm-stub.o
diff --git a/target-i386/hyperv.c b/target-i386/hyperv.c
new file mode 100644
index 0000000..e79b173
--- /dev/null
+++ b/target-i386/hyperv.c
@@ -0,0 +1,127 @@
+/*
+ * QEMU KVM Hyper-V support
+ *
+ * Copyright (C) 2015 Andrey Smetanin <asmetanin@virtuozzo.com>
+ *
+ * Authors:
+ *  Andrey Smetanin <asmetanin@virtuozzo.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#include "hyperv.h"
+#include "standard-headers/asm-x86/hyperv.h"
+
+int kvm_hv_handle_exit(X86CPU *cpu, struct kvm_hyperv_exit *exit)
+{
+    CPUX86State *env = &cpu->env;
+
+    switch (exit->type) {
+    case KVM_EXIT_HYPERV_SYNIC:
+        if (!cpu->hyperv_synic) {
+            return -1;
+        }
+
+        /*
+         * For now just track changes in SynIC control and msg/evt pages msr's.
+         * When SynIC messaging/events processing will be added in future
+         * here we will do messages queues flushing and pages remapping.
+         */
+        switch (exit->u.synic.msr) {
+        case HV_X64_MSR_SCONTROL:
+            env->msr_hv_synic_control = exit->u.synic.control;
+            break;
+        case HV_X64_MSR_SIMP:
+            env->msr_hv_synic_msg_page = exit->u.synic.msg_page;
+            break;
+        case HV_X64_MSR_SIEFP:
+            env->msr_hv_synic_evt_page = exit->u.synic.evt_page;
+            break;
+        default:
+            return -1;
+        }
+        return 0;
+    default:
+        return -1;
+    }
+}
+
+static void kvm_hv_sint_ack_handler(EventNotifier *notifier)
+{
+    HvSintRoute *sint_route = container_of(notifier, HvSintRoute,
+                                           sint_ack_notifier);
+    event_notifier_test_and_clear(notifier);
+    if (sint_route->sint_ack_clb) {
+        sint_route->sint_ack_clb(sint_route);
+    }
+}
+
+HvSintRoute *kvm_hv_sint_route_create(uint32_t vcpu_id, uint32_t sint,
+                                      HvSintAckClb sint_ack_clb)
+{
+    HvSintRoute *sint_route;
+    int r, gsi;
+
+    sint_route = g_malloc0(sizeof(*sint_route));
+    r = event_notifier_init(&sint_route->sint_set_notifier, false);
+    if (r) {
+        goto err;
+    }
+
+    r = event_notifier_init(&sint_route->sint_ack_notifier, false);
+    if (r) {
+        goto err_sint_set_notifier;
+    }
+
+    event_notifier_set_handler(&sint_route->sint_ack_notifier,
+                               kvm_hv_sint_ack_handler);
+
+    gsi = kvm_irqchip_add_hv_sint_route(kvm_state, vcpu_id, sint);
+    if (gsi < 0) {
+        goto err_gsi;
+    }
+
+    r = kvm_irqchip_add_irqfd_notifier_gsi(kvm_state,
+                                           &sint_route->sint_set_notifier,
+                                           &sint_route->sint_ack_notifier, gsi);
+    if (r) {
+        goto err_irqfd;
+    }
+    sint_route->gsi = gsi;
+    sint_route->sint_ack_clb = sint_ack_clb;
+    sint_route->vcpu_id = vcpu_id;
+    sint_route->sint = sint;
+
+    return sint_route;
+
+err_irqfd:
+    kvm_irqchip_release_virq(kvm_state, gsi);
+err_gsi:
+    event_notifier_set_handler(&sint_route->sint_ack_notifier, NULL);
+    event_notifier_cleanup(&sint_route->sint_ack_notifier);
+err_sint_set_notifier:
+    event_notifier_cleanup(&sint_route->sint_set_notifier);
+err:
+    g_free(sint_route);
+
+    return NULL;
+}
+
+void kvm_hv_sint_route_destroy(HvSintRoute *sint_route)
+{
+    kvm_irqchip_remove_irqfd_notifier_gsi(kvm_state,
+                                          &sint_route->sint_set_notifier,
+                                          sint_route->gsi);
+    kvm_irqchip_release_virq(kvm_state, sint_route->gsi);
+    event_notifier_set_handler(&sint_route->sint_ack_notifier, NULL);
+    event_notifier_cleanup(&sint_route->sint_ack_notifier);
+    event_notifier_cleanup(&sint_route->sint_set_notifier);
+    g_free(sint_route);
+}
+
+int kvm_hv_sint_route_set_sint(HvSintRoute *sint_route)
+{
+    return event_notifier_set(&sint_route->sint_set_notifier);
+}
diff --git a/target-i386/hyperv.h b/target-i386/hyperv.h
new file mode 100644
index 0000000..b26201f
--- /dev/null
+++ b/target-i386/hyperv.h
@@ -0,0 +1,42 @@
+/*
+ * QEMU KVM Hyper-V support
+ *
+ * Copyright (C) 2015 Andrey Smetanin <asmetanin@virtuozzo.com>
+ *
+ * Authors:
+ *  Andrey Smetanin <asmetanin@virtuozzo.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#ifndef HYPERV_I386_H
+#define HYPERV_I386_H
+
+#include "cpu.h"
+#include "sysemu/kvm.h"
+#include "qemu/event_notifier.h"
+
+typedef struct HvSintRoute HvSintRoute;
+typedef void (*HvSintAckClb)(HvSintRoute *sint_route);
+
+struct HvSintRoute {
+    uint32_t sint;
+    uint32_t vcpu_id;
+    int gsi;
+    EventNotifier sint_set_notifier;
+    EventNotifier sint_ack_notifier;
+    HvSintAckClb sint_ack_clb;
+};
+
+int kvm_hv_handle_exit(X86CPU *cpu, struct kvm_hyperv_exit *exit);
+
+HvSintRoute *kvm_hv_sint_route_create(uint32_t vcpu_id, uint32_t sint,
+                                      HvSintAckClb sint_ack_clb);
+
+void kvm_hv_sint_route_destroy(HvSintRoute *sint_route);
+
+int kvm_hv_sint_route_set_sint(HvSintRoute *sint_route);
+
+#endif
diff --git a/target-i386/kvm.c b/target-i386/kvm.c
index 325dfec..c760fd2 100644
--- a/target-i386/kvm.c
+++ b/target-i386/kvm.c
@@ -25,6 +25,7 @@
 #include "sysemu/kvm_int.h"
 #include "kvm_i386.h"
 #include "cpu.h"
+#include "hyperv.h"
 #include "exec/gdbstub.h"
 #include "qemu/host-utils.h"
 #include "qemu/config-file.h"
@@ -2908,6 +2909,9 @@ int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
         ret = kvm_handle_debug(cpu, &run->debug.arch);
         qemu_mutex_unlock_iothread();
         break;
+    case KVM_EXIT_HYPERV:
+        ret = kvm_hv_handle_exit(cpu, &run->hyperv);
+        break;
     default:
         fprintf(stderr, "KVM: unknown exit reason %d\n", run->exit_reason);
         ret = -1;
-- 
2.4.3
