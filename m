From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH RFC] virtio-pci: new config layout: using memory BAR
Date: Thu, 30 May 2013 13:28:26 +0930
Message-ID: <87wqqhktjx.fsf@rustcorp.com.au>
References: <20130528160342.GA29915@redhat.com> <87bo7vvxej.fsf@codemonkey.ws>
	<87ppwammp5.fsf@rustcorp.com.au> <87mwreq76y.fsf@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <87mwreq76y.fsf@codemonkey.ws>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Anthony Liguori <aliguori@us.ibm.com>, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, KONRAD Frederic <fred.konrad@greensocs.com>
List-Id: virtualization@lists.linuxfoundation.org

Anthony Liguori <aliguori@us.ibm.com> writes:
> Rusty Russell <rusty@rustcorp.com.au> writes:
>
>> Anthony Liguori <aliguori@us.ibm.com> writes:
>>> "Michael S. Tsirkin" <mst@redhat.com> writes:
>>>> +    case offsetof(struct virtio_pci_common_cfg, device_feature_select):
>>>> +        return proxy->device_feature_select;
>>>
>>> Oh dear no...  Please use defines like the rest of QEMU.
>>
>> It is pretty ugly.
>
> I think beauty is in the eye of the beholder here...
>
> Pretty much every device we have has a switch statement like this.
> Consistency wins when it comes to qualitative arguments like this.

I was agreeing with you here, actually.

>> Yet the structure definitions are descriptive, capturing layout, size
>> and endianness in natural a format readable by any C programmer.
>
>>From an API design point of view, here are the problems I see:
>
> 1) C makes no guarantees about structure layout beyond the first
>    member.  Yes, if it's naturally aligned or has a packed attribute,
>    GCC does the right thing.  But this isn't kernel land anymore,
>    portability matters and there are more compilers than GCC.

[ I argued in detail here, then deleted.  Damn bikeshedding... ]

I think the best thing is to add the decoded integer versions as macros,
and have a heap of BUILD_BUG_ON() in the kernel source to make sure they
match.

> 3) It suspect it's harder to review because a subtle change could more
>    easily have broad impact.  If someone changed the type of a field
>    from u32 to u16, it changes the offset of every other field.  That's
>    not terribly obvious in the patch itself unless you understand how
>    the structure is used elsewhere.

MST's patch just did this, so point taken.  (MST: I'm going to combine
the cfg_type and bar bytes to fix this, patch coming).

>> No change, but there's an open question on whether we should nail it to
>> little endian (or define the endian by the transport).
>>
>> Of course, I can't rule out that the 1.0 standard *may* decide to frob
>> the ring layout somehow,
>
> Well, given that virtio is widely deployed today, I would think the 1.0
> standard should strictly reflect what's deployed today, no?

That will be up to the committee.  I think we want to fix some obvious
pain points, though qemu will not benefit from them in the next 5 years.

> Any new config layout would be 2.0 material, right?
>
> Re: the new config layout, I don't think we would want to use it for
> anything but new devices.

There are enough concrete reasons that I think we want it for existing
devices:

1) Negotiated ring size/alignment.  Coreboot wants smaller, others want
   larger.
2) Remove assertion that it has to be an I/O bar.  PowerPC wants this.
3) Notification location flexibility.  MST wanted this for performance.
4) More feature bits.

> Forcing a guest driver change is a really big
> deal and I see no reason to do that unless there's a compelling reason
> to.
>
> So we're stuck with the 1.0 config layout for a very long time.

We definitely must not force a guest change.  The explicit aim of the
standard is that "legacy" and 1.0 be backward compatible.  One
deliverable is a document detailing how this is done (effectively a
summary of changes between what we have and 1.0).

It's a delicate balancing act.  My plan is to accompany any changes in
the standard with a qemu implementation, so we can see how painful those
changes are.  And if there are performance implications, measure them.

Cheers,
Rusty.
