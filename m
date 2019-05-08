From: Sebastian Ott <sebott@linux.ibm.com>
Subject: Re: [PATCH 07/10] s390/airq: use DMA memory for adapter interrupts
Date: Wed, 8 May 2019 15:58:48 +0200 (CEST)
Message-ID: <alpine.LFD.2.21.1905081553580.1773@schleppi>
References: <20190426183245.37939-1-pasic@linux.ibm.com>
	<20190426183245.37939-8-pasic@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190426183245.37939-8-pasic@linux.ibm.com>
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
> @@ -182,6 +190,8 @@ void airq_iv_release(struct airq_iv *iv)
>  	kfree(iv->ptr);
>  	kfree(iv->bitlock);
>  	kfree(iv->vector);

-  	kfree(iv->vector);

> +	dma_free_coherent(cio_get_dma_css_dev(), iv_size(iv->bits),
> +			  iv->vector, iv->vector_dma);
>  	kfree(iv->avail);
>  	kfree(iv);
>  }

Looks good to me but needs adaption to current code. Probably you can just
revert my changes introducing cacheline aligned vectors since we now use
a whole page.
