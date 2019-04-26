From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: Re: [RFC PATCH] virtio_ring: Use DMA API if guest memory is encrypted
Date: Fri, 26 Apr 2019 20:56:43 -0300
Message-ID: <871s1o1ft0.fsf__41532.3881710478$1556323169$gmane$org@morokweng.localdomain>
References: <20190129134750-mutt-send-email-mst@kernel.org>
	<877eefxvyb.fsf@morokweng.localdomain>
	<20190204144048-mutt-send-email-mst@kernel.org>
	<87ef71seve.fsf@morokweng.localdomain>
	<20190320171027-mutt-send-email-mst@kernel.org>
	<87tvfvbwpb.fsf@morokweng.localdomain>
	<20190323165456-mutt-send-email-mst@kernel.org>
	<87a7go71hz.fsf@morokweng.localdomain>
	<20190419190258-mutt-send-email-mst@kernel.org>
	<875zr228zf.fsf@morokweng.localdomain>
	<20190424210813-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-reply-to: <20190424210813-mutt-send-email-mst@kernel.org>
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
Cc: Mike Anderson <andmike@linux.ibm.com>, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Alexey Kardashevskiy <aik@linux.ibm.com>, Ram Pai <linuxram@us.ibm.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Paul Mackerras <paulus@ozlabs.org>, iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>, David Gibson <david@gibson.dropbear.id.au>
List-Id: virtualization@lists.linuxfoundation.org


Michael S. Tsirkin <mst@redhat.com> writes:

> On Wed, Apr 24, 2019 at 10:01:56PM -0300, Thiago Jung Bauermann wrote:
>>
>> Michael S. Tsirkin <mst@redhat.com> writes:
>>
>> > On Wed, Apr 17, 2019 at 06:42:00PM -0300, Thiago Jung Bauermann wrote:
>> >>
>> >> Michael S. Tsirkin <mst@redhat.com> writes:
>> >>
>> >> > On Thu, Mar 21, 2019 at 09:05:04PM -0300, Thiago Jung Bauermann wrote:
>> >> >>
>> >> >> Michael S. Tsirkin <mst@redhat.com> writes:
>> >> >>
>> >> >> > On Wed, Mar 20, 2019 at 01:13:41PM -0300, Thiago Jung Bauermann wrote:
>> >> >> >> >From what I understand of the ACCESS_PLATFORM definition, the host will
>> >> >> >> only ever try to access memory addresses that are supplied to it by the
>> >> >> >> guest, so all of the secure guest memory that the host cares about is
>> >> >> >> accessible:
>> >> >> >>
>> >> >> >>     If this feature bit is set to 0, then the device has same access to
>> >> >> >>     memory addresses supplied to it as the driver has. In particular,
>> >> >> >>     the device will always use physical addresses matching addresses
>> >> >> >>     used by the driver (typically meaning physical addresses used by the
>> >> >> >>     CPU) and not translated further, and can access any address supplied
>> >> >> >>     to it by the driver. When clear, this overrides any
>> >> >> >>     platform-specific description of whether device access is limited or
>> >> >> >>     translated in any way, e.g. whether an IOMMU may be present.
>> >> >> >>
>> >> >> >> All of the above is true for POWER guests, whether they are secure
>> >> >> >> guests or not.
>> >> >> >>
>> >> >> >> Or are you saying that a virtio device may want to access memory
>> >> >> >> addresses that weren't supplied to it by the driver?
>> >> >> >
>> >> >> > Your logic would apply to IOMMUs as well.  For your mode, there are
>> >> >> > specific encrypted memory regions that driver has access to but device
>> >> >> > does not. that seems to violate the constraint.
>> >> >>
>> >> >> Right, if there's a pre-configured 1:1 mapping in the IOMMU such that
>> >> >> the device can ignore the IOMMU for all practical purposes I would
>> >> >> indeed say that the logic would apply to IOMMUs as well. :-)
>> >> >>
>> >> >> I guess I'm still struggling with the purpose of signalling to the
>> >> >> driver that the host may not have access to memory addresses that it
>> >> >> will never try to access.
>> >> >
>> >> > For example, one of the benefits is to signal to host that driver does
>> >> > not expect ability to access all memory. If it does, host can
>> >> > fail initialization gracefully.
>> >>
>> >> But why would the ability to access all memory be necessary or even
>> >> useful? When would the host access memory that the driver didn't tell it
>> >> to access?
>> >
>> > When I say all memory I mean even memory not allowed by the IOMMU.
>>
>> Yes, but why? How is that memory relevant?
>
> It's relevant when driver is not trusted to only supply correct
> addresses. The feature was originally designed to support userspace
> drivers within guests.

Ah, thanks for clarifying. I don't think that's a problem in our case.
If the guest provides an incorrect address, the hardware simply won't
allow the host to access it.

>> >> >> > Another idea is maybe something like virtio-iommu?
>> >> >>
>> >> >> You mean, have legacy guests use virtio-iommu to request an IOMMU
>> >> >> bypass? If so, it's an interesting idea for new guests but it doesn't
>> >> >> help with guests that are out today in the field, which don't have A
>> >> >> virtio-iommu driver.
>> >> >
>> >> > I presume legacy guests don't use encrypted memory so why do we
>> >> > worry about them at all?
>> >>
>> >> They don't use encrypted memory, but a host machine will run a mix of
>> >> secure and legacy guests. And since the hypervisor doesn't know whether
>> >> a guest will be secure or not at the time it is launched, legacy guests
>> >> will have to be launched with the same configuration as secure guests.
>> >
>> > OK and so I think the issue is that hosts generally fail if they set
>> > ACCESS_PLATFORM and guests do not negotiate it.
>> > So you can not just set ACCESS_PLATFORM for everyone.
>> > Is that the issue here?
>>
>> Yes, that is one half of the issue. The other is that even if hosts
>> didn't fail, existing legacy guests wouldn't "take the initiative" of
>> not negotiating ACCESS_PLATFORM to get the improved performance. They'd
>> have to be modified to do that.
>
> So there's a non-encrypted guest, hypervisor wants to set
> ACCESS_PLATFORM to allow encrypted guests but that will slow down legacy
> guests since their vIOMMU emulation is very slow.

Yes.

> So enabling support for encryption slows down non-encrypted guests. Not
> great but not the end of the world, considering even older guests that
> don't support ACCESS_PLATFORM are completely broken and you do not seem
> to be too worried by that.

Well, I guess that would be the third half of the issue. :-)

> For future non-encrypted guests, bypassing the emulated IOMMU for when
> that emulated IOMMU is very slow might be solvable in some other way,
> e.g. with virtio-iommu. Which reminds me, could you look at
> virtio-iommu as a solution for some of the issues?
> Review of that patchset from that POV would be appreciated.

Yes, I will have a look. As you mentioned already, virtio-iommu doesn't
define a way to request iommu bypass for a device so that would have to
be added.

Though to be honest in practice I don't think such a feature in
virtio-iommu would make things easier for us, at least in the short
term. It would take the same effort to define a powerpc-specific
hypercall to accomplish the same thing (easier, in fact since we
wouldn't have to implement the rest of virtio-iommu). In fact, there
already is such hypercall, but it is only defined for VIO devices
(RTAS_IBM_SET_TCE_BYPASS in QEMU). We would have to make it work on
virtio devices as well.

--
Thiago Jung Bauermann
IBM Linux Technology Center
