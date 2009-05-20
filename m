From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qemu: msi irq allocation api
Date: Wed, 20 May 2009 23:29:14 +0300
Message-ID: <20090520202914.GB23518__43098.4747516506$1242851460$gmane$org@redhat.com>
References: <20090520162130.GA22109@redhat.com>
	<f43fc5580905201021x265ffb8ax36b04a740c9fe92@mail.gmail.com>
	<20090520173536.GA22935@redhat.com>
	<f43fc5580905201044u48a12c13pa8961b7663d1a7bf@mail.gmail.com>
	<20090520182818.GC22935@redhat.com>
	<f43fc5580905201138g52df3570r29242cc50cbbe83a@mail.gmail.com>
	<20090520200224.GA23500@redhat.com>
	<f43fc5580905201318l7d9d2d5ah8fc0745950c52167@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <f43fc5580905201318l7d9d2d5ah8fc0745950c52167@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Blue Swirl <blauwirbel@gmail.com>
Cc: Carsten Otte <cotte@de.ibm.com>, kvm@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, avi@redhat.com, Anthony Liguori <anthony@codemonkey.ws>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, May 20, 2009 at 11:18:56PM +0300, Blue Swirl wrote:
> On 5/20/09, Michael S. Tsirkin <mst@redhat.com> wrote:
> > On Wed, May 20, 2009 at 09:38:58PM +0300, Blue Swirl wrote:
> >  > On 5/20/09, Michael S. Tsirkin <mst@redhat.com> wrote:
> >  > > On Wed, May 20, 2009 at 08:44:31PM +0300, Blue Swirl wrote:
> >  > >  > On 5/20/09, Michael S. Tsirkin <mst@redhat.com> wrote:
> >  > >  > > On Wed, May 20, 2009 at 08:21:01PM +0300, Blue Swirl wrote:
> >  > >  > >  > On 5/20/09, Michael S. Tsirkin <mst@redhat.com> wrote:
> >  > >  > >  > > define api for allocating/setting up msi-x irqs, and for updating them
> >  > >  > >  > >  with msi-x vector information, supply implementation in ioapic. Please
> >  > >  > >  > >  comment on this API: I intend to port my msi-x patch to work on top of
> >  > >  > >  > >  it.
> >  > >  > >  > >
> >  > >  > >  > >  Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> >  > >  > >  >
> >  > >  > >  > Sparc64 also uses packets ("mondos", not implemented yet) for
> >  > >  > >  > interrupt vector data, there the packet size is 8 * 64 bits.
> >  > >  > >  > I think we should aim for a more generic API that covers this case also.
> >  > >  > >
> >  > >  > >
> >  > >  > > Are you sure this is a good idea? MSI is tied to PCI, and PCI only has
> >  > >  > >  MSI, not "mondos". What code would benefit from this abstraction?
> >  > >  >
> >  > >  > Sparc64 emulation, of course. I think also the API would be neater.
> >  > >
> >  > >
> >  > > Since "mondos" are not interrupts, why use irqs for them?
> >  >
> >  > I just said above that they are used for interrupt vector data. What
> >  > makes you think they are not interrupts?
> >
> >
> > I'm sorry, I don't really know anything about sparc.
> >  All I am saying is that in PCI, interrupts never pass data,
> >  so qemu_set_irq as it is now, is a good API to send them.
> >
> >  For the sparc feature you describe, you probably want to add
> >  a message data parameter to qemu_set_irq, but it's not
> >  really useful for MSI.
> 
> But maybe this API would be useful for both MSI and mondo packets:
> /* Get vector data stored in the irq */
> void *qemu_irq_get_data(qemu_irq irq);

Hmm. Yes, it would work for MSI.
However I am thinking ahead to kvm support, which needs to
update the irqchip (with a system call) on each state update.
So 
- I really need a callback on data update
- data update might fail

Which if added to the generic API would make it too complex,
IMO.

> /* Set vector data stored in the irq */
> void qemu_irq_set_data(qemu_irq irq, void *data);
> You'd use a struct msi_state as the opaque (not using the array
> indexed by irq number), I'd use some kind of
> struct mondo {
>  uint64_t packet[8];
> };
> 
> Instead of ioapic_update_msi(), you'd call qemu_irq_set_data().

I guess it's a matter of taste, personally I prefer type-safe functions
to hiding everything in typeless void* buffers.

-- 
MST
