From: Anthony Liguori <anthony@codemonkey.ws>
Subject: Re: [kvm-devel] [PATCH] KVM simplified virtio balloon driver
Date: Wed, 16 Jan 2008 20:14:58 -0600
Message-ID: <478EBA22.30301__8295.04599464617$1200536215$gmane$org@codemonkey.ws>
References: <20080114200357.GA18354@dmt>
	<20080115190102.GA27645@dmt>	<1200525166.26281.103.camel@localhost.localdomain>
	<200801171245.59510.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200801171245.59510.rusty@rustcorp.com.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Marcelo Tosatti <marcelo@kvack.org>, kvm-devel <kvm-devel@lists.sourceforge.net>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Rusty Russell wrote:
> After discussions with Anthony Liguori, it seems that the virtio
> balloon can be made even simpler.  Here's my attempt.
>
> Since the balloon requires Guest cooperation anyway, there seems
> little reason to force it to tell the Host when it wants to reuse a
> page.  It can simply fault it in.
>
> Moreover, the target is best expressed in balloon size, since there is
> no portable way of getting the total RAM in the system.  The host can
> do the math.
>
> Tested with a (fairly hacky) lguest patch.
>
> Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
> ---
>  drivers/virtio/Kconfig          |   10 +
>  drivers/virtio/Makefile         |    1
>  drivers/virtio/virtio_balloon.c |  230 ++++++++++++++++++++++++++++++++++++++++
>  include/linux/virtio_balloon.h  |   13 ++
>  4 files changed, 254 insertions(+)
>
> diff -r c4762959de25 drivers/virtio/Kconfig
> --- a/drivers/virtio/Kconfig	Thu Jan 17 10:31:37 2008 +1100
> +++ b/drivers/virtio/Kconfig	Thu Jan 17 12:28:23 2008 +1100
> @@ -23,3 +23,13 @@ config VIRTIO_PCI
>  
>  	  If unsure, say M.
>  
> +config VIRTIO_BALLOON
> +	tristate "Virtio balloon driver (EXPERIMENTAL)"
> +	select VIRTIO
> +	select VIRTIO_RING
> +	---help---
> +	 This driver supports increasing and decreasing the amount 
> +	 of memory within a KVM guest.
> +
> +	 If unsure, say M.
> +
> diff -r c4762959de25 drivers/virtio/Makefile
> --- a/drivers/virtio/Makefile	Thu Jan 17 10:31:37 2008 +1100
> +++ b/drivers/virtio/Makefile	Thu Jan 17 12:28:23 2008 +1100
> @@ -1,3 +1,4 @@ obj-$(CONFIG_VIRTIO) += virtio.o
>  obj-$(CONFIG_VIRTIO) += virtio.o
>  obj-$(CONFIG_VIRTIO_RING) += virtio_ring.o
>  obj-$(CONFIG_VIRTIO_PCI) += virtio_pci.o
> +obj-$(CONFIG_VIRTIO_BALLOON) += virtio_balloon.o
> diff -r c4762959de25 drivers/virtio/virtio_balloon.c
> --- /dev/null	Thu Jan 01 00:00:00 1970 +0000
> +++ b/drivers/virtio/virtio_balloon.c	Thu Jan 17 12:28:23 2008 +1100
> @@ -0,0 +1,235 @@
> +/* Virtio balloon implementation, inspired by Dor Loar and Marcelo
> + * Tosatti's implementations.
> + *
> + *  Copyright 2008 Rusty Russell IBM Corporation
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License as published by
> + *  the Free Software Foundation; either version 2 of the License, or
> + *  (at your option) any later version.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License
> + *  along with this program; if not, write to the Free Software
> + *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> + */
> +#define DEBUG
> +#include <linux/virtio.h>
> +#include <linux/virtio_balloon.h>
> +#include <linux/swap.h>
> +#include <linux/kthread.h>
> +#include <linux/freezer.h>
> +
> +struct virtio_balloon
> +{
> +	struct virtio_device *vdev;
> +	struct virtqueue *vq;
> +
> +	/* Where the ballooning thread waits for config to change. */
> +	wait_queue_head_t config_change;
> +
> +	/* The thread servicing the balloon. */
> +	struct task_struct *thread;
> +
> +	/* Waiting for host to ack the pages we released. */
> +	struct completion acked;
> +
> +	/* The pages we've told the Host we're not using. */
> +	unsigned int num_pages;
> +	struct list_head pages;
> +
> +	/* The array of pfns we tell the Host about. */
> +	unsigned int num_pfns;
> +	u32 pfns[256];
> +};
> +
> +static struct virtio_device_id id_table[] = {
> +	{ VIRTIO_ID_BALLOON, VIRTIO_DEV_ANY_ID},
>   

Could use a space after VIRTIO_DEV_ANY_ID

> +	{ 0 },
> +};
> +
> +static void leak_balloon(struct virtio_balloon *vb, unsigned int num)
> +{
> +	struct page *page;
> +	unsigned int i;
> +
> +	/* Simply free pages, and usage will fault them back in. */
> +	for (i = 0; i < num; i++) {
> +		page = list_first_entry(&vb->pages, struct page, lru);
> +		list_del(&page->lru);
> +		__free_page(page);
> +		vb->num_pages--;
> +		totalram_pages++;
>   

Do we really want to modify totalram_pages in this driver?  The only 
other place that I see that modifies it is in mm/memory_hotplug and it 
also modifies other things (like num_physpages).  The cmm driver doesn't 
touch totalram_pages.

It would be very useful too to write vb->num_pages into the config space 
whenever it was updated.  This way, the host can easily keep track of 
where the guest is at in terms of ballooning.

Regards,

Anthony Liguori

> +	}
> +}
> +
> +static void balloon_ack(struct virtqueue *vq)
> +{
> +	struct virtio_balloon *vb;
> +	unsigned int len;
> +
> +	vb = vq->vq_ops->get_buf(vq, &len);
> +	if (vb)
> +		complete(&vb->acked);
> +}
> +
> +static void fill_balloon(struct virtio_balloon *vb, unsigned int num)
> +{
> +	struct scatterlist sg;
> +
> +	/* We can only do one array worth at a time. */
> +	num = min(num, ARRAY_SIZE(vb->pfns));
> +
> +	for (vb->num_pfns = 0; vb->num_pfns < num; vb->num_pfns++) {
> +		struct page *page = alloc_page(GFP_HIGHUSER | __GFP_NORETRY);
> +		if (!page) {
> +			if (printk_ratelimit())
> +				dev_printk(KERN_INFO, &vb->vdev->dev,
> +					   "Out of puff! Can't get %u pages\n",
> +					   num);
> +			/* Sleep for at least 1/5 of a second before retry. */
> +			msleep(200);
> +			break;
> +		}
> +		vb->pfns[vb->num_pfns] = page_to_pfn(page);
> +		totalram_pages--;
> +		vb->num_pages++;
> +		list_add(&page->lru, &vb->pages);
> +	}
> +
> +	/* Didn't get any?  Oh well. */
> +	if (vb->num_pfns == 0)
> +		return;
> +	
> +	init_completion(&vb->acked);
> +	sg_init_one(&sg, vb->pfns, sizeof(vb->pfns[0]) * vb->num_pfns);
> +
> +	/* We should always be able to add one buffer to an empty queue. */
> +	if (vb->vq->vq_ops->add_buf(vb->vq, &sg, 1, 0, vb) != 0)
> +		BUG();
> +	vb->vq->vq_ops->kick(vb->vq);
> +
> +	/* When host has read buffer, this completes via balloon_ack */
> +	wait_for_completion(&vb->acked);
> +}
> +
> +static void virtballoon_changed(struct virtio_device *vdev)
> +{
> +	struct virtio_balloon *vb = vdev->priv;
> +
> +	wake_up(&vb->config_change);
> +}
> +
> +static inline int towards_target(struct virtio_balloon *vb)
> +{
> +	u32 v;
> +	__virtio_config_val(vb->vdev,
> +			    offsetof(struct virtio_balloon_config, num_pages),
> +			    &v);
> +	return v - vb->num_pages;
> +}
> +
> +static int balloon(void *_vballoon)
> +{
> +	struct virtio_balloon *vb = _vballoon;
> +
> +	set_freezable();
> +	while (!kthread_should_stop()) {
> +		int diff;
> +
> +		try_to_freeze();
> +		wait_event_interruptible(vb->config_change,
> +					 (diff = towards_target(vb)) != 0
> +					 || kthread_should_stop());
> +		if (diff > 0)
> +			fill_balloon(vb, diff);
> +		else if (diff < 0)
> +			leak_balloon(vb, -diff);
> +	}
> +	return 0;
> +}
> +
> +static int virtballoon_probe(struct virtio_device *vdev)
> +{
> +	struct virtio_balloon *vb;
> +	int err;
> +
> +	vdev->priv = vb = kmalloc(sizeof(*vb), GFP_KERNEL);
> +	if (!vb) {
> +		err = -ENOMEM;
> +		goto out;
> +	}
> +
> +	INIT_LIST_HEAD(&vb->pages);
> +	vb->num_pages = 0;
> +	init_waitqueue_head(&vb->config_change);
> +	vb->vdev = vdev;
> +
> +	/* We expect one virtqueue, for output. */
> +	vb->vq = vdev->config->find_vq(vdev, 0, balloon_ack);
> +	if (IS_ERR(vb->vq)) {
> +		err = PTR_ERR(vb->vq);
> +		goto out_free_vb;
> +	}
> +
> +	vb->thread = kthread_run(balloon, vb, "vballoon");
> +	if (IS_ERR(vb->thread)) {
> +		err = PTR_ERR(vb->thread);
> +		goto out_del_vq;
> +	}
> +	return 0;
> +
> +out_del_vq:
> +	vdev->config->del_vq(vb->vq);
> +out_free_vb:
> +	kfree(vb);
> +out:
> +	return err;
> +}
> +
> +static void virtballoon_remove(struct virtio_device *vdev)
> +{
> +	struct virtio_balloon *vb = vdev->priv;
> +	struct page *i, *next;
> +
> +	kthread_stop(vb->thread);
> +
> +	/* There might be pages left in the balloon: free them. */
> +	list_for_each_entry_safe(i, next, &vb->pages, lru) {
> +		vb->num_pages--;
> +		__free_page(i);
> +	}
> +	BUG_ON(vb->num_pages);
> +
> +	vdev->config->del_vq(vb->vq);
> +	kfree(vb);
> +}
> +
> +static struct virtio_driver virtio_balloon = {
> +	.driver.name =	KBUILD_MODNAME,
> +	.driver.owner =	THIS_MODULE,
> +	.id_table =	id_table,
> +	.probe =	virtballoon_probe,
> +	.remove =	__devexit_p(virtballoon_remove),
> +	.config_changed = virtballoon_changed,
> +};
> +
> +static int __init init(void)
> +{
> +	return register_virtio_driver(&virtio_balloon);
> +}
> +
> +static void __exit fini(void)
> +{
> +	unregister_virtio_driver(&virtio_balloon);
> +}
> +module_init(init);
> +module_exit(fini);
> +
> +MODULE_DEVICE_TABLE(virtio, id_table);
> +MODULE_DESCRIPTION("Virtio balloon driver");
> +MODULE_LICENSE("GPL");
> diff -r c4762959de25 include/linux/virtio_balloon.h
> --- /dev/null	Thu Jan 01 00:00:00 1970 +0000
> +++ b/include/linux/virtio_balloon.h	Thu Jan 17 12:28:23 2008 +1100
> @@ -0,0 +1,13 @@
> +#ifndef _LINUX_VIRTIO_BALLOON_H
> +#define _LINUX_VIRTIO_BALLOON_H
> +#include <linux/virtio_config.h>
> +
> +/* The ID for virtio_balloon */
> +#define VIRTIO_ID_BALLOON	5
> +
> +struct virtio_balloon_config
> +{
> +	/* Number of pages host wants Guest to give up. */
> +	__le32 num_pages;
> +};
> +#endif /* _LINUX_VIRTIO_BALLOON_H */
>
> -------------------------------------------------------------------------
> This SF.net email is sponsored by: Microsoft
> Defy all challenges. Microsoft(R) Visual Studio 2008.
> http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
> _______________________________________________
> kvm-devel mailing list
> kvm-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/kvm-devel
>   
