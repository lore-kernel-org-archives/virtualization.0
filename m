From: Michael Mueller <mimu@linux.ibm.com>
Subject: Re: [PATCH v2 3/8] s390/cio: add basic protected virtualization
	support
Date: Mon, 27 May 2019 14:15:27 +0200
Message-ID: <6cfd1a67-b600-169e-b0c1-64362c7129f8@linux.ibm.com>
References: <20190523162209.9543-1-mimu@linux.ibm.com>
	<20190523162209.9543-4-mimu@linux.ibm.com>
	<20190527123802.54cd3589.cohuck@redhat.com>
Reply-To: mimu@linux.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190527123802.54cd3589.cohuck@redhat.com>
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
To: Cornelia Huck <cohuck@redhat.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>, Linux-S390 Mailing List <linux-s390@vger.kernel.org>, Thomas Huth <thuth@redhat.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, KVM Mailing List <kvm@vger.kernel.org>, Sebastian Ott <sebott@linux.ibm.com>, "Michael S . Tsirkin" <mst@redhat.com>, Pierre Morel <pmorel@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Eric Farman <farman@linux.ibm.com>, virtualization@lists.linux-foundation.org, Halil Pasic <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Christoph Hellwig <hch@infradead.org>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org



On 27.05.19 12:38, Cornelia Huck wrote:
> On Thu, 23 May 2019 18:22:04 +0200
> Michael Mueller <mimu@linux.ibm.com> wrote:
> 
>> From: Halil Pasic <pasic@linux.ibm.com>
>>
>> As virtio-ccw devices are channel devices, we need to use the dma area
>> for any communication with the hypervisor.
>>
>> It handles neither QDIO in the common code, nor any device type specific
>> stuff (like channel programs constructed by the DASD driver).
>>
>> An interesting side effect is that virtio structures are now going to
>> get allocated in 31 bit addressable storage.
>>
>> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> 
> [Side note: you really should add your s-o-b if you send someone else's
> patches... if Halil ends up committing them, it's fine, though.]

My real problem here is that Halil is writing comments and patches after
I have prepared all my changes. ;) And now this contnues...

Michael

> 
>> ---
>>   arch/s390/include/asm/ccwdev.h   |  4 +++
>>   drivers/s390/cio/ccwreq.c        |  9 +++---
>>   drivers/s390/cio/device.c        | 64 +++++++++++++++++++++++++++++++++-------
>>   drivers/s390/cio/device_fsm.c    | 53 ++++++++++++++++++++-------------
>>   drivers/s390/cio/device_id.c     | 20 +++++++------
>>   drivers/s390/cio/device_ops.c    | 21 +++++++++++--
>>   drivers/s390/cio/device_pgid.c   | 22 +++++++-------
>>   drivers/s390/cio/device_status.c | 24 +++++++--------
>>   drivers/s390/cio/io_sch.h        | 20 +++++++++----
>>   drivers/s390/virtio/virtio_ccw.c | 10 -------
>>   10 files changed, 164 insertions(+), 83 deletions(-)
>>
> 
> (...)
> 
>> @@ -1593,20 +1622,31 @@ struct ccw_device * __init ccw_device_create_console(struct ccw_driver *drv)
>>   		return ERR_CAST(sch);
>>   
>>   	io_priv = kzalloc(sizeof(*io_priv), GFP_KERNEL | GFP_DMA);
>> -	if (!io_priv) {
>> -		put_device(&sch->dev);
>> -		return ERR_PTR(-ENOMEM);
>> -	}
>> +	if (!io_priv)
>> +		goto err_priv;
>> +	io_priv->dma_area = dma_alloc_coherent(&sch->dev,
>> +				sizeof(*io_priv->dma_area),
>> +				&io_priv->dma_area_dma, GFP_KERNEL);
> 
> Even though we'll only end up here for 3215 or 3270 consoles, this sent
> me looking.
> 
> This code is invoked via console_init(). A few lines down in
> start_kernel(), we have
> 
>          /*
>           * This needs to be called before any devices perform DMA
>           * operations that might use the SWIOTLB bounce buffers. It will
>           * mark the bounce buffers as decrypted so that their usage will
>           * not cause "plain-text" data to be decrypted when accessed.
>           */
>          mem_encrypt_init();
> 
> So, I'm wondering if creating the console device interacts in any way
> with the memory encryption interface?
> 
> [Does basic recognition work if you start a protected virt guest with a
> 3270 console? I realize that the console is unlikely to work, but that
> should at least exercise this code path.]
> 
>> +	if (!io_priv->dma_area)
>> +		goto err_dma_area;
>>   	set_io_private(sch, io_priv);
>>   	cdev = io_subchannel_create_ccwdev(sch);
>>   	if (IS_ERR(cdev)) {
>>   		put_device(&sch->dev);
>> +		dma_free_coherent(&sch->dev, sizeof(*io_priv->dma_area),
>> +				  io_priv->dma_area, io_priv->dma_area_dma);
>>   		kfree(io_priv);
>>   		return cdev;
>>   	}
>>   	cdev->drv = drv;
>>   	ccw_device_set_int_class(cdev);
>>   	return cdev;
>> +
>> +err_dma_area:
>> +		kfree(io_priv);
>> +err_priv:
>> +	put_device(&sch->dev);
>> +	return ERR_PTR(-ENOMEM);
>>   }
>>   
>>   void __init ccw_device_destroy_console(struct ccw_device *cdev)
> 
