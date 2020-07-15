From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] virtio-blk: check host supplied logical block size
Date: Wed, 15 Jul 2020 07:53:04 -0400
Message-ID: <20200715075151-mutt-send-email-mst@kernel.org>
References: <20200715095518.3724-1-mlevitsk@redhat.com>
 <20200715060233-mutt-send-email-mst@kernel.org>
 <5dd5af8032160eb49a4f0e38749e2d9cd968a0d6.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-block-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5dd5af8032160eb49a4f0e38749e2d9cd968a0d6.camel@redhat.com>
Sender: linux-block-owner@vger.kernel.org
To: Maxim Levitsky <mlevitsk@redhat.com>
Cc: linux-kernel@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>, "open list:BLOCK LAYER" <linux-block@vger.kernel.org>, "open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux-foundation.org>, Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>, Jens Axboe <axboe@kernel.dk>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jul 15, 2020 at 01:19:55PM +0300, Maxim Levitsky wrote:
> On Wed, 2020-07-15 at 06:06 -0400, Michael S. Tsirkin wrote:
> > On Wed, Jul 15, 2020 at 12:55:18PM +0300, Maxim Levitsky wrote:
> > > Linux kernel only supports logical block sizes which are power of
> > > two,
> > > at least 512 bytes and no more that PAGE_SIZE.
> > > 
> > > Check this instead of crashing later on.
> > > 
> > > Note that there is no need to check physical block size since it is
> > > only a hint, and virtio-blk already only supports power of two
> > > values.
> > > 
> > > Bugzilla link: https://bugzilla.redhat.com/show_bug.cgi?id=1664619
> > > 
> > > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> > > ---
> > >  drivers/block/virtio_blk.c | 20 ++++++++++++++++++--
> > >  1 file changed, 18 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> > > index 980df853ee497..36dda31cc4e96 100644
> > > --- a/drivers/block/virtio_blk.c
> > > +++ b/drivers/block/virtio_blk.c
> > > @@ -681,6 +681,12 @@ static const struct blk_mq_ops virtio_mq_ops =
> > > {
> > >  static unsigned int virtblk_queue_depth;
> > >  module_param_named(queue_depth, virtblk_queue_depth, uint, 0444);
> > >  
> > > +
> > > +static bool virtblk_valid_block_size(unsigned int blksize)
> > > +{
> > > +	return blksize >= 512 && blksize <= PAGE_SIZE &&
> > > is_power_of_2(blksize);
> > > +}
> > > +
> > 
> > Is this a blk core assumption? in that case, does not this belong
> > in blk core?
> 
> It is a blk core assumption. 
> I had checked other drivers and these that have variable block size all
> check this manually like that.
> 
> I don't mind fixing all of them but I am a bit afraid to create
> too much mess.

You don't have to, start by adding this in blk core and using in virtio.
Patches to update all drivers can then come separately.

> > 
> > >  static int virtblk_probe(struct virtio_device *vdev)
> > >  {
> > >  	struct virtio_blk *vblk;
> > > @@ -809,9 +815,16 @@ static int virtblk_probe(struct virtio_device
> > > *vdev)
> > >  	err = virtio_cread_feature(vdev, VIRTIO_BLK_F_BLK_SIZE,
> > >  				   struct virtio_blk_config, blk_size,
> > >  				   &blk_size);
> > > -	if (!err)
> > > +	if (!err) {
> > > +		if (!virtblk_valid_block_size(blk_size)) {
> > > +			dev_err(&vdev->dev,
> > > +				"%s failure: unsupported logical block
> > > size %d\n",
> > > +				__func__, blk_size);
> > > +			err = -EINVAL;
> > > +			goto out_cleanup_queue;
> > > +		}
> > >  		blk_queue_logical_block_size(q, blk_size);
> > > -	else
> > > +	} else
> > >  		blk_size = queue_logical_block_size(q);
> > >  
> > >  	/* Use topology information if available */
> > 
> > OK so if we are doing this pls add {} around  blk_size =
> > queue_logical_block_size(q);
> > too.
> Will do.
> 
> > 
> > > @@ -872,6 +885,9 @@ static int virtblk_probe(struct virtio_device
> > > *vdev)
> > >  	device_add_disk(&vdev->dev, vblk->disk, virtblk_attr_groups);
> > >  	return 0;
> > >  
> > > +out_cleanup_queue:
> > > +	blk_cleanup_queue(vblk->disk->queue);
> > > +	vblk->disk->queue = NULL;
> > >  out_free_tags:
> > >  	blk_mq_free_tag_set(&vblk->tag_set);
> > >  out_put_disk:
> > > -- 
> > > 2.26.2
> 
> 
> Best regards,
> 	Maxim Levitsky
