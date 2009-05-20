From: Blue Swirl <blauwirbel@gmail.com>
Subject: Re: [Qemu-devel] [PATCH] qemu: msi irq allocation api
Date: Wed, 20 May 2009 20:44:31 +0300
Message-ID: <f43fc5580905201044u48a12c13pa8961b7663d1a7bf__40744.1292926252$1242844760$gmane$org@mail.gmail.com>
References: <20090520162130.GA22109@redhat.com>
	<f43fc5580905201021x265ffb8ax36b04a740c9fe92@mail.gmail.com>
	<20090520173536.GA22935@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090520173536.GA22935@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Carsten Otte <cotte@de.ibm.com>, kvm@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, avi@redhat.com, Anthony Liguori <anthony@codemonkey.ws>
List-Id: virtualization@lists.linuxfoundation.org

On 5/20/09, Michael S. Tsirkin <mst@redhat.com> wrote:
> On Wed, May 20, 2009 at 08:21:01PM +0300, Blue Swirl wrote:
>  > On 5/20/09, Michael S. Tsirkin <mst@redhat.com> wrote:
>  > > define api for allocating/setting up msi-x irqs, and for updating them
>  > >  with msi-x vector information, supply implementation in ioapic. Please
>  > >  comment on this API: I intend to port my msi-x patch to work on top of
>  > >  it.
>  > >
>  > >  Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>  >
>  > Sparc64 also uses packets ("mondos", not implemented yet) for
>  > interrupt vector data, there the packet size is 8 * 64 bits.
>  > I think we should aim for a more generic API that covers this case also.
>
>
> Are you sure this is a good idea? MSI is tied to PCI, and PCI only has
>  MSI, not "mondos". What code would benefit from this abstraction?

Sparc64 emulation, of course. I think also the API would be neater.

>  > For example, irq.c could support opaque packet payload of
>  > unspecified/predefined size.  MSI packet structure should be defined
>  > in ioapic.c.
>
>
> Note that MSI does not have packets and MSI interrupts do not pass any payload.

I don't know too much about MSI, what's the 'data' field in msi_state then?
