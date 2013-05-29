From: Anthony Liguori <aliguori@us.ibm.com>
Subject: Re: [PATCH RFC] virtio-pci: new config layout: using memory BAR
Date: Wed, 29 May 2013 07:52:37 -0500
Message-ID: <87mwreq76y.fsf@codemonkey.ws>
References: <20130528160342.GA29915@redhat.com> <87bo7vvxej.fsf@codemonkey.ws>
	<87ppwammp5.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <87ppwammp5.fsf@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, KONRAD Frederic <fred.konrad@greensocs.com>
List-Id: virtualization@lists.linuxfoundation.org

Rusty Russell <rusty@rustcorp.com.au> writes:

> Anthony Liguori <aliguori@us.ibm.com> writes:
>> "Michael S. Tsirkin" <mst@redhat.com> writes:
>>> +    case offsetof(struct virtio_pci_common_cfg, device_feature_select):
>>> +        return proxy->device_feature_select;
>>
>> Oh dear no...  Please use defines like the rest of QEMU.
>
> It is pretty ugly.

I think beauty is in the eye of the beholder here...

Pretty much every device we have has a switch statement like this.
Consistency wins when it comes to qualitative arguments like this.

> Yet the structure definitions are descriptive, capturing layout, size
> and endianness in natural a format readable by any C programmer.

From an API design point of view, here are the problems I see:

1) C makes no guarantees about structure layout beyond the first
   member.  Yes, if it's naturally aligned or has a packed attribute,
   GCC does the right thing.  But this isn't kernel land anymore,
   portability matters and there are more compilers than GCC.

2) If we every introduce anything like latching, this doesn't work out
   so well anymore because it's hard to express in a single C structure
   the register layout at that point.  Perhaps a union could be used but
   padding may make it a bit challenging.

3) It suspect it's harder to review because a subtle change could more
   easily have broad impact.  If someone changed the type of a field
   from u32 to u16, it changes the offset of every other field.  That's
   not terribly obvious in the patch itself unless you understand how
   the structure is used elsewhere.

   This may not be a problem for virtio because we all understand that
   the structures are part of an ABI, but if we used this pattern more
   in QEMU, it would be a lot less obvious.

> So AFAICT the question is, do we put the required
>
> #define VIRTIO_PCI_CFG_FEATURE_SEL \
>          (offsetof(struct virtio_pci_common_cfg, device_feature_select))
>
> etc. in the kernel headers or qemu?

I'm pretty sure we would end up just having our own integer defines.  We
carry our own virtio headers today because we can't easily import the
kernel headers.

>> Haven't looked at the proposed new ring layout yet.
>
> No change, but there's an open question on whether we should nail it to
> little endian (or define the endian by the transport).
>
> Of course, I can't rule out that the 1.0 standard *may* decide to frob
> the ring layout somehow,

Well, given that virtio is widely deployed today, I would think the 1.0
standard should strictly reflect what's deployed today, no?

Any new config layout would be 2.0 material, right?

Re: the new config layout, I don't think we would want to use it for
anything but new devices.  Forcing a guest driver change is a really big
deal and I see no reason to do that unless there's a compelling reason
to.

So we're stuck with the 1.0 config layout for a very long time.

Regards,

Anthony Liguori

> but I'd think it would require a compelling
> reason.  I suggest that's 2.0 material...
>
> Cheers,
> Rusty.
>
> --
> To unsubscribe from this list: send the line "unsubscribe kvm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
