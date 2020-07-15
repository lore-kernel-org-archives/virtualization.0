From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 3/7] vhost_vdpa: implement IRQ offloading functions in
 vhost_vdpa
Date: Wed, 15 Jul 2020 16:51:46 +0800
Message-ID: <f352a1d1-6732-3237-c85e-ffca085195ff@redhat.com>
References: <1594565366-3195-1-git-send-email-lingshan.zhu@intel.com>
 <1594565366-3195-3-git-send-email-lingshan.zhu@intel.com>
 <3fb9ecfc-a325-69b5-f5b7-476a5683a324@redhat.com>
 <e06f9706-441f-0d7a-c8c0-cd43a26c5296@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <e06f9706-441f-0d7a-c8c0-cd43a26c5296@intel.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>, mst@redhat.com, alex.williamson@redhat.com, pbonzini@redhat.com, sean.j.christopherson@intel.com, wanpengli@tencent.com
Cc: virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, netdev@vger.kernel.org, dan.daly@intel.com
List-Id: virtualization@lists.linuxfoundation.org


On 2020/7/13 下午5:47, Zhu, Lingshan wrote:
>
>
> On 7/13/2020 4:22 PM, Jason Wang wrote:
>>
>> On 2020/7/12 下午10:49, Zhu Lingshan wrote:
>>> This patch introduce a set of functions for setup/unsetup
>>> and update irq offloading respectively by register/unregister
>>> and re-register the irq_bypass_producer.
>>>
>>> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
>>> ---
>>>   drivers/vhost/vdpa.c | 69 
>>> ++++++++++++++++++++++++++++++++++++++++++++++++++++
>>>   1 file changed, 69 insertions(+)
>>>
>>> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
>>> index 2fcc422..92683e4 100644
>>> --- a/drivers/vhost/vdpa.c
>>> +++ b/drivers/vhost/vdpa.c
>>> @@ -115,6 +115,63 @@ static irqreturn_t vhost_vdpa_config_cb(void 
>>> *private)
>>>       return IRQ_HANDLED;
>>>   }
>>>   +static void vhost_vdpa_setup_vq_irq(struct vdpa_device *dev, int 
>>> qid, int irq)
>>> +{
>>> +    struct vhost_vdpa *v = vdpa_get_drvdata(dev);
>>> +    struct vhost_virtqueue *vq = &v->vqs[qid];
>>> +    int ret;
>>> +
>>> +    vq_err(vq, "setup irq bypass for vq %d with irq = %d\n", qid, 
>>> irq);
>>> +    spin_lock(&vq->call_ctx.ctx_lock);
>>> +    if (!vq->call_ctx.ctx)
>>> +        return;
>>> +
>>> +    vq->call_ctx.producer.token = vq->call_ctx.ctx;
>>> +    vq->call_ctx.producer.irq = irq;
>>> +    ret = irq_bypass_register_producer(&vq->call_ctx.producer);
>>> +    spin_unlock(&vq->call_ctx.ctx_lock);
>>> +
>>> +    if (unlikely(ret))
>>> +        vq_err(vq,
>>> +        "irq bypass producer (token %p registration fails: %d\n",
>>> +        vq->call_ctx.producer.token, ret);
>>
>>
>> Not sure this deserves a vq_err(), irq will be relayed through 
>> eventfd if irq bypass manager can't work.
> OK, I see vq_err() will eventfd_signal err_ctx than just print a 
> message, will remove all vq_err().
>>
>>
>>> +}
>>> +
>>> +static void vhost_vdpa_unsetup_vq_irq(struct vdpa_device *dev, int 
>>> qid)
>>> +{
>>> +    struct vhost_vdpa *v = vdpa_get_drvdata(dev);
>>> +    struct vhost_virtqueue *vq = &v->vqs[qid];
>>> +
>>> +    spin_lock(&vq->call_ctx.ctx_lock);
>>> + irq_bypass_unregister_producer(&vq->call_ctx.producer);
>>> +    spin_unlock(&vq->call_ctx.ctx_lock);
>>> +
>>> +    vq_err(vq, "unsetup irq bypass for vq %d\n", qid);
>>
>>
>> Why call vq_err() here?
>>
>>
>>> +}
>>> +
>>> +static void vhost_vdpa_update_vq_irq(struct vhost_virtqueue *vq)
>>> +{
>>> +    struct eventfd_ctx *ctx;
>>> +    void *token;
>>> +
>>> +    spin_lock(&vq->call_ctx.ctx_lock);
>>> +    ctx = vq->call_ctx.ctx;
>>> +    token = vq->call_ctx.producer.token;
>>> +    if (ctx == token)
>>> +        return;
>>
>>
>> Need do unlock here.
> sure!
>>
>>
>>> +
>>> +    if (!ctx && token)
>>> + irq_bypass_unregister_producer(&vq->call_ctx.producer);
>>> +
>>> +    if (ctx && ctx != token) {
>>> + irq_bypass_unregister_producer(&vq->call_ctx.producer);
>>> +        vq->call_ctx.producer.token = ctx;
>>> + irq_bypass_register_producer(&vq->call_ctx.producer);
>>> +    }
>>> +
>>> +    spin_unlock(&vq->call_ctx.ctx_lock);
>>
>>
>> This should be rare so I'd use simple codes just do unregister and 
>> register.
>
> do you mean remove "if (ctx && ctx != token)"? I think this could be 
> useful, we should only update it when ctx!=NULL and ctx!= existing token.
>

I meant something like:

unregister();
vq->call_ctx.producer.token = ctx;
register();


>>
>>
>>> +}
>>> +
>>>   static void vhost_vdpa_reset(struct vhost_vdpa *v)
>>>   {
>>>       struct vdpa_device *vdpa = v->vdpa;
>>> @@ -332,6 +389,7 @@ static long vhost_vdpa_set_config_call(struct 
>>> vhost_vdpa *v, u32 __user *argp)
>>>         return 0;
>>>   }
>>> +
>>
>>
>> Unnecessary change.
> this new blank line is added because there is no blank line between 
> functions, I will double check


The point is not mixing coding style fix with other fixes or enhancement.

Thanks


> THanks, BR Zhu Lingshan
>>
>>
>>>   static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned 
>>> int cmd,
>>>                      void __user *argp)
>>>   {
>>> @@ -390,6 +448,16 @@ static long vhost_vdpa_vring_ioctl(struct 
>>> vhost_vdpa *v, unsigned int cmd,
>>>               cb.private = NULL;
>>>           }
>>>           ops->set_vq_cb(vdpa, idx, &cb);
>>> +#ifdef CONFIG_HAVE_KVM_IRQ_BYPASS
>>> +        /*
>>> +         * if it has a non-zero irq, means there is a
>>> +         * previsouly registered irq_bypass_producer,
>>> +         * we should update it when ctx (its token)
>>> +         * changes.
>>> +         */
>>> +        if (vq->call_ctx.producer.irq)
>>> +            vhost_vdpa_update_vq_irq(vq);
>>> +#endif
>>>           break;
>>>         case VHOST_SET_VRING_NUM:
>>> @@ -741,6 +809,7 @@ static int vhost_vdpa_open(struct inode *inode, 
>>> struct file *filep)
>>>           vqs[i] = &v->vqs[i];
>>>           vqs[i]->handle_kick = handle_vq_kick;
>>>       }
>>> +
>>
>>
>> Unnecessary change.
>>
>> Thanks
>>
>>
>>>       vhost_dev_init(dev, vqs, nvqs, 0, 0, 0, false,
>>>                  vhost_vdpa_process_iotlb_msg);
>>
