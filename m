From: Pierre Morel <pmorel@linux.ibm.com>
Subject: Re: [PATCH v2 1/1] s390: virtio: let arch accept devices without
 IOMMU feature
Date: Tue, 16 Jun 2020 15:41:20 +0200
Message-ID: <e130c5e7-40e5-40a8-eac3-c2d17c90ee7b@linux.ibm.com>
References: <1592224764-1258-1-git-send-email-pmorel@linux.ibm.com>
 <1592224764-1258-2-git-send-email-pmorel@linux.ibm.com>
 <20200616115202.0285aa08.pasic@linux.ibm.com>
 <ef235cc9-9d4b-1247-c01a-9dd1c63f437c@linux.ibm.com>
 <20200616135726.04fa8314.pasic@linux.ibm.com>
 <20200616141744.61b3a139.cohuck@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20200616141744.61b3a139.cohuck@redhat.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
To: Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, borntraeger@de.ibm.com, frankja@linux.ibm.com, mst@redhat.com, jasowang@redhat.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org, thomas.lendacky@amd.com, David Gibson <david@gibson.dropbear.id.au>, Ram Pai <linuxram@us.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org



On 2020-06-16 14:17, Cornelia Huck wrote:
> On Tue, 16 Jun 2020 13:57:26 +0200
> Halil Pasic <pasic@linux.ibm.com> wrote:
> 
>> On Tue, 16 Jun 2020 12:52:50 +0200
>> Pierre Morel <pmorel@linux.ibm.com> wrote:
>>
>>>>>    int virtio_finalize_features(struct virtio_device *dev)
>>>>>    {
>>>>>    	int ret = dev->config->finalize_features(dev);
>>>>> @@ -179,6 +184,10 @@ int virtio_finalize_features(struct virtio_device *dev)
>>>>>    	if (!virtio_has_feature(dev, VIRTIO_F_VERSION_1))
>>>>>    		return 0;
>>>>>    
>>>>> +	if (arch_needs_iommu_platform(dev) &&
>>>>> +		!virtio_has_feature(dev, VIRTIO_F_IOMMU_PLATFORM))
>>>>> +		return -EIO;
>>>>> +
>>>>
>>>> Why EIO?
>>>
>>> Because I/O can not occur correctly?
>>> I am open to suggestions.
>>
>> We use -ENODEV if feature when the device rejects the features we
>> tried to negotiate (see virtio_finalize_features()) and -EINVAL when
>> the F_VERSION_1 and the virtio-ccw revision ain't coherent (in
>> virtio_ccw_finalize_features()). Any of those seems more fitting
>> that EIO to me. BTW does the error code itself matter in any way,
>> or is it just OK vs some error?
> 
> If I haven't lost my way, we end up in the driver core probe failure
> handling; we probably should do -ENODEV if we just want probing to fail
> and -EINVAL or -EIO if we want the code to moan.
> 

what about returning -ENODEV and add a dedicated warning here?

-- 
Pierre Morel
IBM Lab Boeblingen
