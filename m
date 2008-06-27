From: Amit Shah <amit.shah@qumranet.com>
Subject: [PATCH 2/4] KVM: Introduce a callback routine for IOAPIC ack handling
Date: Fri, 27 Jun 2008 15:55:03 +0300
Message-ID: <1214571305-20701-3-git-send-email-amit.shah@qumranet.com>
References: <1214571305-20701-1-git-send-email-amit.shah@qumranet.com>
 <1214571305-20701-2-git-send-email-amit.shah@qumranet.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1214571305-20701-2-git-send-email-amit.shah@qumranet.com>
Sender: kvm-owner@vger.kernel.org
To: kvm@vger.kernel.org
Cc: muli@il.ibm.com, benami@il.ibm.com, allen.m.kay@intel.com, chrisw@redhat.com, weidong.han@intel.com, avi@qumranet.com, virtualization@lists.osdl.org, Amit Shah <amit.shah@qumranet.com>
List-Id: virtualization@lists.linuxfoundation.org

This will be useful for acking irqs of assigned devices

Signed-off-by: Amit Shah <amit.shah@qumranet.com>
---
 virt/kvm/ioapic.c |    3 +++
 virt/kvm/ioapic.h |    1 +
 2 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/virt/kvm/ioapic.c b/virt/kvm/ioapic.c
index 9d02136..6d99a35 100644
--- a/virt/kvm/ioapic.c
+++ b/virt/kvm/ioapic.c
@@ -295,6 +295,9 @@ static void __kvm_ioapic_update_eoi(struct kvm_ioapic *ioapic, int gsi)
 	ent->fields.remote_irr = 0;
 	if (!ent->fields.mask && (ioapic->irr & (1 << gsi)))
 		ioapic_deliver(ioapic, gsi);
+
+	if (ioapic->ack_notifier)
+		ioapic->ack_notifier(ioapic->kvm, gsi);
 }
 
 void kvm_ioapic_update_eoi(struct kvm *kvm, int vector)
diff --git a/virt/kvm/ioapic.h b/virt/kvm/ioapic.h
index 7f16675..a42743f 100644
--- a/virt/kvm/ioapic.h
+++ b/virt/kvm/ioapic.h
@@ -58,6 +58,7 @@ struct kvm_ioapic {
 	} redirtbl[IOAPIC_NUM_PINS];
 	struct kvm_io_device dev;
 	struct kvm *kvm;
+	void (*ack_notifier)(void *opaque, int irq);
 };
 
 #ifdef DEBUG
-- 
1.5.4.3

