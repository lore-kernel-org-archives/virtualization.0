From: Sebastian Ott <sebott@linux.ibm.com>
Subject: Re: [PATCH 06/10] s390/cio: add basic protected virtualization support
Date: Thu, 9 May 2019 10:52:45 +0200 (CEST)
Message-ID: <alpine.LFD.2.21.1905091041130.1779@schleppi>
References: <20190426183245.37939-1-pasic@linux.ibm.com>
	<20190426183245.37939-7-pasic@linux.ibm.com>
	<alpine.LFD.2.21.1905081522300.1773@schleppi>
	<20190508230809.6b0faaf7.pasic@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190508230809.6b0faaf7.pasic@linux.ibm.com>
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


On Wed, 8 May 2019, Halil Pasic wrote:
> On Wed, 8 May 2019 15:46:42 +0200 (CEST)
> Sebastian Ott <sebott@linux.ibm.com> wrote:
> > On Fri, 26 Apr 2019, Halil Pasic wrote:
> > >  static struct ccw_device * io_subchannel_allocate_dev(struct subchannel *sch)
> > >  {
> > [..]
> > > +	cdev->private = kzalloc(sizeof(struct ccw_device_private),
> > > +				GFP_KERNEL | GFP_DMA);
> > 
> > Do we still need GFP_DMA here (since we now have cdev->private->dma_area)?
> > 
> 
> We probably do not. I kept it GFP_DMA to keep changes to the
> minimum. Should changing this in your opinion be a part of this patch?

This can be changed on top.

> > > @@ -1062,6 +1082,14 @@ static int io_subchannel_probe(struct subchannel *sch)
> > >  	if (!io_priv)
> > >  		goto out_schedule;
> > >  
> > > +	io_priv->dma_area = dma_alloc_coherent(&sch->dev,
> > > +				sizeof(*io_priv->dma_area),
> > > +				&io_priv->dma_area_dma, GFP_KERNEL);
> > 
> > This needs GFP_DMA.
> 
> Christoph already answered this one. Thanks Christoph!

Yes, I'm still struggling to grasp the whole channel IO + DMA API +
protected virtualization thing..

> 
> > You use a genpool for ccw_private->dma and not for iopriv->dma - looks
> > kinda inconsistent.
> > 
> 
> Please have a look at patch #9. A virtio-ccw device uses the genpool of
> it's ccw device (the pool from which ccw_private->dma is allicated) for
> the ccw stuff it needs to do. AFAICT for a subchannel device and its API
> all the DMA memory we need is iopriv->dma. So my thought was
> constructing a genpool for that would be an overkill.
> 
> Are you comfortable with this answer, or should we change something?

Nope, I'm good with that one - ccw_private->dma has multiple users that
all fit into one page.
