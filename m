From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH RFC] virtio-pci: new config layout: using memory BAR
Date: Wed, 29 May 2013 16:24:30 +0300
Message-ID: <20130529132430.GA9363@redhat.com>
References: <20130528160342.GA29915@redhat.com> <87bo7vvxej.fsf@codemonkey.ws>
	<87ppwammp5.fsf@rustcorp.com.au> <87mwreq76y.fsf@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
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
To: Anthony Liguori <aliguori@us.ibm.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, KONRAD Frederic <fred.konrad@greensocs.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, May 29, 2013 at 07:52:37AM -0500, Anthony Liguori wrote:
> Rusty Russell <rusty@rustcorp.com.au> writes:
> 
> > Anthony Liguori <aliguori@us.ibm.com> writes:
> >> "Michael S. Tsirkin" <mst@redhat.com> writes:
> >>> +    case offsetof(struct virtio_pci_common_cfg, device_feature_select):
> >>> +        return proxy->device_feature_select;
> >>
> >> Oh dear no...  Please use defines like the rest of QEMU.
> >
> > It is pretty ugly.
> 
> I think beauty is in the eye of the beholder here...
> 
> Pretty much every device we have has a switch statement like this.
> Consistency wins when it comes to qualitative arguments like this.
> 
> > Yet the structure definitions are descriptive, capturing layout, size
> > and endianness in natural a format readable by any C programmer.
> 
> >From an API design point of view, here are the problems I see:
> 
> 1) C makes no guarantees about structure layout beyond the first
>    member.  Yes, if it's naturally aligned or has a packed attribute,
>    GCC does the right thing.  But this isn't kernel land anymore,
>    portability matters and there are more compilers than GCC.

You expect a compiler to pad this structure:

struct foo {
	uint8_t a;
	uint8_t b;
	uint16_t c;
	uint32_t d;
};

I'm guessing any compiler that decides to waste memory in this way
will quickly get dropped by users and then we won't worry
about building QEMU with it.

> 2) If we every introduce anything like latching, this doesn't work out
>    so well anymore because it's hard to express in a single C structure
>    the register layout at that point.  Perhaps a union could be used but
>    padding may make it a bit challenging.

Then linux won't use it either.

> 3) It suspect it's harder to review because a subtle change could more
>    easily have broad impact.  If someone changed the type of a field
>    from u32 to u16, it changes the offset of every other field.  That's
>    not terribly obvious in the patch itself unless you understand how
>    the structure is used elsewhere.
> 
>    This may not be a problem for virtio because we all understand that
>    the structures are part of an ABI, but if we used this pattern more
>    in QEMU, it would be a lot less obvious.

So let's not use it more in QEMU.

> > So AFAICT the question is, do we put the required
> >
> > #define VIRTIO_PCI_CFG_FEATURE_SEL \
> >          (offsetof(struct virtio_pci_common_cfg, device_feature_select))
> >
> > etc. in the kernel headers or qemu?
> 
> I'm pretty sure we would end up just having our own integer defines.  We
> carry our own virtio headers today because we can't easily import the
> kernel headers.

Yes we can easily import them.
And at least we copy headers verbatim.


> >> Haven't looked at the proposed new ring layout yet.
> >
> > No change, but there's an open question on whether we should nail it to
> > little endian (or define the endian by the transport).
> >
> > Of course, I can't rule out that the 1.0 standard *may* decide to frob
> > the ring layout somehow,
> 
> Well, given that virtio is widely deployed today, I would think the 1.0
> standard should strictly reflect what's deployed today, no?
> Any new config layout would be 2.0 material, right?

Not as it's currently planned. Devices can choose
to support a legacy layout in addition to the new one,
and if you look at the patch you will see that that
is exactly what it does.

> Re: the new config layout, I don't think we would want to use it for
> anything but new devices.  Forcing a guest driver change

There's no forcing.
If you look at the patches closely, you will see that
we still support the old layout on BAR0.


> is a really big
> deal and I see no reason to do that unless there's a compelling reason
> to.

There are many a compelling reasons, and they are well known
limitations of virtio PCI:

- PCI spec compliance (madates device operation with IO memory disabled).
- support 64 bit addressing
- add more than 32 feature bits.
- individually disable queues.
- sanely support cross-endian systems.
- support very small (<1 PAGE) for virtio rings.
- support a separate page for each vq kick.
- make each device place config at flexible offset.

Addressing any one of these would cause us to add a substantially new
way to operate virtio devices.

And since it's a guest change anyway, it seemed like a
good time to do the new layout and fix everything in one go.

And they are needed like yesterday.


> So we're stuck with the 1.0 config layout for a very long time.
> 
> Regards,
> 
> Anthony Liguori

Absolutely. This patch let us support both which will allow for
a gradual transition over the next 10 years or so.

> > reason.  I suggest that's 2.0 material...
> >
> > Cheers,
> > Rusty.
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe kvm" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
