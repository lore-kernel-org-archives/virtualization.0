From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [virtio-dev] Zerocopy VM-to-VM networking using virtio-net
Date: Mon, 27 Apr 2015 13:57:01 +0100
Message-ID: <CAJSP0QU6wBLCJWodfnpCf-5X1cVZDxFhZCKNeAQd+aQQcKupGw@mail.gmail.com>
References: <20150422170138.GA8388@stefanha-thinkpad.redhat.com>
	<CAA2XHbd_Wxs3O6ChSGouF3ZGH-SA0Lzw7OFVfvnuAXZmLAkZoA@mail.gmail.com>
	<CAJSP0QWtbzWwbvHYHVDJ2bccJ1wPZ0WA31bOH5UkGMhbkLF-Ng@mail.gmail.com>
	<CAA2XHbdvxTviZ-wxRVd87EuajcrOb1g=3Rafdyc5cXrzGbJMqA@mail.gmail.com>
	<CAJSP0QU=0KXC3uRjFGukNvKQkSLnSOMvXpEoLgzoxD7CRSx2iA@mail.gmail.com>
	<CAA2XHbed=GMwCAUN4uz4vJ=JZdWeik=D07vwiwV5natk9XSdCg@mail.gmail.com>
	<CAJSP0QW9dqvbqNVt0Ggk2d=Yd=jCQsbCqZA+TCEaGqU35wbDjg@mail.gmail.com>
	<553E2D07.9040406@siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <553E2D07.9040406@siemens.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Rik van Riel <riel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Andrew Jones <drjones@redhat.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Luke Gorrie <luke@snabb.co>, Stefan Hajnoczi <stefanha@redhat.com>, virtio-comment@lists.oasis-open.org, Paolo Bonzini <pbonzini@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Apr 27, 2015 at 1:35 PM, Jan Kiszka <jan.kiszka@siemens.com> wrote:
> Am 2015-04-27 um 12:17 schrieb Stefan Hajnoczi:
>> On Sun, Apr 26, 2015 at 2:24 PM, Luke Gorrie <luke@snabb.co> wrote:
>>> On 24 April 2015 at 15:22, Stefan Hajnoczi <stefanha@gmail.com> wrote:
>>>>
>>>> The motivation for making VM-to-VM fast is that while software
>>>> switches on the host are efficient today (thanks to vhost-user), there
>>>> is no efficient solution if the software switch is a VM.
>>>
>>>
>>> I see. This sounds like a noble goal indeed. I would love to run the
>>> software switch as just another VM in the long term. It would make it much
>>> easier for the various software switches to coexist in the world.
>>>
>>> The main technical risk I see in this proposal is that eliminating the
>>> memory copies might not have the desired effect. I might be tempted to keep
>>> the copies but prevent the kernel from having to inspect the vrings (more
>>> like vhost-user). But that is just a hunch and I suppose the first step
>>> would be a prototype to check the performance anyway.
>>>
>>> For what it is worth here is my view of networking performance on x86 in the
>>> Haswell+ era:
>>> https://groups.google.com/forum/#!topic/snabb-devel/aez4pEnd4ow
>>
>> Thanks.
>>
>> I've been thinking about how to eliminate the VM <-> host <-> VM
>> switching and instead achieve just VM <-> VM.
>>
>> The holy grail of VM-to-VM networking is an exitless I/O path.  In
>> other words, packets can be transferred between VMs without any
>> vmexits (this requires a polling driver).
>>
>> Here is how it works.  QEMU gets "-device vhost-user" so that a VM can
>> act as the vhost-user server:
>>
>> VM1 (virtio-net guest driver) <-> VM2 (vhost-user device)
>>
>> VM1 has a regular virtio-net PCI device.  VM2 has a vhost-user device
>> and plays the host role instead of the normal virtio-net guest driver
>> role.
>>
>> The ugly thing about this is that VM2 needs to map all of VM1's guest
>> RAM so it can access the vrings and packet data.  The solution to this
>> is something like the Shared Buffers BAR but this time it contains not
>> just the packet data but also the vring, let's call it the Shared
>> Virtqueues BAR.
>>
>> The Shared Virtqueues BAR eliminates the need for vhost-net on the
>> host because VM1 and VM2 communicate directly using virtqueue notify
>> or polling vring memory.  Virtqueue notify works by connecting an
>> eventfd as ioeventfd in VM1 and irqfd in VM2.  And VM2 would also have
>> an ioeventfd that is irqfd for VM1 to signal completions.
>
> We had such a discussion before:
> http://thread.gmane.org/gmane.comp.emulators.kvm.devel/123014/focus=279658
>
> Would be great to get this ball rolling again.

Thanks for the interesting link.

Now that vhost-user exists, a QEMU -device vhost-user feature is a
logical step.  It would allow any virtio device to be emulated by
another VM, not just virtio-net.  It seems like a nice model for
storage and networking appliance VMs.

I don't have time to write the patches in the near future but can
participate in code review and discussion.

Stefan
