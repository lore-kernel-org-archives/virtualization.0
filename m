From: "Denis V. Lunev" <den@openvz.org>
Subject: [PATCH 7/9] kvm/x86: split ioapic-handled and EOI exit bitmaps
Date: Fri, 16 Oct 2015 10:07:51 +0300
Message-ID: <1444979273-6587-8-git-send-email-den__29562.4033817605$1444979375$gmane$org@openvz.org>
References: <1444979273-6587-1-git-send-email-den@openvz.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1444979273-6587-1-git-send-email-den@openvz.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
Cc: kvm@vger.kernel.org, Gleb Natapov <gleb@kernel.org>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, rkagan@virtuozzo.com, Paolo Bonzini <pbonzini@redhat.com>, Andrey Smetanin <asmetanin@virtuozzo.com>, "Denis V. Lunev" <den@openvz.org>, Vitaly Kuznetsov <vkuznets@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

From: Andrey Smetanin <asmetanin@virtuozzo.com>

The function to determine if the vector is handled by ioapic used to
rely on the fact that only ioapic-handled vectors were set up to
cause vmexits when virtual apic was in use.

We're going to break this assumption when introducing Hyper-V
synthetic interrupts: they may need to cause vmexits too.

To achieve that, introduce a new bitmap dedicated specifically for
ioapic-handled vectors, and populate EOI exit bitmap from it for now.

Signed-off-by: Andrey Smetanin <asmetanin@virtuozzo.com>
Reviewed-by: Roman Kagan <rkagan@virtuozzo.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Vitaly Kuznetsov <vkuznets@redhat.com>
CC: "K. Y. Srinivasan" <kys@microsoft.com>
CC: Gleb Natapov <gleb@kernel.org>
CC: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/include/asm/kvm_host.h |  4 ++--
 arch/x86/kvm/ioapic.c           |  4 ++--
 arch/x86/kvm/ioapic.h           |  7 ++++---
 arch/x86/kvm/irq_comm.c         |  6 +++---
 arch/x86/kvm/lapic.c            |  2 +-
 arch/x86/kvm/svm.c              |  2 +-
 arch/x86/kvm/vmx.c              |  3 +--
 arch/x86/kvm/x86.c              | 12 +++++++-----
 8 files changed, 21 insertions(+), 19 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 53deb27..07f7cd7 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -400,7 +400,7 @@ struct kvm_vcpu_arch {
 	u64 efer;
 	u64 apic_base;
 	struct kvm_lapic *apic;    /* kernel irqchip context */
-	u64 eoi_exit_bitmap[4];
+	DECLARE_BITMAP(ioapic_handled_vectors, 256);
 	unsigned long apic_attention;
 	int32_t apic_arb_prio;
 	int mp_state;
@@ -833,7 +833,7 @@ struct kvm_x86_ops {
 	int (*cpu_uses_apicv)(struct kvm_vcpu *vcpu);
 	void (*hwapic_irr_update)(struct kvm_vcpu *vcpu, int max_irr);
 	void (*hwapic_isr_update)(struct kvm *kvm, int isr);
-	void (*load_eoi_exitmap)(struct kvm_vcpu *vcpu);
+	void (*load_eoi_exitmap)(struct kvm_vcpu *vcpu, u64 *eoi_exit_bitmap);
 	void (*set_virtual_x2apic_mode)(struct kvm_vcpu *vcpu, bool set);
 	void (*set_apic_access_page_addr)(struct kvm_vcpu *vcpu, hpa_t hpa);
 	void (*deliver_posted_interrupt)(struct kvm_vcpu *vcpu, int vector);
diff --git a/arch/x86/kvm/ioapic.c b/arch/x86/kvm/ioapic.c
index 2dcda0f..3cf7a9c 100644
--- a/arch/x86/kvm/ioapic.c
+++ b/arch/x86/kvm/ioapic.c
@@ -233,7 +233,7 @@ static void kvm_ioapic_inject_all(struct kvm_ioapic *ioapic, unsigned long irr)
 }
 
 
-void kvm_ioapic_scan_entry(struct kvm_vcpu *vcpu, u64 *eoi_exit_bitmap)
+void kvm_ioapic_scan_entry(struct kvm_vcpu *vcpu, ulong *ioapic_handled_vectors)
 {
 	struct kvm_ioapic *ioapic = vcpu->kvm->arch.vioapic;
 	union kvm_ioapic_redirect_entry *e;
@@ -248,7 +248,7 @@ void kvm_ioapic_scan_entry(struct kvm_vcpu *vcpu, u64 *eoi_exit_bitmap)
 			if (kvm_apic_match_dest(vcpu, NULL, 0,
 				e->fields.dest_id, e->fields.dest_mode))
 				__set_bit(e->fields.vector,
-					(unsigned long *)eoi_exit_bitmap);
+					  ioapic_handled_vectors);
 		}
 	}
 	spin_unlock(&ioapic->lock);
diff --git a/arch/x86/kvm/ioapic.h b/arch/x86/kvm/ioapic.h
index 084617d..2d16dc2 100644
--- a/arch/x86/kvm/ioapic.h
+++ b/arch/x86/kvm/ioapic.h
@@ -121,7 +121,8 @@ int kvm_irq_delivery_to_apic(struct kvm *kvm, struct kvm_lapic *src,
 		struct kvm_lapic_irq *irq, unsigned long *dest_map);
 int kvm_get_ioapic(struct kvm *kvm, struct kvm_ioapic_state *state);
 int kvm_set_ioapic(struct kvm *kvm, struct kvm_ioapic_state *state);
