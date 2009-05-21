From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qemu: msi irq allocation api
Date: Thu, 21 May 2009 12:24:27 +0300
Message-ID: <20090521092427.GA25309__49242.5584969625$1242898043$gmane$org@redhat.com>
References: <f43fc5580905201021x265ffb8ax36b04a740c9fe92@mail.gmail.com>
	<20090520173536.GA22935@redhat.com>
	<f43fc5580905201044u48a12c13pa8961b7663d1a7bf@mail.gmail.com>
	<20090520182818.GC22935@redhat.com>
	<f43fc5580905201138g52df3570r29242cc50cbbe83a@mail.gmail.com>
	<20090520200224.GA23500@redhat.com>
	<20090520201733.GA23518@redhat.com>
	<f43fc5580905201326p2472ef1dyf9269c5c21b527ef@mail.gmail.com>
	<20090520203335.GC23518@redhat.com>
	<f43fc5580905201344v23e15851u4a7517b9da879604@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <f43fc5580905201344v23e15851u4a7517b9da879604@mail.gmail.com>
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

On Wed, May 20, 2009 at 11:44:57PM +0300, Blue Swirl wrote:
> On 5/20/09, Michael S. Tsirkin <mst@redhat.com> wrote:
> > On Wed, May 20, 2009 at 11:26:42PM +0300, Blue Swirl wrote:
> >  > On 5/20/09, Michael S. Tsirkin <mst@redhat.com> wrote:
> >  > > On Wed, May 20, 2009 at 11:02:24PM +0300, Michael S. Tsirkin wrote:
> >  > >  > On Wed, May 20, 2009 at 09:38:58PM +0300, Blue Swirl wrote:
> >  > >  > > On 5/20/09, Michael S. Tsirkin <mst@redhat.com> wrote:
> >  > >  > > > On Wed, May 20, 2009 at 08:44:31PM +0300, Blue Swirl wrote:
> >  > >  > > >  > On 5/20/09, Michael S. Tsirkin <mst@redhat.com> wrote:
> >  > >  > > >  > > On Wed, May 20, 2009 at 08:21:01PM +0300, Blue Swirl wrote:
> >  > >  > > >  > >  > On 5/20/09, Michael S. Tsirkin <mst@redhat.com> wrote:
> >  > >  > > >  > >  > > define api for allocating/setting up msi-x irqs, and for updating them
> >  > >  > > >  > >  > >  with msi-x vector information, supply implementation in ioapic. Please
> >  > >  > > >  > >  > >  comment on this API: I intend to port my msi-x patch to work on top of
> >  > >  > > >  > >  > >  it.
> >  > >  > > >  > >  > >
> >  > >  > > >  > >  > >  Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> >  > >  > > >  > >  >
> >  > >  > > >  > >  > Sparc64 also uses packets ("mondos", not implemented yet) for
> >  > >  > > >  > >  > interrupt vector data, there the packet size is 8 * 64 bits.
> >  > >  > > >  > >  > I think we should aim for a more generic API that covers this case also.
> >  > >  > > >  > >
> >  > >  > > >  > >
> >  > >  > > >  > > Are you sure this is a good idea? MSI is tied to PCI, and PCI only has
> >  > >  > > >  > >  MSI, not "mondos". What code would benefit from this abstraction?
> >  > >  > > >  >
> >  > >  > > >  > Sparc64 emulation, of course. I think also the API would be neater.
> >  > >  > > >
> >  > >  > > >
> >  > >  > > > Since "mondos" are not interrupts, why use irqs for them?
> >  > >  > >
> >  > >  > > I just said above that they are used for interrupt vector data. What
> >  > >  > > makes you think they are not interrupts?
> >  > >  >
> >  > >  > I'm sorry, I don't really know anything about sparc.
> >  > >  > All I am saying is that in PCI, interrupts never pass data,
> >  > >  > so qemu_set_irq as it is now, is a good API to send them.
> >  > >  >
> >  > >  > For the sparc feature you describe, you probably want to add
> >  > >  > a message data parameter to qemu_set_irq, but it's not
> >  > >  > really useful for MSI.
> >  > >
> >  > >
> >  > > Just to clarify, the main difference is that with MSI/MSI-X
> >  > >  both data and address fields are mostly static, modifying them
> >  > >  involves ioapic and device updates which might be an expensive
> >  > >  operation (e.g. with kvm, needs an extra system call).
> >  > >
> >  > >  So I don't think it makes sense to pass MSI-X data field
> >  > >  with each call to qemu_set_irq.
> >  >
> >  > No, but I think the Sparc situation is the same, the packet data is
> >  > static for the interrupt source in question.
> >
> >
> > So, ok, we could add data update callback and then MSI and sparc
> >  would do their thing there. I'm not convinced I like all this
> >  play with untyped buffers, do you think it's helpful?
> >
> >  If yes, maybe I'll try to code it up and see how does it look.
> 
> Well, get/set_data could be limited to irq.c, ioapic.c could export
> something like get/set_msi_data. MSI callers should only use
> get/set_msi_data. Ditto for get/set_mondo_data.

I started coding it up and got lost in a maze of callbacks and void pointers :)

And I also remembered that besides data, there's a mask and pending bits in msi
(it's ignored in the patch I sent, but I'm fixing that), so there needs
to be an interface for this as well.

I am guessing that using qemu_irq_get_opaque and qemu_irq_get_vector that I
added, you'll find it's easy to implement mondos in very few lines of code.
We can always add another level of indirection later when sparc code
surfaces, if we find it helps.


-- 
MST
