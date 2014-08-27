From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: virtio DMA API?
Date: Thu, 28 Aug 2014 07:31:16 +1000
Message-ID: <1409175076.25772.156.camel@pasglop>
References: <CALCETrXaNYA=ffd1M0jUM+Z9Yz_Nhs7W=XCxe9N+0FYT558X6g@mail.gmail.com>
	<87iole89xg.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Andy Lutomirski <luto@amacapital.net>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 2014-08-27 at 20:40 +0930, Rusty Russell wrote:

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

So this has popped up in the past a few times already from people who
want to use virtio as a transport between physical systems connected
via a bus like PCI using non-transparent bridges for example.

There's a way to get both here that isn't too nasty... we can make the
virtio drivers use the dma_map_* APIs and just switch the dma_ops in
the struct device based on the hypervisor requirements. IE. For KVM we
could attach a set of ops that basically just return the physical
address, real PCI transport would use the normal callbacks etc...

The only problem at the moment is that the dma_map_ops, while
defined generically, aren't plumbed into the generic struct device
but instead on some architectures dev_archdata. This includes
powerpc, ARM and x86 (under a CONFIG option for the latter which
is only enabled on x86_64 and some oddball i386 variant).

So either we switch to have all architectures we care about always
use the generic DMA ops and move the pointer to struct device, or
we create another inline "indirection" to deal with the cases
without the dma_map_ops...

Cheers,
Ben.
