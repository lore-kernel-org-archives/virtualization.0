From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC 0/4] Virtio uses DMA API for all devices
Date: Sun, 05 Aug 2018 10:53:33 +1000
Message-ID: <7fdcb1cb2900755a6534199a675483f60beb47fc.camel@kernel.crashing.org>
References: <20180801083639.GF26378@infradead.org>
	<26c1d3d50d8e081eed44fe9940fbefed34598cbd.camel@kernel.crashing.org>
	<20180802182959-mutt-send-email-mst@kernel.org>
	<82ccef6ec3d95ee43f3990a4a2d0aea87eb45e89.camel@kernel.crashing.org>
	<20180802200646-mutt-send-email-mst@kernel.org>
	<e9beb6bba5a7d05741e27e85b24a3b23ba7c2762.camel@kernel.crashing.org>
	<20180802225738-mutt-send-email-mst@kernel.org>
	<de4888b6457e220776e16a9c8958ff0886ffc66c.camel@kernel.crashing.org>
	<20180803070507.GA1344@infradead.org>
	<20180803221634-mutt-send-email-mst@kernel.org>
	<20180804081500.GA1455@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180804081500.GA1455@infradead.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Christoph Hellwig <hch@infradead.org>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: robh@kernel.org, srikar@linux.vnet.ibm.com, mpe@ellerman.id.au, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, linuxram@us.ibm.com, virtualization@lists.linux-foundation.org, paulus@samba.org, marc.zyngier@arm.com, joe@perches.com, robin.murphy@arm.com, david@gibson.dropbear.id.au, linuxppc-dev@lists.ozlabs.org, elfring@users.sourceforge.net, haren@linux.vnet.ibm.com, Anshuman Khandual <khandual@linux.vnet.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Sat, 2018-08-04 at 01:15 -0700, Christoph Hellwig wrote:
>   b) a way to document in a virtio-related spec how the bus handles
>      dma for Ben's totally fucked up hypervisor.  Without that there
>      is not way we'll get interoperable implementations.

Christoph, this isn't a totally fucked up hypervisor. It's not even
about the hypervisor itself, I mean seriously, man, can you at least
bother reading what I described is going on with the security
architecture ?

Anyway, Michael is onto what could possibly be an alternative approach,
by having us tell qemu to flip to iommu mode at secure VM boot time.
Let's see where that leads.

Cheers,
Ben.
