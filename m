From: Heinz Graalfs <graalfs@linux.vnet.ibm.com>
Subject: Fwd: Re: [PATCH v4 RFC 0/3] virtio: add 'device_lost' to virtio_device
Date: Mon, 13 Jan 2014 13:12:02 +0100
Message-ID: <52D3D812.3050409@linux.vnet.ibm.com>
References: <52B7F6B1.9070300@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <52B7F6B1.9070300@linux.vnet.ibm.com>
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org


Rusty, a Happy New Year!

how about my answer? What am I missing?

-------- Original Message --------
Subject: Re: [PATCH v4 RFC 0/3] virtio: add 'device_lost' to virtio_device
Date: Mon, 23 Dec 2013 09:39:13 +0100
From: Heinz Graalfs <graalfs@linux.vnet.ibm.com>
To: Rusty Russell <rusty@rustcorp.com.au>, mst@redhat.com, 
virtualization@lists.linux-foundation.org
CC: borntraeger@de.ibm.com

On 19/12/13 01:19, Rusty Russell wrote:
> Heinz Graalfs <graalfs@linux.vnet.ibm.com> writes:
>> On 17/12/13 04:42, Rusty Russell wrote:
>>> Heinz Graalfs <graalfs@linux.vnet.ibm.com> writes:
>>>> Hi, here is my v4 patch-set update to the v3 RFC submitted on Nov 27th.
>>>>
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
>>>
>>>
>>> Hi Heinz,
>>>
>>>           If you simply mark every virtqueue as broken when this
>>> unexpected unplug happens, does that not Just Work?
>>>
>>> I think I've asked this before...
>>> Rusty.
>>
>> Hi Rusty,
>>
>> setting the (one) virtqueue, vblk is currently using, as broken doesn't
>> solve the problems.
>>
>> In that case virtblk_request()s still succeed  - like this one...
>
> No, you set *all* virtqueues broken.  Which is accurate, right?
>
> Cheers,
> Rusty.
>

I'm sorry, but I don't get this.
The vblk involved has only 1 virtqueue.
What do you mean by all "*all* virtqueues ?

Heinz

>>
>> ([<0000000000112b28>] show_trace+0xf8/0x154)
>>    [<0000000000112bde>] show_stack+0x5a/0xdc
>>    [<000000000045eb56>] virtblk_request+0x25a/0x2b8
>>    [<00000000003e749c>] __blk_run_queue+0x50/0x64
>>    [<00000000003edb54>] blk_queue_bio+0x358/0x3f0
>>    [<00000000003eb446>] generic_make_request+0xea/0x130
>>    [<00000000003eb536>] submit_bio+0xaa/0x1a8
>>    [<00000000002c95e8>] _submit_bh+0x1c4/0x2f4
>>    [<00000000003a25e4>] journal_write_superblock+0xa0/0x1fc
>>    [<00000000003a3ed4>] journal_update_sb_log_tail+0x48/0x7c
>>    [<000000000039e742>] journal_commit_transaction+0x1586/0x1aa0
>>    [<00000000003a2a0e>] kjournald+0xfe/0x2a0
>>    [<00000000001786fc>] kthread+0xd8/0xe0
>>    [<0000000000698fee>] kernel_thread_starter+0x6/0xc
>> 2 locks held by kjournald/1984:
>>
>> ... and end up in hang situations ...
>>
>> PID: 13     TASK: 1e3f8000          CPU: 0   COMMAND: "kworker/u128:1"
>>    #0 [1e2033e0] __schedule at 695ff2
>>    #1 [1e203530] log_wait_commit at 3a28a6
>>    #2 [1e2035a0] ext3_sync_fs at 328dea
>>    #3 [1e2035d8] sync_filesystem at 2c785c
>>    #4 [1e203600] fsync_bdev at 2d4650
>>    #5 [1e203628] invalidate_partition at 3f80c8
>>    #6 [1e203650] del_gendisk at 3f8f5c
>>    #7 [1e2036c8] virtblk_remove at 45e60e
>>    #8 [1e203700] virtio_dev_remove at 42d72e
>>    #9 [1e203738] __device_release_driver at 44f0b0
>> #10 [1e203760] device_release_driver at 44f16c
>> #11 [1e203788] bus_remove_device at 44ea92
>> #12 [1e2037b8] device_del at 44bb40
>> #13 [1e2037f0] device_unregister at 44bbfa
>> #14 [1e203810] unregister_virtio_device at 42d9e6
>> #15 [1e203830] virtio_ccw_remove at 53b834
>> #16 [1e203850] ccw_device_remove at 4c5bf6
>> #17 [1e2038d8] __device_release_driver at 44f0b0
>> #18 [1e203900] device_release_driver at 44f16c
>> #19 [1e203928] bus_remove_device at 44ea92
>> #20 [1e203958] device_del at 44bb40
>> #21 [1e203990] ccw_device_unregister at 4c645c
>> #22 [1e2039b0] io_subchannel_remove at 4c6b1a
>> #23 [1e2039e8] css_remove at 4c054e
>> #24 [1e203a08] __device_release_driver at 44f0b0
>> #25 [1e203a30] device_release_driver at 44f16c
>> #26 [1e203a58] bus_remove_device at 44ea92
>> #27 [1e203a88] device_del at 44bb40
>> #28 [1e203ac0] device_unregister at 44bbfa
>> #29 [1e203ae0] css_sch_device_unregister at 4c06cc
>> #30 [1e203b08] io_subchannel_sch_event at 4c8c3a
>> #31 [1e203b80] css_evaluate_known_subchannel at 4c09bc
>> #32 [1e203be0] slow_eval_known_fn at 4c19a6
>> #33 [1e203c10] bus_for_each_dev at 44d50e
>> #34 [1e203c50] for_each_subchannel_staged at 4c1066
>> #35 [1e203c98] css_slow_path_func at 4c1124
>> #36 [1e203cc0] process_one_work at 16c7f6
>> #37 [1e203d60] worker_thread at 16dce4
>> #38 [1e203da8] kthread at 1786fc
>> #39 [1e203eb0] kernel_thread_starter at 698fee
>>
>> Heinz
>>
>>>
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

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
