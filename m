From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH RFC v2 02/24] scsi: allocate separate queue for reserved
 commands
Date: Tue, 7 Apr 2020 09:30:33 -0700
Message-ID: <20200407163033.GA26568@infradead.org>
References: <1583857550-12049-1-git-send-email-john.garry@huawei.com>
 <1583857550-12049-3-git-send-email-john.garry@huawei.com>
 <20200310183243.GA14549@infradead.org>
 <79cf4341-f2a2-dcc9-be0d-2efc6e83028a@huawei.com>
 <20200311062228.GA13522@infradead.org>
 <b5a63725-722b-8ccd-3867-6db192a248a4@suse.de>
 <9c6ced82-b3f1-9724-b85e-d58827f1a4a4@huawei.com>
 <39bc2d82-2676-e329-5d32-8acb99b0a204@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <39bc2d82-2676-e329-5d32-8acb99b0a204@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Hannes Reinecke <hare@suse.de>
Cc: John Garry <john.garry@huawei.com>, Christoph Hellwig <hch@infradead.org>, axboe@kernel.dk, jejb@linux.ibm.com, martin.petersen@oracle.com, ming.lei@redhat.com, bvanassche@acm.org, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org, virtualization@lists.linux-foundation.org, esc.storagedev@microsemi.com, chenxiang66@hisilicon.com, Hannes Reinecke <hare@suse.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Apr 07, 2020 at 04:00:10PM +0200, Hannes Reinecke wrote:
> My concern is this:
> 
> struct scsi_device *scsi_get_host_dev(struct Scsi_Host *shost)
> {
> 	[ .. ]
> 	starget = scsi_alloc_target(&shost->shost_gendev, 0, shost->this_id);
> 	[ .. ]
> 
> and we have typically:
> 
> drivers/scsi/hisi_sas/hisi_sas_v3_hw.c: .this_id                = -1,
> 
> It's _very_ uncommon to have a negative number as the SCSI target device; in
> fact, it _is_ an unsigned int already.
> 
> But alright, I'll give it a go; let's see what I'll end up with.

But this shouldn't be exposed anywhere.  And I prefer that over having
magic requests/scsi_cmnd that do not have a valid ->device pointer.
