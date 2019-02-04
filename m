From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: Re: [RFC PATCH] virtio_ring: Use DMA API if guest memory is encrypted
Date: Mon, 04 Feb 2019 16:14:20 -0200
Message-ID: <877eefxvyb.fsf__12761.8025335082$1555717127$gmane$org@morokweng.localdomain>
References: <87zhrj8kcp.fsf@morokweng.localdomain>
	<87womn8inf.fsf@morokweng.localdomain>
	<20190129134750-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-reply-to: <20190129134750-mutt-send-email-mst@kernel.org>
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
Cc: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Alexey Kardashevskiy <aik@linux.ibm.com>, Ram Pai <linuxram@us.ibm.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Paul Mackerras <paulus@ozlabs.org>, iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>, David Gibson <david@gibson.dropbear.id.au>
List-Id: virtualization@lists.linuxfoundation.org


Hello Michael,

Michael S. Tsirkin <mst@redhat.com> writes:

> On Tue, Jan 29, 2019 at 03:42:44PM -0200, Thiago Jung Bauermann wrote:
>>
>> Fixing address of powerpc mailing list.
>>
>> Thiago Jung Bauermann <bauerman@linux.ibm.com> writes:
>>
>> > Hello,
>> >
>> > With Christoph's rework of the DMA API that recently landed, the patch
>> > below is the only change needed in virtio to make it work in a POWER
>> > secure guest under the ultravisor.
>> >
>> > The other change we need (making sure the device's dma_map_ops is NULL
>> > so that the dma-direct/swiotlb code is used) can be made in
>> > powerpc-specific code.
>> >
>> > Of course, I also have patches (soon to be posted as RFC) which hook up
>> > <linux/mem_encrypt.h> to the powerpc secure guest support code.
>> >
>> > What do you think?
>> >
>> > From d0629a36a75c678b4a72b853f8f7f8c17eedd6b3 Mon Sep 17 00:00:00 2001
>> > From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
>> > Date: Thu, 24 Jan 2019 22:08:02 -0200
>> > Subject: [RFC PATCH] virtio_ring: Use DMA API if guest memory is encrypted
>> >
>> > The host can't access the guest memory when it's encrypted, so using
>> > regular memory pages for the ring isn't an option. Go through the DMA API.
>> >
>> > Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
>
> Well I think this will come back to bite us (witness xen which is now
> reworking precisely this path - but at least they aren't to blame, xen
> came before ACCESS_PLATFORM).
>
> I also still think the right thing would have been to set
> ACCESS_PLATFORM for all systems where device can't access all memory.

I understand. The problem with that approach for us is that because we
don't know which guests will become secure guests and which will remain
regular guests, QEMU would need to offer ACCESS_PLATFORM to all guests.

And the problem with that is that for QEMU on POWER, having
ACCESS_PLATFORM turned off means that it can bypass the IOMMU for the
device (which makes sense considering that the name of the flag was
IOMMU_PLATFORM). And we need that for regular guests to avoid
performance degradation.

So while ACCESS_PLATFORM solves our problems for secure guests, we can't
turn it on by default because we can't affect legacy systems. Doing so
would penalize existing systems that can access all memory. They would
all have to unnecessarily go through address translations, and take a
performance hit.

The semantics of ACCESS_PLATFORM assume that the hypervisor/QEMU knows
in advance - right when the VM is instantiated - that it will not have
access to all guest memory. Unfortunately that assumption is subtly
broken on our secure-platform. The hypervisor/QEMU realizes that the
platform is going secure only *after the VM is instantiated*. It's the
kernel running in the VM that determines that it wants to switch the
platform to secure-mode.

Another way of looking at this issue which also explains our reluctance
is that the only difference between a secure guest and a regular guest
(at least regarding virtio) is that the former uses swiotlb while the
latter doens't. And from the device's point of view they're
indistinguishable. It can't tell one guest that is using swiotlb from
one that isn't. And that implies that secure guest vs regular guest
isn't a virtio interface issue, it's "guest internal affairs". So
there's no reason to reflect that in the feature flags.

That said, we still would like to arrive at a proper design for this
rather than add yet another hack if we can avoid it. So here's another
proposal: considering that the dma-direct code (in kernel/dma/direct.c)
automatically uses swiotlb when necessary (thanks to Christoph's recent
DMA work), would it be ok to replace virtio's own direct-memory code
that is used in the !ACCESS_PLATFORM case with the dma-direct code? That
way we'll get swiotlb even with !ACCESS_PLATFORM, and virtio will get a
code cleanup (replace open-coded stuff with calls to existing
infrastructure).

> But I also think I don't have the energy to argue about power secure
> guest anymore.  So be it for power secure guest since the involved
> engineers disagree with me.  Hey I've been wrong in the past ;).

Yeah, it's been a difficult discussion. Thanks for still engaging!
I honestly thought that this patch was a good solution (if the guest has
encrypted memory it means that the DMA API needs to be used), but I can
see where you are coming from. As I said, we'd like to arrive at a good
solution if possible.

> But the name "sev_active" makes me scared because at least AMD guys who
> were doing the sensible thing and setting ACCESS_PLATFORM

My understanding is, AMD guest-platform knows in advance that their
guest will run in secure mode and hence sets the flag at the time of VM
instantiation. Unfortunately we dont have that luxury on our platforms.

> (unless I'm
> wrong? I reemember distinctly that's so) will likely be affected too.
> We don't want that.
>
> So let's find a way to make sure it's just power secure guest for now
> pls.

Yes, my understanding is that they turn ACCESS_PLATFORM on. And because
of that, IIUC this patch wouldn't affect them because in their platform
vring_use_dma_api() returns true earlier in the
"if !virtio_has_iommu_quirk(vdev)" condition.

> I also think we should add a dma_api near features under virtio_device
> such that these hacks can move off data path.

Sorry, I don't understand this.

> By the way could you please respond about virtio-iommu and
> why there's no support for ACCESS_PLATFORM on power?

There is support for ACCESS_PLATFORM on POWER. We don't enable it
because it causes a performance hit.

> I have Cc'd you on these discussions.

I'm having a look at the spec and the patches, but to be honest I'm not
the best powerpc guy for this. I'll see if I can get others to have a
look.

> Thanks!

Thanks as well!

--
Thiago Jung Bauermann
IBM Linux Technology Center
