From: Pierre Morel <pmorel@linux.ibm.com>
Subject: Re: [PATCH v3 1/1] s390: virtio: let arch accept devices without
 IOMMU feature
Date: Mon, 29 Jun 2020 18:10:02 +0200
Message-ID: <4777633f-728b-1a67-c870-0fafa313e468@linux.ibm.com>
References: <1592390637-17441-1-git-send-email-pmorel@linux.ibm.com>
 <1592390637-17441-2-git-send-email-pmorel@linux.ibm.com>
 <20200618002956.5f179de4.pasic@linux.ibm.com>
 <20200619112051.74babdb1.cohuck@redhat.com>
 <7fe6e9ab-fd5a-3f92-1f3a-f9e6805d3730@linux.ibm.com>
 <20200629154439.14cc5ae7.cohuck@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200629154439.14cc5ae7.cohuck@redhat.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: gor@linux.ibm.com, linux-s390@vger.kernel.org, frankja@linux.ibm.com, kvm@vger.kernel.org, mst@redhat.com, heiko.carstens@de.ibm.com, linuxram@us.ibm.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Halil Pasic <pasic@linux.ibm.com>, borntraeger@de.ibm.com, thomas.lendacky@amd.com, david@gibson.dropbear.id.au
List-Id: virtualization@lists.linuxfoundation.org



On 2020-06-29 15:44, Cornelia Huck wrote:
> On Mon, 29 Jun 2020 15:14:04 +0200
> Pierre Morel <pmorel@linux.ibm.com> wrote:
> 
>> On 2020-06-19 11:20, Cornelia Huck wrote:
>>> On Thu, 18 Jun 2020 00:29:56 +0200
>>> Halil Pasic <pasic@linux.ibm.com> wrote:
>>>    
>>>> On Wed, 17 Jun 2020 12:43:57 +0200
>>>> Pierre Morel <pmorel@linux.ibm.com> wrote:
> 
>>>>> @@ -179,6 +194,13 @@ int virtio_finalize_features(struct virtio_device *dev)
>>>>>    	if (!virtio_has_feature(dev, VIRTIO_F_VERSION_1))
>>>>>    		return 0;
>>>>>    
>>>>> +	if (arch_needs_virtio_iommu_platform(dev) &&
>>>>> +		!virtio_has_feature(dev, VIRTIO_F_IOMMU_PLATFORM)) {
>>>>> +		dev_warn(&dev->dev,
>>>>> +			 "virtio: device must provide VIRTIO_F_IOMMU_PLATFORM\n");
> 
> [Side note: wasn't there a patch renaming this bit on the list? I think
> this name is only kept for userspace compat.]

Sorry, I do not understand what you expect from me.
On which mailing list you think there is a patch on?

> 
>>>>
>>>> I'm not sure, divulging the current Linux name of this feature bit is a
>>>> good idea, but if everybody else is fine with this, I don't care that
>>>
>>> Not sure if that feature name will ever change, as it is exported in
>>> headers. At most, we might want to add the new ACCESS_PLATFORM define
>>> and keep the old one, but that would still mean some churn.
>>>    
>>>> much. An alternative would be:
>>>> "virtio: device falsely claims to have full access to the memory,
>>>> aborting the device"
>>>
>>> "virtio: device does not work with limited memory access" ?
>>>
>>> But no issue with keeping the current message.
>>>    
>>
>> If it is OK, I would like to specify that the arch is responsible to
>> accept or not the device.
>> The reason why the device is not accepted without IOMMU_PLATFORM is arch
>> specific.
> 
> Hm, I'd think the reason is always the same (the device cannot access
> the memory directly), just the way to figure out whether that is the
> case or not is arch-specific, as with so many other things. No real
> need to go into detail here, I think.
> 

As you like, so I rename the subject to:
"virtio: device does not work with limited memory access"

Regards,

Pierre


-- 
Pierre Morel
IBM Lab Boeblingen
