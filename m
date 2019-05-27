From: Michael Mueller <mimu@linux.ibm.com>
Subject: Re: [PATCH v2 3/8] s390/cio: add basic protected virtualization
	support
Date: Mon, 27 May 2019 17:01:12 +0200
Message-ID: <f2b8d5c3-a39b-8632-c463-cde47bf38c91@linux.ibm.com>
References: <20190523162209.9543-1-mimu@linux.ibm.com>
	<20190523162209.9543-4-mimu@linux.ibm.com>
	<alpine.LFD.2.21.1905251124230.3359@schleppi>
Reply-To: mimu@linux.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.21.1905251124230.3359@schleppi>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Sebastian Ott <sebott@linux.ibm.com>
Cc: Farhan Ali <alifm@linux.ibm.com>, Linux-S390 Mailing List <linux-s390@vger.kernel.org>, Thomas Huth <thuth@redhat.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, KVM Mailing List <kvm@vger.kernel.org>, "Michael S . Tsirkin" <mst@redhat.com>, Pierre Morel <pmorel@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Eric Farman <farman@linux.ibm.com>, virtualization@lists.linux-foundation.org, Halil Pasic <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Christoph Hellwig <hch@infradead.org>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org



On 25.05.19 11:44, Sebastian Ott wrote:
> 
> On Thu, 23 May 2019, Michael Mueller wrote:
>>   static struct ccw_device * io_subchannel_allocate_dev(struct subchannel *sch)
>>   {
>>   	struct ccw_device *cdev;
>> +	struct gen_pool *dma_pool;
>>   
>>   	cdev  = kzalloc(sizeof(*cdev), GFP_KERNEL);
>> -	if (cdev) {
>> -		cdev->private = kzalloc(sizeof(struct ccw_device_private),
>> -					GFP_KERNEL | GFP_DMA);
>> -		if (cdev->private)
>> -			return cdev;
>> -	}
>> +	if (!cdev)
>> +		goto err_cdev;
>> +	cdev->private = kzalloc(sizeof(struct ccw_device_private),
>> +				GFP_KERNEL | GFP_DMA);
>> +	if (!cdev->private)
>> +		goto err_priv;
>> +	cdev->dev.coherent_dma_mask = sch->dev.coherent_dma_mask;
>> +	cdev->dev.dma_mask = &cdev->dev.coherent_dma_mask;
>> +	dma_pool = cio_gp_dma_create(&cdev->dev, 1);
> 
> This can return NULL. gen_pool_alloc will panic in this case.
> [...]

yep, will handled in next version

> 
>> +err_dma_area:
>> +		kfree(io_priv);

one tab gone

> 
> Indentation.
> 
>> +err_priv:
>> +	put_device(&sch->dev);
>> +	return ERR_PTR(-ENOMEM);
>>   }
> [...]
>>   void ccw_device_update_sense_data(struct ccw_device *cdev)
>>   {
>>   	memset(&cdev->id, 0, sizeof(cdev->id));
>> -	cdev->id.cu_type   = cdev->private->senseid.cu_type;
>> -	cdev->id.cu_model  = cdev->private->senseid.cu_model;
>> -	cdev->id.dev_type  = cdev->private->senseid.dev_type;
>> -	cdev->id.dev_model = cdev->private->senseid.dev_model;
>> +	cdev->id.cu_type   =
>> +		cdev->private->dma_area->senseid.cu_type;
>> +	cdev->id.cu_model  =
>> +		cdev->private->dma_area->senseid.cu_model;
>> +	cdev->id.dev_type  =
>> +		cdev->private->dma_area->senseid.dev_type;
>> +	cdev->id.dev_model =
>> +		cdev->private->dma_area->senseid.dev_model;
> 
> These fit into one line.

yep, surprisingly below 80 characters

> 
>> +/**
>> + * Allocate zeroed dma coherent 31 bit addressable memory using
>> + * the subchannels dma pool. Maximal size of allocation supported
>> + * is PAGE_SIZE.
>> + */
> drivers/s390/cio/device_ops.c:708: warning: Function parameter or member 'cdev' not described in 'ccw_device_dma_zalloc'
> drivers/s390/cio/device_ops.c:708: warning: Function parameter or member 'size' not described in 'ccw_device_dma_zalloc'

changing comment open token

> 
> 
> Reviewed-by: Sebastian Ott <sebott@linux.ibm.com>
> 

Thanks!


Michael
