From: Pierre Morel <pmorel@linux.ibm.com>
Subject: Re: [PATCH v5 2/2] s390: virtio: PV needs VIRTIO I/O device protection
Date: Thu, 9 Jul 2020 16:51:04 +0200
Message-ID: <c9be019f-236e-5e44-64b6-0875cd40ab11@linux.ibm.com>
References: <1594283959-13742-1-git-send-email-pmorel@linux.ibm.com>
 <1594283959-13742-3-git-send-email-pmorel@linux.ibm.com>
 <20200709105733.6d68fa53.cohuck@redhat.com>
 <270d8674-0f73-0a38-a2a7-fbc1caa44301@linux.ibm.com>
 <20200709164700.09a83069.pasic@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200709164700.09a83069.pasic@linux.ibm.com>
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
To: Halil Pasic <pasic@linux.ibm.com>
Cc: gor@linux.ibm.com, linux-s390@vger.kernel.org, frankja@linux.ibm.com, kvm@vger.kernel.org, mst@redhat.com, heiko.carstens@de.ibm.com, Cornelia Huck <cohuck@redhat.com>, linuxram@us.ibm.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, borntraeger@de.ibm.com, thomas.lendacky@amd.com, david@gibson.dropbear.id.au
List-Id: virtualization@lists.linuxfoundation.org



On 2020-07-09 16:47, Halil Pasic wrote:
> On Thu, 9 Jul 2020 12:51:58 +0200
> Pierre Morel <pmorel@linux.ibm.com> wrote:
> 
>>>> +int arch_validate_virtio_features(struct virtio_device *dev)
>>>> +{
>>>> +	if (!is_prot_virt_guest())
>>>> +		return 0;
>>>> +
>>>> +	if (!virtio_has_feature(dev, VIRTIO_F_VERSION_1)) {
>>>> +		dev_warn(&dev->dev, "device must provide VIRTIO_F_VERSION_1\n");
>>>
>>> I'd probably use "legacy virtio not supported with protected
>>> virtualization".
>>>    
>>>> +		return -ENODEV;
>>>> +	}
>>>> +
>>>> +	if (!virtio_has_feature(dev, VIRTIO_F_IOMMU_PLATFORM)) {
>>>> +		dev_warn(&dev->dev,
>>>> +			 "device must provide VIRTIO_F_IOMMU_PLATFORM\n");
>>>
>>> "support for limited memory access required for protected
>>> virtualization"
>>>
>>> ?
>>>
>>> Mentioning the feature flag is shorter in both cases, though.
>>
>> And I think easier to look for in case of debugging purpose.
>> I change it if there is more demands.
> 
> Not all our end users are kernel and/or qemu developers. I find the
> messages from v4 less technical, more informative, and way better.
> 
> Regards,
> Halil
> 

Can you please tell me the messages you are speaking of, because for me 
the warning's messages are exactly the same in v4 and v5!?

I checked many times, but may be I still missed something.

Regards,
Pierre


-- 
Pierre Morel
IBM Lab Boeblingen
