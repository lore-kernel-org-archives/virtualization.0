From: Amit Shah <amit.shah@qumranet.com>
Subject: [PATCH 1/2] KVM: Expose get_eoi_gsi() for IRQ acking by PCI
	passthrough devices
Date: Thu, 10 Apr 2008 11:48:52 +0300
Message-ID: <1207817334-31775-2-git-send-email-amit.shah__32093.2837239981$1207817541$gmane$org@qumranet.com>
References: <1207817334-31775-1-git-send-email-amit.shah@qumranet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1207817334-31775-1-git-send-email-amit.shah@qumranet.com>
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
Cc: chrisw@redhat.com, allen.m.kay@intel.com, gcosta@redhat.com, virtualization@lists.linux-foundation.org, BENAMI@il.ibm.com
List-Id: virtualization@lists.linuxfoundation.org

Signed-off-by: Amit Shah <amit.shah@qumranet.com>
---
 virt/kvm/ioapic.c |    2 +-
 virt/kvm/ioapic.h |    1 +
 2 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/virt/kvm/ioapic.c b/virt/kvm/ioapic.c
index 4232fd7..c5e776a 100644
--- a/virt/kvm/ioapic.c
+++ b/virt/kvm/ioapic.c
@@ -268,7 +268,7 @@ void kvm_ioapic_set_irq(struct kvm_ioapic *ioapic, int irq, int level)
 	}
 }
 
-static int get_eoi_gsi(struct kvm_ioapic *ioapic, int vector)
+int get_eoi_gsi(struct kvm_ioapic *ioapic, int vector)
 {
 	int i;
 
diff --git a/virt/kvm/ioapic.h b/virt/kvm/ioapic.h
index 7f16675..d112a88 100644
--- a/virt/kvm/ioapic.h
+++ b/virt/kvm/ioapic.h
@@ -91,5 +91,6 @@ void kvm_ioapic_update_eoi(struct kvm *kvm, int vector);
 int kvm_ioapic_init(struct kvm *kvm);
 void kvm_ioapic_set_irq(struct kvm_ioapic *ioapic, int irq, int level);
 void kvm_ioapic_reset(struct kvm_ioapic *ioapic);
+int get_eoi_gsi(struct kvm_ioapic *ioapic, int vector);
 
 #endif
-- 
1.4.4.2
