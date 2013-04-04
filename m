From: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH RFC] kvm: add PV MMIO EVENTFD
Date: Thu, 4 Apr 2013 16:02:57 +0200
Message-ID: <23D9B42C-8E20-47F0-9DB1-987AC0AA5DC1@suse.de>
References: <20130404104846.GA6227@redhat.com>
	<6D40C5F1-849E-4F32-B391-E1A1BFA8C59D@suse.de>
	<20130404120825.GD17919@redhat.com>
	<194AE9A4-07C6-4597-B3AA-1EDF3DA97FA0@suse.de>
	<20130404125802.GC6467@redhat.com>
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130404125802.GC6467@redhat.com>
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
Cc: Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, Xiao Guangrong <xiaoguangrong@linux.vnet.ibm.com>, Ingo Molnar <mingo@redhat.com>, kvm@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Sasha Levin <sasha.levin@oracle.com>, Thomas Gleixner <tglx@linutronix.de>, Christoffer Dall <c.dall@virtualopensystems.com>, virtualization@lists.linux-foundation.org, Takuya Yoshikawa <yoshikawa_takuya_b1@lab.ntt.co.jp>
List-Id: virtualization@lists.linuxfoundation.org


On 04.04.2013, at 14:58, Michael S. Tsirkin wrote:

> On Thu, Apr 04, 2013 at 02:22:09PM +0200, Alexander Graf wrote:
>> 
>> On 04.04.2013, at 14:08, Gleb Natapov wrote:
>> 
>>> On Thu, Apr 04, 2013 at 01:57:34PM +0200, Alexander Graf wrote:
>>>> 
>>>> On 04.04.2013, at 12:50, Michael S. Tsirkin wrote:
>>>> 
>>>>> With KVM, MMIO is much slower than PIO, due to the need to
>>>>> do page walk and emulation. But with EPT, it does not have to be: we
>>>>> know the address from the VMCS so if the address is unique, we can look
>>>>> up the eventfd directly, bypassing emulation.
>>>>> 
>>>>> Add an interface for userspace to specify this per-address, we can
>>>>> use this e.g. for virtio.
>>>>> 
>>>>> The implementation adds a separate bus internally. This serves two
>>>>> purposes:
>>>>> - minimize overhead for old userspace that does not use PV MMIO
>>>>> - minimize disruption in other code (since we don't know the length,
>>>>> devices on the MMIO bus only get a valid address in write, this
>>>>> way we don't need to touch all devices to teach them handle
>>>>> an dinvalid length)
>>>>> 
>>>>> At the moment, this optimization is only supported for EPT on x86 and
>>>>> silently ignored for NPT and MMU, so everything works correctly but
>>>>> slowly.
>>>>> 
>>>>> TODO: NPT, MMU and non x86 architectures.
>>>>> 
>>>>> The idea was suggested by Peter Anvin.  Lots of thanks to Gleb for
>>>>> pre-review and suggestions.
>>>>> 
>>>>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>>>> 
>>>> This still uses page fault intercepts which are orders of magnitudes slower than hypercalls. Why don't you just create a PV MMIO hypercall that the guest can use to invoke MMIO accesses towards the host based on physical addresses with explicit length encodings?
>>>> 
>>> It is slower, but not an order of magnitude slower. It become faster
>>> with newer HW.
>>> 
>>>> That way you simplify and speed up all code paths, exceeding the speed of PIO exits even. It should also be quite easily portable, as all other platforms have hypercalls available as well.
>>>> 
>>> We are trying to avoid PV as much as possible (well this is also PV,
>>> but not guest visible). We haven't replaced PIO with hypercall for the
>>> same reason. My hope is that future HW will provide us with instruction
>>> decode for basic mov instruction at which point this optimisation can be
>>> dropped.
>> 
>> The same applies to an MMIO hypercall. Once the PV interface becomes obsolete, we can drop the capability we expose to the guest.
> 
> Yes but unlike a hypercall this optimization does not need special code
> in the guest. You can use standard OS interfaces for memory access.

Yes, but let's try to understand the room for optimization we're talking about here. The "normal" MMIO case seems excessively slower in MST's benchmarks than it did in mine. So maybe we're really just looking at a bug here.

Also, if hcalls are again only 50% of a fast MMIO callback, it's certainly worth checking out what room for improvement we're really wasting.


Alex
