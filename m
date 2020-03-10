From: Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH RFC v2 01/24] scsi: add 'nr_reserved_cmds' field to the
 SCSI host template
Date: Wed, 11 Mar 2020 07:08:35 +0800
Message-ID: <20200310230835.GA16056@ming.t460p>
References: <1583857550-12049-1-git-send-email-john.garry@huawei.com>
 <1583857550-12049-2-git-send-email-john.garry@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-scsi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1583857550-12049-2-git-send-email-john.garry@huawei.com>
Sender: linux-scsi-owner@vger.kernel.org
To: John Garry <john.garry@huawei.com>
Cc: axboe@kernel.dk, jejb@linux.ibm.com, martin.petersen@oracle.com, hare@suse.de, bvanassche@acm.org, hch@infradead.org, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org, virtualization@lists.linux-foundation.org, esc.storagedev@microsemi.com, chenxiang66@hisilicon.com, Hannes Reinecke <hare@suse.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Mar 11, 2020 at 12:25:27AM +0800, John Garry wrote:
> From: Hannes Reinecke <hare@suse.com>
> 
> Add a new field 'nr_reserved_cmds' to the SCSI host template to
> instruct the block layer to set aside a tag space for reserved
> commands.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.com>
> ---
>  drivers/scsi/scsi_lib.c  | 1 +
>  include/scsi/scsi_host.h | 6 ++++++
>  2 files changed, 7 insertions(+)
> 
> diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
> index 610ee41fa54c..2967325df7a0 100644
> --- a/drivers/scsi/scsi_lib.c
> +++ b/drivers/scsi/scsi_lib.c
> @@ -1896,6 +1896,7 @@ int scsi_mq_setup_tags(struct Scsi_Host *shost)
>  		shost->tag_set.ops = &scsi_mq_ops_no_commit;
>  	shost->tag_set.nr_hw_queues = shost->nr_hw_queues ? : 1;
>  	shost->tag_set.queue_depth = shost->can_queue;
> +	shost->tag_set.reserved_tags = shost->nr_reserved_cmds;

You reserve tags for special usage, meantime the whole queue depth
isn't increased, that means the tags for IO request is decreased given
reserved tags can't be used for IO, so IO performance may be effected.

If not the case, please explain a bit in commit log.

Thanks,
Ming
