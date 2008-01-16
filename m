From: Dor Laor <dor.laor@gmail.com>
Subject: Re: [PATCH] KVM virtio balloon driver
Date: Thu, 17 Jan 2008 01:12:46 +0200
Message-ID: <1200525166.26281.103.camel__13750.4101302058$1200525306$gmane$org@localhost.localdomain>
References: <20080114200357.GA18354@dmt>
	<200801151032.09495.rusty@rustcorp.com.au> <20080115190102.GA27645@dmt>
Reply-To: dor.laor@qumranet.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20080115190102.GA27645@dmt>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Marcelo Tosatti <marcelo@kvack.org>, kvm-devel <kvm-devel@lists.sourceforge.net>
Cc: Anthony Liguori <aliguori@us.ibm.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org


On Tue, 2008-01-15 at 17:01 -0200, Marcelo Tosatti wrote:

> OK, thats simpler. How about this:
> 

It's sure is simpler :)

> [PATCH] Virtio balloon driver
> 
> Add a balloon driver for KVM, host<->guest communication is performed
> via virtio.
> 
> Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

[snip]

> +static void free_page_array(struct balloon_buf *buf, unsigned int npages)
> +{
> +	struct page *page;
> +	u32 *pfn = (u32 *)&buf->data;
> +	int i;
> +
> +	for (i=0; i<npages; i++) { 
> +		page = pfn_to_page(*pfn);
> +		list_del_init(&page->lru);
> +		 __free_page(page);
> +		pfn++;

In add_page_array below you update baloon_size & totalram_pages,
it is need here too.

> +	}
> +}
> +
> +static void add_page_array(struct virtballoon *v, struct balloon_buf *buf,
> +			   unsigned int npages)
> +{
> +	struct page *page;
> +	u32 *pfn = (u32 *)&buf->data;
> +	int i;
> +
> +	for (i=0; i<npages; i++) {
> +		page = pfn_to_page(*pfn);
> +		v->balloon_size++;
> +		totalram_pages--;
> +		list_add(&page->lru, &v->balloon_plist);
> +		pfn++;
> +	}
> +}
> +
> +static void inflate_done(struct virtballoon *v, struct balloon_buf *buf,
> +			 unsigned int npages)
> +{
> +	u8 status = buf->hdr.status;
> +
> +	/* inflate OK */
> +	if (!status)
> +		add_page_array(v, buf, npages);
> +	else 
> +		free_page_array(buf, npages);
> +}
> +
> +static void deflate_done(struct virtballoon *v, struct balloon_buf *buf,
> +			 unsigned int npages)
> +{
> +	u8 status = buf->hdr.status;
> +
> +	/* deflate OK, return pages to the system */
> +	if (!status) {
> +		free_page_array(buf, npages);

If there are update above then no need below.

> +		totalram_pages += npages;
> +		v->balloon_size -= npages;
> +	}
> +	return;
> +}
> +

[snip]

> +static void balloon_config_changed(struct virtio_device *vdev)
> +{
> +	struct virtballoon *v = vdev->priv;
> +	u32 target_nrpages;
> +

A check should be added to see if rmmod_wait is active.
If it is then don't allow the monitor to inflate the balloon since
we like to remove the module.
Best regards,
Dor

> +	__virtio_config_val(v->vdev, 0, &target_nrpages);
> +	atomic_set(&v->target_nrpages, target_nrpages);
> +	wake_up(&v->balloon_wait);
> +	dprintk(&vdev->dev, "%s\n", __func__);
> +}
> +
> +static struct virtio_driver virtio_balloon = {
> +	.driver.name =  KBUILD_MODNAME,
> +	.driver.owner = THIS_MODULE,
> +	.id_table =     id_table,
> +	.probe =        balloon_probe,
> +	.remove =	__devexit_p(balloon_remove),
> +	.config_changed	= balloon_config_changed,
> +};
> +
> +module_param(kvm_balloon_debug, int, 0);
> +
> +static int __init kvm_balloon_init(void)
> +{
> +	return register_virtio_driver(&virtio_balloon);
> +}
> +
> +static void __exit kvm_balloon_exit(void)
> +{
> +	struct virtballoon *v;
> +	
> +	list_for_each_entry(v, &balloon_devices, list) { 
> +		while (v->balloon_size) {
> +			DEFINE_WAIT(wait);
> +
> +			atomic_add(v->balloon_size, &v->target_nrpages);
> +			wake_up(&v->balloon_wait);
> +			prepare_to_wait(&v->rmmod_wait, &wait,
> +					TASK_INTERRUPTIBLE);
> +			schedule_timeout(HZ*10);
> +			finish_wait(&v->rmmod_wait, &wait);
> +		}
> +	}
> +
> +	unregister_virtio_driver(&virtio_balloon);
> +}
> +
> +module_init(kvm_balloon_init);
> +module_exit(kvm_balloon_exit);
> Index: linux-2.6-nv/drivers/virtio/virtio_pci.c
> ===================================================================
> --- linux-2.6-nv.orig/drivers/virtio/virtio_pci.c
> +++ linux-2.6-nv/drivers/virtio/virtio_pci.c
> @@ -67,6 +67,7 @@ static struct pci_device_id virtio_pci_i
>  	{ 0x1AF4, 0x1000, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 }, /* Dummy entry */
>  	{ 0x1AF4, 0x1001, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 }, /* Dummy entry */
>  	{ 0x1AF4, 0x1002, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 }, /* Dummy entry */
> +	{ 0x1AF4, 0x1003, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 }, /* Balloon */
>  	{ 0 },
>  };
>  
> Index: linux-2.6-nv/include/linux/virtio_balloon.h
> ===================================================================
> --- /dev/null
> +++ linux-2.6-nv/include/linux/virtio_balloon.h
> @@ -0,0 +1,20 @@
> +#ifndef _LINUX_VIRTIO_BALLOON_H
> +#define _LINUX_VIRTIO_BALLOON_H
> +#include <linux/virtio_config.h>
> +
> +#define VIRTIO_ID_BALLOON 3
> +
> +#define CMD_BALLOON_INFLATE 0x1
> +#define CMD_BALLOON_DEFLATE 0x2
> +
> +struct virtio_balloon_hdr {
> +	__u8 cmd;
> +	__u8 status;
> +};
> +
> +struct virtio_balloon_config
> +{
> +	__u32 target_nrpages;
> +};
> +
> +#endif /* _LINUX_VIRTIO_BALLOON_H */
> _______________________________________________
> Virtualization mailing list
> Virtualization@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/virtualization
