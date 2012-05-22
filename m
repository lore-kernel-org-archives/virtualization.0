From: Asias He <asias@redhat.com>
Subject: Re: [RFC PATCH 1/5] block: Introduce q->abort_queue_fn()
Date: Tue, 22 May 2012 15:30:37 +0800
Message-ID: <4FBB409D.4070201@redhat.com>
References: <1337591313-26333-1-git-send-email-asias@redhat.com>
	<20120521154213.GB6549@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120521154213.GB6549@google.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Tejun Heo <tj@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On 05/21/2012 11:42 PM, Tejun Heo wrote:
> On Mon, May 21, 2012 at 05:08:29PM +0800, Asias He wrote:
>> When user hot-unplug a disk which is busy serving I/O, __blk_run_queue
>> might be unable to drain all the requests. As a result, the
>> blk_drain_queue() would loop forever and blk_cleanup_queue would not
>> return. So hot-unplug will fail.
>>
>> This patch adds a callback in blk_drain_queue() for low lever driver to
>> abort requests.
>>
>> Currently, this is useful for virtio-blk to do cleanup in hot-unplug.
>
> Why is this necessary?  virtio-blk should know that the device is gone
> and fail in-flight / new commands.  That's what other drivers do.
> What makes virtio-blk different?

blk_cleanup_queue() relies on __blk_run_queue() to finish all the 
requests before DEAD marking, right?

There are two problems:

1) if the queue is stopped, q->request_fn() will never call called. we 
will be stuck in the loop forever. This can happen if the remove method 
is called after the q->request_fn() calls blk_stop_queue() to stop the 
queue when the device is full, and before the device interrupt handler 
to start the queue. This can be fixed by calling blk_start_queue() 
before __blk_run_queue(q).

blk_drain_queue() {
    while(true) {
       ...
       if (!list_empty(&q->queue_head))
         __blk_run_queue(q);
       ...
    }
}

2) Since the device is gonna be removed, is it safe to rely on the 
device to finish the request before the DEAD marking? E.g, In 
vritio-blk, We reset the device and thus disable the interrupt before we 
call blk_cleanup_queue(). I also suspect that the real hardware can 
finish the pending requests when being hot-unplugged.

So I proposed the q->abort_queue_fn() callback in blk_drain_queue() for 
the driver to abort the queue explicitly no mater how the device behaves.

BTW, do we have any infrastructure in block layer to track the requests 
already dispatched to driver. This might be useful for driver if it want 
to abort all of them. Otherwise the driver has to do it on their own.

-- 
Asias
