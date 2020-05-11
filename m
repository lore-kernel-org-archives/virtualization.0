From: Francesco Lavra <francescolavra.fl@gmail.com>
Subject: Re: [PATCH] ifcvf: move IRQ request/free to status change handlers
Date: Mon, 11 May 2020 12:18:29 +0200
Message-ID: <c1da2054-eb4c-d7dd-ca83-29e85e5cfe90@gmail.com>
References: <1589181563-38400-1-git-send-email-lingshan.zhu@intel.com>
 <22d9dcdb-e790-0a68-ba41-b9530b2bf9fd@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <22d9dcdb-e790-0a68-ba41-b9530b2bf9fd@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jason Wang <jasowang@redhat.com>, Zhu Lingshan <lingshan.zhu@intel.com>, mst@redhat.com, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: lulu@redhat.com, dan.daly@intel.com, cunming.liang@intel.com
List-Id: virtualization@lists.linuxfoundation.org

On 5/11/20 11:26 AM, Jason Wang wrote:
> 
> On 2020/5/11 下午3:19, Zhu Lingshan wrote:
>> This commit move IRQ request and free operations from probe()
>> to VIRTIO status change handler to comply with VIRTIO spec.
>>
>> VIRTIO spec 1.1, section 2.1.2 Device Requirements: Device Status Field
>> The device MUST NOT consume buffers or send any used buffer
>> notifications to the driver before DRIVER_OK.
> 
> 
> My previous explanation might be wrong here. It depends on how you 
> implement your hardware, if you hardware guarantee that no interrupt 
> will be triggered before DRIVER_OK, then it's fine.
> 
> And the main goal for this patch is to allocate the interrupt on demand.
> 
> 
>>
>> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
>> ---
>>   drivers/vdpa/ifcvf/ifcvf_main.c | 119 
>> ++++++++++++++++++++++++----------------
>>   1 file changed, 73 insertions(+), 46 deletions(-)
>>
>> diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c 
>> b/drivers/vdpa/ifcvf/ifcvf_main.c
>> index abf6a061..4d58bf2 100644
>> --- a/drivers/vdpa/ifcvf/ifcvf_main.c
>> +++ b/drivers/vdpa/ifcvf/ifcvf_main.c
>> @@ -28,6 +28,60 @@ static irqreturn_t ifcvf_intr_handler(int irq, void 
>> *arg)
>>       return IRQ_HANDLED;
>>   }
>> +static void ifcvf_free_irq_vectors(void *data)
>> +{
>> +    pci_free_irq_vectors(data);
>> +}
>> +
>> +static void ifcvf_free_irq(struct ifcvf_adapter *adapter, int queues)
>> +{
>> +    struct pci_dev *pdev = adapter->pdev;
>> +    struct ifcvf_hw *vf = &adapter->vf;
>> +    int i;
>> +
>> +
>> +    for (i = 0; i < queues; i++)
>> +        devm_free_irq(&pdev->dev, vf->vring[i].irq, &vf->vring[i]);
>> +
>> +    ifcvf_free_irq_vectors(pdev);
>> +}
>> +
>> +static int ifcvf_request_irq(struct ifcvf_adapter *adapter)
>> +{
>> +    struct pci_dev *pdev = adapter->pdev;
>> +    struct ifcvf_hw *vf = &adapter->vf;
>> +    int vector, i, ret, irq;
>> +
>> +    ret = pci_alloc_irq_vectors(pdev, IFCVF_MAX_INTR,
>> +                    IFCVF_MAX_INTR, PCI_IRQ_MSIX);
>> +    if (ret < 0) {
>> +        IFCVF_ERR(pdev, "Failed to alloc IRQ vectors\n");
>> +        return ret;
>> +    }
>> +
>> +    for (i = 0; i < IFCVF_MAX_QUEUE_PAIRS * 2; i++) {
>> +        snprintf(vf->vring[i].msix_name, 256, "ifcvf[%s]-%d\n",
>> +             pci_name(pdev), i);
>> +        vector = i + IFCVF_MSI_QUEUE_OFF;
>> +        irq = pci_irq_vector(pdev, vector);
>> +        ret = devm_request_irq(&pdev->dev, irq,
>> +                       ifcvf_intr_handler, 0,
>> +                       vf->vring[i].msix_name,
>> +                       &vf->vring[i]);
>> +        if (ret) {
>> +            IFCVF_ERR(pdev,
>> +                  "Failed to request irq for vq %d\n", i);
>> +            ifcvf_free_irq(adapter, i);
> 
> 
> I'm not sure this unwind is correct. It looks like we should loop and 
> call devm_free_irq() for virtqueue [0, i);

That's exactly what the code does: ifcvf_free_irq() contains a (i = 0; i 
< queues; i++) loop, and here the function is called with the `queues` 
argument set to `i`.
