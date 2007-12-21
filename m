From: Dor Laor <dor.laor@gmail.com>
Subject: [kvm-devel] [Virtio-for-kvm] [PATCH 3/13] [Mostly resend] virtio
 additions
Date: Fri, 21 Dec 2007 17:17:50 +0200
Message-ID: <476BD91E.10605__39774.7529707432$1198250407$gmane$org@qumranet.com>
Reply-To: dor.laor@qumranet.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: kvm-devel <kvm-devel@lists.sourceforge.net>, virtualization <virtualization@lists.linux-foundation.org>, Rusty Russell <rusty@rustcorp.com.au>Anthony Liguori <a>
List-Id: virtualization@lists.linuxfoundation.org

 From 09d2dcb6b517e7e4cbbdfc960e3171105085ec9e Mon Sep 17 00:00:00 2001
From: Anthony Liguori <aliguori@us.ibm.com>
Date: Wed, 7 Nov 2007 20:46:30 -0600
Subject: [PATCH] virtio: Export vring functions for modules to use

This is needed for the virtio PCI device to be compiled as a module.

Signed-off-by: Anthony Liguori <aliguori@us.ibm.com>
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 drivers/virtio/virtio_ring.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 1dc04b6..f9dc079 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -260,6 +260,8 @@ irqreturn_t vring_interrupt(int irq, void *_vq)
     return IRQ_HANDLED;
 }
 
+EXPORT_SYMBOL_GPL(vring_interrupt);
+
 static struct virtqueue_ops vring_vq_ops = {
     .add_buf = vring_add_buf,
     .get_buf = vring_get_buf,
@@ -312,8 +314,12 @@ struct virtqueue *vring_new_virtqueue(unsigned int num,
     return &vq->vq;
 }
 
+EXPORT_SYMBOL_GPL(vring_new_virtqueue);
+
 void vring_del_virtqueue(struct virtqueue *vq)
 {
     kfree(to_vvq(vq));
 }
 
+EXPORT_SYMBOL_GPL(vring_del_virtqueue);
+
-- 
1.5.3.3
