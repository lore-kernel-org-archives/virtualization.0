From: =?UTF-8?Q?Mika_Penttil=c3=a4?= <mika.penttila@nextfour.com>
Subject: Re: [PATCH 4/6] vhost_vdpa: support doorbell mapping via mmap
Date: Fri, 29 May 2020 12:16:02 +0300
Message-ID: <bab90a3f-f0b3-37d3-89bc-cd17d33f3208@nextfour.com>
References: <20200529080303.15449-1-jasowang@redhat.com>
 <20200529080303.15449-5-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200529080303.15449-5-jasowang@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jason Wang <jasowang@redhat.com>, mst@redhat.com
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, rob.miller@broadcom.com, lingshan.zhu@intel.com, eperezma@redhat.com, lulu@redhat.com, shahafs@mellanox.com, hanand@xilinx.com, mhabets@solarflare.com, gdawar@xilinx.com, saugatm@xilinx.com, vmireyno@marvell.com, zhangweining@ruijie.com.cn, eli@mellanox.com
List-Id: virtualization@lists.linuxfoundation.org

Hi,

On 29.5.2020 11.03, Jason Wang wrote:
> Currently the doorbell is relayed via eventfd which may have
> significant overhead because of the cost of vmexits or syscall. This
> patch introduces mmap() based doorbell mapping which can eliminate the
> overhead caused by vmexit or syscall.

Just wondering. I know very little about vdpa. But how is such a "sw 
doorbell" monitored or observed, if no fault or wmexit etc.
Is there some kind of polling used?

> To ease the userspace modeling of the doorbell layout (usually
> virtio-pci), this patch starts from a doorbell per page
> model. Vhost-vdpa only support the hardware doorbell that sit at the
> boundary of a page and does not share the page with other registers.
>
> Doorbell of each virtqueue must be mapped separately, pgoff is the
> index of the virtqueue. This allows userspace to map a subset of the
> doorbell which may be useful for the implementation of software
> assisted virtqueue (control vq) in the future.
>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>   drivers/vhost/vdpa.c | 59 ++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 59 insertions(+)
>
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index 6ff72289f488..bbe23cea139a 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -15,6 +15,7 @@
>   #include <linux/module.h>
>   #include <linux/cdev.h>
>   #include <linux/device.h>
> +#include <linux/mm.h>
>   #include <linux/iommu.h>
>   #include <linux/uuid.h>
>   #include <linux/vdpa.h>
> @@ -741,12 +742,70 @@ static int vhost_vdpa_release(struct inode *inode, struct file *filep)
>   	return 0;
>   }
>   
> +static vm_fault_t vhost_vdpa_fault(struct vm_fault *vmf)
> +{
> +	struct vhost_vdpa *v = vmf->vma->vm_file->private_data;
> +	struct vdpa_device *vdpa = v->vdpa;
> +	const struct vdpa_config_ops *ops = vdpa->config;
> +	struct vdpa_notification_area notify;
> +	struct vm_area_struct *vma = vmf->vma;
> +	u16 index = vma->vm_pgoff;
> +
> +	notify = ops->get_vq_notification(vdpa, index);
> +
> +	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
> +	if (remap_pfn_range(vma, vmf->address & PAGE_MASK,
> +			    notify.addr >> PAGE_SHIFT, PAGE_SIZE,
> +			    vma->vm_page_prot))
> +		return VM_FAULT_SIGBUS;
> +
> +	return VM_FAULT_NOPAGE;
> +}
> +
> +static const struct vm_operations_struct vhost_vdpa_vm_ops = {
> +	.fault = vhost_vdpa_fault,
> +};
> +
> +static int vhost_vdpa_mmap(struct file *file, struct vm_area_struct *vma)
> +{
> +	struct vhost_vdpa *v = vma->vm_file->private_data;
> +	struct vdpa_device *vdpa = v->vdpa;
> +	const struct vdpa_config_ops *ops = vdpa->config;
> +	struct vdpa_notification_area notify;
> +	int index = vma->vm_pgoff;
> +
> +	if (vma->vm_end - vma->vm_start != PAGE_SIZE)
> +		return -EINVAL;
> +	if ((vma->vm_flags & VM_SHARED) == 0)
> +		return -EINVAL;
> +	if (vma->vm_flags & VM_READ)
> +		return -EINVAL;
> +	if (index > 65535)
> +		return -EINVAL;
> +	if (!ops->get_vq_notification)
> +		return -ENOTSUPP;
> +
> +	/* To be safe and easily modelled by userspace, We only
> +	 * support the doorbell which sits on the page boundary and
> +	 * does not share the page with other registers.
> +	 */
> +	notify = ops->get_vq_notification(vdpa, index);
> +	if (notify.addr & (PAGE_SIZE - 1))
> +		return -EINVAL;
> +	if (vma->vm_end - vma->vm_start != notify.size)
> +		return -ENOTSUPP;
> +
> +	vma->vm_ops = &vhost_vdpa_vm_ops;
> +	return 0;
> +}
> +
>   static const struct file_operations vhost_vdpa_fops = {
>   	.owner		= THIS_MODULE,
>   	.open		= vhost_vdpa_open,
>   	.release	= vhost_vdpa_release,
>   	.write_iter	= vhost_vdpa_chr_write_iter,
>   	.unlocked_ioctl	= vhost_vdpa_unlocked_ioctl,
> +	.mmap		= vhost_vdpa_mmap,
>   	.compat_ioctl	= compat_ptr_ioctl,
>   };
>   
