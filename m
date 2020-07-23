From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V3 3/6] vDPA: implement vq IRQ allocate/free helpers in
 vDPA core
Date: Thu, 23 Jul 2020 12:19:42 +0800
Message-ID: <a3c05c65-74bf-6250-5f4a-3b6cf60f4474@redhat.com>
References: <20200722100859.221669-1-lingshan.zhu@intel.com>
 <20200722100859.221669-4-lingshan.zhu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20200722100859.221669-4-lingshan.zhu@intel.com>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: Zhu Lingshan <lingshan.zhu@intel.com>, alex.williamson@redhat.com, mst@redhat.com, pbonzini@redhat.com, sean.j.christopherson@intel.com, wanpengli@tencent.com
Cc: virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, kvm@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org


On 2020/7/22 下午6:08, Zhu Lingshan wrote:
> +/*
> + * Request irq for a vq, setup irq offloading if its a vhost_vdpa vq.
> + * This function should be only called through setting virtio DRIVER_OK.
> + * If you want to request irq during probe, you should use raw APIs
> + * like request_irq() or devm_request_irq().


This makes the API less flexibile. The reason is we store the irq in 
vhost-vdpa not vDPA.

I wonder whether the following looks better:

1) store irq in vdpa device
2) register producer when DRIVER_OK and unregister producer when 
!DRIVER_OK in vhost-vDPA
3) deal with the synchronization with SET_VRING_CALL
4) document that irq is not expected to be changed during DRIVER_OK

This can make sure the API works during driver probe, and we don't need 
the setup_irq and unsetup_irq method in vdpa_driver

Thanks


> + */
> +int vdpa_devm_request_irq(struct device *dev, struct vdpa_device *vdev,
> +			  unsigned int irq, irq_handler_t handler,
> +			  unsigned long irqflags, const char *devname, void *dev_id,
> +			  int qid)
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
> +EXPORT_SYMBOL_GPL(vdpa_devm_request_irq);
