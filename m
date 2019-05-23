From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH 05/10] s390/cio: introduce DMA pools to cio
Date: Thu, 23 May 2019 17:17:56 +0200
Message-ID: <20190523171756.4d30233a.pasic@linux.ibm.com>
References: <20190426183245.37939-1-pasic@linux.ibm.com>
	<20190426183245.37939-6-pasic@linux.ibm.com>
	<alpine.LFD.2.21.1905081447280.1773@schleppi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.21.1905081447280.1773@schleppi>
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
Cc: Farhan Ali <alifm@linux.ibm.com>, linux-s390@vger.kernel.org, Thomas Huth <thuth@redhat.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>, virtualization@lists.linux-foundation.org, Christoph Hellwig <hch@infradead.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Michael Mueller <mimu@linux.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 8 May 2019 15:18:10 +0200 (CEST)
Sebastian Ott <sebott@linux.ibm.com> wrote:

> > @@ -224,6 +228,9 @@ struct subchannel *css_alloc_subchannel(struct subchannel_id schid,
> >  	INIT_WORK(&sch->todo_work, css_sch_todo);
> >  	sch->dev.release = &css_subchannel_release;
> >  	device_initialize(&sch->dev);
> > +	sch->dma_mask = css_dev_dma_mask;
> > +	sch->dev.dma_mask = &sch->dma_mask;
> > +	sch->dev.coherent_dma_mask = sch->dma_mask;  
> 
> Could we do:
> 	sch->dev.dma_mask = &sch->dev.coherent_dma_mask;
> 	sch->dev.coherent_dma_mask = css_dev_dma_mask;
> ?

Looks like a good idea to me. We will do it for all 3 (sch, ccw and
css). Thanks!

Regards,
Halil
