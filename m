From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: udev PATH_ID for virtio devices
Date: Tue, 25 Aug 2015 14:43:21 +0300
Message-ID: <20150825144034-mutt-send-email-mst@redhat.com>
References: <CAG-2HqURZE_KtaxOx=9YH+9W0Ar56SLvcvLB6Be6QS3mvVTdWA@mail.gmail.com>
	<20140327173009.GA2593@redhat.com>
	<CAPXgP12KbrUhpQyXxXnEo80-xyDz4089Y9uwtd7b5OGH9tSguQ@mail.gmail.com>
	<20140327185902.GA4059@redhat.com>
	<CAPXgP10kov-O2ecWBhyBA3rRj_t7FHYy2jn8LyjVvMu-ozxWAQ@mail.gmail.com>
	<20140327191355.GB4114@redhat.com>
	<CAPXgP12FjjRrT2bLf1pTp5APJxL2fyG1iBbbYtt3zE_XD+PLgQ@mail.gmail.com>
	<CAG-2HqWFQB2C90z4btpoEfMv25C_t7ZAXnRzyGunTGd3EcUc9A@mail.gmail.com>
	<20140327205827.GA4440@redhat.com>
	<CAG-2HqUzkk6DE776K7gH=Z5_RkdhZ90nGHVUwm7MYB-tgrj0AA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CAG-2HqUzkk6DE776K7gH=Z5_RkdhZ90nGHVUwm7MYB-tgrj0AA@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Tom Gundersen <teg@jklm.no>
Cc: Kay Sievers <kay@vrfy.org>, Harald Hoyer <harald@redhat.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Aug 24, 2015 at 06:10:01PM +0200, Tom Gundersen wrote:
> On Thu, Mar 27, 2014 at 9:58 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> > On Thu, Mar 27, 2014 at 09:24:10PM +0100, Tom Gundersen wrote:
> >> On Thu, Mar 27, 2014 at 8:25 PM, Kay Sievers <kay@vrfy.org> wrote:
> >> > On Thu, Mar 27, 2014 at 8:13 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> >> >> On Thu, Mar 27, 2014 at 08:06:15PM +0100, Kay Sievers wrote:
> >> >>> On Thu, Mar 27, 2014 at 7:59 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> >> >>> > On Thu, Mar 27, 2014 at 07:43:34PM +0100, Kay Sievers wrote:
> >> >>> >> On Thu, Mar 27, 2014 at 6:30 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> >> >>> >>
> >> >>> >> > If the virtio device is a PCI device, it is really best to
> >> >>> >> > treat it like you treat any other PCI function (I guess you mean
> >> >>> >> > function and not device, right? We support multifunction
> >> >>> >> > devices and some people do pack multiple NICs in a single device)..
> >> >>> >> >
> >> >>> >> > At the moment many devices in a single pci function can not happen on a
> >> >>> >> > PCI system (no multiport) but if we add multiport, we'll follow some
> >> >>> >> > existing standard to expose this information to the guest.
> >> >>> >>
> >> >>> >> This means, that there can currently never multiple devices below one
> >> >>> >> and the same virtio parent device?
> >> >>>
> >> >>> > There's a single virtio device per pci function (you keep saying
> >> >>> > device but I hope the distinction is clear and this is
> >> >>> > just slip of the tongue).
> >> >>>
> >> >>> Right, we talks about sysfs directories and they are called "device",
> >> >>> we don't really care about the actual bus that is implemented,
> >> >>> userspace does not really know much about them. :)
> >> >>>
> >> >>> > For net devices under a pci function that is also currently the case,
> >> >>> > but I can't yet tell you for sure ahead of the time how we'll present
> >> >>> > multiport devices if we ever implement them.
> >> >>> >
> >> >>> > I'm guessing there will be multiple net devices under
> >> >>> > a single pci device and we'll present a sysfs attribute with the port
> >> >>> > number in this case.
> >> >>> >
> >> >>> > Hmm maybe we should go ahead and add a place-holder
> >> >>> > attribute so that it's future-proof?
> >> >>> >
> >> >>> > I'll write a patch like that and we'll see how it's accepted.
> >> >>>
> >> >>> Netdevs with multiple ports are represented with the standard "dev_id"
> >> >>> attribute identifying the instance of the driver per parent "device";
> >> >>> should all work already from the userspace side, if the virtio side
> >> >>> would use that too.
> >> >>>
> >> >>> Kay
> >> >>
> >> >> Aha. In that case it's easy - pls assume that if and when we implement
> >> >> multiple we'll just follow standards and use dev_id.
> >> >> For virtio pci devices specifically virtio<->pci 1:1 mapping is set
> >> >> in stone in the spec.
> >> >>
> >> >> Non pci ones need to be examined separately.
> >> >
> >> > Nice, thanks. That means we can just "jump over" the "virtio*" device
> >> > (device as in sysfs view), and let the pci parent let identify the
> >> > device.
> >> >
> >> > Background: The logic for device naming generally refuses to touch
> >> > devices with unknown parent devices in the chain (the directories you
> >> > see for: ls -l /sys/class/net/), because the parents *could* offer
> >> > their own bus logic that exposes multiple devices below and we would
> >> > create clashing names for them. That's why the virt vs. non-virt case
> >> > needs to be handled explicitly (seems in this case by just skipping
> >> > it) and it is not necessarily by default the same behaviour.
> >>
> >> So Kay and I discussed this a bit more, and found that we likely
> >> cannot handle virtio nic's nicely. As we would name them based on the
> >> pci geo, we rely on this being stable between reboots and when
> >> adding/removing hardware. Is there some way to make this work with
> >> virtio, or will the 'fake' pci busses simply be enumerated as they are
> >> created?
> >>
> >> Cheers,
> >>
> >> Tom
> >
> > I think it's standard PCI thing.
> > Some pci bridges have a slot id register - I'm assuming you
> > are using these if present?
> >
> > If not you'll either need to rely on firmware enumerating buses
> > consistently, or use the mac of the NIC.
> 
> Hi Michael,
> 
> Sorry to resurrect such an old thread, but this suddenly became
> relevant again and I see that we never really reached a conclusion.
> Rereading the discussion it is still not really clear to me what the
> API promise is, so let me try to rephrase what we need and hopefully
> you can help me understand where we are at.
> 
> My understanding is that the enumeration of virtioX buses is global
> rather than local to the direct parent device of a given bus. That
> means that we cannot base deterministic naming of child devices
> (functions) on virtio enumeration, as the names would then depend on
> the presence or absence of unrelated virtio buses on the system.
> 
> We have two options that would allow us to get around this:
> 
> 1) if there is a guarantee now and in the future (even if only
> restricted to netdevs) that no virtio bus will have a direct sibling
> bus (i.e., with the same parent device); or

I think this is the case. The virtio bus is an artifact.
There's always a single one behind each pci device.
Is this sufficient?

> 2) if the enumeration of virtio buses was extended with a "port"
> numebr which was guaranteed to be made local to their direct parent
> device and moreover be made deterministic. I.e., if there are no
> virtio sibling buses (but there may be other unrelated virtio buses)
> the name would always be virtioX.0, and if there are two buses with
> the same parent their names would always be virtioX.0 and virtioX.1
> and always in the same order.
> 
> Is either of those things something that is already guaranteed or
> something that could be made working?
> 
> Cheers,
> 
> Tom
