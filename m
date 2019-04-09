From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [RFC PATCH 03/12] s390/mm: force swiotlb for protected
	virtualization
Date: Tue, 9 Apr 2019 12:16:47 +0200
Message-ID: <20190409121647.3e0e1f53.cohuck@redhat.com>
References: <20190404231622.52531-1-pasic@linux.ibm.com>
	<20190404231622.52531-4-pasic@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190404231622.52531-4-pasic@linux.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Halil Pasic <pasic@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org, Eric Farman <farman@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, kvm@vger.kernel.org, Sebastian Ott <sebott@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, virtualization@lists.linux-foundation.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri,  5 Apr 2019 01:16:13 +0200
Halil Pasic <pasic@linux.ibm.com> wrote:

> On s390 protected virtualization guests also have to use bounce I/O
> buffers.  That requires some plumbing.
> 
> Let us make sure any device using DMA API accordingly is spared from the
> problems that hypervisor attempting I/O to a non-shared secure page would
> bring.

I have problems parsing this sentence :(

Do you mean that we want to exclude pages for I/O from encryption?

> 
> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> ---
>  arch/s390/Kconfig                   |  4 ++++
>  arch/s390/include/asm/Kbuild        |  1 -
>  arch/s390/include/asm/dma-mapping.h | 13 +++++++++++
>  arch/s390/include/asm/mem_encrypt.h | 18 +++++++++++++++
>  arch/s390/mm/init.c                 | 44 +++++++++++++++++++++++++++++++++++++
>  5 files changed, 79 insertions(+), 1 deletion(-)
>  create mode 100644 arch/s390/include/asm/dma-mapping.h
>  create mode 100644 arch/s390/include/asm/mem_encrypt.h

(...)

> @@ -126,6 +129,45 @@ void mark_rodata_ro(void)
>  	pr_info("Write protected read-only-after-init data: %luk\n", size >> 10);
>  }
>  
> +int set_memory_encrypted(unsigned long addr, int numpages)
> +{
> +	/* also called for the swiotlb bounce buffers, make all pages shared */
> +	/* TODO: do ultravisor calls */
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(set_memory_encrypted);
> +
> +int set_memory_decrypted(unsigned long addr, int numpages)
> +{
> +	/* also called for the swiotlb bounce buffers, make all pages shared */
> +	/* TODO: do ultravisor calls */
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(set_memory_decrypted);
> +
> +/* are we a protected virtualization guest? */
> +bool sev_active(void)
> +{
> +	/*
> +	 * TODO: Do proper detection using ultravisor, for now let us fake we
> +	 *  have it so the code gets exercised.

That's the swiotlb stuff, right?

(The patches will obviously need some reordering before it is actually
getting merged.)

> +	 */
> +	return true;
> +}
> +EXPORT_SYMBOL_GPL(sev_active);
> +
> +/* protected virtualization */
> +static void pv_init(void)
> +{
> +	if (!sev_active())
> +		return;
> +
> +	/* make sure bounce buffers are shared */
> +	swiotlb_init(1);
> +	swiotlb_update_mem_attributes();
> +	swiotlb_force = SWIOTLB_FORCE;
> +}
> +
>  void __init mem_init(void)
>  {
>  	cpumask_set_cpu(0, &init_mm.context.cpu_attach_mask);
> @@ -134,6 +176,8 @@ void __init mem_init(void)
>  	set_max_mapnr(max_low_pfn);
>          high_memory = (void *) __va(max_low_pfn * PAGE_SIZE);
>  
> +	pv_init();
> +
>  	/* Setup guest page hinting */
>  	cmma_init();
>  
