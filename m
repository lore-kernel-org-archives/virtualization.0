From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: virtio DMA API?
Date: Wed, 27 Aug 2014 13:52:50 +0200
Message-ID: <20140827115249.GA16850@redhat.com>
References: <CALCETrXaNYA=ffd1M0jUM+Z9Yz_Nhs7W=XCxe9N+0FYT558X6g@mail.gmail.com>
	<87iole89xg.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <87iole89xg.fsf@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, virtualization@lists.linux-foundation.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Andy Lutomirski <luto@amacapital.net>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Aug 27, 2014 at 08:40:51PM +0930, Rusty Russell wrote:
> Andy Lutomirski <luto@amacapital.net> writes:
> > Currently, a lot of the virtio code assumes that bus (i.e. hypervisor)
> > addresses are the same as physical address.  This is false on Xen, so
> > virtio is completely broken.  I wouldn't be surprised if it also
> > becomes a problem the first time that someone sticks a physical
> > "virtio" device on a 32-bit bus on an ARM SOC with more than 4G RAM.
> >
> > Would you accept patches to convert virtio_ring and virtio_pci to use
> > the DMA APIs?  I think that the only real catch will be that
> > virtio_ring's approach to freeing indirect blocks is currently
> > incompatible with the DMA API -- it assumes that knowing the bus
> > address is enough to call kfree, and I don't think that the DMA API
> > provides a reverse mapping like that.
> 
> Hi Andy,
> 
>         This has long been a source of contention.  virtio assumes that
> the hypervisor can decode guest-physical addresses.
> 
>         PowerPC, in particular, doesn't want to pay the cost of IOMMU
> manipulations, and all arguments presented so far for using an IOMMU for
> a virtio device are weak.  And changing to use DMA APIs would break them
> anyway.
> 
>         Of course, it's Just A Matter of Code, so it's possible to
> create a Xen-specific variant which uses the DMA APIs.  I'm not sure
> what that would look like in the virtio standard, however.
> 
> Cheers,
> Rusty.

For x86 as of QEMU 2.0 there's no iommu.
So a reasonable thing to do for that platform
might be to always use iommu *if it's there*.
My understanding is this isn't the case for powerpc?

-- 
MST
