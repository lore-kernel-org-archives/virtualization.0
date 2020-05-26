From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [Sound-open-firmware] [PATCH 5/6] vhost: add an rpmsg API
Date: Tue, 26 May 2020 15:09:19 -0500
Message-ID: <f93b01b9-b14c-2433-af97-5bb9ae53f788@linux.intel.com>
References: <20200516101109.2624-1-guennadi.liakhovetski@linux.intel.com>
 <20200516101109.2624-6-guennadi.liakhovetski@linux.intel.com>
 <9737e3f2-e59c-0174-9254-a2d8f29f30b7@linux.intel.com>
 <20200525135336.GB6761@ubuntu>
 <59029e07-f49b-8d1a-4eb4-2f6d5775cf54@linux.intel.com>
 <20200526185522.GA6992@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20200526185522.GA6992@ubuntu>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
To: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, sound-open-firmware@alsa-project.org, linux-remoteproc@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org



>>>>> +config VHOST_RPMSG
>>>>> +	tristate
>>>>> +	depends on VHOST
>>>>
>>>> depends on RPMSG_VIRTIO?
>>>
>>> No, RPMSG_VIRTIO is used on the guest side, VHOST_RPMSG (as well as
>>> all other vhost drivers) on the host side.
>>
>> I vaguely recalled something about sockets, and was wondering if there isn't
>> a dependency on this:
>>
>> config VHOST_VSOCK
>> 	tristate "vhost virtio-vsock driver"
>> 	depends on VSOCKETS && EVENTFD && VHOST_DPN
>> 	select VHOST
> 
> You probably are thinking about the first patch in the series "vhost: convert
> VHOST_VSOCK_SET_RUNNING to a generic ioctl." But no, this RPMsg driver
> doesn't depend on vsock, on the contrary, it takes a (albeit tiny) piece of
> functionality from vsock and makes it global.

yes, this is what I was thinking about, thanks for clarifying.
