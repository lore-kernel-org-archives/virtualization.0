From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH 2/3] Virtio draft IV: the block driver
Date: Mon, 23 Jul 2007 13:13:11 +0200
Message-ID: <200707231313.11847.borntraeger@de.ibm.com>
References: <1183522348.6110.37.camel@localhost.localdomain>
	<1183522765.6110.40.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1183522765.6110.40.camel@localhost.localdomain>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

> +#ifdef __KERNEL__
> +struct gendisk;
> +struct virtio_device;
> +
> +struct gendisk *virtblk_probe(struct virtqueue *vq);

Hello Rusty,

I am currently do some prototyping with virtio IV and found tis small issue in 
the block device. virtblk_probe requires a declaration of virtqueue, not 
virtio_device. 

---
 include/linux/virtio_blk.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.22/include/linux/virtio_blk.h
===================================================================
--- linux-2.6.22.orig/include/linux/virtio_blk.h
+++ linux-2.6.22/include/linux/virtio_blk.h
@@ -37,7 +37,7 @@ struct virtio_blk_inhdr
 
 #ifdef __KERNEL__
 struct gendisk;
-struct virtio_device;
+struct virtqueue;
 
 struct gendisk *virtblk_probe(struct virtqueue *vq);
 void virtblk_remove(struct gendisk *disk);
