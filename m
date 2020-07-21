From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 01/10] block: introduce blk_is_valid_logical_block_size
Date: Tue, 21 Jul 2020 17:13:13 +0200
Message-ID: <20200721151313.GA10620@lst.de>
References: <20200721105239.8270-1-mlevitsk@redhat.com> <20200721105239.8270-2-mlevitsk@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200721105239.8270-2-mlevitsk@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Maxim Levitsky <mlevitsk@redhat.com>
Cc: linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>, Josef Bacik <josef@toxicpanda.com>, "open list:BLOCK LAYER" <linux-block@vger.kernel.org>, Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>, "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>, "open list:SCSI CDROM DRIVER" <linux-scsi@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Bart Van Assche <bvanassche@acm.org>, "Martin K. Petersen" <martin.petersen@oracle.com>, Damien Le Moal <damien.lemoal@wdc.com>, Jason Wang <jasowang@redhat.com>, Maxim Levitsky <maximlevitsky@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>, Colin Ian King <colin.king@canonical.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: virtualization@lists.linuxfoundation.org

> +/**
> + * blk_check_logical_block_size - check if logical block size is supported
> + * by the kernel
> + * @size:  the logical block size, in bytes
> + *
> + * Description:
> + *   This function checks if the block layers supports given block size
> + **/
> +bool blk_is_valid_logical_block_size(unsigned int size)
> +{
> +	return size >= SECTOR_SIZE && size <= PAGE_SIZE && !is_power_of_2(size);

Shouldn't this be a ... && is_power_of_2(size)?

>  	if (q->limits.io_min < q->limits.physical_block_size)
>  		q->limits.io_min = q->limits.physical_block_size;
> +
>  }

This adds a pointless empty line.

> +extern bool blk_is_valid_logical_block_size(unsigned int size);

No need for externs on function declarations.
