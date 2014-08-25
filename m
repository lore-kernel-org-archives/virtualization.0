From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: virtio DMA API?
Date: Mon, 25 Aug 2014 14:54:41 -0400
Message-ID: <20140825185441.GB14061@laptop.dumpdata.com>
References: <CALCETrXaNYA=ffd1M0jUM+Z9Yz_Nhs7W=XCxe9N+0FYT558X6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CALCETrXaNYA=ffd1M0jUM+Z9Yz_Nhs7W=XCxe9N+0FYT558X6g@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andy Lutomirski <luto@amacapital.net>
Cc: virtualization@lists.linux-foundation.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Aug 25, 2014 at 10:18:46AM -0700, Andy Lutomirski wrote:
> Currently, a lot of the virtio code assumes that bus (i.e. hypervisor)
> addresses are the same as physical address.  This is false on Xen, so
> virtio is completely broken.  I wouldn't be surprised if it also
> becomes a problem the first time that someone sticks a physical
> "virtio" device on a 32-bit bus on an ARM SOC with more than 4G RAM.
> 
> Would you accept patches to convert virtio_ring and virtio_pci to use
> the DMA APIs?  I think that the only real catch will be that
> virtio_ring's approach to freeing indirect blocks is currently
> incompatible with the DMA API -- it assumes that knowing the bus
> address is enough to call kfree, and I don't think that the DMA API
> provides a reverse mapping like that.

If you use the dma_map/unmap_sg all of that ends up being stuck in the
sg structure (sg->dma_address ends with the DMA addr, sg_phys(sg) gives
you the physical address).


> 
> --Andy
> 
> -- 
> Andy Lutomirski
> AMA Capital Management, LLC
