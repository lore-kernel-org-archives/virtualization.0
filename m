From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: [RFC PATCH kvmtool 06/15] irq: register MSI doorbell addresses
Date: Fri,  7 Apr 2017 20:24:46 +0100
Message-ID: <20170407192455.26814-7-jean-philippe.brucker__31644.5889453918$1491593161$gmane$org@arm.com>
References: <20170407191747.26618-1-jean-philippe.brucker@arm.com>
	<20170407192455.26814-1-jean-philippe.brucker@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170407192455.26814-1-jean-philippe.brucker@arm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: iommu@lists.linux-foundation.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org
Cc: cdall@linaro.org, lorenzo.pieralisi@arm.com, mst@redhat.com, marc.zyngier@arm.com, joro@8bytes.org, will.deacon@arm.com, robin.murphy@arm.com
List-Id: virtualization@lists.linuxfoundation.org

For passed-through devices behind a vIOMMU, we'll need to translate writes
to MSI vectors. Let the IRQ code register MSI doorbells, and add a simple
way for other systems to check if an address is a doorbell.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 arm/gic.c         |  4 ++++
 include/kvm/irq.h |  3 +++
 irq.c             | 35 +++++++++++++++++++++++++++++++++++
 3 files changed, 42 insertions(+)

diff --git a/arm/gic.c b/arm/gic.c
index bf7a22a9..c708031e 100644
--- a/arm/gic.c
+++ b/arm/gic.c
@@ -108,6 +108,10 @@ static int gic__create_its_frame(struct kvm *kvm, u64 its_frame_addr)
 	};
 	int err;
 
+	err = irq__add_msi_doorbell(kvm, its_frame_addr, KVM_VGIC_V3_ITS_SIZE);
+	if (err)
+		return err;
+
 	err = ioctl(kvm->vm_fd, KVM_CREATE_DEVICE, &its_device);
 	if (err) {
 		fprintf(stderr,
diff --git a/include/kvm/irq.h b/include/kvm/irq.h
index a188a870..2a59257e 100644
--- a/include/kvm/irq.h
+++ b/include/kvm/irq.h
@@ -24,6 +24,9 @@ int irq__allocate_routing_entry(void);
 int irq__add_msix_route(struct kvm *kvm, struct msi_msg *msg, u32 device_id);
 void irq__update_msix_route(struct kvm *kvm, u32 gsi, struct msi_msg *msg);
 
+int irq__add_msi_doorbell(struct kvm *kvm, u64 addr, u64 size);
+bool irq__addr_is_msi_doorbell(struct kvm *kvm, u64 addr);
+
 /*
  * The function takes two eventfd arguments, trigger_fd and resample_fd. If
  * resample_fd is <= 0, resampling is disabled and the IRQ is edge-triggered
diff --git a/irq.c b/irq.c
index a4ef75e4..a04f4d37 100644
--- a/irq.c
+++ b/irq.c
@@ -8,6 +8,14 @@
 #include "kvm/irq.h"
 #include "kvm/kvm-arch.h"
 
+struct kvm_msi_doorbell_region {
+	u64			start;
+	u64			end;
+	struct list_head	head;
+};
+
+static LIST_HEAD(msi_doorbells);
+
 static u8 next_line = KVM_IRQ_OFFSET;
 static int allocated_gsis = 0;
 
@@ -147,6 +155,33 @@ void irq__update_msix_route(struct kvm *kvm, u32 gsi, struct msi_msg *msg)
 		die_perror("KVM_SET_GSI_ROUTING");
 }
 
+int irq__add_msi_doorbell(struct kvm *kvm, u64 addr, u64 size)
+{
+	struct kvm_msi_doorbell_region *doorbell = malloc(sizeof(*doorbell));
+
+	if (!doorbell)
+		return -ENOMEM;
+
+	doorbell->start = addr;
+	doorbell->end = addr + size - 1;
+
+	list_add(&doorbell->head, &msi_doorbells);
+
+	return 0;
+}
+
+bool irq__addr_is_msi_doorbell(struct kvm *kvm, u64 addr)
+{
+	struct kvm_msi_doorbell_region *doorbell;
+
+	list_for_each_entry(doorbell, &msi_doorbells, head) {
+		if (addr >= doorbell->start && addr <= doorbell->end)
+			return true;
+	}
+
+	return false;
+}
+
 int irq__common_add_irqfd(struct kvm *kvm, unsigned int gsi, int trigger_fd,
 			   int resample_fd)
 {
-- 
2.12.1
