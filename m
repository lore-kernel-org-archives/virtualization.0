From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC PATCH] virtio_ring: Use DMA API if guest memory is encrypted
Date: Tue, 16 Jul 2019 09:24:06 +1000
Message-ID: <d5b4f80db724da9d7571b614be76dd8b2b57432e.camel__24066.2994723365$1563235327$gmane$org@kernel.crashing.org>
References: <20190323165456-mutt-send-email-mst@kernel.org>
	<87a7go71hz.fsf@morokweng.localdomain>
	<20190520090939-mutt-send-email-mst@kernel.org>
	<877ea26tk8.fsf@morokweng.localdomain>
	<20190603211528-mutt-send-email-mst@kernel.org>
	<877e96qxm7.fsf@morokweng.localdomain>
	<20190701092212-mutt-send-email-mst@kernel.org>
	<87d0id9nah.fsf@morokweng.localdomain>
	<20190715103411-mutt-send-email-mst@kernel.org>
	<874l3nnist.fsf@morokweng.localdomain>
	<20190715163453-mutt-send-email-mst@kernel.org>
	<8736j7neg8.fsf@morokweng.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <8736j7neg8.fsf@morokweng.localdomain>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Thiago Jung Bauermann <bauerman@linux.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Mike Anderson <andmike@linux.ibm.com>, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, Alexey Kardashevskiy <aik@linux.ibm.com>, Ram Pai <linuxram@us.ibm.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Paul Mackerras <paulus@ozlabs.org>, iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>, David Gibson <david@gibson.dropbear.id.au>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 2019-07-15 at 19:03 -0300, Thiago Jung Bauermann wrote:
> > > Indeed. The idea is that QEMU can offer the flag, old guests can
> > > reject
> > > it (or even new guests can reject it, if they decide not to
> > > convert into
> > > secure VMs) and the feature negotiation will succeed with the
> > > flag
> > > unset.
> > 
> > OK. And then what does QEMU do? Assume guest is not encrypted I
> > guess?
> 
> There's nothing different that QEMU needs to do, with or without the
> flag. the perspective of the host, a secure guest and a regular guest
> work the same way with respect to virtio.

This is *precisely* why I was against adding a flag and touch the
protocol negociation with qemu in the first place, back when I cared
about that stuff...

Guys, this has gone in circles over and over again.

This has nothing to do with qemu. Qemu doesn't need to know about this.
It's entirely guest local. This is why the one-liner in virtio was a
far better and simpler solution.

This is something the guest does to itself (with the participation of a
ultravisor but that's not something qemu cares about at this stage, at
least not as far as virtio is concerned).

Basically, the guest "hides" its memory from the host using a HW secure
memory facility. As a result, it needs to ensure that all of its DMA
pages are bounced through insecure pages that aren't hidden. That's it,
it's all guest side. Qemu shouldn't have to care about it at all.

Cheers,
Ben.
