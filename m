From: Dongli Zhang <dongli.zhang@oracle.com>
Subject: Re: virtio-blk: should num_vqs be limited by num_possible_cpus()?
Date: Fri, 15 Mar 2019 00:08:18 +0800
Message-ID: <74cf10ad-34bb-333a-3119-6021697c8e33__37262.4691155337$1552579720$gmane$org@oracle.com>
References: <e4afe4c5-0262-4500-aeec-60f30734b4fc@default>
	<20190312183351.74764f4f.cohuck@redhat.com>
	<173d19c9-24db-35f2-269f-0b9b83bd0ad6@oracle.com>
	<20190313103900.1ea7f996.cohuck@redhat.com>
	<a3f24cfa-5160-0ccc-decc-a48362c8de19@oracle.com>
	<20190314131339.1b61fff6.cohuck@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190314131339.1b61fff6.cohuck@redhat.com>
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
Cc: axboe@kernel.dk, mst@redhat.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org



On 03/14/2019 08:13 PM, Cornelia Huck wrote:
> On Thu, 14 Mar 2019 14:12:32 +0800
> Dongli Zhang <dongli.zhang@oracle.com> wrote:
> 
>> On 3/13/19 5:39 PM, Cornelia Huck wrote:
>>> On Wed, 13 Mar 2019 11:26:04 +0800
>>> Dongli Zhang <dongli.zhang@oracle.com> wrote:
>>>   
>>>> On 3/13/19 1:33 AM, Cornelia Huck wrote:  
>>>>> On Tue, 12 Mar 2019 10:22:46 -0700 (PDT)
>>>>> Dongli Zhang <dongli.zhang@oracle.com> wrote:
> 
>>>>>> Is this by design on purpose, or can we fix with below?
>>>>>>
>>>>>>
>>>>>> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
>>>>>> index 4bc083b..df95ce3 100644
>>>>>> --- a/drivers/block/virtio_blk.c
>>>>>> +++ b/drivers/block/virtio_blk.c
>>>>>> @@ -513,6 +513,8 @@ static int init_vq(struct virtio_blk *vblk)
>>>>>>  	if (err)
>>>>>>  		num_vqs = 1;
>>>>>>  
>>>>>> +	num_vqs = min(num_possible_cpus(), num_vqs);
>>>>>> +
>>>>>>  	vblk->vqs = kmalloc_array(num_vqs, sizeof(*vblk->vqs), GFP_KERNEL);
>>>>>>  	if (!vblk->vqs)
>>>>>>  		return -ENOMEM;    
>>>>>
>>>>> virtio-blk, however, is not pci-specific.
>>>>>
>>>>> If we are using the ccw transport on s390, a completely different
>>>>> interrupt mechanism is in use ('floating' interrupts, which are not
>>>>> per-cpu). A check like that should therefore not go into the generic
>>>>> driver.
>>>>>     
>>>>
>>>> So far there seems two options.
>>>>
>>>> The 1st option is to ask the qemu user to always specify "-num-queues" with the
>>>> same number of vcpus when running x86 guest with pci for virtio-blk or
>>>> virtio-scsi, in order to assign a vector for each queue.  
>>>
>>> That does seem like an extra burden for the user: IIUC, things work
>>> even if you have too many queues, it's just not optimal. It sounds like
>>> something that can be done by a management layer (e.g. libvirt), though.
>>>   
>>>> Or, is it fine for virtio folks to add a new hook to 'struct virtio_config_ops'
>>>> so that different platforms (e.g., pci or ccw) would use different ways to limit
>>>> the max number of queues in guest, with something like below?  
>>>
>>> That sounds better, as both transports and drivers can opt-in here.
>>>
>>> However, maybe it would be even better to try to come up with a better
>>> strategy of allocating msix vectors in virtio-pci. More vectors in the
>>> num_queues > num_cpus case, even if they still need to be shared?
>>> Individual vectors for n-1 cpus and then a shared one for the remaining
>>> queues?
>>>
>>> It might even be device-specific: Have some low-traffic status queues
>>> share a vector, and provide an individual vector for high-traffic
>>> queues. Would need some device<->transport interface, obviously.
>>>   
>>
>> This sounds a little bit similar to multiple hctx maps?
>>
>> So far, as virtio-blk only supports set->nr_maps = 1, no matter how many hw
>> queues are assigned for virtio-blk, blk_mq_alloc_tag_set() would use at most
>> nr_cpu_ids hw queues.
>>
>> 2981 int blk_mq_alloc_tag_set(struct blk_mq_tag_set *set)
>> ... ...
>> 3021         /*
>> 3022          * There is no use for more h/w queues than cpus if we just have
>> 3023          * a single map
>> 3024          */
>> 3025         if (set->nr_maps == 1 && set->nr_hw_queues > nr_cpu_ids)
>> 3026                 set->nr_hw_queues = nr_cpu_ids;
>>
>> Even the block layer would limit the number of hw queues by nr_cpu_ids when
>> (set->nr_maps == 1).
> 
> Correct me if I'm wrong, but there seem to be two kinds of limitations
> involved here:
> - Allocation of msix vectors by the virtio-pci transport. We end up
>   with shared vectors if we have more virtqueues than vcpus. Other
>   transports may or may not have similar issues, but essentially, this
>   is something that applies to all kind of virtio devices attached via
>   the virtio-pci transport.

It depends.

For virtio-net, we need to specify the number of available vectors on qemu side,
e.g.,:

-device virtio-net-pci,netdev=tapnet,mq=true,vectors=16

This parameter is specific for virtio-net.

Suppose if 'queues=8' while 'vectors=16', as 2*8+1 > 16, there will be lack of
vectors and guest would not be able to assign one vector for each queue.

I was tortured by this long time ago and it seems qemu would minimize the memory
allocation and the default 'vectors' is 3.

BTW, why cannot we have a more consistent configuration for most qemu devices,
e.g., so far:

virtio-blk use 'num-queues'
nvme use 'num_queues'
virtio-net use 'queues' for tap :)

> - The block layer limits the number of hw queues to the number of
>   vcpus. This applies only to virtio devices that interact with the
>   block layer, but regardless of the virtio transport.

Yes: virtio-blk and virtio-scsi.

> 
>> That's why I think virtio-blk should use the similar solution as nvme
>> (regardless about write_queues and poll_queues) and xen-blkfront.
> 
> Ok, the hw queues limit from above would be an argument to limit to
> #vcpus in the virtio-blk driver, regardless of the transport used. (No
> idea if there are better ways to deal with this, I'm not familiar with
> the interface.)
> 
> For virtio devices that don't interact with the block layer and are
> attached via the virtio-pci transport, it might still make sense to
> revisit vector allocation.
> 

As mentioned above, we need to specify 'vectors' for virtio-net as the default
value is only 3 (config + tx + rx). That would make a little difference?

Dongli Zhang
