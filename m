From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 06/10] s390/cio: add basic protected virtualization support
Date: Wed, 8 May 2019 06:54:57 -0700
Message-ID: <20190508135457.GA3530@infradead.org>
References: <20190426183245.37939-1-pasic@linux.ibm.com>
	<20190426183245.37939-7-pasic@linux.ibm.com>
	<alpine.LFD.2.21.1905081522300.1773@schleppi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.21.1905081522300.1773@schleppi>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Sebastian Ott <sebott@linux.ibm.com>
Cc: Farhan Ali <alifm@linux.ibm.com>, linux-s390@vger.kernel.org, Thomas Huth <thuth@redhat.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>, virtualization@lists.linux-foundation.org, Halil Pasic <pasic@linux.ibm.com>, Christoph Hellwig <hch@infradead.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, May 08, 2019 at 03:46:42PM +0200, Sebastian Ott wrote:
> > +	io_priv->dma_area = dma_alloc_coherent(&sch->dev,
> > +				sizeof(*io_priv->dma_area),
> > +				&io_priv->dma_area_dma, GFP_KERNEL);
> 
> This needs GFP_DMA.
> You use a genpool for ccw_private->dma and not for iopriv->dma - looks
> kinda inconsistent.

dma_alloc_* never needs GFP_DMA.  It selects the zone to allocate
from based on the dma_coherent_mask of the device.
