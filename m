From: Andrey Smetanin <asmetanin@virtuozzo.com>
Subject: [PATCH 4/7] kvm: Hyper-V SynIC irq routing support
Date: Mon, 26 Oct 2015 12:50:57 +0300
Message-ID: <1445853060-24201-5-git-send-email-asmetanin__45473.0806210593$1446420859$gmane$org@virtuozzo.com>
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
 include/sysemu/kvm.h |  1 +
 kvm-all.c            | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index 461ef65..5af10fb 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -455,6 +455,7 @@ int kvm_irqchip_update_msi_route(KVMState *s, int virq, MSIMessage msg,
 void kvm_irqchip_release_virq(KVMState *s, int virq);
 
 int kvm_irqchip_add_adapter_route(KVMState *s, AdapterInfo *adapter);
+int kvm_irqchip_add_hv_sint_route(KVMState *s, uint32_t vcpu, uint32_t sint);
 
 int kvm_irqchip_add_irqfd_notifier_gsi(KVMState *s, EventNotifier *n,
                                        EventNotifier *rn, int virq);
diff --git a/kvm-all.c b/kvm-all.c
index c442838..4d36a6c 100644
--- a/kvm-all.c
+++ b/kvm-all.c
@@ -1297,6 +1297,34 @@ int kvm_irqchip_add_adapter_route(KVMState *s, AdapterInfo *adapter)
     return virq;
 }
 
+int kvm_irqchip_add_hv_sint_route(KVMState *s, uint32_t vcpu, uint32_t sint)
+{
+    struct kvm_irq_routing_entry kroute = {};
+    int virq;
+
+    if (!kvm_gsi_routing_enabled()) {
+        return -ENOSYS;
+    }
+    if (!kvm_check_extension(s, KVM_CAP_HYPERV_SYNIC)) {
+        return -ENOSYS;
+    }
+    virq = kvm_irqchip_get_virq(s);
+    if (virq < 0) {
+        return virq;
+    }
+
+    kroute.gsi = virq;
+    kroute.type = KVM_IRQ_ROUTING_HV_SINT;
+    kroute.flags = 0;
+    kroute.u.hv_sint.vcpu = vcpu;
+    kroute.u.hv_sint.sint = sint;
+
+    kvm_add_routing_entry(s, &kroute);
+    kvm_irqchip_commit_routes(s);
+
+    return virq;
+}
+
 #else /* !KVM_CAP_IRQ_ROUTING */
 
 void kvm_init_irq_routing(KVMState *s)
@@ -1322,6 +1350,11 @@ int kvm_irqchip_add_adapter_route(KVMState *s, AdapterInfo *adapter)
     return -ENOSYS;
 }
 
+int kvm_irqchip_add_hv_sint_route(KVMState *s, uint32_t vcpu, uint32_t sint)
+{
+    return -ENOSYS;
+}
+
 static int kvm_irqchip_assign_irqfd(KVMState *s, int fd, int virq, bool assign)
 {
     abort();
-- 
2.4.3
