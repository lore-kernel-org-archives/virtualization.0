From: Maxim Levitsky <mlevitsk@redhat.com>
Subject: Re: [PATCH 01/10] block: introduce blk_is_valid_logical_block_size
Date: Wed, 22 Jul 2020 11:50:26 +0300
Message-ID: <c9124b5487ed51e02dc9264fa8c87b93313fa68f.camel@redhat.com>
References: <20200721105239.8270-1-mlevitsk@redhat.com>
 <20200721105239.8270-2-mlevitsk@redhat.com> <20200721151313.GA10620@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200721151313.GA10620@lst.de>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Christoph Hellwig <hch@lst.de>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>, "open list:VIRTIO CORE
 AND NET DRIVERS" <virtualization@lists.linux-foundation.org>, Hou Tao <houtao1@huawei.com>, Sagi Grimberg <sagi@grimberg.me>, "open list:SCSI CDROM DRIVER" <linux-scsi@vger.kernel.org>, Satya Tangirala <satyat@google.com>, Ajay Joshi <ajay.joshi@wdc.com>, Alex Dubov <oakad@yahoo.com>, "James E.J.
 Bottomley" <jejb@linux.ibm.com>, Josef Bacik <josef@toxicpanda.com>, Ming Lei <ming.lei@redhat.com>, "open list:BLOCK LAYER" <linux-block@vger.kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, Colin Ian King <colin.king@canonical.com>, Keith Busch <kbusch@kernel.org>, "open list:NETWORK BLOCK DEVICE (NBD)" <nbd@other.debian.org>, Bart Van Assche <bvanassche@acm.org>, Maxim Levitsky <maximlevitsky@gmail.com>, Jens Axboe <axboe@kernel.dk>Jens
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 2020-07-21 at 17:13 +0200, Christoph Hellwig wrote:
> > +/**
> > + * blk_check_logical_block_size - check if logical block size is
> > supported
> > + * by the kernel
> > + * @size:  the logical block size, in bytes
> > + *
> > + * Description:
> > + *   This function checks if the block layers supports given block
> > size
> > + **/
> > +bool blk_is_valid_logical_block_size(unsigned int size)
> > +{
> > +	return size >= SECTOR_SIZE && size <= PAGE_SIZE &&
> > !is_power_of_2(size);
> 
> Shouldn't this be a ... && is_power_of_2(size)?
Yep. I noticed that few minutes after I sent the patches.

> 
> >  	if (q->limits.io_min < q->limits.physical_block_size)
> >  		q->limits.io_min = q->limits.physical_block_size;
> > +
> >  }
> 
> This adds a pointless empty line.
Will fix.
> 
> > +extern bool blk_is_valid_logical_block_size(unsigned int size);
> 
> No need for externs on function declarations.
I also think so, but I followed the style of all existing function
prototypes in this file. Most of them have 'extern'.

Thanks for the review!

Best regards,
	maxim Levitsky
