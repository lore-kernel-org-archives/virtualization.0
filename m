From: Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH RFC v2 12/24] hpsa: use reserved commands
Date: Wed, 11 Mar 2020 16:10:59 +0800
Message-ID: <20200311081059.GC31504@ming.t460p>
References: <1583857550-12049-1-git-send-email-john.garry@huawei.com>
 <1583857550-12049-13-git-send-email-john.garry@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-block-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1583857550-12049-13-git-send-email-john.garry@huawei.com>
Sender: linux-block-owner@vger.kernel.org
To: John Garry <john.garry@huawei.com>
Cc: axboe@kernel.dk, jejb@linux.ibm.com, martin.petersen@oracle.com, hare@suse.de, bvanassche@acm.org, hch@infradead.org, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org, virtualization@lists.linux-foundation.org, esc.storagedev@microsemi.com, chenxiang66@hisilicon.com, Hannes Reinecke <hare@suse.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Mar 11, 2020 at 12:25:38AM +0800, John Garry wrote:
> From: Hannes Reinecke <hare@suse.com>
> 
> Enable the use of reserved commands, and drop the hand-crafted
> command allocation.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.com>
> ---
>  drivers/scsi/hpsa.c | 147 ++++++++++++++------------------------------
>  drivers/scsi/hpsa.h |   1 -
>  2 files changed, 45 insertions(+), 103 deletions(-)
> 
> diff --git a/drivers/scsi/hpsa.c b/drivers/scsi/hpsa.c
> index 703f824584fe..c14dd4b6e598 100644
> --- a/drivers/scsi/hpsa.c
> +++ b/drivers/scsi/hpsa.c
> @@ -244,10 +244,6 @@ static struct hpsa_scsi_dev_t
>  	*hpsa_find_device_by_sas_rphy(struct ctlr_info *h,
>  		struct sas_rphy *rphy);
>  
> -#define SCSI_CMD_BUSY ((struct scsi_cmnd *)&hpsa_cmd_busy)
> -static const struct scsi_cmnd hpsa_cmd_busy;
> -#define SCSI_CMD_IDLE ((struct scsi_cmnd *)&hpsa_cmd_idle)
> -static const struct scsi_cmnd hpsa_cmd_idle;
>  static int number_of_controllers;
>  
>  static irqreturn_t do_hpsa_intr_intx(int irq, void *dev_id);
> @@ -342,7 +338,7 @@ static inline struct ctlr_info *shost_to_hba(struct Scsi_Host *sh)
>  
>  static inline bool hpsa_is_cmd_idle(struct CommandList *c)
>  {
> -	return c->scsi_cmd == SCSI_CMD_IDLE;
> +	return c->scsi_cmd == NULL;
>  }
>  
>  /* extract sense key, asc, and ascq from sense data.  -1 means invalid. */
> @@ -2445,7 +2441,12 @@ static void hpsa_cmd_resolve_events(struct ctlr_info *h,
>  	 * this command has completed.  Then, check to see if the handler is
>  	 * waiting for this command, and, if so, wake it.
>  	 */
> -	c->scsi_cmd = SCSI_CMD_IDLE;
> +	if (c->scsi_cmd && c->cmd_type == CMD_IOCTL_PEND) {
> +		struct scsi_cmnd *scmd = c->scsi_cmd;
> +
> +		scsi_put_reserved_cmd(scmd);
> +	}
> +	c->scsi_cmd = NULL;
>  	mb();	/* Declare command idle before checking for pending events. */
>  	if (dev) {
>  		atomic_dec(&dev->commands_outstanding);
> @@ -5502,7 +5503,6 @@ static void hpsa_cmd_init(struct ctlr_info *h, int index,
>  	c->ErrDesc.Addr = cpu_to_le64((u64) err_dma_handle);
>  	c->ErrDesc.Len = cpu_to_le32((u32) sizeof(*c->err_info));
>  	c->h = h;
> -	c->scsi_cmd = SCSI_CMD_IDLE;
>  }
>  
>  static void hpsa_preinitialize_commands(struct ctlr_info *h)
> @@ -5803,6 +5803,7 @@ static int hpsa_scsi_host_alloc(struct ctlr_info *h)
>  	sh->max_lun = HPSA_MAX_LUN;
>  	sh->max_id = HPSA_MAX_LUN;
>  	sh->can_queue = h->nr_cmds - HPSA_NRESERVED_CMDS;
> +	sh->nr_reserved_cmds = HPSA_NRESERVED_CMDS;

Now .nr_reserved_cmds has been passed to blk-mq, you need to increase
sh->can_queue to h->nr_cmds, because .can_queue is the whole queue depth
(include the part of reserved tags), otherwise, IO tags will be
decreased.

Not look into other drivers, I guess they need such change too.

Thanks,
Ming
