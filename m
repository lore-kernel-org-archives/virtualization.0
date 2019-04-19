From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC PATCH] virtio_ring: Use DMA API if guest memory is encrypted
Date: Fri, 19 Apr 2019 19:09:14 -0400
Message-ID: <20190419190258-mutt-send-email-mst__36786.666284182$1555715392$gmane$org@kernel.org>
References: <87zhrj8kcp.fsf@morokweng.localdomain>
	<87womn8inf.fsf@morokweng.localdomain>
	<20190129134750-mutt-send-email-mst@kernel.org>
	<877eefxvyb.fsf@morokweng.localdomain>
	<20190204144048-mutt-send-email-mst@kernel.org>
	<87ef71seve.fsf@morokweng.localdomain>
	<20190320171027-mutt-send-email-mst@kernel.org>
	<87tvfvbwpb.fsf@morokweng.localdomain>
	<20190323165456-mutt-send-email-mst@kernel.org>
	<87a7go71hz.fsf@morokweng.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <87a7go71hz.fsf@morokweng.localdomain>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Cc: Mike Anderson <andmike@linux.ibm.com>, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Alexey Kardashevskiy <aik@linux.ibm.com>, Ram Pai <linuxram@us.ibm.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Paul Mackerras <paulus@ozlabs.org>, iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>, David Gibson <david@gibson.dropbear.id.au>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Apr 17, 2019 at 06:42:00PM -0300, Thiago Jung Bauermann wrote:
> 
> Michael S. Tsirkin <mst@redhat.com> writes:
> 
> > On Thu, Mar 21, 2019 at 09:05:04PM -0300, Thiago Jung Bauermann wrote:
> >>
> >> Michael S. Tsirkin <mst@redhat.com> writes:
> >>
> >> > On Wed, Mar 20, 2019 at 01:13:41PM -0300, Thiago Jung Bauermann wrote:
> >> >> >From what I understand of the ACCESS_PLATFORM definition, the host will
> >> >> only ever try to access memory addresses that are supplied to it by the
> >> >> guest, so all of the secure guest memory that the host cares about is
> >> >> accessible:
> >> >>
> >> >>     If this feature bit is set to 0, then the device has same access to
> >> >>     memory addresses supplied to it as the driver has. In particular,
> >> >>     the device will always use physical addresses matching addresses
> >> >>     used by the driver (typically meaning physical addresses used by the
> >> >>     CPU) and not translated further, and can access any address supplied
> >> >>     to it by the driver. When clear, this overrides any
> >> >>     platform-specific description of whether device access is limited or
> >> >>     translated in any way, e.g. whether an IOMMU may be present.
> >> >>
> >> >> All of the above is true for POWER guests, whether they are secure
> >> >> guests or not.
> >> >>
> >> >> Or are you saying that a virtio device may want to access memory
> >> >> addresses that weren't supplied to it by the driver?
> >> >
> >> > Your logic would apply to IOMMUs as well.  For your mode, there are
> >> > specific encrypted memory regions that driver has access to but device
> >> > does not. that seems to violate the constraint.
> >>
> >> Right, if there's a pre-configured 1:1 mapping in the IOMMU such that
> >> the device can ignore the IOMMU for all practical purposes I would
> >> indeed say that the logic would apply to IOMMUs as well. :-)
> >>
> >> I guess I'm still struggling with the purpose of signalling to the
> >> driver that the host may not have access to memory addresses that it
> >> will never try to access.
> >
> > For example, one of the benefits is to signal to host that driver does
> > not expect ability to access all memory. If it does, host can
> > fail initialization gracefully.
> 
> But why would the ability to access all memory be necessary or even
> useful? When would the host access memory that the driver didn't tell it
> to access?

When I say all memory I mean even memory not allowed by the IOMMU.


