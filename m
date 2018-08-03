From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC 0/4] Virtio uses DMA API for all devices
Date: Fri, 03 Aug 2018 13:58:46 -0500
Message-ID: <22310f58605169fe9de83abf78b59f593ff7fbb7.camel@kernel.crashing.org>
References: <20180801083639.GF26378@infradead.org>
	<26c1d3d50d8e081eed44fe9940fbefed34598cbd.camel@kernel.crashing.org>
	<20180802182959-mutt-send-email-mst@kernel.org>
	<82ccef6ec3d95ee43f3990a4a2d0aea87eb45e89.camel@kernel.crashing.org>
	<20180802200646-mutt-send-email-mst@kernel.org>
	<e9beb6bba5a7d05741e27e85b24a3b23ba7c2762.camel@kernel.crashing.org>
	<20180802225738-mutt-send-email-mst@kernel.org>
	<de4888b6457e220776e16a9c8958ff0886ffc66c.camel@kernel.crashing.org>
	<20180803070507.GA1344@infradead.org>
	<eb1750e90e4bd45da297fa6f78f8ef93671b7c2f.camel@kernel.crashing.org>
	<20180803160246.GA13794@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180803160246.GA13794@infradead.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Christoph Hellwig <hch@infradead.org>
Cc: robh@kernel.org, srikar@linux.vnet.ibm.com, "Michael S. Tsirkin" <mst@redhat.com>, mpe@ellerman.id.au, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, linuxram@us.ibm.com, virtualization@lists.linux-foundation.org, paulus@samba.org, marc.zyngier@arm.com, joe@perches.com, robin.murphy@arm.com, david@gibson.dropbear.id.au, linuxppc-dev@lists.ozlabs.org, elfring@users.sourceforge.net, haren@linux.vnet.ibm.com, Anshuman Khandual <khandual@linux.vnet.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 2018-08-03 at 09:02 -0700, Christoph Hellwig wrote:
> On Fri, Aug 03, 2018 at 10:58:36AM -0500, Benjamin Herrenschmidt wrote:
> > On Fri, 2018-08-03 at 00:05 -0700, Christoph Hellwig wrote:
> > > >   2- Make virtio use the DMA API with our custom platform-provided
> > > > swiotlb callbacks when needed, that is when not using IOMMU *and*
> > > > running on a secure VM in our case.
> > > 
> > > And total NAK the customer platform-provided part of this.  We need
> > > a flag passed in from the hypervisor that the device needs all bus
> > > specific dma api treatment, and then just use the normal plaform
> > > dma mapping setup. 
> > 
> > Christoph, as I have explained already, we do NOT have a way to provide
> > such a flag as neither the hypervisor nor qemu knows anything about
> > this when the VM is created.
> 
> Well, if your setup is so fucked up I see no way to support it in Linux.
> 
> Let's end the discussion right now then.

You are saying something along the lines of "I don't like an
instruction in your ISA, let's not support your entire CPU architecture
in Linux".

Our setup is not fucked. It makes a LOT of sense and it's a very
sensible design. It's hitting a problem due to a corner case oddity in
virtio bypassing the MMU, we've worked around such corner cases many
times in the past without any problem, I fail to see what the problem
is here.

We aren't going to cancel years of HW and SW development for our
security infrastructure bcs you don't like a 2 lines hook into virtio
to make things work and aren't willing to even consider the options.

Ben.
