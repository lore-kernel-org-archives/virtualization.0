From: Asias He <asias@redhat.com>
Subject: Re: [PATCH V6 2/2] virtio-blk: Add REQ_FLUSH and REQ_FUA support
	to bio path
Date: Wed, 08 Aug 2012 14:20:20 +0800
Message-ID: <50220524.4050202@redhat.com>
References: <1344329235-17449-1-git-send-email-asias@redhat.com>
	<1344329235-17449-3-git-send-email-asias@redhat.com>
	<20120807091510.GA2651@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120807091510.GA2651@lst.de>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Tejun Heo <tj@kernel.org>, Shaohua Li <shli@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On 08/07/2012 05:15 PM, Christoph Hellwig wrote:
> At least after review is done I really think this patch sopuld be folded
> into the previous one.

OK.

> Some more comments below:
>
>> @@ -58,6 +58,12 @@ struct virtblk_req
>>   	struct bio *bio;
>>   	struct virtio_blk_outhdr out_hdr;
>>   	struct virtio_scsi_inhdr in_hdr;
>> +	struct work_struct work;
>> +	struct virtio_blk *vblk;
>
> I think using bio->bi_private for the virtio_blk pointer would
> be cleaner.

I wish I could use bio->bi_private but I am seeing this when using 
bio->bi_priate to store virito_blk pointer:


[    1.100335] Call Trace:
[    1.100335]  <IRQ>
[    1.100335]  [<ffffffff811dd4b0>] ? end_bio_bh_io_sync+0x30/0x50
[    1.100335]  [<ffffffff811e167d>] bio_endio+0x1d/0x40
[    1.100335]  [<ffffffff81551fb2>] virtblk_done+0xa2/0x260
[    1.100335]  [<ffffffff813d714d>] vring_interrupt+0x2d/0x40
[    1.100335]  [<ffffffff81119c0d>] handle_irq_event_percpu+0x6d/0x210
[    1.100335]  [<ffffffff81119df1>] handle_irq_event+0x41/0x70
[    1.100335]  [<ffffffff8111d2c9>] handle_edge_irq+0x69/0x120
[    1.100335]  [<ffffffff810613a2>] handle_irq+0x22/0x30
[    1.100335]  [<ffffffff81aadccd>] do_IRQ+0x5d/0xe0
[    1.100335]  [<ffffffff81aa432f>] common_interrupt+0x6f/0x6f

end_bio_bh_io_sync() uses bio->private:

    struct buffer_head *bh = bio->bi_private;

>
>> +	bool is_flush;
>> +	bool req_flush;
>> +	bool req_data;
>> +	bool req_fua;
>
> This could be a bitmap, or better even a single state field.

Will use a bitmap for now.

>> +static int virtblk_bio_send_flush(struct virtio_blk *vblk,
>> +				  struct virtblk_req *vbr)
>
>> +static int virtblk_bio_send_data(struct virtio_blk *vblk,
>> +				 struct virtblk_req *vbr)
>
> These should only get the struct virtblk_req * argument as the virtio_blk
> structure is easily derivable from it.

Yes. Will clean it up.

>> +static inline void virtblk_bio_done_flush(struct virtio_blk *vblk,
>> +					  struct virtblk_req *vbr)
>>   {
>> +	if (vbr->req_data) {
>> +		/* Send out the actual write data */
>> +		struct virtblk_req *_vbr;
>> +		_vbr = virtblk_alloc_req(vblk, GFP_NOIO);
>> +		if (!_vbr) {
>> +			bio_endio(vbr->bio, -ENOMEM);
>> +			goto out;
>> +		}
>> +		_vbr->req_fua = vbr->req_fua;
>> +		_vbr->bio = vbr->bio;
>> +		_vbr->vblk = vblk;
>> +		INIT_WORK(&_vbr->work, virtblk_bio_send_data_work);
>> +		queue_work(virtblk_wq, &_vbr->work);
>
> The _vbr naming isn't too nice.  Also can you explain why the original
> request can't be reused in a comment here

Ah, the original request can be reused. Will fix this.

> Also if using a state variable I think the whole code would be
> a bit cleaner if the bio_done helpers are combined.
>
>> -	if (writeback && !use_bio)
>> +	if (writeback)
>>   		blk_queue_flush(vblk->disk->queue, REQ_FLUSH);
>
> Shouldn't this be REQ_FLUSH | REQ_FUA for the bio case?

Without REQ_FUA, I am also seeing bio with REQ_FUA flag set. Do we need 
to set REQ_FUA explicitly?

> Btw, did you verify that flushes really work correctly for all cases
> using tracing in qemu?

I added some debug code in both kernel and kvm tool to verity the flush.

-- 
Asias
