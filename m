From: John Garry <john.garry@huawei.com>
Subject: Re: [PATCH RFC v2 02/24] scsi: allocate separate queue for reserved
 commands
Date: Tue, 7 Apr 2020 15:35:24 +0100
Message-ID: <20ebe296-9e57-b3e3-21b3-63a09ce86036@huawei.com>
References: <1583857550-12049-1-git-send-email-john.garry@huawei.com>
 <1583857550-12049-3-git-send-email-john.garry@huawei.com>
 <20200310183243.GA14549@infradead.org>
 <79cf4341-f2a2-dcc9-be0d-2efc6e83028a@huawei.com>
 <20200311062228.GA13522@infradead.org>
 <b5a63725-722b-8ccd-3867-6db192a248a4@suse.de>
 <9c6ced82-b3f1-9724-b85e-d58827f1a4a4@huawei.com>
 <39bc2d82-2676-e329-5d32-8acb99b0a204@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <39bc2d82-2676-e329-5d32-8acb99b0a204@suse.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@infradead.org>
Cc: axboe@kernel.dk, jejb@linux.ibm.com, martin.petersen@oracle.com, ming.lei@redhat.com, bvanassche@acm.org, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org, virtualization@lists.linux-foundation.org, esc.storagedev@microsemi.com, chenxiang66@hisilicon.com, Hannes Reinecke <hare@suse.com>
List-Id: virtualization@lists.linuxfoundation.org

On 07/04/2020 15:00, Hannes Reinecke wrote:
> On 4/7/20 1:54 PM, John Garry wrote:
>> On 06/04/2020 10:05, Hannes Reinecke wrote:
>>> On 3/11/20 7:22 AM, Christoph Hellwig wrote:
>>>> On Tue, Mar 10, 2020 at 09:08:56PM +0000, John Garry wrote:
>>>>> On 10/03/2020 18:32, Christoph Hellwig wrote:
>>>>>> On Wed, Mar 11, 2020 at 12:25:28AM +0800, John Garry wrote:
>>>>>>> From: Hannes Reinecke <hare@suse.com>
>>>>>>>
>>>>>>> Allocate a separate 'reserved_cmd_q' for sending reserved commands.
>>>>>>
>>>>>> Why?  Reserved command specifically are not in any way tied to 
>>>>>> queues.
>>>>>> .
>>>>>>
>>>>>
>>>>> So the v1 series used a combination of the sdev queue and the per-host
>>>>> reserved_cmd_q. Back then you questioned using the sdev queue for 
>>>>> virtio
>>>>> scsi, and the unconfirmed conclusion was to use a common per-host 
>>>>> q. This is
>>>>> the best link I can find now:
>>>>>
>>>>> https://www.mail-archive.com/linux-scsi@vger.kernel.org/msg83177.html
>>>>
>>>> That was just a question on why virtio uses the per-device tags, which
>>>> didn't look like it made any sense.  What I'm worried about here is
>>>> mixing up the concept of reserved tags in the tagset, and queues to use
>>>> them.  Note that we already have the scsi_get_host_dev to allocate
>>>> a scsi_device and thus a request_queue for the host itself.  That seems
>>>> like the better interface to use a tag for a host wide command vs
>>>> introducing a parallel path.
>>>>
>>> Thinking about it some more, I don't think that scsi_get_host_dev() is
>>> the best way of handling it.
>>> Problem is that it'll create a new scsi_device with <hostno:this_id:0>,
>>> which will then show up via eg 'lsscsi'.
>>
>> are you sure? Doesn't this function just allocate the sdev, but do 
>> nothing with it, like probing it?
>>
>> I bludgeoned it in here for PoC:
>>
>> https://github.com/hisilicon/kernel-dev/commit/ef0ae8540811e32776f64a5b42bd76cbed17ba47 
>>
>>
>> And then still:
>>
>> john@ubuntu:~$ lsscsi
>> [0:0:0:0] disk SEAGATE  ST2000NM0045  N004  /dev/sda
>> [0:0:1:0] disk SEAGATE  ST2000NM0045  N004  /dev/sdb
>> [0:0:2:0] disk ATASAMSUNG HM320JI  0_01  /dev/sdc
>> [0:0:3:0] disk SEAGATE  ST1000NM0023  0006  /dev/sdd
>> [0:0:4:0] enclosu HUAWEIExpander 12Gx16  128-
>> john@ubuntu:~$
>>
>> Some proper plumbing would be needed, though.
>>
>>> This would be okay if 'this_id' would have been defined by the driver;
>>> sadly, most drivers which are affected here do set 'this_id' to -1.
>>> So we wouldn't have a nice target ID to allocate the device from, let
>>> alone the problem that we would have to emulate a complete scsi device
>>> with all required minimal command support etc.
>>> And I'm not quite sure how well that would play with the exising SCSI
>>> host template; the device we'll be allocating would have basically
>>> nothing in common with the 'normal' SCSI devices.
>>>
>>> What we could do, though, is to try it the other way round:
>>> Lift the request queue from scsi_get_host_dev() into the scsi host
>>> itself, so that scsi_get_host_dev() can use that queue, but we also
>>> would be able to use it without a SCSI device attached.
>>
>> wouldn't that limit 1x scsi device per host, not that I know if any 
>> more would ever be required? But it does still seem better to use the 
>> request queue in the scsi device.
>>
> My concern is this:
> 
> struct scsi_device *scsi_get_host_dev(struct Scsi_Host *shost)
> {
>      [ .. ]
>      starget = scsi_alloc_target(&shost->shost_gendev, 0, shost->this_id);
>      [ .. ]
> 
> and we have typically:
> 
> drivers/scsi/hisi_sas/hisi_sas_v3_hw.c: .this_id                = -1,
> 
> It's _very_ uncommon to have a negative number as the SCSI target 
> device; in fact, it _is_ an unsigned int already.
> 

FWIW, the only other driver (gdth) which I see uses this API has this_id 
= -1 in the scsi host template.

> But alright, I'll give it a go; let's see what I'll end up with.

note: If we want a fixed scsi_device per host, calling 
scsi_mq_setup_tags() -> scsi_get_host_dev() will fail as shost state is 
not running. Maybe we need to juggle some things there to provide a 
generic solution.

thanks
