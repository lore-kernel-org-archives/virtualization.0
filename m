From: Sebastian Ott <sebott@linux.ibm.com>
Subject: Re: [PATCH 06/10] s390/cio: add basic protected virtualization support
Date: Wed, 8 May 2019 15:46:42 +0200 (CEST)
Message-ID: <alpine.LFD.2.21.1905081522300.1773@schleppi>
References: <20190426183245.37939-1-pasic@linux.ibm.com>
	<20190426183245.37939-7-pasic@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190426183245.37939-7-pasic@linux.ibm.com>
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
>  static struct ccw_device * io_subchannel_allocate_dev(struct subchannel *sch)
>  {
[..]
> +	cdev->private = kzalloc(sizeof(struct ccw_device_private),
> +				GFP_KERNEL | GFP_DMA);

Do we still need GFP_DMA here (since we now have cdev->private->dma_area)?

> @@ -1062,6 +1082,14 @@ static int io_subchannel_probe(struct subchannel *sch)
>  	if (!io_priv)
>  		goto out_schedule;
>  
> +	io_priv->dma_area = dma_alloc_coherent(&sch->dev,
> +				sizeof(*io_priv->dma_area),
> +				&io_priv->dma_area_dma, GFP_KERNEL);

This needs GFP_DMA.
You use a genpool for ccw_private->dma and not for iopriv->dma - looks
kinda inconsistent.
