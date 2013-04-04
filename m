From: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH RFC] kvm: add PV MMIO EVENTFD
Date: Thu, 4 Apr 2013 14:49:39 +0200
Message-ID: <1B68D701-103D-4B1A-8F5E-3916753699CB@suse.de>
References: <20130404104846.GA6227@redhat.com>
	<6D40C5F1-849E-4F32-B391-E1A1BFA8C59D@suse.de>
	<20130404120825.GD17919@redhat.com>
	<959E147D-EB7B-4F4B-9F84-4F1BBA98DEF8@suse.de>
	<20130404123806.GG17919@redhat.com>
	<EF153515-9835-4FB9-B6BC-73D0BDC86492@suse.de>
	<20130404124501.GH17919@redhat.com>
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130404124501.GH17919@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gleb Natapov <gleb@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, x86@kernel.org, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, Xiao Guangrong <xiaoguangrong@linux.vnet.ibm.com>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Sasha Levin <sasha.levin@oracle.com>, Thomas Gleixner <tglx@linutronix.de>, Christoffer Dall <c.dall@virtualopensystems.com>, virtualization@lists.linux-foundation.org, Takuya Yoshikawa <yoshikawa_takuya_b1@lab.ntt.co.jp>
List-Id: virtualization@lists.linuxfoundation.org


On 04.04.2013, at 14:45, Gleb Natapov wrote:

> On Thu, Apr 04, 2013 at 02:39:51PM +0200, Alexander Graf wrote:
>> 
>> On 04.04.2013, at 14:38, Gleb Natapov wrote:
>> 
>>> On Thu, Apr 04, 2013 at 02:32:08PM +0200, Alexander Graf wrote:
>>>> 
>>>> On 04.04.2013, at 14:08, Gleb Natapov wrote:
>>>> 
>>>>> On Thu, Apr 04, 2013 at 01:57:34PM +0200, Alexander Graf wrote:
>>>>>> 
>>>>>> On 04.04.2013, at 12:50, Michael S. Tsirkin wrote:
>>>>>> 
>>>>>>> With KVM, MMIO is much slower than PIO, due to the need to
>>>>>>> do page walk and emulation. But with EPT, it does not have to be: we
>>>>>>> know the address from the VMCS so if the address is unique, we can look
>>>>>>> up the eventfd directly, bypassing emulation.
>>>>>>> 
>>>>>>> Add an interface for userspace to specify this per-address, we can
>>>>>>> use this e.g. for virtio.
>>>>>>> 
>>>>>>> The implementation adds a separate bus internally. This serves two
>>>>>>> purposes:
>>>>>>> - minimize overhead for old userspace that does not use PV MMIO
>>>>>>> - minimize disruption in other code (since we don't know the length,
>>>>>>> devices on the MMIO bus only get a valid address in write, this
>>>>>>> way we don't need to touch all devices to teach them handle
>>>>>>> an dinvalid length)
>>>>>>> 
>>>>>>> At the moment, this optimization is only supported for EPT on x86 and
>>>>>>> silently ignored for NPT and MMU, so everything works correctly but
>>>>>>> slowly.
>>>>>>> 
>>>>>>> TODO: NPT, MMU and non x86 architectures.
>>>>>>> 
>>>>>>> The idea was suggested by Peter Anvin.  Lots of thanks to Gleb for
>>>>>>> pre-review and suggestions.
>>>>>>> 
>>>>>>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>>>>>> 
>>>>>> This still uses page fault intercepts which are orders of magnitudes slower than hypercalls. Why don't you just create a PV MMIO hypercall that the guest can use to invoke MMIO accesses towards the host based on physical addresses with explicit length encodings?
>>>>>> 
>>>>> It is slower, but not an order of magnitude slower. It become faster
>>>>> with newer HW.
>>>>> 
>>>>>> That way you simplify and speed up all code paths, exceeding the speed of PIO exits even. It should also be quite easily portable, as all other platforms have hypercalls available as well.
>>>>>> 
>>>>> We are trying to avoid PV as much as possible (well this is also PV,
>>>>> but not guest visible
>>>> 
>>>> Also, how is this not guest visible? Who sets KVM_IOEVENTFD_FLAG_PV_MMIO? The comment above its definition indicates that the guest does so, so it is guest visible.
>>>> 
>>> QEMU sets it.
>> 
>> How does QEMU know?
>> 
> Knows what? When to create such eventfd? virtio device knows.

Where does it know from?

> 
>>> 
>>>> +/*
>>>> + * PV_MMIO - Guest can promise us that all accesses touching this address
>>>> + * are writes of specified length, starting at the specified address.
>>>> + * If not - it's a Guest bug.
>>>> + * Can not be used together with either PIO or DATAMATCH.
>>>> + */
>>>> 
>>> Virtio spec will state that access to a kick register needs to be of
>>> specific length. This is reasonable thing for HW to ask.
>> 
>> This is a spec change. So the guest would have to indicate that it adheres to a newer spec. Thus it's a guest visible change.
>> 
> There is not virtio spec that has kick register in MMIO. The spec is in
> the works AFAIK. Actually PIO will not be deprecated and my suggestion

So the guest would indicate that it supports a newer revision of the spec (in your case, that it supports MMIO). How is that any different from exposing that it supports a PV MMIO hcall?

> is to move to MMIO only when PIO address space is exhausted. For PCI it
> will be never, for PCI-e it will be after ~16 devices.

Ok, let's go back a step here. Are you actually able to measure any speed in performance with this patch applied and without when going through MMIO kicks?


Alex
