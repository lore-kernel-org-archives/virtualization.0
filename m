From: Anthony Liguori <aliguori@us.ibm.com>
Subject: Re: [PATCH RFC] virtio-pci: new config layout: using memory BAR
Date: Wed, 29 May 2013 09:16:39 -0500
Message-ID: <8761y1q3aw.fsf__33269.4180695855$1369837027$gmane$org@codemonkey.ws>
References: <20130528160342.GA29915@redhat.com> <87bo7vvxej.fsf@codemonkey.ws>
	<87ppwammp5.fsf@rustcorp.com.au> <87mwreq76y.fsf@codemonkey.ws>
	<20130529132430.GA9363@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130529132430.GA9363@redhat.com>
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
Cc: Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, KONRAD Frederic <fred.konrad@greensocs.com>
List-Id: virtualization@lists.linuxfoundation.org

"Michael S. Tsirkin" <mst@redhat.com> writes:

> On Wed, May 29, 2013 at 07:52:37AM -0500, Anthony Liguori wrote:
>> 1) C makes no guarantees about structure layout beyond the first
>>    member.  Yes, if it's naturally aligned or has a packed attribute,
>>    GCC does the right thing.  But this isn't kernel land anymore,
>>    portability matters and there are more compilers than GCC.
>
> You expect a compiler to pad this structure:
>
> struct foo {
> 	uint8_t a;
> 	uint8_t b;
> 	uint16_t c;
> 	uint32_t d;
> };
>
> I'm guessing any compiler that decides to waste memory in this way
> will quickly get dropped by users and then we won't worry
> about building QEMU with it.

There are other responses in the thread here and I don't really care to
bikeshed on this issue.

>> Well, given that virtio is widely deployed today, I would think the 1.0
>> standard should strictly reflect what's deployed today, no?
>> Any new config layout would be 2.0 material, right?
>
> Not as it's currently planned. Devices can choose
> to support a legacy layout in addition to the new one,
> and if you look at the patch you will see that that
> is exactly what it does.

Adding a new BAR most certainly requires bumping the revision ID or
changing the device ID, no?

Didn't we run into this problem with the virtio-win drivers with just
the BAR size changing? 

>> Re: the new config layout, I don't think we would want to use it for
>> anything but new devices.  Forcing a guest driver change
>
> There's no forcing.
> If you look at the patches closely, you will see that
> we still support the old layout on BAR0.
>
>
>> is a really big
>> deal and I see no reason to do that unless there's a compelling reason
>> to.
>
> There are many a compelling reasons, and they are well known
> limitations of virtio PCI:
>
> - PCI spec compliance (madates device operation with IO memory
> disabled).

PCI express spec.  We are fully compliant with the PCI spec.  And what's
the user visible advantage of pointing an emulated virtio device behind
a PCI-e bus verses a legacy PCI bus?

This is a very good example because if we have to disable BAR0, then
it's an ABI breaker plan and simple.

> - support 64 bit addressing

We currently support 44-bit addressing for the ring.  While I agree we
need to bump it, there's no immediate problem with 44-bit addressing.

> - add more than 32 feature bits.
> - individually disable queues.
> - sanely support cross-endian systems.
> - support very small (<1 PAGE) for virtio rings.
> - support a separate page for each vq kick.
> - make each device place config at flexible offset.

None of these things are holding us back today.

I'm not saying we shouldn't introduce a new device.  But adoption of
that device will be slow and realistically will be limited to new
devices only.

We'll be supporting both devices for a very, very long time.

Compatibility is the fundamental value that we provide.  We need to go
out of our way to make sure that existing guests work and work as well
as possible.

Sticking virtio devices behind a PCI-e bus just for the hell of it isn't
a compelling reason to break existing guests.

Regards,

Anthony Liguori


> Addressing any one of these would cause us to add a substantially new
> way to operate virtio devices.
>
> And since it's a guest change anyway, it seemed like a
> good time to do the new layout and fix everything in one go.
>
> And they are needed like yesterday.
>
>
>> So we're stuck with the 1.0 config layout for a very long time.
>> 
>> Regards,
>> 
>> Anthony Liguori
>
> Absolutely. This patch let us support both which will allow for
> a gradual transition over the next 10 years or so.
>
>> > reason.  I suggest that's 2.0 material...
>> >
>> > Cheers,
>> > Rusty.
>> >
>> > --
>> > To unsubscribe from this list: send the line "unsubscribe kvm" in
>> > the body of a message to majordomo@vger.kernel.org
>> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe kvm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
