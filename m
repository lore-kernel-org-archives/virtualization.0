From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH RFC v2 02/24] scsi: allocate separate queue for reserved
 commands
Date: Tue, 10 Mar 2020 11:32:43 -0700
Message-ID: <20200310183243.GA14549@infradead.org>
References: <1583857550-12049-1-git-send-email-john.garry@huawei.com>
 <1583857550-12049-3-git-send-email-john.garry@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1583857550-12049-3-git-send-email-john.garry@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: John Garry <john.garry@huawei.com>
Cc: axboe@kernel.dk, jejb@linux.ibm.com, martin.petersen@oracle.com, hare@suse.de, ming.lei@redhat.com, bvanassche@acm.org, hch@infradead.org, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org, virtualization@lists.linux-foundation.org, esc.storagedev@microsemi.com, chenxiang66@hisilicon.com, Hannes Reinecke <hare@suse.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Mar 11, 2020 at 12:25:28AM +0800, John Garry wrote:
> From: Hannes Reinecke <hare@suse.com>
> 
> Allocate a separate 'reserved_cmd_q' for sending reserved commands.

Why?  Reserved command specifically are not in any way tied to queues.
