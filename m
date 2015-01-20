From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC] virtio-mmio: Update the device to OASIS spec version
Date: Tue, 20 Jan 2015 19:44:25 +0200
Message-ID: <20150120174425.GA2706@redhat.com>
References: <20150115165101.GA29808@redhat.com>
	<1421343158.4601.7.camel@arm.com>
	<20150115175132.GA30453@redhat.com>
	<1421345477.4601.9.camel@arm.com>
	<20150115182903.GA30947@redhat.com>
	<1421347322.4601.13.camel@arm.com>
	<20150115191203.GA31136@redhat.com>
	<1421689554.17436.30.camel@arm.com>
	<20150119183647.GB5336@redhat.com>
	<1421774303.14076.19.camel@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1421774303.14076.19.camel@arm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Pawel Moll <pawel.moll@arm.com>
Cc: "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jan 20, 2015 at 05:18:23PM +0000, Pawel Moll wrote:
> On Mon, 2015-01-19 at 18:36 +0000, Michael S. Tsirkin wrote:
> > > > > Well, not quite: as of now I've got legacy block device driver happily
> > > > > working on top of compliant (so v2 in MMIO speech) MMIO device - the
> > > > > transport if completely transparent here.
> > > > 
> > > > Spec says explicitly it's an illegal configuration.
> > > 
> > > What part of the spec exactly? The closest I can think of are 2.2.3, 6.2
> > > and 6.3. Both legacy and spec-complaint MMIO transports will satisfy all
> > > requirements from those paragraphs, whether VIRTIO_F_VERSION_1 is
> > > negotiated or not.
> > 
> > The parts that say VIRTIO_F_VERSION_1 MUST be set.
> > I'll look up the chapter and verse later if you like.
> 
> That would be:
> 
> "6.1 Driver Requirements: Reserved Feature Bits
> A driver MUST accept VIRTIO_F_VERSION_1 if it is offered. A driver MAY
> fail to operate further if VIRTIO_F_VERSION_1 is not offered."
> 
> "6.2 Device Requirements: Reserved Feature Bits
> A device MUST offer VIRTIO_F_VERSION_1. A device MAY fail to operate
> further if VIRTIO_F_VERSION_1 is not accepted."

That, and there are a bunch of other changes we made in devices
as compared to virtio 0.9.

> 
> Both are perfectly clear and reasonable for me. And the MMIO transport
> in both versions (pre-spec and the spec one) will meet those
> requirements, as it was able to pass more than 32 features bits from the
> very beginning.

Good. But your current code will also try to support a mix: device that
uses the new transport underneath, but old layout and semantics on top.

This has no value: the spec does *not* define such devices
and it also does not match any hosts, so this just adds to support matrix.
And if linux supports it, someone *will* ship such a
device and we'll be stuck with it forever.

So please, detect out of spec devices and fail gracefully.
pci and s390 do this already.


> > Can you please also add a comment?
> > E.g. 
> >      /*
> >       * MMIO uses ID 0 to mean device not present.  Avoid probing
> >       * the device further: it's sure to fail anyway.
> >       */
> 
> There is a comment:
> 
> > On Fri, 2014-12-19 at 18:38 +0000, Pawel Moll wrote: 
> > > +		/*
> > > +		 * ID 0 means a dummy (placeholder) device, skip quietly
> > > +		 * (as in: no error) with no further actions
> > > +		 */
> > 
> But I'm can use your wording if you find it better.
> 
> Pawel

Either that or combine them in some way.
