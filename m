From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC 3/11] pci: add pci_iomap_range
Date: Thu, 15 Dec 2011 10:30:49 +0200
Message-ID: <20111215083048.GB3630@redhat.com>
References: <87pqfzgy6p.fsf@rustcorp.com.au> <87hb1bgxpt.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <87hb1bgxpt.fsf@rustcorp.com.au>
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
Cc: Sasha Levin <levinsasha928@gmail.com>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Dec 08, 2011 at 09:02:46PM +1030, Rusty Russell wrote:
> From: Michael S Tsirkin <mst@redhat.com>
> 
> Virtio drivers should map the part of the range they need, not necessarily
> all of it.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>


I think that we should add a forcenocache flag.
This will let devices put the cap structure in
the prefetcheable BAR. That has an advantage that
it can be located anywhere in the 2^64 space,
while non-prefetcheable BARs are limited to lower 4G
for devices behind a PCI-to-PCI bridge.

> ---
>  include/asm-generic/io.h    |    4 ++++
>  include/asm-generic/iomap.h |   11 +++++++++++
>  lib/iomap.c                 |   41 ++++++++++++++++++++++++++++++++++++-----
>  3 files changed, 51 insertions(+), 5 deletions(-)
> 
> diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
> index 9120887..3cf1787 100644
> --- a/include/asm-generic/io.h
> +++ b/include/asm-generic/io.h
> @@ -286,6 +286,10 @@ static inline void writesb(const void __iomem *addr, const void *buf, int len)
>  /* Create a virtual mapping cookie for a PCI BAR (memory or IO) */
>  struct pci_dev;
>  extern void __iomem *pci_iomap(struct pci_dev *dev, int bar, unsigned long max);
> +extern void __iomem *pci_iomap_range(struct pci_dev *dev, int bar,
> +				     unsigned offset,
> +				     unsigned long minlen,
> +				     unsigned long maxlen);
>  static inline void pci_iounmap(struct pci_dev *dev, void __iomem *p)
>  {
>  }
> diff --git a/include/asm-generic/iomap.h b/include/asm-generic/iomap.h
> index 98dcd76..6f192d4 100644
> --- a/include/asm-generic/iomap.h
> +++ b/include/asm-generic/iomap.h
> @@ -70,8 +70,19 @@ extern void ioport_unmap(void __iomem *);
>  /* Create a virtual mapping cookie for a PCI BAR (memory or IO) */
>  struct pci_dev;
>  extern void __iomem *pci_iomap(struct pci_dev *dev, int bar, unsigned long max);
> +extern void __iomem *pci_iomap_range(struct pci_dev *dev, int bar,
> +				     unsigned offset,
> +				     unsigned long minlen,
> +				     unsigned long maxlen);
>  extern void pci_iounmap(struct pci_dev *dev, void __iomem *);
>  #else
> +static inline void __iomem *pci_iomap_range(struct pci_dev *dev, int bar,
> +					    unsigned offset,
> +					    unsigned long minlen,
> +					    unsigned long maxlen)
> +{
> +	return NULL;
> +}
>  struct pci_dev;
>  static inline void __iomem *pci_iomap(struct pci_dev *dev, int bar, unsigned long max)
>  {
> diff --git a/lib/iomap.c b/lib/iomap.c
> index 5dbcb4b..93ae915 100644
> --- a/lib/iomap.c
> +++ b/lib/iomap.c
> @@ -243,26 +243,37 @@ EXPORT_SYMBOL(ioport_unmap);
>  
>  #ifdef CONFIG_PCI
>  /**
> - * pci_iomap - create a virtual mapping cookie for a PCI BAR
> + * pci_iomap_range - create a virtual mapping cookie for a PCI BAR
>   * @dev: PCI device that owns the BAR
>   * @bar: BAR number
> - * @maxlen: length of the memory to map
> + * @offset: map memory at the given offset in BAR
> + * @minlen: min length of the memory to map
> + * @maxlen: max length of the memory to map
>   *
>   * Using this function you will get a __iomem address to your device BAR.
>   * You can access it using ioread*() and iowrite*(). These functions hide
>   * the details if this is a MMIO or PIO address space and will just do what
>   * you expect from them in the correct way.
>   *
> + * @minlen specifies the minimum length to map. We check that BAR is
> + * large enough.
>   * @maxlen specifies the maximum length to map. If you want to get access to
> - * the complete BAR without checking for its length first, pass %0 here.
> + * the complete BAR from offset to the end, pass %0 here.
>   * */
> -void __iomem *pci_iomap(struct pci_dev *dev, int bar, unsigned long maxlen)
> +void __iomem *pci_iomap_range(struct pci_dev *dev, int bar,
> +			      unsigned offset,
> +			      unsigned long minlen,
> +			      unsigned long maxlen)
>  {
>  	resource_size_t start = pci_resource_start(dev, bar);
>  	resource_size_t len = pci_resource_len(dev, bar);
>  	unsigned long flags = pci_resource_flags(dev, bar);
>  
> -	if (!len || !start)
> +	if (len <= offset || !start)
> +		return NULL;
> +	len -= offset;
> +	start += offset;
> +	if (len < minlen)
>  		return NULL;
>  	if (maxlen && len > maxlen)
>  		len = maxlen;
> @@ -277,10 +288,30 @@ void __iomem *pci_iomap(struct pci_dev *dev, int bar, unsigned long maxlen)
>  	return NULL;
>  }
>  
> +/**
> + * pci_iomap - create a virtual mapping cookie for a PCI BAR
> + * @dev: PCI device that owns the BAR
> + * @bar: BAR number
> + * @maxlen: length of the memory to map
> + *
> + * Using this function you will get a __iomem address to your device BAR.
> + * You can access it using ioread*() and iowrite*(). These functions hide
> + * the details if this is a MMIO or PIO address space and will just do what
> + * you expect from them in the correct way.
> + *
> + * @maxlen specifies the maximum length to map. If you want to get access to
> + * the complete BAR without checking for its length first, pass %0 here.
> + * */
> +void __iomem *pci_iomap(struct pci_dev *dev, int bar, unsigned long maxlen)
> +{
> +	return pci_iomap_range(dev, bar, 0, 0, maxlen);
> +}
> +
>  void pci_iounmap(struct pci_dev *dev, void __iomem * addr)
>  {
>  	IO_COND(addr, /* nothing */, iounmap(addr));
>  }
>  EXPORT_SYMBOL(pci_iomap);
> +EXPORT_SYMBOL(pci_iomap_range);
>  EXPORT_SYMBOL(pci_iounmap);
>  #endif /* CONFIG_PCI */