> >> >> >> > But the name "sev_active" makes me scared because at least AMD guys who
> >> >> >> > were doing the sensible thing and setting ACCESS_PLATFORM
> >> >> >>
> >> >> >> My understanding is, AMD guest-platform knows in advance that their
> >> >> >> guest will run in secure mode and hence sets the flag at the time of VM
> >> >> >> instantiation. Unfortunately we dont have that luxury on our platforms.
> >> >> >
> >> >> > Well you do have that luxury. It looks like that there are existing
> >> >> > guests that already acknowledge ACCESS_PLATFORM and you are not happy
> >> >> > with how that path is slow. So you are trying to optimize for
> >> >> > them by clearing ACCESS_PLATFORM and then you have lost ability
> >> >> > to invoke DMA API.
> >> >> >
> >> >> > For example if there was another flag just like ACCESS_PLATFORM
> >> >> > just not yet used by anyone, you would be all fine using that right?
> >> >>
> >> >> Yes, a new flag sounds like a great idea. What about the definition
> >> >> below?
> >> >>
> >> >> VIRTIO_F_ACCESS_PLATFORM_NO_IOMMU This feature has the same meaning as
> >> >>     VIRTIO_F_ACCESS_PLATFORM both when set and when not set, with the
> >> >>     exception that the IOMMU is explicitly defined to be off or bypassed
> >> >>     when accessing memory addresses supplied to the device by the
> >> >>     driver. This flag should be set by the guest if offered, but to
> >> >>     allow for backward-compatibility device implementations allow for it
> >> >>     to be left unset by the guest. It is an error to set both this flag
> >> >>     and VIRTIO_F_ACCESS_PLATFORM.
> >> >
> >> > It looks kind of narrow but it's an option.
> >>
> >> Great!
> >>
> >> > I wonder how we'll define what's an iommu though.
> >>
> >> Hm, it didn't occur to me it could be an issue. I'll try.
> 
> I rephrased it in terms of address translation. What do you think of
> this version? The flag name is slightly different too:
> 
> 
> VIRTIO_F_ACCESS_PLATFORM_NO_TRANSLATION This feature has the same
>     meaning as VIRTIO_F_ACCESS_PLATFORM both when set and when not set,
>     with the exception that address translation is guaranteed to be
>     unnecessary when accessing memory addresses supplied to the device
>     by the driver. Which is to say, the device will always use physical
>     addresses matching addresses used by the driver (typically meaning
>     physical addresses used by the CPU) and not translated further. This
>     flag should be set by the guest if offered, but to allow for
>     backward-compatibility device implementations allow for it to be
>     left unset by the guest. It is an error to set both this flag and
>     VIRTIO_F_ACCESS_PLATFORM.

Thanks, I'll think about this approach. Will respond next week.

> >> > Another idea is maybe something like virtio-iommu?
> >>
> >> You mean, have legacy guests use virtio-iommu to request an IOMMU
> >> bypass? If so, it's an interesting idea for new guests but it doesn't
> >> help with guests that are out today in the field, which don't have A
> >> virtio-iommu driver.
> >
> > I presume legacy guests don't use encrypted memory so why do we
> > worry about them at all?
> 
> They don't use encrypted memory, but a host machine will run a mix of
> secure and legacy guests. And since the hypervisor doesn't know whether
> a guest will be secure or not at the time it is launched, legacy guests
> will have to be launched with the same configuration as secure guests.

OK and so I think the issue is that hosts generally fail if they set
ACCESS_PLATFORM and guests do not negotiate it.
So you can not just set ACCESS_PLATFORM for everyone.
Is that the issue here?


> >> >> > Is there any justification to doing that beyond someone putting
> >> >> > out slow code in the past?
> >> >>
> >> >> The definition of the ACCESS_PLATFORM flag is generic and captures the
> >> >> notion of memory access restrictions for the device. Unfortunately, on
> >> >> powerpc pSeries guests it also implies that the IOMMU is turned on
> >> >
> >> > IIUC that's really because on pSeries IOMMU is *always* turned on.
> >> > Platform has no way to say what you want it to say
> >> > which is bypass the iommu for the specific device.
> >>
> >> Yes, that's correct. pSeries guests running on KVM are in a gray area
> >> where theoretically they use an IOMMU but in practice KVM ignores it.
> >> It's unfortunate but it's the reality on the ground today. :-/
> >
> > Well it's not just the reality, virt setups need something that
> > emulated IOMMUs don't provide. That is not uncommon, e.g.
> > intel's VTD has a "cache mode" field which AFAIK is only used for virt.
> 
> That's good to know. Thanks for this example.
> 
> --
> Thiago Jung Bauermann
> IBM Linux Technology Center
