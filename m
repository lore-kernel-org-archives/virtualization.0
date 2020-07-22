From: Zhu Lingshan <lingshan.zhu@intel.com>
Subject: [PATCH V3 2/6] kvm: detect assigned device via irqbypass manager
Date: Wed, 22 Jul 2020 18:08:55 +0800
Message-ID: <20200722100859.221669-3-lingshan.zhu@intel.com>
References: <20200722100859.221669-1-lingshan.zhu@intel.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20200722100859.221669-1-lingshan.zhu@intel.com>
Sender: netdev-owner@vger.kernel.org
To: jasowang@redhat.com, alex.williamson@redhat.com, mst@redhat.com, pbonzini@redhat.com, sean.j.christopherson@intel.com, wanpengli@tencent.com
Cc: virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, kvm@vger.kernel.org, Zhu Lingshan <lingshan.zhu@intel.com>
List-Id: virtualization@lists.linuxfoundation.org

vDPA devices has dedicated backed hardware like
passthrough-ed devices. Then it is possible to setup irq
offloading to vCPU for vDPA devices. Thus this patch tries to
manipulated assigned device counters by
kvm_arch_start/end_assignment() in irqbypass manager, so that
assigned devices could be detected in update_pi_irte()

We will increase/decrease the assigned device counter in kvm/x86.
Both vDPA and VFIO would go through this code path.

Only X86 uses these counters and kvm_arch_start/end_assignment(),
so this code path only affect x86 for now.

Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
---
 arch/x86/kvm/x86.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 88c593f83b28..b2bf17f808b6 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -10630,11 +10630,17 @@ int kvm_arch_irq_bypass_add_producer(struct irq_bypass_consumer *cons,
 {
 	struct kvm_kernel_irqfd *irqfd =
 		container_of(cons, struct kvm_kernel_irqfd, consumer);
+	int ret;
 
 	irqfd->producer = prod;
+	kvm_arch_start_assignment(irqfd->kvm);
+	ret = kvm_x86_ops.update_pi_irte(irqfd->kvm,
+					 prod->irq, irqfd->gsi, 1);
+
+	if (ret)
+		kvm_arch_end_assignment(irqfd->kvm);
 
-	return kvm_x86_ops.update_pi_irte(irqfd->kvm,
-					   prod->irq, irqfd->gsi, 1);
+	return ret;
 }
 
 void kvm_arch_irq_bypass_del_producer(struct irq_bypass_consumer *cons,
@@ -10645,6 +10651,7 @@ void kvm_arch_irq_bypass_del_producer(struct irq_bypass_consumer *cons,
 		container_of(cons, struct kvm_kernel_irqfd, consumer);
 
 	WARN_ON(irqfd->producer != prod);
+	kvm_arch_end_assignment(irqfd->kvm);
 	irqfd->producer = NULL;
 
 	/*
-- 
2.18.4
