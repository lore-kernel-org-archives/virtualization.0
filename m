From: Anthony Liguori <anthony@codemonkey.ws>
Subject: Re: [Qemu-devel] [PATCH] virtio: Add PCI memory BAR in addition to
	PIO BAR
Date: Thu, 03 Nov 2011 09:37:59 -0500
Message-ID: <4EB2A747.9040909@codemonkey.ws>
References: <1317360376-12090-1-git-send-email-david@gibson.dropbear.id.au>	<4EB07096.4070806@us.ibm.com>
	<4EB26EA5.4060606@redhat.com>	<4EB291F4.8070503@us.ibm.com>
	<4EB29381.9060707@redhat.com>	<4EB2993C.9000902@codemonkey.ws>
	<4EB29B00.10907@redhat.com>	<4EB29BEB.4070603@codemonkey.ws>
	<20111103143129.GA20860@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20111103143129.GA20860@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: kvm@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, Pekka Enberg <penberg@kernel.org>, Avi Kivity <avi@redhat.com>, David Gibson <david@gibson.dropbear.id.au>
List-Id: virtualization@lists.linuxfoundation.org

On 11/03/2011 09:31 AM, Michael S. Tsirkin wrote:
> On Thu, Nov 03, 2011 at 08:49:31AM -0500, Anthony Liguori wrote:
>> On 11/03/2011 08:45 AM, Avi Kivity wrote:
>>> On 11/03/2011 03:38 PM, Anthony Liguori wrote:
>>>>>
>>>>>> We could use a better agreement on the processor for making virtio
>>>>>> changes. Should it go (1) virtio spec (2) kernel (3) qemu, or should
>>>>>> it go (2), (1), (3)?
>>>>>
>>>>> 1. Informal discussion
>>>>
>>>>
>>>> Where?  Is this lkml?  There were a number of virtio changes recently
>>>> that never involved qemu-devel.
>>>
>>> Theoretically, virtualization@lists.linux-foundation.org, if it still
>>> exists.  Maybe we need a virtio list. qemu-devel@, kvm@, lkml could be
>>> copied.
>>
>> Perhaps it's time to create a virtio@vger?  Just have a simple
>> process that all spec changes to there the appropriate kernel, QEMU,
>> virtio-win, or NKT maintainers can require any virtio change to also
>> have a committed spec change first.
>
> Historically virtualization@lists.linux-foundation.org was used,
> that is still low enough volume. It was down but seems to be
> up now. It's easy enough for me to subscribe to yet
> another list but my concern is that if we move we might loose some
> people that don't notice the change.
>
> Anything wrong with just using the old list?

No, but it's so old, I have no idea who admin's it these days.

> It's on the MAINTAINERS file, I'm not sure why it was bypassed in this case.
> Maybe linux-foundation.org was still down when the patch was posted?

The list has been down for a while.

>>>>> 2. Proposed spec patch, kernel change, qemu change
>>>>> 3. Buy-ins from spec maintainer, kernel driver maintainer, qemu device
>>>>> maintainer (only regarding the ABI, not the code)
>>>>
>>>> I don't think this is how it's working today.  I would be happy with a
>>>> flow like this.
>>>
>>> If Michael and Rusty agree, we can adopt it immediately.
>>>
>
> If I understand the proposal, what is suggested is that
> all of spec, kvm and virtio patches are posted on list and
> acked before merging any one of them?
>
> Sure, this makes sense.

Well, what's needed before the spec is changed is an interesting question, but I 
think the main thing is, don't commit any virtio ABI changes to vhost, QEMU, 
NKT, or the kernel until the spec for the change has been committed.

It would be nice to have a working implementation before committing a spec 
change.  Even nicer would be to have Acked-by's a maintainer in each area affected.

Regards,

Anthony Liguori
