From: Anthony Liguori <anthony@codemonkey.ws>
Subject: Re: [Qemu-devel] Re: [PATCH] qemu/virtio: move features to an inline
	function
Date: Tue, 11 Aug 2009 11:08:32 -0500
Message-ID: <4A819780.4040002@codemonkey.ws>
References: <20090810192809.GA16800@redhat.com>
	<4A8076F0.5050700@codemonkey.ws>
	<20090810194753.GA16803@redhat.com>
	<4A808437.8040307@codemonkey.ws>
	<20090810221940.GB17099@redhat.com>
	<4A80A0A1.2020905@codemonkey.ws> <20090811084807.GA3029@redhat.com>
	<4A816EEB.4070707@codemonkey.ws>
	<20090811134331.GA22661@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090811134331.GA22661@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Michael S. Tsirkin wrote:
>> Let's say we supported virtio-vbus along with virtio-pci.  What does  
>> virtio_blk_get_features() do to mask out sg_indirect?  For all  
>> virtio-blk knows, it could be on top of virtio-vbus.
>>     
>
> So? VIRTIO_RING_F_INDIRECT_DESC applies to all transports.
> Just clear this bit.
>   

You can have many layers with virtio.  device + transport + ring

virtio-vbus would have a different transport and a different ring 
implementation.  So no, VIRTIO_RING_F_INDIRECT_DESC wouldn't apply to 
virtio-vbus.

>>>   This would break things like
>>> migrating between userspace and kernel virtio (something that I
>>> support).
>>>       
>> The PIT uses a common state structure and common code for save/restore.   
>> This makes migration compatible.
>>     
>
> Isn't device name put in the machine config, which presumably is
> send along as well?
>   

Good question.  I don't know the best way to resolve this.

Maybe migration between devices isn't such a good idea.  It's 
conceivable that vhost will require some state that isn't present in the 
userspace virtio-net.  I think this requires some thought.

>> In this case, it's two separate implementations of the same device.  I  
>> think it makes sense for them to be separate devices.
>>
>> Regards,
>>
>> Anthony Liguori
>>     
>
> Hmm, I see what you mean. But kernel virtio is harder. Unlike
> PIT/APIC, it is not a separate codepath.  It still needs
> all of userspace virtio to support live migration and non-MSI guests.
> Really, it's the same device that switches between kernel and userspace
> modes on the fly.
>
> This will become clearer from code when I implement migration for vhost,
> but basically you switch to userspace when you start migration, and
> back to kernel if migration fails. You also switch to kernel when MSI
> is enabled and back to userspace when it is disabled.
>   

Why bother switching to userspace for migration?  Can't you just have 
get/set ioctls for the state?

Regards,

Anthony Liguori
