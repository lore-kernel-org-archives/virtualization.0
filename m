From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: VIRTIO adoption in other hypervisors
Date: Fri, 28 Feb 2020 11:36:03 +0100
Message-ID: <0b80da21-ed40-c550-c605-031a209115b1@siemens.com>
References: <87mu93vwy2.fsf@linaro.org>
 <db75fc2b-ac2e-2351-cc3c-cdb42a50ac24@siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <virtio-dev-return-6814-gcvd-virtio-dev=m.gmane-mx.org@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
In-Reply-To: <db75fc2b-ac2e-2351-cc3c-cdb42a50ac24@siemens.com>
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org
Cc: Stefano Stabellini <sstabellini@kernel.org>, Wei Liu <liuw@liuw.name>
List-Id: virtualization@lists.linuxfoundation.org

On 28.02.20 11:30, Jan Kiszka wrote:
> On 28.02.20 11:16, Alex Bennée wrote:
>> Hi,
>>
>> I'm currently trying to get my head around virtio and was wondering how
>> widespread adoption of virtio is amongst the various hypervisors and
>> emulators out there.
>>
>> Obviously I'm familiar with QEMU both via KVM and even when just doing
>> plain emulation (although with some restrictions). As far as I'm aware
>> the various Rust based VMMs have vary degrees of support for virtio
>> devices over KVM as well. CrosVM specifically is embracing virtio for
>> multi-process device emulation.
>>
>> I believe there has been some development work for supporting VIRTIO on
>> Xen although it seems to have stalled according to:
>>
>>    https://wiki.xenproject.org/wiki/Virtio_On_Xen
>>
>> Recently at KVM Forum there was Jan's talk about Inter-VM shared memory
>> which proposed ivshmemv2 as a VIRTIO transport:
>>
>>    
>> https://events19.linuxfoundation.org/events/kvm-forum-2019/program/schedule/ 
>>
>>
>> As I understood it this would allow Xen (and other hypervisors) a simple
>> way to be able to carry virtio traffic between guest and end point.

And to clarify the scope of this effort: virtio-over-ivshmem is not the 
fastest option to offer virtio to a guest (static "DMA" window), but it 
is the simplest one from the hypervisor PoV and, thus, also likely the 
easiest one to argue over when it comes to security and safety.

Jan

>>
>> So some questions:
>>
>>    - Am I missing anything out in that summary?
>>    - How about HyperV and the OSX equivalent?
>>    - Do any other type-1 hypervisors support virtio?
> 
>  From the top of my head, some other hypervisors with virtio support 
> (irrespective of any classification):
> 
> https://wiki.freebsd.org/bhyve
> https://projectacrn.org/
> http://www.xhypervisor.org/
> https://www.opensynergy.com/automotive-hypervisor/
> 
> But there are likely more.
> 
> Jan
> 

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux
