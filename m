From: Anthony Liguori <aliguori@us.ibm.com>
Subject: Re: [Qemu-devel] Proposal for virtio standardization.
Date: Thu, 04 Oct 2012 13:49:56 -0500
Message-ID: <874nmajcmj.fsf__9889.53479468382$1349391806$gmane$org@codemonkey.ws>
References: <87zk4c2tqq.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <87zk4c2tqq.fsf@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>, Adam Litke <agl@us.ibm.com>, Amit Shah <amit.shah@redhat.com>, Avi Kivity <avi@redhat.com>, Avishay Traeger <AVISHAY@il.ibm.com>, Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ohad Ben-Cohen <ohad@wizery.com>, Paolo Bonzini <pbonzini@redhat.com>, Pawel Moll <pawel.moll@arm.com>, Sasha Levin <levinsasha928@gmail.com>, Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: virtualization@lists.linux-foundation.org, qemu-devel <qemu-devel@nongnu.org>, kvm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Rusty Russell <rusty@rustcorp.com.au> writes:

> Hi all,
>
> 	I've had several requests for a more formal approach to the
> virtio draft spec, and (after some soul-searching) I'd like to try that.
>
> 	The proposal is to use OASIS as the standards body, as it's
> fairly light-weight as these things go.  For me this means paperwork and
> setting up a Working Group and getting the right people involved as
> Voting members starting with the current contributors; for most of you
> it just means a new mailing list, though I'll be cross-posting any
> drafts and major changes here anyway.
>
> 	I believe that a documented standard (aka virtio 1.0) will
> increase visibility and adoption in areas outside our normal linux/kvm
> universe.  There's been some of that already, but this is the clearest
> path to accelerate it.  Not the easiest path, but I believe that a solid
> I/O standard is a Good Thing for everyone.
>
> 	Yet I also want to decouple new and experimental development
> from the standards effort; running code comes first.  New feature bits
> and new device numbers should be reservable without requiring a full
> spec change.
>
> So the essence of my proposal is:
> 1) I start a Working Group within OASIS where we can aim for virtio spec
>    1.0.
>
> 2) The current spec is textually reordered so the core is clearly
>    bus-independent, with PCI, mmio, etc appendices.
>
> 3) Various clarifications, formalizations and cleanups to the spec text,
>    and possibly elimination of old deprecated features.
>
> 4) The only significant change to the spec is that we use PCI
>    capabilities, so we can have infinite feature bits.
>    (see http://lists.linuxfoundation.org/pipermail/virtualization/2011-December/019198.html)

We discussed this on IRC last night.  I don't think PCI capabilites are
a good mechanism to use...

PCI capabilities are there to organize how the PCI config space is
allocated to allow vendor extensions to co-exist with future PCI
extensions.

But we've never used the PCI config space within virtio-pci.  We do
everything in BAR0.  I don't think there's any real advantage of using
the config space vs. a BAR for virtio-pci.

The nice thing about using a BAR is that the region is MMIO or PIO.
This maps really nicely to non-PCI transports too.  But extending the
PCI config space (especially dealing with capability allocation) is
pretty gnarly and there isn't an obvious equivalent outside of PCI.

There are very devices that we emulate today that make use of extended
PCI device registers outside the platform devices (that have no BARs).

Regards,

Anthony Liguori

>
> 5) Changes to the ring layout and other such things are deferred to a
>    future virtio version; whether this is done within OASIS or
>    externally depends on how well this works for the 1.0 release.
>
> Thoughts?
> Rusty.
