From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH 35/35] x86: Don't panic if can not alloc buffer for swiotlb
Date: Fri, 25 Jan 2013 11:47:49 -0500
Message-ID: <20130125164749.GB27244@phenom.dumpdata.com>
References: <1359058816-7615-1-git-send-email-yinghai@kernel.org>
	<1359058816-7615-36-git-send-email-yinghai@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1359058816-7615-36-git-send-email-yinghai@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Yinghai Lu <yinghai@kernel.org>
Cc: linux-mips@linux-mips.org, Jeremy Fitzhardinge <jeremy@goop.org>, xen-devel@lists.xensource.com, Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Shuah Khan <shuahkhan@gmail.com>, Joerg Roedel <joro@8bytes.org>, Jason Wessel <jason.wessel@windriver.com>, linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, virtualization@lists.linux-foundation.org, Kyungmin Park <kyungmin.park@samsung.com>, Jan Kiszka <jan.kiszka@web.de>, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, Andrzej Pietrasiewicz <andrzej.p@samsung.com>, Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Jan 24, 2013 at 12:20:16PM -0800, Yinghai Lu wrote:
> Normal boot path on system with iommu support:
> swiotlb buffer will be allocated early at first and then try to initialize
> iommu, if iommu for intel or AMD could setup properly, swiotlb buffer
> will be freed.
> 
> The early allocating is with bootmem, and could panic when we try to use
> kdump with buffer above 4G only, or with memmap to limit mem under 4G.
> for example: memmap=4095M$1M to remove memory under 4G.
> 
> According to Eric, add _nopanic version and no_iotlb_memory to fail
> map single later if swiotlb is still needed.
> 
> -v2: don't pass nopanic, and use -ENOMEM return value according to Eric.
>      panic early instead of using swiotlb_full to panic...according to Eric/Konrad.
> -v3: make swiotlb_init to be notpanic, but will affect:
>      arm64, ia64, powerpc, tile, unicore32, x86.
> -v4: cleanup swiotlb_init by removing swiotlb_init_with_default_size.
> 
> Suggested-by: Eric W. Biederman <ebiederm@xmission.com>
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

Acked-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Tested-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

:-)

> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Jeremy Fitzhardinge <jeremy@goop.org>
> Cc: Kyungmin Park <kyungmin.park@samsung.com>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Andrzej Pietrasiewicz <andrzej.p@samsung.com>
> Cc: linux-mips@linux-mips.org
> Cc: xen-devel@lists.xensource.com
> Cc: virtualization@lists.linux-foundation.org
> Cc: Shuah Khan <shuahkhan@gmail.com>
> ---
>  arch/mips/cavium-octeon/dma-octeon.c |    3 ++-
>  drivers/xen/swiotlb-xen.c            |    4 ++-
>  include/linux/swiotlb.h              |    2 +-
>  lib/swiotlb.c                        |   47 +++++++++++++++++++++-------------
>  4 files changed, 35 insertions(+), 21 deletions(-)
> 
> diff --git a/arch/mips/cavium-octeon/dma-octeon.c b/arch/mips/cavium-octeon/dma-octeon.c
> index 41dd0088..02f2444 100644
> --- a/arch/mips/cavium-octeon/dma-octeon.c
> +++ b/arch/mips/cavium-octeon/dma-octeon.c
> @@ -317,7 +317,8 @@ void __init plat_swiotlb_setup(void)
>  
>  	octeon_swiotlb = alloc_bootmem_low_pages(swiotlbsize);
>  
> -	swiotlb_init_with_tbl(octeon_swiotlb, swiotlb_nslabs, 1);
> +	if (swiotlb_init_with_tbl(octeon_swiotlb, swiotlb_nslabs, 1) == -ENOMEM)
> +		panic("Cannot allocate SWIOTLB buffer");
>  
>  	mips_dma_map_ops = &octeon_linear_dma_map_ops.dma_map_ops;
>  }
> diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
> index af47e75..1d94316 100644
> --- a/drivers/xen/swiotlb-xen.c
> +++ b/drivers/xen/swiotlb-xen.c
> @@ -231,7 +231,9 @@ retry:
>  	}
>  	start_dma_addr = xen_virt_to_bus(xen_io_tlb_start);
>  	if (early) {
> -		swiotlb_init_with_tbl(xen_io_tlb_start, xen_io_tlb_nslabs, verbose);
> +		if (swiotlb_init_with_tbl(xen_io_tlb_start, xen_io_tlb_nslabs,
> +			 verbose))
> +			panic("Cannot allocate SWIOTLB buffer");
>  		rc = 0;
>  	} else
>  		rc = swiotlb_late_init_with_tbl(xen_io_tlb_start, xen_io_tlb_nslabs);
> diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
> index 071d62c..2de42f9 100644
> --- a/include/linux/swiotlb.h
> +++ b/include/linux/swiotlb.h
> @@ -23,7 +23,7 @@ extern int swiotlb_force;
>  #define IO_TLB_SHIFT 11
>  
>  extern void swiotlb_init(int verbose);
> -extern void swiotlb_init_with_tbl(char *tlb, unsigned long nslabs, int verbose);
> +int swiotlb_init_with_tbl(char *tlb, unsigned long nslabs, int verbose);
>  extern unsigned long swiotlb_nr_tbl(void);
>  extern int swiotlb_late_init_with_tbl(char *tlb, unsigned long nslabs);
>  
> diff --git a/lib/swiotlb.c b/lib/swiotlb.c
> index 196b069..bfe02b8 100644
> --- a/lib/swiotlb.c
> +++ b/lib/swiotlb.c
> @@ -122,11 +122,18 @@ static dma_addr_t swiotlb_virt_to_bus(struct device *hwdev,
>  	return phys_to_dma(hwdev, virt_to_phys(address));
>  }
>  
> +static bool no_iotlb_memory;
> +
>  void swiotlb_print_info(void)
>  {
>  	unsigned long bytes = io_tlb_nslabs << IO_TLB_SHIFT;
>  	unsigned char *vstart, *vend;
>  
> +	if (no_iotlb_memory) {
> +		pr_warn("software IO TLB: No low mem\n");
> +		return;
> +	}
> +
>  	vstart = phys_to_virt(io_tlb_start);
>  	vend = phys_to_virt(io_tlb_end);
>  
> @@ -136,7 +143,7 @@ void swiotlb_print_info(void)
>  	       bytes >> 20, vstart, vend - 1);
>  }
>  
> -void __init swiotlb_init_with_tbl(char *tlb, unsigned long nslabs, int verbose)
> +int __init swiotlb_init_with_tbl(char *tlb, unsigned long nslabs, int verbose)
>  {
>  	void *v_overflow_buffer;
>  	unsigned long i, bytes;
> @@ -150,9 +157,10 @@ void __init swiotlb_init_with_tbl(char *tlb, unsigned long nslabs, int verbose)
>  	/*
>  	 * Get the overflow emergency buffer
>  	 */
> -	v_overflow_buffer = alloc_bootmem_low_pages(PAGE_ALIGN(io_tlb_overflow));
> +	v_overflow_buffer = alloc_bootmem_low_pages_nopanic(
> +						PAGE_ALIGN(io_tlb_overflow));
>  	if (!v_overflow_buffer)
> -		panic("Cannot allocate SWIOTLB overflow buffer!\n");
> +		return -ENOMEM;
>  
>  	io_tlb_overflow_buffer = __pa(v_overflow_buffer);
>  
> @@ -169,15 +177,19 @@ void __init swiotlb_init_with_tbl(char *tlb, unsigned long nslabs, int verbose)
>  
>  	if (verbose)
>  		swiotlb_print_info();
> +
> +	return 0;
>  }
>  
>  /*
>   * Statically reserve bounce buffer space and initialize bounce buffer data
>   * structures for the software IO TLB used to implement the DMA API.
>   */
> -static void __init
> -swiotlb_init_with_default_size(size_t default_size, int verbose)
> +void  __init
> +swiotlb_init(int verbose)
>  {
> +	/* default to 64MB */
> +	size_t default_size = 64UL<<20;
>  	unsigned char *vstart;
>  	unsigned long bytes;
>  
> @@ -188,20 +200,16 @@ swiotlb_init_with_default_size(size_t default_size, int verbose)
>  
>  	bytes = io_tlb_nslabs << IO_TLB_SHIFT;
>  
> -	/*
> -	 * Get IO TLB memory from the low pages
> -	 */
> -	vstart = alloc_bootmem_low_pages(PAGE_ALIGN(bytes));
> -	if (!vstart)
> -		panic("Cannot allocate SWIOTLB buffer");
> -
> -	swiotlb_init_with_tbl(vstart, io_tlb_nslabs, verbose);
> -}
> +	/* Get IO TLB memory from the low pages */
> +	vstart = alloc_bootmem_low_pages_nopanic(PAGE_ALIGN(bytes));
> +	if (vstart && !swiotlb_init_with_tbl(vstart, io_tlb_nslabs, verbose))
> +		return;
>  
> -void __init
> -swiotlb_init(int verbose)
> -{
> -	swiotlb_init_with_default_size(64 * (1<<20), verbose);	/* default to 64MB */
> +	if (io_tlb_start)
> +		free_bootmem(io_tlb_start,
> +				 PAGE_ALIGN(io_tlb_nslabs << IO_TLB_SHIFT));
> +	pr_warn("Cannot allocate SWIOTLB buffer");
> +	no_iotlb_memory = true;
>  }
>  
>  /*
> @@ -405,6 +413,9 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev,
>  	unsigned long offset_slots;
>  	unsigned long max_slots;
>  
> +	if (no_iotlb_memory)
> +		panic("Can not allocate SWIOTLB buffer earlier and can't now provide you with the DMA bounce buffer");
> +
>  	mask = dma_get_seg_boundary(hwdev);
>  
>  	tbl_dma_addr &= mask;
> -- 
> 1.7.10.4
> 
