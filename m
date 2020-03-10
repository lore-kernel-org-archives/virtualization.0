From: John Garry <john.garry@huawei.com>
Subject: Re: [PATCH RFC v2 02/24] scsi: allocate separate queue for reserved
 commands
Date: Tue, 10 Mar 2020 21:08:56 +0000
Message-ID: <79cf4341-f2a2-dcc9-be0d-2efc6e83028a@huawei.com>
References: <1583857550-12049-1-git-send-email-john.garry@huawei.com>
 <1583857550-12049-3-git-send-email-john.garry@huawei.com>
 <20200310183243.GA14549@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-block-owner@vger.kernel.org>
In-Reply-To: <20200310183243.GA14549@infradead.org>
Content-Language: en-US
Sender: linux-block-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: axboe@kernel.dk, jejb@linux.ibm.com, martin.petersen@oracle.com, hare@suse.de, ming.lei@redhat.com, bvanassche@acm.org, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org, virtualization@lists.linux-foundation.org, esc.storagedev@microsemi.com, chenxiang66@hisilicon.com, Hannes Reinecke <hare@suse.com>
List-Id: virtualization@lists.linuxfoundation.org

On 10/03/2020 18:32, Christoph Hellwig wrote:
> On Wed, Mar 11, 2020 at 12:25:28AM +0800, John Garry wrote:
>> From: Hannes Reinecke <hare@suse.com>
>>
>> Allocate a separate 'reserved_cmd_q' for sending reserved commands.
> 
> Why?  Reserved command specifically are not in any way tied to queues.
> .
> 

So the v1 series used a combination of the sdev queue and the per-host 
reserved_cmd_q. Back then you questioned using the sdev queue for virtio 
scsi, and the unconfirmed conclusion was to use a common per-host q. 
This is the best link I can find now:

https://www.mail-archive.com/linux-scsi@vger.kernel.org/msg83177.html

"

 >> My implementation actually allows for per-device reserved tags (eg for
 >> virtio). But some drivers require to use internal commands prior to any
 >> device setup, so they have to use a separate reserved command queue 
just to
 >> be able to allocate tags.
 >
 > Why would virtio-scsi need per-device reserved commands?  It 
currently uses
 > a global mempool to allocate the reset commands.
 >
Oh, I'm perfectly fine with dropping the per-device reserved commands,
and use the host-wide queue in general.
It turns out most of the drivers use it that way already.
Will be doing so for the next iteration.

"

Cheers
