From: Sebastian Ott <sebott@linux.ibm.com>
Subject: Re: [PATCH 05/10] s390/cio: introduce DMA pools to cio
Date: Wed, 8 May 2019 15:18:10 +0200 (CEST)
Message-ID: <alpine.LFD.2.21.1905081447280.1773@schleppi>
References: <20190426183245.37939-1-pasic@linux.ibm.com>
	<20190426183245.37939-6-pasic@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190426183245.37939-6-pasic@linux.ibm.com>
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
Cc: Farhan Ali <alifm@linux.ibm.com>, linux-s390@vger.kernel.org, Thomas Huth <thuth@redhat.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>, virtualization@lists.linux-foundation.org, Christoph Hellwig <hch@infradead.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org


On Fri, 26 Apr 2019, Halil Pasic wrote:
> @@ -224,6 +228,9 @@ struct subchannel *css_alloc_subchannel(struct subchannel_id schid,
>  	INIT_WORK(&sch->todo_work, css_sch_todo);
>  	sch->dev.release = &css_subchannel_release;
>  	device_initialize(&sch->dev);
> +	sch->dma_mask = css_dev_dma_mask;
> +	sch->dev.dma_mask = &sch->dma_mask;
> +	sch->dev.coherent_dma_mask = sch->dma_mask;

Could we do:
	sch->dev.dma_mask = &sch->dev.coherent_dma_mask;
	sch->dev.coherent_dma_mask = css_dev_dma_mask;
?

> +#define POOL_INIT_PAGES 1
> +static struct gen_pool *cio_dma_pool;
> +/* Currently cio supports only a single css */
> +#define  CIO_DMA_GFP (GFP_KERNEL | __GFP_ZERO)

__GFP_ZERO has no meaning with the dma api (since all implementations do
an implicit zero initialization) but let's keep it for the sake of
documentation.

We need GFP_DMA here (which will return addresses < 2G on s390)!

> +void cio_gp_dma_free(struct gen_pool *gp_dma, void *cpu_addr, size_t size)
> +{
> +	if (!cpu_addr)
> +		return;
> +	memset(cpu_addr, 0, size);

Hm, normally I'd do the memset during alloc not during free - but maybe
this makes more sense here with your usecase in mind.

> @@ -1063,6 +1163,7 @@ static int __init css_bus_init(void)
>  		unregister_reboot_notifier(&css_reboot_notifier);
>  		goto out_unregister;
>  	}
> +	cio_dma_pool_init();

This is too late for early devices (ccw console!).
