From: Maxim Levitsky <mlevitsk@redhat.com>
Subject: Re: [PATCH 05/10] block: null: use blk_is_valid_logical_block_size
Date: Tue, 21 Jul 2020 15:42:07 +0300
Message-ID: <435f1c04b58bd2298be3166b7bab458640927118.camel@redhat.com>
References: <20200721105239.8270-1-mlevitsk@redhat.com>
         <20200721105239.8270-6-mlevitsk@redhat.com>
         <CY4PR04MB3751882A6BDF7C073D6ECF88E7780@CY4PR04MB3751.namprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-block-owner@vger.kernel.org>
In-Reply-To: <CY4PR04MB3751882A6BDF7C073D6ECF88E7780@CY4PR04MB3751.namprd04.prod.outlook.com>
Sender: linux-block-owner@vger.kernel.org
To: Damien Le Moal <Damien.LeMoal@wdc.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Keith Busch <kbusch@kernel.org>, Josef Bacik <josef@toxicpanda.com>, "open list:BLOCK LAYER" <linux-block@vger.kernel.org>, Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>, "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>, "open list:SCSI CDROM DRIVER" <linux-scsi@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Bart Van Assche <bvanassche@acm.org>, "Martin K. Petersen" <martin.petersen@oracle.com>, Jason Wang <jasowang@redhat.com>, Maxim Levitsky <maximlevitsky@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>, Colin Ian King <colin.king@canonical.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Ulf Hansson <ulf.hansson@linaro.org>, Ajay Joshi <Ajay.Joshi@wdc.com>, Ming Lei <ming.lei@redhat.>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 2020-07-21 at 11:15 +0000, Damien Le Moal wrote:
> On 2020/07/21 19:54, Maxim Levitsky wrote:
> > This slightly changes the behavier of the driver,
> 
> s/behavier/behavior
Thanks. This is one of the typos I make very consistently.

> 
> > when given invalid block size (non power of two, or below 512 bytes),
> > but shoudn't matter.
> > 
> > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> > ---
> >  drivers/block/null_blk_main.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
> > index 87b31f9ca362e..e4df4b903b90b 100644
> > --- a/drivers/block/null_blk_main.c
> > +++ b/drivers/block/null_blk_main.c
> > @@ -1684,8 +1684,8 @@ static int null_init_tag_set(struct nullb *nullb, struct blk_mq_tag_set *set)
> >  
> >  static int null_validate_conf(struct nullb_device *dev)
> >  {
> > -	dev->blocksize = round_down(dev->blocksize, 512);
> > -	dev->blocksize = clamp_t(unsigned int, dev->blocksize, 512, 4096);
> > +	if (!blk_is_valid_logical_block_size(dev->blocksize))
> > +		return -ENODEV;
> >  
> >  	if (dev->queue_mode == NULL_Q_MQ && dev->use_per_node_hctx) {
> >  		if (dev->submit_queues != nr_online_nodes)
> > @@ -1865,7 +1865,7 @@ static int __init null_init(void)
> >  	struct nullb *nullb;
> >  	struct nullb_device *dev;
> >  
> > -	if (g_bs > PAGE_SIZE) {
> > +	if (!blk_is_valid_logical_block_size(g_bs)) {
> >  		pr_warn("invalid block size\n");
> >  		pr_warn("defaults block size to %lu\n", PAGE_SIZE);
> >  		g_bs = PAGE_SIZE;
> 
> Not sure if this change is OK. Shouldn't the if here be kept as is and
> blk_is_valid_logical_block_size() called after it to check values lower than 4K ?

The thing is that this driver supports two ways of creating the block devices.
On module load it creates by default a single block device and it uses g_bs
as its block size, but then it also has configfs based interface that allows
to create more block devices.

The default is taken also from g_bs but then user can change it (
via those NULLB_DEVICE_ATTR wrappers)
I changed the behavior slightly, that now if user supplies bad value,
it will be rejected instead of finding closest valid value.

In addition to that there is very small bug that didn't bother to fix in
this series (but I will in next one). The bug is that when null_validate_conf
fails, it return value is overriden with -ENOMEM, which gives the user a wrong
error message.

Thanks for the review!

Best regards,
	Maxim Levitsky

> 
> 
