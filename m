From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v4 2/8] s390/cio: introduce DMA pools to cio
Date: Wed, 12 Jun 2019 08:30:17 +0200
Message-ID: <20190612083017.0cbbe17b.cohuck@redhat.com>
References: <20190606115127.55519-1-pasic@linux.ibm.com>
	<20190606115127.55519-3-pasic@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190606115127.55519-3-pasic@linux.ibm.com>
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
Cc: Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org, Thomas Huth <thuth@redhat.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, kvm@vger.kernel.org, Sebastian Ott <sebott@linux.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, Farhan Ali <alifm@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Eric Farman <farman@linux.ibm.com>, virtualization@lists.linux-foundation.org, Christoph Hellwig <hch@infradead.org>, Christian Borntraeger <borntraeger@de.ibm.com>, "Jason J. Herne" <jjherne@linux.ibm.com>, Michael Mueller <mimu@linux.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu,  6 Jun 2019 13:51:21 +0200
Halil Pasic <pasic@linux.ibm.com> wrote:

[just looked at it in the context of failed init]

> +static void __gp_dma_free_dma(struct gen_pool *pool,
> +			      struct gen_pool_chunk *chunk, void *data)

Just to note: the 'pool' is mandated by the api for this callback.

> +{
> +	size_t chunk_size = chunk->end_addr - chunk->start_addr + 1;
> +
> +	dma_free_coherent((struct device *) data, chunk_size,
> +			 (void *) chunk->start_addr,
> +			 (dma_addr_t) chunk->phys_addr);
> +}
> +
> +void cio_gp_dma_destroy(struct gen_pool *gp_dma, struct device *dma_dev)
> +{
> +	if (!gp_dma)
> +		return;

So this seems fine.

> +	/* this is qite ugly but no better idea */
> +	gen_pool_for_each_chunk(gp_dma, __gp_dma_free_dma, dma_dev);
> +	gen_pool_destroy(gp_dma);
> +}
> +
> +static int cio_dma_pool_init(void)
> +{
> +	/* No need to free up the resources: compiled in */
> +	cio_dma_pool = cio_gp_dma_create(cio_get_dma_css_dev(), 1);
> +	if (!cio_dma_pool)
> +		return -ENOMEM;
> +	return 0;
> +}
> +
> +void *cio_gp_dma_zalloc(struct gen_pool *gp_dma, struct device *dma_dev,
> +			size_t size)
> +{
> +	dma_addr_t dma_addr;
> +	unsigned long addr;
> +	size_t chunk_size;
> +

I'd probably do a quick exit for !gp_dma here as well (just to be on
the safe side).

> +	addr = gen_pool_alloc(gp_dma, size);
> +	while (!addr) {
> +		chunk_size = round_up(size, PAGE_SIZE);
> +		addr = (unsigned long) dma_alloc_coherent(dma_dev,
> +					 chunk_size, &dma_addr, CIO_DMA_GFP);
> +		if (!addr)
> +			return NULL;
> +		gen_pool_add_virt(gp_dma, addr, dma_addr, chunk_size, -1);
> +		addr = gen_pool_alloc(gp_dma, size);
> +	}
> +	return (void *) addr;
> +}
> +
> +void cio_gp_dma_free(struct gen_pool *gp_dma, void *cpu_addr, size_t size)
> +{
> +	if (!cpu_addr)
> +		return;

This already makes it safe enough.

> +	memset(cpu_addr, 0, size);
> +	gen_pool_free(gp_dma, (unsigned long) cpu_addr, size);
> +}
> +
> +/*
> + * Allocate dma memory from the css global pool. Intended for memory not
> + * specific to any single device within the css. The allocated memory
> + * is not guaranteed to be 31-bit addressable.
> + *
> + * Caution: Not suitable for early stuff like console.
> + */
> +void *cio_dma_zalloc(size_t size)
> +{

If you check in the called function, you do not need to check here.
Probably a matter of taste.

> +	return cio_gp_dma_zalloc(cio_dma_pool, cio_get_dma_css_dev(), size);
> +}
> +
> +void cio_dma_free(void *cpu_addr, size_t size)
> +{

This one should be safe due to the check in the called function.

> +	cio_gp_dma_free(cio_dma_pool, cpu_addr, size);
> +}
> +
>  /*
>   * Now that the driver core is running, we can setup our channel subsystem.
>   * The struct subchannel's are created during probing.
