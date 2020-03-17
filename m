From: John Garry <john.garry@huawei.com>
Subject: Re: [PATCH RFC v2 12/24] hpsa: use reserved commands
Date: Tue, 17 Mar 2020 09:38:10 +0000
Message-ID: <a76ab13a-85a3-0d88-595f-af13ef1b3fe3@huawei.com>
References: <1583857550-12049-1-git-send-email-john.garry@huawei.com>
 <1583857550-12049-13-git-send-email-john.garry@huawei.com>
 <20200311081059.GC31504@ming.t460p>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-block-owner@vger.kernel.org>
In-Reply-To: <20200311081059.GC31504@ming.t460p>
Content-Language: en-US
Sender: linux-block-owner@vger.kernel.org
To: Ming Lei <ming.lei@redhat.com>
Cc: axboe@kernel.dk, jejb@linux.ibm.com, martin.petersen@oracle.com, hare@suse.de, bvanassche@acm.org, hch@infradead.org, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org, virtualization@lists.linux-foundation.org, esc.storagedev@microsemi.com, chenxiang66@hisilicon.com, Hannes Reinecke <hare@suse.com>
List-Id: virtualization@lists.linuxfoundation.org

On 11/03/2020 08:10, Ming Lei wrote:
>> ands(struct ctlr_info *h)
>> @@ -5803,6 +5803,7 @@ static int hpsa_scsi_host_alloc(struct ctlr_info *h)
>>   	sh->max_lun = HPSA_MAX_LUN;
>>   	sh->max_id = HPSA_MAX_LUN;
>>   	sh->can_queue = h->nr_cmds - HPSA_NRESERVED_CMDS;
>> +	sh->nr_reserved_cmds = HPSA_NRESERVED_CMDS;
> Now .nr_reserved_cmds has been passed to blk-mq, you need to increase
> sh->can_queue to h->nr_cmds, because .can_queue is the whole queue depth
> (include the part of reserved tags), otherwise, IO tags will be
> decreased.
> 

Sounds correct.

Cheers,
John

> Not look into other drivers, I guess they need such change too.
> 
> Thanks,
> Ming
> 
> .
