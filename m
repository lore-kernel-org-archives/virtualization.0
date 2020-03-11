From: Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH RFC v2 01/24] scsi: add 'nr_reserved_cmds' field to the
 SCSI host template
Date: Wed, 11 Mar 2020 16:00:26 +0800
Message-ID: <20200311080026.GB31504@ming.t460p>
References: <1583857550-12049-1-git-send-email-john.garry@huawei.com>
 <1583857550-12049-2-git-send-email-john.garry@huawei.com>
 <20200310230835.GA16056@ming.t460p>
 <fecc400c-fe6b-144a-51f9-1b3b2704c1a2@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-block-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <fecc400c-fe6b-144a-51f9-1b3b2704c1a2@suse.de>
Sender: linux-block-owner@vger.kernel.org
To: Hannes Reinecke <hare@suse.de>
Cc: John Garry <john.garry@huawei.com>, axboe@kernel.dk, jejb@linux.ibm.com, martin.petersen@oracle.com, bvanassche@acm.org, hch@infradead.org, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org, virtualization@lists.linux-foundation.org, esc.storagedev@microsemi.com, chenxiang66@hisilicon.com, Hannes Reinecke <hare@suse.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Mar 11, 2020 at 07:55:46AM +0100, Hannes Reinecke wrote:
> On 3/11/20 12:08 AM, Ming Lei wrote:
> > On Wed, Mar 11, 2020 at 12:25:27AM +0800, John Garry wrote:
> >> From: Hannes Reinecke <hare@suse.com>
> >>
> >> Add a new field 'nr_reserved_cmds' to the SCSI host template to
> >> instruct the block layer to set aside a tag space for reserved
> >> commands.
> >>
> >> Signed-off-by: Hannes Reinecke <hare@suse.com>
> >> ---
> >>  drivers/scsi/scsi_lib.c  | 1 +
> >>  include/scsi/scsi_host.h | 6 ++++++
> >>  2 files changed, 7 insertions(+)
> >>
> >> diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
> >> index 610ee41fa54c..2967325df7a0 100644
> >> --- a/drivers/scsi/scsi_lib.c
> >> +++ b/drivers/scsi/scsi_lib.c
> >> @@ -1896,6 +1896,7 @@ int scsi_mq_setup_tags(struct Scsi_Host *shost)
> >>  		shost->tag_set.ops = &scsi_mq_ops_no_commit;
> >>  	shost->tag_set.nr_hw_queues = shost->nr_hw_queues ? : 1;
> >>  	shost->tag_set.queue_depth = shost->can_queue;
> >> +	shost->tag_set.reserved_tags = shost->nr_reserved_cmds;
> > 
> > You reserve tags for special usage, meantime the whole queue depth
> > isn't increased, that means the tags for IO request is decreased given
> > reserved tags can't be used for IO, so IO performance may be effected.
> > 
> > If not the case, please explain a bit in commit log.
> > 
> The overall idea of this patchset is to fold _existing_ management
> command handling into using the blk-mq bitmap.
> Currently, quite a lot of drivers are using management commands
> internally, which typically use the same hardware tag pool (ie they are
> being allocated from the same hardware resources) than the 'normal' I/O
> commands.
> But as they are using the same tagpool these drivers already decrement
> the available number of commands; check eg. hpsa:
> 
> static int hpsa_scsi_host_alloc(struct ctlr_info *h)
> {
> 	struct Scsi_Host *sh;
> 
> 	sh = scsi_host_alloc(&hpsa_driver_template, sizeof(h));
> 	if (sh == NULL) {
> 		dev_err(&h->pdev->dev, "scsi_host_alloc failed\n");
> 		return -ENOMEM;
> 	}
> 
> 	sh->io_port = 0;
> 	sh->n_io_port = 0;
> 	sh->this_id = -1;
> 	sh->max_channel = 3;
> 	sh->max_cmd_len = MAX_COMMAND_SIZE;
> 	sh->max_lun = HPSA_MAX_LUN;
> 	sh->max_id = HPSA_MAX_LUN;
> 	sh->can_queue = h->nr_cmds - HPSA_NRESERVED_CMDS;
> 	sh->cmd_per_lun = sh->can_queue;
> 
> So the idea of this patchset is to convert existing use-cases; seeing
> that they already reserve commands internally performance will not be
> affected.
> 

OK, got it.

I'd suggest to add comment about this idea in commit log, cause
it is one fundamental thing about this change.

Thanks,
Ming
