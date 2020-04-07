From: John Garry <john.garry@huawei.com>
Subject: Re: [PATCH RFC v2 02/24] scsi: allocate separate queue for reserved
 commands
Date: Tue, 7 Apr 2020 16:19:35 +0100
Message-ID: <38c1592d-c90a-d6ca-1e7e-e8cc665aaf22@huawei.com>
References: <1583857550-12049-1-git-send-email-john.garry@huawei.com>
 <1583857550-12049-3-git-send-email-john.garry@huawei.com>
 <20200310183243.GA14549@infradead.org>
 <79cf4341-f2a2-dcc9-be0d-2efc6e83028a@huawei.com>
 <20200311062228.GA13522@infradead.org>
 <b5a63725-722b-8ccd-3867-6db192a248a4@suse.de>
 <9c6ced82-b3f1-9724-b85e-d58827f1a4a4@huawei.com>
 <39bc2d82-2676-e329-5d32-8acb99b0a204@suse.de>
 <20ebe296-9e57-b3e3-21b3-63a09ce86036@huawei.com>
 <dcfba0ea-4ba5-4e4f-150d-24bd4fe11cdd@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <dcfba0ea-4ba5-4e4f-150d-24bd4fe11cdd@suse.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@infradead.org>
Cc: axboe@kernel.dk, jejb@linux.ibm.com, martin.petersen@oracle.com, ming.lei@redhat.com, bvanassche@acm.org, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org, virtualization@lists.linux-foundation.org, esc.storagedev@microsemi.com, chenxiang66@hisilicon.com, Hannes Reinecke <hare@suse.com>
List-Id: virtualization@lists.linuxfoundation.org

>>>
>>
>> FWIW, the only other driver (gdth) which I see uses this API has 
>> this_id = -1 in the scsi host template.
>>
>>> But alright, I'll give it a go; let's see what I'll end up with.
>>
>> note: If we want a fixed scsi_device per host, calling 
>> scsi_mq_setup_tags() -> scsi_get_host_dev() will fail as shost state 
>> is not running. Maybe we need to juggle some things there to provide a 
>> generic solution.
>>
> It might even get worse, as during device setup things like 
> 'slave_alloc' etc is getting called, which has a fair chance of getting 
> confused for non-existing devices.
> Cf qla2xxx:qla2xx_slave_alloc() is calling starget_to_rport(), which 
> will get us a nice oops when accessing a target which is _not_ the child 
> of a fc remote port.

Yes, something similar happens for libsas [hence my hack], where 
sas_alloc_target()->sas_find_dev_by_rphy() fails as it cannot handle 
rphy for scsi host as parent properly.

> And this is why I'm not utterly keen on this approach; auditing all 
> these callbacks is _not_ fun.
> 

Understood. And if you can't test them, then a change like this is too 
risky for those drivers.

Cheers,
John
