From: "Denis V. Lunev" <den@openvz.org>
Subject: [PATCH 4/9] kvm/irqchip: allow only multiple irqchip routes per GSI
Date: Fri, 16 Oct 2015 10:07:48 +0300
Message-ID: <1444979273-6587-5-git-send-email-den__31746.881400659$1444979345$gmane$org@openvz.org>
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

Any other irq routing types (MSI, S390_ADAPTER, upcoming Hyper-V
SynIC) map one-to-one to GSI.

Signed-off-by: Andrey Smetanin <asmetanin@virtuozzo.com>
Reviewed-by: Roman Kagan <rkagan@virtuozzo.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Vitaly Kuznetsov <vkuznets@redhat.com>
CC: "K. Y. Srinivasan" <kys@microsoft.com>
CC: Gleb Natapov <gleb@kernel.org>
CC: Paolo Bonzini <pbonzini@redhat.com>
---
 virt/kvm/irqchip.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/virt/kvm/irqchip.c b/virt/kvm/irqchip.c
index 716a1c4..f0b08a2 100644
--- a/virt/kvm/irqchip.c
+++ b/virt/kvm/irqchip.c
@@ -144,11 +144,11 @@ static int setup_routing_entry(struct kvm_irq_routing_table *rt,
 
 	/*
 	 * Do not allow GSI to be mapped to the same irqchip more than once.
-	 * Allow only one to one mapping between GSI and MSI.
+	 * Allow only one to one mapping between GSI and non-irqchip routing.
 	 */
 	hlist_for_each_entry(ei, &rt->map[ue->gsi], link)
-		if (ei->type == KVM_IRQ_ROUTING_MSI ||
-		    ue->type == KVM_IRQ_ROUTING_MSI ||
+		if (ei->type != KVM_IRQ_ROUTING_IRQCHIP ||
+		    ue->type != KVM_IRQ_ROUTING_IRQCHIP ||
 		    ue->u.irqchip.irqchip == ei->irqchip.irqchip)
 			return r;
 
-- 
2.1.4