-void kvm_ioapic_scan_entry(struct kvm_vcpu *vcpu, u64 *eoi_exit_bitmap);
-void kvm_scan_ioapic_routes(struct kvm_vcpu *vcpu, u64 *eoi_exit_bitmap);
-
+void kvm_ioapic_scan_entry(struct kvm_vcpu *vcpu,
+			   ulong *ioapic_handled_vectors);
+void kvm_scan_ioapic_routes(struct kvm_vcpu *vcpu,
+			    ulong *ioapic_handled_vectors);
 #endif
diff --git a/arch/x86/kvm/irq_comm.c b/arch/x86/kvm/irq_comm.c
index 6f922c2..fe91f72 100644
--- a/arch/x86/kvm/irq_comm.c
+++ b/arch/x86/kvm/irq_comm.c
@@ -371,7 +371,8 @@ void kvm_arch_post_irq_routing_update(struct kvm *kvm)
 	kvm_make_scan_ioapic_request(kvm);
 }
 
-void kvm_scan_ioapic_routes(struct kvm_vcpu *vcpu, u64 *eoi_exit_bitmap)
+void kvm_scan_ioapic_routes(struct kvm_vcpu *vcpu,
+			    ulong *ioapic_handled_vectors)
 {
 	struct kvm *kvm = vcpu->kvm;
 	struct kvm_kernel_irq_routing_entry *entry;
@@ -398,8 +399,7 @@ void kvm_scan_ioapic_routes(struct kvm_vcpu *vcpu, u64 *eoi_exit_bitmap)
 						dest_mode)) {
 				u32 vector = entry->msi.data & 0xff;
 
-				__set_bit(vector,
-					  (unsigned long *) eoi_exit_bitmap);
+				__set_bit(vector, ioapic_handled_vectors);
 			}
 		}
 	}
diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 944b38a..dc03a01 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -930,7 +930,7 @@ int kvm_apic_compare_prio(struct kvm_vcpu *vcpu1, struct kvm_vcpu *vcpu2)
 
 static bool kvm_ioapic_handles_vector(struct kvm_lapic *apic, int vector)
 {
-	return test_bit(vector, (ulong *)apic->vcpu->arch.eoi_exit_bitmap);
+	return test_bit(vector, apic->vcpu->arch.ioapic_handled_vectors);
 }
 
 static void kvm_ioapic_send_eoi(struct kvm_lapic *apic, int vector)
diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
index 54a8618..03ccb78 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -3651,7 +3651,7 @@ static int svm_cpu_uses_apicv(struct kvm_vcpu *vcpu)
 	return 0;
 }
 
-static void svm_load_eoi_exitmap(struct kvm_vcpu *vcpu)
+static void svm_load_eoi_exitmap(struct kvm_vcpu *vcpu, u64 *eoi_exit_bitmap)
 {
 	return;
 }
diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 8eeba6a..fccf39c 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -8179,9 +8179,8 @@ static void vmx_hwapic_irr_update(struct kvm_vcpu *vcpu, int max_irr)
 	}
 }
 
-static void vmx_load_eoi_exitmap(struct kvm_vcpu *vcpu)
+static void vmx_load_eoi_exitmap(struct kvm_vcpu *vcpu, u64 *eoi_exit_bitmap)
 {
-	u64 *eoi_exit_bitmap = vcpu->arch.eoi_exit_bitmap;
 	if (!vmx_cpu_uses_apicv(vcpu))
 		return;
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index bcbc9234..668a1c4 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -6198,13 +6198,15 @@ static void vcpu_scan_ioapic(struct kvm_vcpu *vcpu)
 	if (!kvm_apic_hw_enabled(vcpu->arch.apic))
 		return;
 
-	memset(vcpu->arch.eoi_exit_bitmap, 0, 256 / 8);
+	bitmap_zero(vcpu->arch.ioapic_handled_vectors, 256);
 
 	if (irqchip_split(vcpu->kvm))
-		kvm_scan_ioapic_routes(vcpu, vcpu->arch.eoi_exit_bitmap);
+		kvm_scan_ioapic_routes(vcpu, vcpu->arch.ioapic_handled_vectors);
 	else
-		kvm_ioapic_scan_entry(vcpu, vcpu->arch.eoi_exit_bitmap);
-	kvm_x86_ops->load_eoi_exitmap(vcpu);
+		kvm_ioapic_scan_entry(vcpu, vcpu->arch.ioapic_handled_vectors);
+
+	kvm_x86_ops->load_eoi_exitmap(vcpu,
+				      (u64 *)vcpu->arch.ioapic_handled_vectors);
 }
 
 static void kvm_vcpu_flush_tlb(struct kvm_vcpu *vcpu)
@@ -6310,7 +6312,7 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 		if (kvm_check_request(KVM_REQ_IOAPIC_EOI_EXIT, vcpu)) {
 			BUG_ON(vcpu->arch.pending_ioapic_eoi > 255);
 			if (test_bit(vcpu->arch.pending_ioapic_eoi,
-				     (void *) vcpu->arch.eoi_exit_bitmap)) {
+				     vcpu->arch.ioapic_handled_vectors)) {
 				vcpu->run->exit_reason = KVM_EXIT_IOAPIC_EOI;
 				vcpu->run->eoi.vector =
 						vcpu->arch.pending_ioapic_eoi;
-- 
2.1.4
