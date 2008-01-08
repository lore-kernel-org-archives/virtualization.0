From: Anthony Liguori <anthony@codemonkey.ws>
Subject: Re: [kvm-devel] [PATCH] kvm guest balloon driver
Date: Tue, 08 Jan 2008 10:14:02 -0600
Message-ID: <4783A14A.3080605__34070.883136201$1199809126$gmane$org@codemonkey.ws>
References: <20080108153356.GA21726@dmt> <478399D5.9030707@codemonkey.ws>
	<20080108161005.GA22168@dmt>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20080108161005.GA22168@dmt>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Marcelo Tosatti <marcelo@kvack.org>
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Marcelo Tosatti wrote:
> On Tue, Jan 08, 2008 at 09:42:13AM -0600, Anthony Liguori wrote:
>   
>> Marcelo Tosatti wrote:
>>     
>>> Following patch introduces a KVM guest balloon driver. Communication
>>> to/from the host is performed via virtio.
>>>
>>>       
>
> I'll address the other comments.
>
>   
>>> +	virtballoon.dev = vdev;
>>> +	init_waitqueue_head(&virtballoon.balloon_wait);
>>> +	init_waitqueue_head(&virtballoon.rmmod_wait);
>>> +	atomic_set(&virtballoon.inflight_bufs, 0);
>>> +
>>> +	err = request_irq(pvdev->pci_dev->irq, balloon_irq, IRQF_SHARED,
>>> +			  pvdev->vdev.dev.bus_id, &virtballoon);
>>> +	if (err)
>>> +		goto out_free_vq;
>>>  
>>>       
>> Why is it taking over the irq?  This is very, very wrong.  A virtio 
>> device cannot be dependent on being used on top of the virtio-pci backend.
>>     
>
> A notification is necessary whenever the host changes the target value
> in the config space. So right now this notification is sharing the
> same IRQ as the main PCI device.
>   

A message should be sent over a virtqueue to indicate that the other 
need needs to reread a config value.

You really need two virtqueues.  The virtqueue you have now for the 
guest to send messages to the host, and another virtqueue that the guest 
adds buffers too that the host can use to send messages to the guest.  A 
good example of using two queues for bidirectional communication would 
be the virtio_console driver.

BTW, I don't think the target should be a config value.  You don't gain 
anything from it being in the config space and it's somewhat unnatural 
for a virtio device.  It makes more sense as a message to the guest.

The PCI config space is not automatically saved/restored during migration.

> Do you have any suggestion on how to retrieve the IRQ of the virtio
> device, or some other notification mechanism?
>   

A virtio device does not necessarily have an interrupt or it may have 
multiple interrupts.

Regards,

Anthony Liguori
