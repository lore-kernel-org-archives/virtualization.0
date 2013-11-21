From: Heinz Graalfs <graalfs@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC 0/3] virtio: add new notify() callback to virtio_driver
Date: Thu, 21 Nov 2013 15:43:51 +0100
Message-ID: <528E1C27.4020603@linux.vnet.ibm.com>
References: <1384960923-31463-1-git-send-email-graalfs@linux.vnet.ibm.com>
	<20131121064753.GK19005@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20131121064753.GK19005@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: borntraeger@de.ibm.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 21/11/13 07:47, Michael S. Tsirkin wrote:
> On Wed, Nov 20, 2013 at 04:22:00PM +0100, Heinz Graalfs wrote:
>> Hi,
>>
>> when an active virtio block device is hot-unplugged from a KVM guest, running
>> affected guest user applications are not aware of any errors that occur due
>> to the lost device. This patch-set adds code to avoid further request queueing
>> when a lost block device is detected, resulting in appropriate error info.
>>
>> On System z there exists no handshake mechanism between host and guest
>> when a device is hot-unplugged. The device is removed and no further I/O
>> is possible.
>>
>> When an online channel device disappears on System z the kernel's CIO layer
>> informs the driver (virtio_ccw) about the lost device.
>>
>> It's just the block device drivers that care to provide a notify
>> callback.
>>
>> Here are some more error details:
>>
>> For a particular block device virtio's request function virtblk_request()
>> is called by the block layer to queue requests to be handled by the host.
>> In case of a lost device requests can still be queued, but an appropriate
>> subsequent host kick usually fails. This leads to situations where no error
>> feedback is shown.
>>
>> In order to prevent request queueing for lost devices appropriate settings
>> in the block layer should be made. Exploiting System z's CIO notify handler
>> callback, and adding a corresponding new virtio_driver notify() handler to
>> 'inform' the block layer, solve this task.
>>
>> Patch 1 adds an optional notify() callback to virtio_driver.
>>
>> Patch 2 adds a new notify() callback for the virtio_blk driver. When called
>> for a lost device settings are made to prevent future request queueing.
>>
>> Patch 3 modifies the CIO notify handler in virtio_ccw's transport layer to pass
>> on the lost device info to virtio's backend driver virtio_blk.
>
> Question: I guess remove callback is invoked eventually?
> Could you please clarify why isn't this sufficient?
>

yes, the remove callback is invoked lateron, and it could be done there. 
However, it should be done conditionally, and prior to invoking 
del_gendisk() (which triggers final I/O). We would still have the need 
for such notification information. The remove callback is also invoked 
when a device is set offline, and in that case we don't want a queue to 
reject further requests. The way it is done right doesn't affect the 
remove callback. The weird situation, however, is solved by the new 
notify callback.

Doing it in blk_cleanup_queue() (also triggered from virtblk_remove()) 
is too late for this scenario of a lost device. One wouldn't see any 
errors, but experience a 'hang' due to inclomplete I/O. The invocation 
of virtblk_request() indirectly caused by del_gendisk() would accept 
requests, the subsequent host notification, however, would fail. (This 
is probably another 'window' that should be closed.)

>
>
>> Heinz Graalfs (3):
>>    virtio: add notify() callback to virtio_driver
>>    virtio_blk: add virtblk_notify() as virtio_driver's notify() callback
>>    virtio_ccw: invoke virtio_driver's notify() on CIO_GONE notification
>>
>>   drivers/block/virtio_blk.c    | 14 ++++++++++++++
>>   drivers/s390/kvm/virtio_ccw.c | 14 ++++++++++++--
>>   drivers/virtio/virtio.c       |  8 ++++++++
>>   include/linux/virtio.h        | 10 ++++++++++
>>   4 files changed, 44 insertions(+), 2 deletions(-)
>>
>> --
>> 1.8.3.1
>
