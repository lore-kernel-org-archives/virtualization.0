From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V2 3/6] vDPA: implement IRQ offloading helpers in vDPA
 core
Date: Fri, 17 Jul 2020 12:19:30 +0800
Message-ID: <ab4644cc-9668-a909-4dea-5416aacf7221@redhat.com>
References: <1594898629-18790-1-git-send-email-lingshan.zhu@intel.com>
 <1594898629-18790-4-git-send-email-lingshan.zhu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1594898629-18790-4-git-send-email-lingshan.zhu@intel.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
To: Zhu Lingshan <lingshan.zhu@intel.com>, mst@redhat.com, alex.williamson@redhat.com, pbonzini@redhat.com, sean.j.christopherson@intel.com, wanpengli@tencent.com
Cc: virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, kvm@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org


On 2020/7/16 下午7:23, Zhu Lingshan wrote:
> This commit implements IRQ offloading helpers


Let's say "vq irq allocate/free helpers" here.


> in vDPA core by
> introducing two couple of functions:
>
> vdpa_alloc_vq_irq() and vdpa_free_vq_irq(): request irq and free
> irq, will setup irq offloading.
>
> vdpa_setup_irq() and vdpa_unsetup_irq(): supportive functions,
> will call vhost_vdpa helpers.
>
> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
> Suggested-by: Jason Wang <jasowang@redhat.com>
> ---
>   drivers/vdpa/vdpa.c  | 42 ++++++++++++++++++++++++++++++++++++++++++
>   include/linux/vdpa.h | 13 +++++++++++++
>   2 files changed, 55 insertions(+)
>
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index ff6562f..cce4d91 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -163,6 +163,48 @@ void vdpa_unregister_driver(struct vdpa_driver *drv)
>   }
>   EXPORT_SYMBOL_GPL(vdpa_unregister_driver);
>   
> +static void vdpa_setup_irq(struct vdpa_device *vdev, int qid, int irq)
> +{
> +	struct vdpa_driver *drv = drv_to_vdpa(vdev->dev.driver);
> +
> +	if (drv->setup_vq_irq)
> +		drv->setup_vq_irq(vdev, qid, irq);
> +}
> +
> +static void vdpa_unsetup_irq(struct vdpa_device *vdev, int qid)
> +{
> +	struct vdpa_driver *drv = drv_to_vdpa(vdev->dev.driver);
> +
> +	if (drv->unsetup_vq_irq)
> +		drv->unsetup_vq_irq(vdev, qid);


Do you need to check the existence of drv before calling unset_vq_irq()?

And how can this synchronize with driver releasing and binding?


> +}
> +
> +int vdpa_alloc_vq_irq(struct device *dev, struct vdpa_device *vdev,
> +		      unsigned int irq, irq_handler_t handler,
> +		      unsigned long irqflags, const char *devname, void *dev_id,
> +		      int qid)


Let's add comment as what has been done by other exported helpers.


> +{
> +	int ret;
> +
> +	ret = devm_request_irq(dev, irq, handler, irqflags, devname, dev_id);
> +	if (ret)
> +		dev_err(dev, "Failed to request irq for vq %d\n", qid);
> +	else
> +		vdpa_setup_irq(vdev, qid, irq);
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
> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> index 239db79..7d64d83 100644
> --- a/include/linux/vdpa.h
> +++ b/include/linux/vdpa.h
> @@ -220,17 +220,30 @@ struct vdpa_device *__vdpa_alloc_device(struct device *parent,
>   
>   int vdpa_register_device(struct vdpa_device *vdev);
>   void vdpa_unregister_device(struct vdpa_device *vdev);
> +/* request irq for a vq, setup irq offloading if its a vhost_vdpa vq */


Let's do the documentation in vdpa.c, and again, document the devres 
implications or j_xxxust name it as vdpa_devm_xxx.


> +int vdpa_alloc_vq_irq(struct device *dev, struct vdpa_device *vdev,
> +		      unsigned int irq, irq_handler_t handler,
> +		      unsigned long irqflags, const char *devname, void *dev_id,
> +		      int qid);
> +/* free irq for a vq, unsetup irq offloading if its a vhost_vdpa vq */
> +void vdpa_free_vq_irq(struct device *dev, struct vdpa_device *vdev, int irq,
> +		      int qid, void *dev_id);
> +
>   
>   /**
>    * vdpa_driver - operations for a vDPA driver
>    * @driver: underlying device driver
>    * @probe: the function to call when a device is found.  Returns 0 or -errno.
>    * @remove: the function to call when a device is removed.
> + * @setup_vq_irq: setup irq offloading for a vhost_vdpa vq.
> + * @unsetup_vq_irq: unsetup offloading for a vhost_vdpa vq.


Let's not limit the methods for a specific use case like irq offloading 
here.


>    */
>   struct vdpa_driver {
>   	struct device_driver driver;
>   	int (*probe)(struct vdpa_device *vdev);
>   	void (*remove)(struct vdpa_device *vdev);
> +	void (*setup_vq_irq)(struct vdpa_device *vdev, int qid, int irq);
> +	void (*unsetup_vq_irq)(struct vdpa_device *vdev, int qid);


To be consistent with the exported helper, let's use 
alloc_vq_irq/free_vq_irq

Thanks


>   };
>   
>   #define vdpa_register_driver(drv) \
