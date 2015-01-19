From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC] virtio-mmio: Update the device to OASIS spec version
Date: Mon, 19 Jan 2015 20:36:47 +0200
Message-ID: <20150119183647.GB5336@redhat.com>
References: <1419014284-18500-1-git-send-email-pawel.moll@arm.com>
	<20150115165101.GA29808@redhat.com>
	<1421343158.4601.7.camel@arm.com>
	<20150115175132.GA30453@redhat.com>
	<1421345477.4601.9.camel@arm.com>
	<20150115182903.GA30947@redhat.com>
	<1421347322.4601.13.camel@arm.com>
	<20150115191203.GA31136@redhat.com>
	<1421689554.17436.30.camel@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1421689554.17436.30.camel@arm.com>
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

On Mon, Jan 19, 2015 at 05:45:54PM +0000, Pawel Moll wrote:
> On Thu, 2015-01-15 at 19:12 +0000, Michael S. Tsirkin wrote:
> > > > > > > > > +static struct device_attribute vm_dev_attr_version =
> > > > > > > > > +             __ATTR(version, S_IRUGO, vm_dev_attr_version_show, NULL);
> > > > > > > > > +
> > > > > > > > >  static int virtio_mmio_probe(struct platform_device *pdev)
> > > > > > > > >  {
> > > > > > > > >       struct virtio_mmio_device *vm_dev;
> > > > > > > > 
> > > > > > > > We already expose feature bits - this one really necessary?
> > > > > > > 
> > > > > > > Necessary? Of course not, just a debugging feature, really, to see what
> > > > > > > version of control registers are available. Useful - I strongly believe
> > > > > > > so.
> > > > > > 
> > > > > > Yes but the point is the same info is already available
> > > > > > in core: just look at feature bit 31.
> > > > > > If you think it's important enough to expose in a decoded
> > > > > > way, let's add this in core?
> > > > > 
> > > > > How do you mean "in core"? It's a mmio-specific value. Content of the
> > > > > VIRTIO_MMIO_VERSION control register.
> > > > 
> > > > Yes but if driver loaded, then revision is always in sync
> > > > with the feature bit.
> > > 
> > > Well, not quite: as of now I've got legacy block device driver happily
> > > working on top of compliant (so v2 in MMIO speech) MMIO device - the
> > > transport if completely transparent here.
> > 
> > Spec says explicitly it's an illegal configuration.
> 
> What part of the spec exactly? The closest I can think of are 2.2.3, 6.2
> and 6.3. Both legacy and spec-complaint MMIO transports will satisfy all
> requirements from those paragraphs, whether VIRTIO_F_VERSION_1 is
> negotiated or not.

The parts that say VIRTIO_F_VERSION_1 MUST be set.
I'll look up the chapter and verse later if you like.

> Make no mistake - I don't know why would anyone wanted to do this kind
> of mishmash (other than for testing purposes), but from the MMIO
> transport point of view, it's not a problem.
> 
> Does the check in finalize_features() solves the problem? If I
> understand correctly it should, so there's nothing more to be done,
> either in the MMIO spec or in the driver.

It does but it must be in driver since there are
transitional drivers so we can't just fail finalize_features
in core.

> > > > If driver failed to attach, attribute is not there
> > > > so can't be used for debugging.
> > > 
> > > Interesting point on its own, haven't thought of that. This is an issue
> > > with platform devices, no standard set of attributes, always available.
> > > Will have a look at this.
> > > 
> > > > > > Absolutely. So what happens if you drop these code lines?
> > > > > > There's no driver registered for this ID, so it's just ignored.
> > > > > > Seems like what spec is asking for, no?
> > > > > 
> > > > > Not to me, no. There will be a vm_dev registered with an _illegal_ ID.
> > > > 
> > > > Yes - there will be a device, but no driver will drive it.
> > > 
> > > A device with an *illegal* ID.
> > 
> > So? The "device" is just a bunch of allocated memory. There's no driver
> > and no one touches is, which is what the spec requires.
> 
> So what exactly is wrong with the "if (id == 0) ignore" case handling? I
> bet a compare-to-zero and a branch in two places takes less memory than
> the allocated struct virtio_device. And certainly takes less cycles (not
> that this matters at all :-). And it's pretty well documented in the
> spec.
> > > > > > > > @@ -496,7 +531,8 @@ static int virtio_mmio_remove(struct platform_device *pdev)
> > > > > > > > >  {
> > > > > > > > >       struct virtio_mmio_device *vm_dev = platform_get_drvdata(pdev);
> > > > > > > > >
> > > > > > > > > -     unregister_virtio_device(&vm_dev->vdev);
> > > > > > > > > +     if (vm_dev)
> > > > > > > > > +             unregister_virtio_device(&vm_dev->vdev);
> > > > > > > > >
> > > > > > > > 
> > > > > > > > Will remove ever be called if probe fails?
> > > > > > > 
> > > > > > > No.
> > > > > > 
> > > > > > Then this if isn't necessary: vm_dev is always set.
> > > > > 
> > > > > Not (in the current code) if ID is 0.
> > > > 
> > > > So just return -ENODEV, then probe will be considered
> > > > failed and remove won't be called.
> > > 
> > > "4.2.2.2 Driver Requirements: MMIO Device Register Layout 
> > > 
> > > The driver MUST ignore a device with DeviceID 0x0, but MUST NOT report any error."
> > > 
> > > Returning -ENODEV *reports* an error.
> > 
> > Reports to whom? Do you refer to http://xkcd.com/838/ ?
> > ENODEV is not "reported". 
> 
> No, you're right - -ENODEV doesn't print out "probe of xxx failed with
> error yyy" message, I was wrong. I'm pretty sure I tried it before (I
> was hoping to find an error which would block probing in a silent way)
> and I saw something, but it was probably the pr_debug() level message.
> 
> > It's just a function return value,
> > it tells kernel not to call remove.
> > Users don't know: module probe succeeds, core will not print any errors, user is not
> > queried.
> > 
> > What happens with your patch? Driver is attached to
> > device (check where does driver attribute points to!),
> > but doesn't do anything.
> > 
> > Looks like if you just keep going, you'll achieve
> > the same result.
> 
> Yes, returning -ENODEV when ID == 0 seems perfectly fine for me.
>
> > > > Or - better - just register the device, it's harmless
> > > > as no driver will try to attach to it, and there
> > > > won't be any need to special-case it.
> > > 
> > > Really, you may want to refresh your memory. We've been there. This *is*
> > > a special case. Intentionally.
> > 
> > Hmm I found https://issues.oasis-open.org/browse/VIRTIO-7
> > but the resolution there is merely asking that no driver
> > matches ID 0. Seems OK.
> > The MMIO changes were all made as part of
> > https://issues.oasis-open.org/browse/VIRTIO-44
> > Anyway, my memory is irrelevant, we need to document motivation
> > for kernel code changes for future readers.
> 
> As a refresher:
> 
> https://lists.oasis-open.org/archives/virtio/201307/msg00035.html
> 
> and in particular:
> 
> > On Wed, 2013-07-31 at 15:04 +0100, Michael S. Tsirkin wrote: 
> > > I meant using standard bus specific things where we are describing bus
> > > specific behaviour.
> > > In this case, I think you really want a "no device" flag for
> > > virtio-mmio which originally lacked device presence detection.
> > > I think for this purpose, it is best to to:
> > > 1. declare device ID 0 (or e.g. FFFF) as reserved and illegal for devices,
> > >    explicitly in core spec
> > > 2. in the mmio appendix, say that if ID 0 (or FFFF) is detected, this
> > >    means device not present
> > > I think this is the cleaner approach than saying there's
> > > a dummy "null device" in particular because
> > > 1. there won't be dummy devices on the bus, in sysfs etc
> > > 2. down the road you will be able to support hotplug.

Okay, I see, thanks!

> It seems that you personally weren't happy about "dummy devices on the
> bus"...
> 
> >  It seems that dropping this
> > chunk satisfies the spec, so if not true, let's add a comment in code
> > that explains why.
> > 
> > Assume you stick in device with ID 0.
> > kernel probes the device, and then sees there is no driver
> > and leaves it alone.
> > Seems perfect, matches the spec.
> > 
> > Do you have a config that's not handled well here?
> 
> The end effect will be the same, I agree. I simply disagree with your
> claim that it matches the spec and I see no point of discussing this
> subject further. I'm going to keep the special case with -ENODEV in the
> driver and apply other changes you suggested. If you want you can NAK
> the updated patch and we'll find someone to resolve the argument.
> 
> Pawel

Can you please also add a comment?
E.g. 
     /*
      * MMIO uses ID 0 to mean device not present.  Avoid probing
      * the device further: it's sure to fail anyway.
      */
