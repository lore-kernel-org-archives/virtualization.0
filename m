From: Michael Mueller <mimu@linux.ibm.com>
Subject: Re: [PATCH v2 6/8] virtio/s390: add indirection to indicators access
Date: Wed, 29 May 2019 13:05:41 +0200
Message-ID: <08e56ae6-28ed-52ae-62ec-fde786949500@linux.ibm.com>
References: <20190523162209.9543-1-mimu@linux.ibm.com>
	<20190523162209.9543-7-mimu@linux.ibm.com>
	<20190527130028.62e1f7d7.cohuck@redhat.com>
	<20190527135706.34837062.pasic@linux.ibm.com>
	<20190527141029.102f838a.cohuck@redhat.com>
Reply-To: mimu@linux.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190527141029.102f838a.cohuck@redhat.com>
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
To: Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>, Linux-S390 Mailing List <linux-s390@vger.kernel.org>, Thomas Huth <thuth@redhat.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, KVM Mailing List <kvm@vger.kernel.org>, Sebastian Ott <sebott@linux.ibm.com>, "Michael S . Tsirkin" <mst@redhat.com>, Pierre Morel <pmorel@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Eric Farman <farman@linux.ibm.com>, virtualization@lists.linux-foundation.org, Christoph Hellwig <hch@infradead.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org



On 27.05.19 14:10, Cornelia Huck wrote:
> On Mon, 27 May 2019 13:57:06 +0200
> Halil Pasic <pasic@linux.ibm.com> wrote:
> 
>> On Mon, 27 May 2019 13:00:28 +0200
>> Cornelia Huck <cohuck@redhat.com> wrote:
>>
>>> On Thu, 23 May 2019 18:22:07 +0200
>>> Michael Mueller <mimu@linux.ibm.com> wrote:
>>>    
>>>> From: Halil Pasic <pasic@linux.ibm.com>
>>>>
>>>> This will come in handy soon when we pull out the indicators from
>>>> virtio_ccw_device to a memory area that is shared with the hypervisor
>>>> (in particular for protected virtualization guests).
>>>>
>>>> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
>>>> Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>
>>>> ---
>>>>   drivers/s390/virtio/virtio_ccw.c | 40 +++++++++++++++++++++++++---------------
>>>>   1 file changed, 25 insertions(+), 15 deletions(-)
>>>>    
>>>    
>>>> @@ -338,17 +348,17 @@ static void virtio_ccw_drop_indicator(struct virtio_ccw_device *vcdev,
>>>>   		ccw->cda = (__u32)(unsigned long) thinint_area;
>>>>   	} else {
>>>>   		/* payload is the address of the indicators */
>>>> -		indicatorp = kmalloc(sizeof(&vcdev->indicators),
>>>> +		indicatorp = kmalloc(sizeof(indicators(vcdev)),
>>>>   				     GFP_DMA | GFP_KERNEL);
>>>>   		if (!indicatorp)
>>>>   			return;
>>>>   		*indicatorp = 0;
>>>>   		ccw->cmd_code = CCW_CMD_SET_IND;
>>>> -		ccw->count = sizeof(&vcdev->indicators);
>>>> +		ccw->count = sizeof(indicators(vcdev));
>>>>   		ccw->cda = (__u32)(unsigned long) indicatorp;
>>>>   	}
>>>>   	/* Deregister indicators from host. */
>>>> -	vcdev->indicators = 0;
>>>> +	*indicators(vcdev) = 0;
>>>
>>> I'm not too hot about this notation, but it's not wrong and a minor
>>> thing :)
>>
>> I don't have any better ideas :/
>>
>>>    
>>>>   	ccw->flags = 0;
>>>>   	ret = ccw_io_helper(vcdev, ccw,
>>>>   			    vcdev->is_thinint ?
>>>
>>> Patch looks reasonable and not dependent on the other patches here.
>>>    
>>
>> looks reasonable == r-b?
>>
>> Not dependent in a sense that this patch could be made a first patch in
>> the series. A subsequent patch depends on it.
> 
> What is the plan with these patches? I can either pick patch 5+6 and
> let them go through the virtio tree, or give my r-b and let them go
> through the s390 tree. The former is probably the quicker route, but
> the latter has less potential for dependency issues.

please give your r-b then for these.

> 

Michael
