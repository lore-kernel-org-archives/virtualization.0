From: Mark McLoughlin <markmc@redhat.com>
Subject: Re: [PATCH 2/3] virtio: indirect ring entries
	(VIRTIO_RING_F_INDIRECT_DESC)
Date: Mon, 22 Dec 2008 10:17:21 +0000
Message-ID: <1229941041.19474.2.camel__13513.3863114335$1229941201$gmane$org@localhost.localdomain>
References: <1229620222-22216-1-git-send-email-markmc@redhat.com>
	<1229620222-22216-2-git-send-email-markmc@redhat.com>
	<1229620222-22216-3-git-send-email-markmc@redhat.com>
	<200812201238.07510.ioe-lkml@rameria.de>
Reply-To: Mark McLoughlin <markmc@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200812201238.07510.ioe-lkml@rameria.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Ingo Oeser <ioe-lkml@rameria.de>
Cc: Avi Kivity <avi@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Hi Ingo,

On Sat, 2008-12-20 at 12:38 +0100, Ingo Oeser wrote:
> Hi Mark,
> 
> On Thursday 18 December 2008, Mark McLoughlin wrote:
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > index 5777196..2330c4b 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -70,6 +73,55 @@ struct vring_virtqueue
> >  
> >  #define to_vvq(_vq) container_of(_vq, struct vring_virtqueue, vq)
> >  
> > +/* Set up an indirect table of descriptors and add it to the queue. */
> > +static int vring_add_indirect(struct vring_virtqueue *vq,
> > +			      struct scatterlist sg[],
> > +			      unsigned int out,
> > +			      unsigned int in)
> > +{
> > +	struct vring_desc *desc;
> > +	unsigned head;
> > +	int i;
> > +
> > +	desc = kmalloc((out + in) * sizeof(struct vring_desc), GFP_ATOMIC);
> 
> kmalloc() returns ZERO_SIZE_PTR, if (out + in) == 0

vring_add_buf() has:

  BUG_ON(out + in == 0)

I should just add that here too before the kmalloc() call.

Thanks,
Mark.
