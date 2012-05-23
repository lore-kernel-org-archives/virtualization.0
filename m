From: Asias He <asias@redhat.com>
Subject: Re: [RFC PATCH 1/5] block: Introduce q->abort_queue_fn()
Date: Wed, 23 May 2012 23:04:18 +0800
Message-ID: <4FBCFC72.9070306@redhat.com>
References: <1337591313-26333-1-git-send-email-asias@redhat.com>
	<20120521154213.GB6549@google.com> <4FBB409D.4070201@redhat.com>
	<20120522151441.GB14339@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120522151441.GB14339@google.com>
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

On 05/22/2012 11:14 PM, Tejun Heo wrote:
> Hello,
>
> On Tue, May 22, 2012 at 03:30:37PM +0800, Asias He wrote:
>> On 05/21/2012 11:42 PM, Tejun Heo wrote:
>> 1) if the queue is stopped, q->request_fn() will never call called.
>> we will be stuck in the loop forever. This can happen if the remove
>> method is called after the q->request_fn() calls blk_stop_queue() to
>> stop the queue when the device is full, and before the device
>> interrupt handler to start the queue. This can be fixed by calling
>> blk_start_queue() before __blk_run_queue(q).
>>
>> blk_drain_queue() {
>>     while(true) {
>>        ...
>>        if (!list_empty(&q->queue_head))
>>          __blk_run_queue(q);
>>        ...
>>     }
>> }
>
> Wouldn't that be properly fixed by making queue cleanup override
> stopped state?
>
>> 2) Since the device is gonna be removed, is it safe to rely on the
>> device to finish the request before the DEAD marking? E.g, In
>> vritio-blk, We reset the device and thus disable the interrupt
>> before we call blk_cleanup_queue(). I also suspect that the real
>> hardware can finish the pending requests when being hot-unplugged.
>
> Yes, it should be safe (otherwise it's a driver bug).  Device driver
> already knows the state of the device it is driving.  If the device
> can't service requests for whatever reason, the device driver should
> abort any in-flight and future requests.  That's how other block
> drivers behave and I don't see why virtio should be any different.


> Also, blk_drain_queue() is used for other purposes too - elevator
> switch and blkcg policy changes.  You definitely don't want to be
> aborting requests across those events.
> So, NACK.

Well. I think I can do the cleanup in virtio driver without introducing 
a new API now. We can reset the device after blk_cleanup_queue so that 
the device can complete all the requests before queue DEAD marking. This 
would be much simpler.

Thanks for pointing out, Tejun ;-)

-- 
Asias
