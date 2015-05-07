From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: Re: [RFC 4/4] rpmsg: DMA map sgs passed to virtio
Date: Thu, 7 May 2015 10:28:09 +1000
Message-ID: <20150507002809.GW10142@toto>
References: <1430456507-26862-1-git-send-email-edgar.iglesias@gmail.com>
	<1430456507-26862-5-git-send-email-edgar.iglesias@gmail.com>
	<87wq0mgr9f.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <87wq0mgr9f.fsf@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: edgar.iglesias@xilinx.com, linux@arm.linux.org.uk, mst@redhat.com, michal.simek@xilinx.com, virtualization@lists.linux-foundation.org, j.wu@xilinx.com
List-Id: virtualization@lists.linuxfoundation.org

On Wed, May 06, 2015 at 03:51:48PM +0930, Rusty Russell wrote:
> "Edgar E. Iglesias" <edgar.iglesias@gmail.com> writes:
> > From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
> >
> > Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> 
> First off, I have handed maintainership off to Michael S. Tsirkin, so
> his word is now law.
> 
> That said... there's nothing fundamentally *wrong* with this, but it's
> not how standard virtio works.  We decided some time ago that as we're
> paravirtualized, we would not be doing address mapping.
> 
> rpmsg uses virtio, but it's with a twist: they're not talking to a
> host.  Thus my preference, in order, would be:
> 
> 1) Don't use non-kmalloc addresses.
> 2) If that's not possible, call these _dma interfaces _rpmsg instead,
>    so normal virtio users don't get confused and try to use them.

Thanks Rusty,

That was helpful, I'll see if I can do something in line with nr 2.

AFAICT, #1 will be hard. The remote-processor would have to be
cache-coherent and share memory address-space view with the master
CPU. This is not the common case for remoteproc (unlike when virtio
communication flows between host and guest on the same CPU or SMP system).
Ohad, do you have any thoughts on this?

Cheers,
Edgar


> 
> Cheers,
> Rusty.
> 
> 
> > ---
> >  drivers/rpmsg/virtio_rpmsg_bus.c | 28 ++++++++++++++++++++++------
> >  1 file changed, 22 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
> > index 73354ee..9ae53a0 100644
> > --- a/drivers/rpmsg/virtio_rpmsg_bus.c
> > +++ b/drivers/rpmsg/virtio_rpmsg_bus.c
> > @@ -210,6 +210,22 @@ static void __ept_release(struct kref *kref)
> >  	kfree(ept);
> >  }
> >  
> > +static inline dma_addr_t msg_dma_address(struct virtproc_info *vrp, void *msg)
> > +{
> > +	unsigned long offset = msg - vrp->rbufs;
> > +
> > +	return vrp->bufs_dma + offset;
> > +}
> > +
> > +static inline void rpmsg_msg_sg_init(struct virtproc_info *vrp,
> > +				     struct scatterlist *sg,
> > +				     void *msg, unsigned int len)
> > +{
> > +	sg_init_table(sg, 1);
> > +	sg_dma_address(sg) = msg_dma_address(vrp, msg);
> > +	sg_dma_len(sg) = len;
> > +}
> > +
> >  /* for more info, see below documentation of rpmsg_create_ept() */
> >  static struct rpmsg_endpoint *__rpmsg_create_ept(struct virtproc_info *vrp,
> >  		struct rpmsg_channel *rpdev, rpmsg_rx_cb_t cb,
> > @@ -754,12 +770,12 @@ int rpmsg_send_offchannel_raw(struct rpmsg_channel *rpdev, u32 src, u32 dst,
> >  	print_hex_dump(KERN_DEBUG, "rpmsg_virtio TX: ", DUMP_PREFIX_NONE, 16, 1,
> >  					msg, sizeof(*msg) + msg->len, true);
> >  
> > -	sg_init_one(&sg, msg, sizeof(*msg) + len);
> > +	rpmsg_msg_sg_init(vrp, &sg, msg, sizeof(*msg) + len);
> >  
> >  	mutex_lock(&vrp->tx_lock);
> >  
> >  	/* add message to the remote processor's virtqueue */
> > -	err = virtqueue_add_outbuf(vrp->svq, &sg, 1, msg, GFP_KERNEL);
> > +	err = dma_virtqueue_add_outbuf(vrp->svq, &sg, 1, msg, GFP_KERNEL);
> >  	if (err) {
> >  		/*
> >  		 * need to reclaim the buffer here, otherwise it's lost
> > @@ -828,10 +844,10 @@ static int rpmsg_recv_single(struct virtproc_info *vrp, struct device *dev,
> >  		dev_warn(dev, "msg received with no recipient\n");
> >  
> >  	/* publish the real size of the buffer */
> > -	sg_init_one(&sg, msg, RPMSG_BUF_SIZE);
> > +	rpmsg_msg_sg_init(vrp, &sg, msg, RPMSG_BUF_SIZE);
> >  
> >  	/* add the buffer back to the remote processor's virtqueue */
> > -	err = virtqueue_add_inbuf(vrp->rvq, &sg, 1, msg, GFP_KERNEL);
> > +	err = dma_virtqueue_add_inbuf(vrp->rvq, &sg, 1, msg, GFP_KERNEL);
> >  	if (err < 0) {
> >  		dev_err(dev, "failed to add a virtqueue buffer: %d\n", err);
> >  		return err;
> > @@ -1007,9 +1023,9 @@ static int rpmsg_probe(struct virtio_device *vdev)
> >  		struct scatterlist sg;
> >  		void *cpu_addr = vrp->rbufs + i * RPMSG_BUF_SIZE;
> >  
> > -		sg_init_one(&sg, cpu_addr, RPMSG_BUF_SIZE);
> > +		rpmsg_msg_sg_init(vrp, &sg, cpu_addr, RPMSG_BUF_SIZE);
> >  
> > -		err = virtqueue_add_inbuf(vrp->rvq, &sg, 1, cpu_addr,
> > +		err = dma_virtqueue_add_inbuf(vrp->rvq, &sg, 1, cpu_addr,
> >  								GFP_KERNEL);
> >  		WARN_ON(err); /* sanity check; this can't really happen */
> >  	}
> > -- 
> > 1.9.1
