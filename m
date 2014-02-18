From: Heinz Graalfs <graalfs@linux.vnet.ibm.com>
Subject: Re: [PATCH v4 RFC 0/3] virtio: add 'device_lost' to virtio_device
Date: Tue, 18 Feb 2014 11:58:08 +0100
Message-ID: <53033CC0.3090502@linux.vnet.ibm.com>
References: <1386940410-44943-1-git-send-email-graalfs@linux.vnet.ibm.com>
	<878uu72tcq.fsf@rustcorp.com.au>
	<52E7D6F1.1020900@linux.vnet.ibm.com>
	<87ha8nxpsc.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <87ha8nxpsc.fsf@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>, mst@redhat.com, virtualization@lists.linux-foundation.org
Cc: borntraeger@de.ibm.com, Jens Axboe <axboe@kernel.dk>
List-Id: virtualization@lists.linuxfoundation.org


On 29/01/14 07:31, Rusty Russell wrote:
> Heinz Graalfs <graalfs@linux.vnet.ibm.com> writes:
>> On 23/01/14 05:51, Rusty Russell wrote:
>>> Heinz Graalfs <graalfs@linux.vnet.ibm.com> writes:
>>>> Hi, here is my v4 patch-set update to the v3 RFC submitted on Nov 27th.
>>>
>>> Hi Heinz,
>>>
>>>           I didn't get a response on my 'break all the virtqueues' patch
>>> series.  Could your System Z code work with this?
>>>
>>> Rusty.
>>>
>>>
>>
>> Sorry Rusty, I'm back as of today.
>>
>> I applied your patch series and did some testing...
>>
>> Removing a disk while reading from it mostly still ends up
>> in hangs as of below:
>
> OK, we still have the problem of in-flight requests.
>
> I think the correct answer is to drop all requests if the virtqueue
> is broken:
>
>   -	blk_cleanup_queue(vblk->disk->queue);
>   +	if (virtqueue_is_broken(vblk->vq))
>   +              /* Don't wait for completion, just drop queue. */
>   +              blk_abandon_queue(vblk->disk->queue);
Rusty,

but blk_abandon_queue() would not solve the incomplete in-flight
requests, would it? I suppose it would avoid additional in-flight
requests similar to __blk_request_all() and passing -EIO.

Ending of asynchronous in-flight requests still cause other problems
in the host. Such problems should be handled/avoided there, I suppose.

Heinz

