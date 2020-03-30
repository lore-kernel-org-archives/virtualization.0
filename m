From: John Garry <john.garry@huawei.com>
Subject: Re: [PATCH RFC v2 12/24] hpsa: use reserved commands
Date: Mon, 30 Mar 2020 14:42:45 +0100
Message-ID: <c3f5c030-d735-c730-6ff9-19cb1cb50fe8@huawei.com>
References: <1583857550-12049-1-git-send-email-john.garry@huawei.com>
 <1583857550-12049-13-git-send-email-john.garry@huawei.com>
 <20200311081059.GC31504@ming.t460p>
 <a76ab13a-85a3-0d88-595f-af13ef1b3fe3@huawei.com>
 <881b6a9b-2137-946f-a900-5c4e6cf1fe37@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-block-owner@vger.kernel.org>
In-Reply-To: <881b6a9b-2137-946f-a900-5c4e6cf1fe37@suse.de>
Content-Language: en-US
Sender: linux-block-owner@vger.kernel.org
To: Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>
Cc: axboe@kernel.dk, jejb@linux.ibm.com, martin.petersen@oracle.com, bvanassche@acm.org, hch@infradead.org, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org, virtualization@lists.linux-foundation.org, esc.storagedev@microsemi.com, chenxiang66@hisilicon.com, Hannes Reinecke <hare@suse.com>
List-Id: virtualization@lists.linuxfoundation.org

On 17/03/2020 09:48, Hannes Reinecke wrote:
> On 3/17/20 10:38 AM, John Garry wrote:
>> On 11/03/2020 08:10, Ming Lei wrote:
>>>> ands(struct ctlr_info *h)
>>>> @@ -5803,6 +5803,7 @@ static int hpsa_scsi_host_alloc(struct 
>>>> ctlr_info *h)
>>>>       sh->max_lun = HPSA_MAX_LUN;
>>>>       sh->max_id = HPSA_MAX_LUN;
>>>>       sh->can_queue = h->nr_cmds - HPSA_NRESERVED_CMDS;
>>>> +    sh->nr_reserved_cmds = HPSA_NRESERVED_CMDS;
>>> Now .nr_reserved_cmds has been passed to blk-mq, you need to increase
>>> sh->can_queue to h->nr_cmds, because .can_queue is the whole queue depth
>>> (include the part of reserved tags), otherwise, IO tags will be
>>> decreased.
>>>
>>
>> Sounds correct.
>>
> I will have having a look at the patchset; I thought I did a patch to 
> modify .can_queue so that it would cover only the usable tags, not the 
> reserved ones.
> 

To me, it makes sense to leave .can_queue unmodified, carry it down to 
blk-mq and allow blk_mq_init_bitmap_tags() find the queue depth:

static struct blk_mq_tags *blk_mq_init_bitmap_tags(struct blk_mq_tags *tags,
   int node, int alloc_policy)
{
	unsigned int depth = tags->nr_tags - tags->nr_reserved_tags; *
	bool round_robin = alloc_policy == BLK_TAG_ALLOC_RR;

	if (bt_alloc(&tags->bitmap_tags, depth, round_robin, node))
		goto free_tags;

Cheers,
John
