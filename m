From: Anthony Liguori <aliguori-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 1/3] Export vring functions for modules to use
Date: Wed,  7 Nov 2007 20:46:30 -0600
Message-ID: <11944900141678-git-send-email-aliguori@us.ibm.com>
References: <11944899922822-git-send-email-aliguori@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kvm-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <11944899922822-git-send-email-aliguori-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/kvm-devel>,
	<mailto:kvm-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=kvm-devel>
List-Post: <mailto:kvm-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:kvm-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/kvm-devel>,
	<mailto:kvm-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: kvm-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: kvm-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Rusty Russell <rusty-PBSTF//UHa40n/F98K4Iww@public.gmane.org>, virtualization-qjLDD68F18O7TbgM5vRIOg@public.gmane.org, Anthony Liguori <aliguori-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>, kvm-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: virtualization@lists.linuxfoundation.org

This is needed for the virtio PCI device to be compiled as a module.

Signed-off-by: Anthony Liguori <aliguori-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 0e1bf05..3f28b47 100644
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
@@ -306,8 +308,12 @@ struct virtqueue *vring_new_virtqueue(unsigned int num,
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

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
