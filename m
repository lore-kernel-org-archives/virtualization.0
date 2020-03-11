From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH RFC v2 02/24] scsi: allocate separate queue for reserved
 commands
Date: Tue, 10 Mar 2020 23:22:28 -0700
Message-ID: <20200311062228.GA13522@infradead.org>
References: <1583857550-12049-1-git-send-email-john.garry@huawei.com>
 <1583857550-12049-3-git-send-email-john.garry@huawei.com>
 <20200310183243.GA14549@infradead.org>
 <79cf4341-f2a2-dcc9-be0d-2efc6e83028a@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-block-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <79cf4341-f2a2-dcc9-be0d-2efc6e83028a@huawei.com>
Sender: linux-block-owner@vger.kernel.org
To: John Garry <john.garry@huawei.com>
Cc: Christoph Hellwig <hch@infradead.org>, axboe@kernel.dk, jejb@linux.ibm.com, martin.petersen@oracle.com, hare@suse.de, ming.lei@redhat.com, bvanassche@acm.org, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org, virtualization@lists.linux-foundation.org, esc.storagedev@microsemi.com, chenxiang66@hisilicon.com, Hannes Reinecke <hare@suse.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Mar 10, 2020 at 09:08:56PM +0000, John Garry wrote:
> On 10/03/2020 18:32, Christoph Hellwig wrote:
> > On Wed, Mar 11, 2020 at 12:25:28AM +0800, John Garry wrote:
> > > From: Hannes Reinecke <hare@suse.com>
> > > 
> > > Allocate a separate 'reserved_cmd_q' for sending reserved commands.
> > 
> > Why?  Reserved command specifically are not in any way tied to queues.
> > .
> > 
> 
> So the v1 series used a combination of the sdev queue and the per-host
> reserved_cmd_q. Back then you questioned using the sdev queue for virtio
> scsi, and the unconfirmed conclusion was to use a common per-host q. This is
> the best link I can find now:
> 
> https://www.mail-archive.com/linux-scsi@vger.kernel.org/msg83177.html

That was just a question on why virtio uses the per-device tags, which
didn't look like it made any sense.  What I'm worried about here is
mixing up the concept of reserved tags in the tagset, and queues to use
them.  Note that we already have the scsi_get_host_dev to allocate
a scsi_device and thus a request_queue for the host itself.  That seems
like the better interface to use a tag for a host wide command vs
introducing a parallel path.
