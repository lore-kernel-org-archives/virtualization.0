From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] virtio_blk: fix incorrect message when disk is resized
Date: Fri, 4 Aug 2017 16:24:36 +0300
Message-ID: <20170804162420-mutt-send-email-mst__24760.2216819816$1501853194$gmane$org@kernel.org>
References: <20170726143223.2769-1-stefanha@redhat.com>
	<20170804093754.GA9867@stefanha-x1.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20170804093754.GA9867@stefanha-x1.localdomain>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Aug 04, 2017 at 10:37:54AM +0100, Stefan Hajnoczi wrote:
> On Wed, Jul 26, 2017 at 03:32:23PM +0100, Stefan Hajnoczi wrote:
> > The message printed on disk resize is incorrect.  The following is
> > printed when resizing to 2 GiB:
> > 
> >   $ truncate -s 1G test.img
> >   $ qemu -device virtio-blk-pci,logical_block_size=4096,...
> >   (qemu) block_resize drive1 2G
> > 
> >   virtio_blk virtio0: new size: 4194304 4096-byte logical blocks (17.2 GB/16.0 GiB)
> > 
> > The virtio_blk capacity config field is in 512-byte sector units
> > regardless of logical_block_size as per the VIRTIO specification.
> > Therefore the message should read:
> > 
> >   virtio_blk virtio0: new size: 524288 4096-byte logical blocks (2.15 GB/2.0 GiB)
> > 
> > Note that this only affects the printed message.  Thankfully the actual
> > block device has the correct size because the block layer expects
> > capacity in sectors.
> > 
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >  drivers/block/virtio_blk.c | 16 ++++++++++------
> >  1 file changed, 10 insertions(+), 6 deletions(-)
> 
> Ping?

Oops - I thought I sent it up. Will do.

> > diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> > index 4e02aa5fdac0..69a2d1748743 100644
> > --- a/drivers/block/virtio_blk.c
> > +++ b/drivers/block/virtio_blk.c
> > @@ -381,6 +381,7 @@ static void virtblk_config_changed_work(struct work_struct *work)
> >  	struct request_queue *q = vblk->disk->queue;
> >  	char cap_str_2[10], cap_str_10[10];
> >  	char *envp[] = { "RESIZE=1", NULL };
> > +	unsigned long long nblocks;
> >  	u64 capacity;
> >  
> >  	/* Host must always specify the capacity. */
> > @@ -393,16 +394,19 @@ static void virtblk_config_changed_work(struct work_struct *work)
> >  		capacity = (sector_t)-1;
> >  	}
> >  
> > -	string_get_size(capacity, queue_logical_block_size(q),
> > +	nblocks = DIV_ROUND_UP_ULL(capacity, queue_logical_block_size(q) >> 9);
> > +
> > +	string_get_size(nblocks, queue_logical_block_size(q),
> >  			STRING_UNITS_2, cap_str_2, sizeof(cap_str_2));
> > -	string_get_size(capacity, queue_logical_block_size(q),
> > +	string_get_size(nblocks, queue_logical_block_size(q),
> >  			STRING_UNITS_10, cap_str_10, sizeof(cap_str_10));
> >  
> >  	dev_notice(&vdev->dev,
> > -		  "new size: %llu %d-byte logical blocks (%s/%s)\n",
> > -		  (unsigned long long)capacity,
> > -		  queue_logical_block_size(q),
> > -		  cap_str_10, cap_str_2);
> > +		   "new size: %llu %d-byte logical blocks (%s/%s)\n",
> > +		   nblocks,
> > +		   queue_logical_block_size(q),
> > +		   cap_str_10,
> > +		   cap_str_2);
> >  
> >  	set_capacity(vblk->disk, capacity);
> >  	revalidate_disk(vblk->disk);
> > -- 
> > 2.13.3
> > 
