From: Zhu Lingshan <lingshan.zhu@intel.com>
Subject: [PATCH V3 6/6] irqbypass: do not start cons/prod when failed connect
Date: Wed, 22 Jul 2020 18:08:59 +0800
Message-ID: <20200722100859.221669-7-lingshan.zhu@intel.com>
References: <20200722100859.221669-1-lingshan.zhu@intel.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20200722100859.221669-1-lingshan.zhu@intel.com>
Sender: kvm-owner@vger.kernel.org
To: jasowang@redhat.com, alex.williamson@redhat.com, mst@redhat.com, pbonzini@redhat.com, sean.j.christopherson@intel.com, wanpengli@tencent.com
Cc: virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, kvm@vger.kernel.org, Zhu Lingshan <lingshan.zhu@intel.com>
List-Id: virtualization@lists.linuxfoundation.org

If failed to connect, there is no need to start consumer nor
producer.

Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
---
 virt/lib/irqbypass.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/virt/lib/irqbypass.c b/virt/lib/irqbypass.c
index 28fda42e471b..c9bb3957f58a 100644
--- a/virt/lib/irqbypass.c
+++ b/virt/lib/irqbypass.c
@@ -40,17 +40,21 @@ static int __connect(struct irq_bypass_producer *prod,
 	if (prod->add_consumer)
 		ret = prod->add_consumer(prod, cons);
 
-	if (!ret) {
-		ret = cons->add_producer(cons, prod);
-		if (ret && prod->del_consumer)
-			prod->del_consumer(prod, cons);
-	}
+	if (ret)
+		goto err_add_consumer;
+
+	ret = cons->add_producer(cons, prod);
+	if (ret)
+		goto err_add_producer;
 
 	if (cons->start)
 		cons->start(cons);
 	if (prod->start)
 		prod->start(prod);
-
+err_add_producer:
+	if (prod->del_consumer)
+		prod->del_consumer(prod, cons);
+err_add_consumer:
 	return ret;
 }
 
-- 
2.18.4
