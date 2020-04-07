From: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH RFC v2 02/24] scsi: allocate separate queue for reserved
 commands
Date: Tue, 7 Apr 2020 16:45:04 +0200
Message-ID: <dcfba0ea-4ba5-4e4f-150d-24bd4fe11cdd@suse.de>
References: <1583857550-12049-1-git-send-email-john.garry@huawei.com>
 <1583857550-12049-3-git-send-email-john.garry@huawei.com>
 <20200310183243.GA14549@infradead.org>
 <79cf4341-f2a2-dcc9-be0d-2efc6e83028a@huawei.com>
 <20200311062228.GA13522@infradead.org>
 <b5a63725-722b-8ccd-3867-6db192a248a4@suse.de>
 <9c6ced82-b3f1-9724-b85e-d58827f1a4a4@huawei.com>
 <39bc2d82-2676-e329-5d32-8acb99b0a204@suse.de>
 <20ebe296-9e57-b3e3-21b3-63a09ce86036@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-block-owner@vger.kernel.org>
In-Reply-To: <20ebe296-9e57-b3e3-21b3-63a09ce86036@huawei.com>
Content-Language: en-US
Sender: linux-block-owner@vger.kernel.org
To: John Garry <john.garry@huawei.com>, Christoph Hellwig <hch@infradead.org>
Cc: axboe@kernel.dk, jejb@linux.ibm.com, martin.petersen@oracle.com, ming.lei@redhat.com, bvanassche@acm.org, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org, virtualization@lists.linux-foundation.org, esc.storagedev@microsemi.com, chenxiang66@hisilicon.com, Hannes Reinecke <hare@suse.com>
List-Id: virtualization@lists.linuxfoundation.org

On 4/7/20 4:35 PM, John Garry wrote:
> On 07/04/2020 15:00, Hannes Reinecke wrote:
>> On 4/7/20 1:54 PM, John Garry wrote:
>>> On 06/04/2020 10:05, Hannes Reinecke wrote:
[ .. ]
>>>> This would be okay if 'this_id' would have been defined by the driver;
>>>> sadly, most drivers which are affected here do set 'this_id' to -1.
>>>> So we wouldn't have a nice target ID to allocate the device from, let
>>>> alone the problem that we would have to emulate a complete scsi device
>>>> with all required minimal command support etc.
>>>> And I'm not quite sure how well that would play with the exising SCSI
>>>> host template; the device we'll be allocating would have basically
>>>> nothing in common with the 'normal' SCSI devices.
>>>>
>>>> What we could do, though, is to try it the other way round:
>>>> Lift the request queue from scsi_get_host_dev() into the scsi host
>>>> itself, so that scsi_get_host_dev() can use that queue, but we also
>>>> would be able to use it without a SCSI device attached.
>>>
>>> wouldn't that limit 1x scsi device per host, not that I know if any 
>>> more would ever be required? But it does still seem better to use the 
>>> request queue in the scsi device.
>>>
>> My concern is this:
>>
>> struct scsi_device *scsi_get_host_dev(struct Scsi_Host *shost)
>> {
>>      [ .. ]
>>      starget = scsi_alloc_target(&shost->shost_gendev, 0, 
>> shost->this_id);
>>      [ .. ]
>>
>> and we have typically:
>>
>> drivers/scsi/hisi_sas/hisi_sas_v3_hw.c: .this_id                = -1,
>>
>> It's _very_ uncommon to have a negative number as the SCSI target 
>> device; in fact, it _is_ an unsigned int already.
>>
> 
> FWIW, the only other driver (gdth) which I see uses this API has this_id 
> = -1 in the scsi host template.
> 
>> But alright, I'll give it a go; let's see what I'll end up with.
> 
> note: If we want a fixed scsi_device per host, calling 
> scsi_mq_setup_tags() -> scsi_get_host_dev() will fail as shost state is 
> not running. Maybe we need to juggle some things there to provide a 
> generic solution.
> 
It might even get worse, as during device setup things like 
'slave_alloc' etc is getting called, which has a fair chance of getting 
confused for non-existing devices.
Cf qla2xxx:qla2xx_slave_alloc() is calling starget_to_rport(), which 
will get us a nice oops when accessing a target which is _not_ the child 
of a fc remote port.
And this is why I'm not utterly keen on this approach; auditing all 
these callbacks is _not_ fun.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke            Teamlead Storage & Networking
hare@suse.de                               +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
