From: Asias He <asias@redhat.com>
Subject: Re: [PATCH] virtio-blk: Disable callback in virtblk_done()
Date: Thu, 27 Sep 2012 14:48:50 +0800
Message-ID: <5063F6D2.7030908@redhat.com>
References: <1348540577-7474-1-git-send-email-asias@redhat.com>
	<5061BAED.9020205@redhat.com> <87ehlo497o.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <87ehlo497o.fsf@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On 09/27/2012 08:10 AM, Rusty Russell wrote:
> Asias He <asias@redhat.com> writes:
> 
>> On 09/25/2012 10:36 AM, Asias He wrote:
>>> This reduces unnecessary interrupts that host could send to guest while
>>> guest is in the progress of irq handling.
>>>
>>> If one vcpu is handling the irq, while another interrupt comes, in
>>> handle_edge_irq(), the guest will mask the interrupt via mask_msi_irq()
>>> which is a very heavy operation that goes all the way down to host.
>>>
>>> Signed-off-by: Asias He <asias@redhat.com>
>>> ---
>>
>> Here are some performance numbers on qemu:
> 
> I assume this is with qemu using kvm, not qemu in soft emulation? :)

Of course.

> 
>> Before:
>> -------------------------------------
>>   seq-read  : io=0 B, bw=269730KB/s, iops=67432 , runt= 62200msec
>>   seq-write : io=0 B, bw=339716KB/s, iops=84929 , runt= 49386msec
>>   rand-read : io=0 B, bw=270435KB/s, iops=67608 , runt= 62038msec
>>   rand-write: io=0 B, bw=354436KB/s, iops=88608 , runt= 47335msec
>>     clat (usec): min=101 , max=138052 , avg=14822.09, stdev=11771.01
>>     clat (usec): min=96 , max=81543 , avg=11798.94, stdev=7735.60
>>     clat (usec): min=128 , max=140043 , avg=14835.85, stdev=11765.33
>>     clat (usec): min=109 , max=147207 , avg=11337.09, stdev=5990.35
>>   cpu          : usr=15.93%, sys=60.37%, ctx=7764972, majf=0, minf=54
>>   cpu          : usr=32.73%, sys=120.49%, ctx=7372945, majf=0, minf=1
>>   cpu          : usr=18.84%, sys=58.18%, ctx=7775420, majf=0, minf=1
>>   cpu          : usr=24.20%, sys=59.85%, ctx=8307886, majf=0, minf=0
>>   vdb: ios=8389107/8368136, merge=0/0, ticks=19457874/14616506,
>> in_queue=34206098, util=99.68%
>>  43: interrupt in total: 887320
>> fio --exec_prerun="echo 3 > /proc/sys/vm/drop_caches" --group_reporting
>> --ioscheduler=noop --thread --bs=4k --size=512MB --direct=1 --numjobs=16
>> --ioengine=libaio --iodepth=64 --loops=3 --ramp_time=0
>> --filename=/dev/vdb --name=seq-read --stonewall --rw=read
>> --name=seq-write --stonewall --rw=write --name=rnd-read --stonewall
>> --rw=randread --name=rnd-write --stonewall --rw=randwrite
>>
>> After:
>> -------------------------------------
>>   seq-read  : io=0 B, bw=309503KB/s, iops=77375 , runt= 54207msec
>>   seq-write : io=0 B, bw=448205KB/s, iops=112051 , runt= 37432msec
>>   rand-read : io=0 B, bw=311254KB/s, iops=77813 , runt= 53902msec
>>   rand-write: io=0 B, bw=377152KB/s, iops=94287 , runt= 44484msec
>>     clat (usec): min=81 , max=90588 , avg=12946.06, stdev=9085.94
>>     clat (usec): min=57 , max=72264 , avg=8967.97, stdev=5951.04
>>     clat (usec): min=29 , max=101046 , avg=12889.95, stdev=9067.91
>>     clat (usec): min=52 , max=106152 , avg=10660.56, stdev=4778.19
>>   cpu          : usr=15.05%, sys=57.92%, ctx=7710941, majf=0, minf=54
>>   cpu          : usr=26.78%, sys=101.40%, ctx=7387891, majf=0, minf=2
>>   cpu          : usr=19.03%, sys=58.17%, ctx=7681976, majf=0, minf=8
>>   cpu          : usr=24.65%, sys=58.34%, ctx=8442632, majf=0, minf=4
>>   vdb: ios=8389086/8361888, merge=0/0, ticks=17243780/12742010,
>> in_queue=30078377, util=99.59%
>>  43: interrupt in total: 1259639
>> fio --exec_prerun="echo 3 > /proc/sys/vm/drop_caches" --group_reporting
>> --ioscheduler=noop --thread --bs=4k --size=512MB --direct=1 --numjobs=16
>> --ioengine=libaio --iodepth=64 --loops=3 --ramp_time=0
>> --filename=/dev/vdb --name=seq-read --stonewall --rw=read
>> --name=seq-write --stonewall --rw=write --name=rnd-read --stonewall
>> --rw=randread --name=rnd-write --stonewall --rw=randwrite
>>
>>>  drivers/block/virtio_blk.c | 19 +++++++++++--------
>>>  1 file changed, 11 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
>>> index 53b81d5..0bdde8f 100644
>>> --- a/drivers/block/virtio_blk.c
>>> +++ b/drivers/block/virtio_blk.c
>>> @@ -274,15 +274,18 @@ static void virtblk_done(struct virtqueue *vq)
>>>  	unsigned int len;
>>>  
>>>  	spin_lock_irqsave(vblk->disk->queue->queue_lock, flags);
>>> -	while ((vbr = virtqueue_get_buf(vblk->vq, &len)) != NULL) {
>>> -		if (vbr->bio) {
>>> -			virtblk_bio_done(vbr);
>>> -			bio_done = true;
>>> -		} else {
>>> -			virtblk_request_done(vbr);
>>> -			req_done = true;
>>> +	do {
>>> +		virtqueue_disable_cb(vq);
>>> +		while ((vbr = virtqueue_get_buf(vblk->vq, &len)) != NULL) {
>>> +			if (vbr->bio) {
>>> +				virtblk_bio_done(vbr);
>>> +				bio_done = true;
>>> +			} else {
>>> +				virtblk_request_done(vbr);
>>> +				req_done = true;
>>> +			}
>>>  		}
>>> -	}
>>> +	} while (!virtqueue_enable_cb(vq));
>>>  	/* In case queue is stopped waiting for more buffers. */
>>>  	if (req_done)
>>>  		blk_start_queue(vblk->disk->queue);
> 
> Fascinating.  Please just confirm that VIRTIO_RING_F_EVENT_IDX is
> enabled?

Sure. It is enabled ;-)

> 
> I forgot about the cool hack which MST put in to defer event updates
> using disable_cb/enable_cb.

Hmm, are you talking about virtqueue_enable_cb_delayed()?

> 
> Applied!
> Rusty.
> 


-- 
Asias
