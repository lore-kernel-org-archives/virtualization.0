From: Maxim Levitsky <mlevitsk@redhat.com>
Subject: Re: [PATCH 02/10] block: virtio-blk: check logical block size
Date: Wed, 22 Jul 2020 12:11:17 +0300
Message-ID: <f16aba1020019530564f0869a67951282104a5d2.camel@redhat.com>
References: <20200721105239.8270-1-mlevitsk@redhat.com>
         <20200721105239.8270-3-mlevitsk@redhat.com> <20200721151437.GB10620@lst.de>
         <yq1zh7sfedj.fsf@ca-mkp.ca.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-scsi-owner@vger.kernel.org>
In-Reply-To: <yq1zh7sfedj.fsf@ca-mkp.ca.oracle.com>
Sender: linux-scsi-owner@vger.kernel.org
To: "Martin K. Petersen" <martin.petersen@oracle.com>, Christoph Hellwig <hch@lst.de>
Cc: linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>, Josef Bacik <josef@toxicpanda.com>, "open list:BLOCK LAYER" <linux-block@vger.kernel.org>, Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>, "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>, "open list:SCSI CDROM DRIVER" <linux-scsi@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Bart Van Assche <bvanassche@acm.org>, Damien Le Moal <damien.lemoal@wdc.com>, Jason Wang <jasowang@redhat.com>, Maxim Levitsky <maximlevitsky@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>, Colin Ian King <colin.king@canonical.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Ulf Hansson <ulf.hansson@linaro.org>, Ajay Joshi <ajay.joshi@wdc.com>, Ming
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 2020-07-21 at 22:55 -0400, Martin K. Petersen wrote:
> Christoph,
> 
> > Hmm, I wonder if we should simply add the check and warning to
> > blk_queue_logical_block_size and add an error in that case.  Then
> > drivers only have to check the error return, which might add a lot
> > less boiler plate code.
> 
> Yep, I agree.
> 

I also agree that this would be cleaner (I actually tried to implement
this the way you suggest), but let me explain my reasoning for doing it
this way.

The problem is that most current users of blk_queue_logical_block_size
(43 uses in the tree, out of which only 9 use constant block size) check
for the block size relatively early, often store it in some internal
struct etc, prior to calling blk_queue_logical_block_size thus making
them only to rely on blk_queue_logical_block_size as the check for 
block size validity will need non-trivial changes in their code.

Instead of this adding blk_is_valid_logical_block_size allowed me
to trivially convert most of the uses.

For RFC I converted only some drivers that I am more familiar with
and/or can test but I can remove the driver's own checks in most other
drivers with low chance of introducing a bug, even if I can't test the
driver.

What do you think?

I can also both make blk_queue_logical_block_size return an error value,
and have blk_is_valid_logical_block_size and use either of these checks,
depending on the driver with eventual goal of un-exporting
blk_is_valid_logical_block_size.

Also note that I did add WARN_ON to blk_queue_logical_block_size.

Best regards,
	Maxim Levitsky
