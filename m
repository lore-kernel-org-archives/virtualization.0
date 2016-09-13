From: Benjamin Serebrin via Virtualization
	<virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH] virtio_pci: Limit DMA mask to 44 bits for legacy virtio
	devices
Date: Mon, 12 Sep 2016 23:11:19 -0700
Message-ID: <CAN+hb0Wu3SqXs7d7wDvg=6+Zh8znKaFjBGH-9gwmYKOVPSNxEg__48477.4145683788$1473747093$gmane$org@mail.gmail.com>
References: <1473682241-21984-1-git-send-email-will.deacon@arm.com>
	<20160912182203-mutt-send-email-mst@kernel.org>
	<20160912155727.GD4792@arm.com>
Reply-To: Benjamin Serebrin <serebrin@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20160912155727.GD4792@arm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Will Deacon <will.deacon@arm.com>
Cc: virtualization@lists.linux-foundation.org, kvm <kvm@vger.kernel.org>, Andy Lutomirski <luto@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Sep 12, 2016 at 8:57 AM, Will Deacon <will.deacon@arm.com> wrote:
>
> On Mon, Sep 12, 2016 at 06:33:43PM +0300, Michael S. Tsirkin wrote:
> > On Mon, Sep 12, 2016 at 01:10:41PM +0100, Will Deacon wrote:
> > > Legacy virtio defines the virtqueue base using a 32-bit PFN field, with
> > > a read-only register indicating a fixed page size of 4k.
> > >
> > > This can cause problems for DMA allocators that allocate top down from
> > > the DMA mask, which is set to 64 bits. In this case, the addresses are
> > > silently truncated to 44-bit, leading to IOMMU faults, failure to read
> > > from the queue or data corruption.
> > >
> > > This patch restricts the DMA mask for legacy PCI virtio devices to
> > > 44 bits, which matches the specification.
> > >
> > > Cc: Andy Lutomirski <luto@kernel.org>
> > > Cc: Michael S. Tsirkin <mst@redhat.com>
> > > Signed-off-by: Will Deacon <will.deacon@arm.com>
> >
> > Hmm - IIUC it's actually only the case for the virtio rings
> > themselves. The buffer addresses put in the rings are full 64 bit ones.
>
> I think that's right, yes.


Yes.

>
>
> > It so happens that virtio doesn't use coherent allocs except
> > for the rings.
> > So I'm inclined to say the coherent mask should be set to 44,
> > with a comment explaning that this is for the rings.
>
> I can certainly add that in v2, along with your suggestion to use
> 32 + VIRTIO_PCI_QUEUE_ADDR_SHIFT instead of the 44.
>
> > In case we start using coherent allocations in virtio,
> > it might be cleaner to relax the mask after allocating
> > the rings, but I'm not sure that's allowed by the DMA API.
> > thoughts?
>
> Hmm, that *might* work, but I could certainly imagine some DMA
> implementations going wrong if they assume the mask is fixed.


There's probably a hack to make the buffer addresses be 64-bit capable
while letting the queue addresses be 44-bit, but is it worth the trouble?
Maybe assume that guests with more than 16 TB of RAM are rare today,
and catch the Virtio 1.x spec to fix the 32-bit PFN limit?

Alternately, you could keep the DMA mask at 64 bits but try to allocate
the rings early, and abort if they can't get a < 16 TB address.  I think
I prefer the 44 bit mask approach, though.


>
>
> Will
> _______________________________________________
> Virtualization mailing list
> Virtualization@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/virtualization
