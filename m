From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 4/7] vDPA: implement IRQ offloading helpers in vDPA core
Date: Mon, 13 Jul 2020 16:27:08 +0800
Message-ID: <6e8b267c-0734-1d9b-d3da-e2e6f44f7847@redhat.com>
References: <1594565366-3195-1-git-send-email-lingshan.zhu@intel.com>
 <1594565366-3195-4-git-send-email-lingshan.zhu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1594565366-3195-4-git-send-email-lingshan.zhu@intel.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
To: Zhu Lingshan <lingshan.zhu@intel.com>, mst@redhat.com, alex.williamson@redhat.com, pbonzini@redhat.com, sean.j.christopherson@intel.com, wanpengli@tencent.com
Cc: virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, netdev@vger.kernel.org, dan.daly@intel.com
List-Id: virtualization@lists.linuxfoundation.org


On 2020/7/12 下午10:49, Zhu Lingshan wrote:
> This commit implements IRQ offloading helpers in vDPA core by
> introducing two couple of functions:
>
> vdpa_alloc_vq_irq() and vdpa_free_vq_irq(): request irq and free
> irq, will setup irq offloading if irq_bypass is enabled.
>
> vdpa_setup_irq() and vdpa_unsetup_irq(): supportive functions,
> will call vhost_vdpa helpers.
>
> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>


This patch should go before patch 3.


> ---
>   drivers/vdpa/vdpa.c   | 46 ++++++++++++++++++++++++++++++++++++++++++++++
>   drivers/vhost/Kconfig |  1 +
>   drivers/vhost/vdpa.c  |  2 ++
>   include/linux/vdpa.h  | 11 +++++++++++
>   4 files changed, 60 insertions(+)
>
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index ff6562f..d8eba01 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -163,6 +163,52 @@ void vdpa_unregister_driver(struct vdpa_driver *drv)
>   }
>   EXPORT_SYMBOL_GPL(vdpa_unregister_driver);
>   
> +static void vdpa_setup_irq(struct vdpa_device *vdev, int qid, int irq)
> +{
> +	struct vdpa_driver *drv = drv_to_vdpa(vdev->dev.driver);
> +
> +#ifdef CONFIG_HAVE_KVM_IRQ_BYPASS


Let's don't do the check here. It's the responsibility of driver to 
decide what it should do.


> +	if (drv->setup_vq_irq)
> +		drv->setup_vq_irq(vdev, qid, irq);
> +#endif
> +}
> +
> +static void vdpa_unsetup_irq(struct vdpa_device *vdev, int qid)
> +{
> +	struct vdpa_driver *drv = drv_to_vdpa(vdev->dev.driver);
> +
> +#ifdef CONFIG_HAVE_KVM_IRQ_BYPASS
> +	if (drv->unsetup_vq_irq)
> +		drv->unsetup_vq_irq(vdev, qid);
> +#endif
> +}
> +
> +int vdpa_alloc_vq_irq(struct device *dev, struct vdpa_device *vdev,
> +		      unsigned int irq, irq_handler_t handler,
> +		      unsigned long irqflags, const char *devname, void *dev_id,
> +		      int qid)
> +{
> +	int ret;
> +
> +	ret = devm_request_irq(dev, irq, handler, irqflags, devname, dev_id);
> +	if (ret)
> +		dev_err(dev, "Failed to request irq for vq %d\n", qid);
> +	else
> +		vdpa_setup_irq(vdev, qid, irq);


I'd like to squash the vdpa_setup_irq logic here.


> +
> +	return ret;
> +
> +}
> +EXPORT_SYMBOL_GPL(vdpa_alloc_vq_irq);
> +
> +void vdpa_free_vq_irq(struct device *dev, struct vdpa_device *vdev, int irq,
> +			 int qid, void *dev_id)
> +{
> +	devm_free_irq(dev, irq, dev_id);
> +	vdpa_unsetup_irq(vdev, qid);
> +}
> +EXPORT_SYMBOL_GPL(vdpa_free_vq_irq);
> +
>   static int vdpa_init(void)
>   {
>   	return bus_register(&vdpa_bus);
> diff --git a/drivers/vhost/Kconfig b/drivers/vhost/Kconfig


Let squash the vhost patch into patch 3.


> index d3688c6..587fbae 100644
> --- a/drivers/vhost/Kconfig
> +++ b/drivers/vhost/Kconfig
> @@ -65,6 +65,7 @@ config VHOST_VDPA
>   	tristate "Vhost driver for vDPA-based backend"
>   	depends on EVENTFD
>   	select VHOST
> +	select IRQ_BYPASS_MANAGER
>   	depends on VDPA
>   	help
>   	  This kernel module can be loaded in host kernel to accelerate
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index 92683e4..6e25158 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -1020,6 +1020,8 @@ static void vhost_vdpa_remove(struct vdpa_device *vdpa)
>   	},
>   	.probe	= vhost_vdpa_probe,
>   	.remove	= vhost_vdpa_remove,
> +	.setup_vq_irq = vhost_vdpa_setup_vq_irq,
> +	.unsetup_vq_irq = vhost_vdpa_unsetup_vq_irq,
>   };
>   
>   static int __init vhost_vdpa_init(void)
> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> index 239db79..9f9b245 100644
> --- a/include/linux/vdpa.h
> +++ b/include/linux/vdpa.h
> @@ -220,17 +220,28 @@ struct vdpa_device *__vdpa_alloc_device(struct device *parent,
>   
>   int vdpa_register_device(struct vdpa_device *vdev);
>   void vdpa_unregister_device(struct vdpa_device *vdev);
> +int vdpa_alloc_vq_irq(struct device *dev, struct vdpa_device *vdev,
> +		      unsigned int irq, irq_handler_t handler,
> +		      unsigned long irqflags, const char *devname, void *dev_id,
> +		      int qid);
> +void vdpa_free_vq_irq(struct device *dev, struct vdpa_device *vdev, int irq,
> +		      int qid, void *dev_id);


You need to document the devres implications of those two helpers.


> +
>   
>   /**
>    * vdpa_driver - operations for a vDPA driver
>    * @driver: underlying device driver
>    * @probe: the function to call when a device is found.  Returns 0 or -errno.
>    * @remove: the function to call when a device is removed.
> + * @setup_vq_irq: setup irq bypass for a vhost_vdpa vq.
> + * @unsetup_vq_irq: unsetup irq bypass for a vhost_vdpa vq.


Though irq bypass is used by vhost-vdpa, it's not necessarily to be true 
in the future. So it's better not to mention irqbypass in the doc here.

Thanks


>    */
>   struct vdpa_driver {
>   	struct device_driver driver;
>   	int (*probe)(struct vdpa_device *vdev);
>   	void (*remove)(struct vdpa_device *vdev);
> +	void (*setup_vq_irq)(struct vdpa_device *vdev, int qid, int irq);
> +	void (*unsetup_vq_irq)(struct vdpa_device *vdev, int qid);
>   };
>   
>   #define vdpa_register_driver(drv) \
