From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC 7/11] virtio_pci: new, capability-aware driver.
Date: Thu, 12 Jan 2012 07:46:04 +1100
Message-ID: <1326314764.23910.128.camel@pasglop>
References: <20111212182533.GB25916@redhat.com>
	<87liqhtdnj.fsf@rustcorp.com.au> <20111215063004.GA3630@redhat.com>
	<87zketp9nz.fsf@rustcorp.com.au> <20111218101831.GB30374@redhat.com>
	<87bor5nlht.fsf@rustcorp.com.au> <20111219091324.GA19535@redhat.com>
	<871us0om2t.fsf@rustcorp.com.au> <20111220113718.GF3913@redhat.com>
	<878vm6daqy.fsf@rustcorp.com.au> <20120110170334.GA18404@redhat.com>
	<8762gj6q5r.fsf@rustcorp.com.au>
	<CAJSP0QU_viNks2jv003c8+gYWFkyW=FvZpU5w6wyroeEyFkXsA@mail.gmail.com>
	<1326273019.23910.118.camel@pasglop>
	<CAJSP0QWMBhsg9ExmTsDG7d32p=7tokCPpm5Z0DMAm2_ADvvb+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAJSP0QWMBhsg9ExmTsDG7d32p=7tokCPpm5Z0DMAm2_ADvvb+g@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Pawel Moll <pawel.moll@arm.com>, "Michael S. Tsirkin" <mst@redhat.com>, virtualization <virtualization@lists.linux-foundation.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Sasha Levin <levinsasha928@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 2012-01-11 at 14:28 +0000, Stefan Hajnoczi wrote:
> On Wed, Jan 11, 2012 at 9:10 AM, Benjamin Herrenschmidt
> <benh@kernel.crashing.org> wrote:
> > On Wed, 2012-01-11 at 08:47 +0000, Stefan Hajnoczi wrote:
> >>
> >> This is also an opportunity to stop using CPU physical addresses in
> >> the ring and instead perform DMA like a normal PCI device (use bus
> >> addresses).
> >
> > Euh why ?
> 
> Because it's a paravirt hack that ends up hitting corner cases.  It's
> not possible to do virtio-pci passthrough under nested virtualization
> unless we use an IOMMU.  Imagine passing virtio-net from L0 into the
> L2 guest (i.e. PCI-passthrough).  If virtio-pci is really "PCI" this
> should be possible but it's not when we use physical addresses instead
> of bus addresses.

Is this just an academic exercise or is there any actual value in doing
this ?

Using an iommu is going to slaugher your performance, so at the very
least it should be kept an option.

Yes, it's a paravirt "hack" as you call it but that's what virtio is all
about.... paravirt. If you prefer you can emulate a real HW device :-)

Ben.