>   +      else
>   +		blk_cleanup_queue(vblk->disk->queue);
>   +
>
> Unfortunately blk_abandon_queue() doesn't exist.  Your previous patch
> did nothing in that path, which I suspect may leak memory.  That may be
> acceptable given that this Shouldn't Happen (often).
>
> At this point, I ask Jens :)
>
waiting for requests (e.g. in-flight requests) in blk_cleanup_queue() that
> Cheers,
> Rusty.
>
>>
>> PID: 13     TASK: 163f8000          CPU: 0   COMMAND: "kworker/u128:1"
>>    #0 [163f72e0] __schedule at 6aa22c
>>    #1 [163f7428] io_schedule at 6aab6c
>>    #2 [163f7448] sleep_on_page at 22cbb2
>>    #3 [163f7460] __wait_on_bit at 6ab394
>>    #4 [163f74b0] wait_on_page_bit at 22cef4
>>    #5 [163f7508] filemap_fdatawait_range at 22d0a6
>>    #6 [163f75e8] filemap_write_and_wait at 22de62
>>    #7 [163f7618] fsync_bdev at 2dc5d8
>>    #8 [163f7640] invalidate_partition at 407ba8
>>    #9 [163f7668] del_gendisk at 408a4c
>> #10 [163f76c0] virtblk_remove at 46f81e
>> #11 [163f76f8] virtio_dev_remove at 43d302
>> #12 [163f7730] __device_release_driver at 4604c4
waiting for requests (e.g. in-flight requests) in blk_cleanup_queue() that
>> #13 [163f7758] device_release_driver at 46057c
>> #14 [163f7780] bus_remove_device at 45ff74
>> #15 [163f77b0] device_del at 45cf54
>> #16 [163f77e8] device_unregister at 45d00e
>> #17 [163f7808] unregister_virtio_device at 43d5ba
>> #18 [163f7828] virtio_ccw_remove at 55156c
>> #19 [163f7850] ccw_device_remove at 4d7e22
>> #20 [163f78d8] __device_release_driver at 4604c4
>> #21 [163f7900] device_release_driver at 46057c
>> #22 [163f7928] bus_remove_device at 45ff74
>> #23 [163f7958] device_del at 45cf54
>> #24 [163f7990] ccw_device_unregister at 4d86a0
>> #25 [163f79b0] io_subchannel_remove at 4d8d1a
>> #26 [163f79e8] css_remove at 4d2856
>> #27 [163f7a08] __device_release_driver at 4604c4
>> #28 [163f7a30] device_release_driver at 46057c
>> #29 [163f7a58] bus_remove_device at 45ff74
>> #30 [163f7a88] device_del at 45cf54
>> #31 [163f7ac0] device_unregister at 45d00e
>> #32 [163f7ae0] css_sch_device_unregister at 4d29d4
>> #33 [163f7b08] io_subchannel_sch_event at 4daad6
>> #34 [163f7b80] css_evaluate_known_subchannel at 4d2cc0
>> #35 [163f7be0] slow_eval_known_fn at 4d3cea
>> #36 [163f7c10] bus_for_each_dev at 45ea56
>> #37 [163f7c50] for_each_subchannel_staged at 4d337e
>> #38 [163f7c98] css_slow_path_func at 4d3450
>> #39 [163f7cc0] process_one_work at 164ff4
>> #40 [163f7d60] worker_thread at 166500
>> #41 [163f7da8] kthread at 16e67c
>> #42 [163f7eb0] kernel_thread_starter at 6b0a5e
>>
>> Removing a disk while writing to it now ends up mostly
>> with errors (which is new behavior and good).
>> However, the detached device is still listed under /dev, and a
>> subsequent umount ends up in a hang. Latter also occurred with
>> my approach, sometimes.
>>
>> Sometimes everything ends up in QEMU crashes, which is, however, not
>> reproducible. I will investigate on this.
>>
>> Heinz
>>
>>>> When an active virtio block device is hot-unplugged from a KVM guest,
>>>> affected guest user applications are not aware of any errors that occur
>>>> due to the lost device. This patch-set adds code to avoid further request
>>>> queueing when a lost block device is detected, resulting in appropriate
>>>> error info. Additionally a potential hang situation can be avoided by not
>>>> waiting for requests (e.g. in-flight requests) in blk_cleanup_queue() that
>>>> will never complete.
>>>>
>>>> On System z there exists no handshake mechanism between host and guest
>>>> when a device is hot-unplugged. The device is removed and no further I/O
>>>> is possible.
>>>>
>>>> When an online channel device disappears on System z the kernel's CIO layer
>>>> informs the driver (virtio_ccw) about the lost device.
>>>>
>>>> Here are some more error details:
>>>>
>>>> For a particular block device virtio's request function virtblk_request()
>>>> is called by the block layer to queue requests to be handled by the host.
>>>> In case of a lost device requests can still be queued, but an appropriate
>>>> subsequent host kick usually fails. This leads to situations where no error
>>>> feedback is shown.
>>>>
>>>> In order to prevent request queueing for lost devices appropriate settings
>>>> in the block layer should be made. Exploiting System z's CIO notify handler
>>>> callback, and passing on device loss information via the surprize_removal
>>>> flag to the remove callback of the backend driver, can solve this task.
>>>>
>>>> v3->v4 changes:
>>>>    - patch 1: solves some vcdev pointer handling issues in the virtio_ccw driver
>>>>      (e.g. locked vcdev pointer reset/query; serialize remove()/set_offline()
>>>>      callback processing).
>>>>    - patch 2: introduces 'device_lost' atomic in virtio_device and use in
>>>>      backend driver virtio_blk accordingly (original 3 patches merged).
>>>>    - patch 3: the notify() callback is now serialized with remove()/set_offline()
>>>>      callbacks. The notification is ignored if the vcdev pointer has been cleared
>>>>      already (by remove() or set_offline()).
>>>>
>>>> v2->v3 changes:
>>>>    - remove virtio_driver's notify callback (and appropriate code) introduced
>>>>      in my v1 RFC
>>>>    - introduce 'surprize_removal' in struct virtio_device
>>>>    - change virtio_blk's remove callback to perform special actions when the
>>>>      surprize_removal flag is set
>>>>      - avoid final I/O by preventing further request queueing
>>>>      - avoid hangs in blk_cleanup_queue() due to waits on 'in-flight' requests
>>>>    - set surprize_removal in virtio_ccw's notify callback when a device is lost
>>>>
>>>> v1->v2 changes:
>>>>    - add include of linux/notifier.h (I also added it to the 3rd patch)
>>>>    - get queue lock in order to be able to use safe queue_flag_set() functions
>>>>      in virtblk_notify() handler
>>>>
>>>>
>>>> Heinz Graalfs (3):
>>>>     virtio_ccw: fix vcdev pointer handling issues
>>>>     virtio: introduce 'device_lost' flag in virtio_device
>>>>     virtio_ccw: set 'device_lost' on CIO_GONE notification
>>>>
>>>>    drivers/block/virtio_blk.c    | 14 ++++++++++-
>>>>    drivers/s390/kvm/virtio_ccw.c | 58 ++++++++++++++++++++++++++++++++++++-------
>>>>    include/linux/virtio.h        |  2 ++
>>>>    3 files changed, 64 insertions(+), 10 deletions(-)
>>>>
>>>> --
>>>> 1.8.3.1
>>>
>
