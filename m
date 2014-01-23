From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH v4 RFC 0/3] virtio: add 'device_lost' to virtio_device
Date: Thu, 23 Jan 2014 15:21:49 +1030
Message-ID: <878uu72tcq.fsf@rustcorp.com.au>
References: <1386940410-44943-1-git-send-email-graalfs@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1386940410-44943-1-git-send-email-graalfs@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Heinz Graalfs <graalfs@linux.vnet.ibm.com>, mst@redhat.com, virtualization@lists.linux-foundation.org
Cc: borntraeger@de.ibm.com
List-Id: virtualization@lists.linuxfoundation.org

Heinz Graalfs <graalfs@linux.vnet.ibm.com> writes:
> Hi, here is my v4 patch-set update to the v3 RFC submitted on Nov 27th. 

Hi Heinz,

        I didn't get a response on my 'break all the virtqueues' patch
series.  Could your System Z code work with this?

Rusty.




>
> When an active virtio block device is hot-unplugged from a KVM guest,
> affected guest user applications are not aware of any errors that occur
> due to the lost device. This patch-set adds code to avoid further request
> queueing when a lost block device is detected, resulting in appropriate
> error info. Additionally a potential hang situation can be avoided by not
> waiting for requests (e.g. in-flight requests) in blk_cleanup_queue() that
> will never complete.
>
> On System z there exists no handshake mechanism between host and guest
> when a device is hot-unplugged. The device is removed and no further I/O
> is possible.
>
> When an online channel device disappears on System z the kernel's CIO layer
> informs the driver (virtio_ccw) about the lost device.
>
> Here are some more error details:
>
> For a particular block device virtio's request function virtblk_request()
> is called by the block layer to queue requests to be handled by the host.
> In case of a lost device requests can still be queued, but an appropriate
> subsequent host kick usually fails. This leads to situations where no error
> feedback is shown.
>
> In order to prevent request queueing for lost devices appropriate settings
> in the block layer should be made. Exploiting System z's CIO notify handler
> callback, and passing on device loss information via the surprize_removal
> flag to the remove callback of the backend driver, can solve this task.
>
> v3->v4 changes:
>  - patch 1: solves some vcdev pointer handling issues in the virtio_ccw driver
>    (e.g. locked vcdev pointer reset/query; serialize remove()/set_offline()
>    callback processing).
>  - patch 2: introduces 'device_lost' atomic in virtio_device and use in
>    backend driver virtio_blk accordingly (original 3 patches merged).
>  - patch 3: the notify() callback is now serialized with remove()/set_offline()
>    callbacks. The notification is ignored if the vcdev pointer has been cleared
>    already (by remove() or set_offline()).
>
> v2->v3 changes:
>  - remove virtio_driver's notify callback (and appropriate code) introduced
>    in my v1 RFC
>  - introduce 'surprize_removal' in struct virtio_device
>  - change virtio_blk's remove callback to perform special actions when the
>    surprize_removal flag is set
>    - avoid final I/O by preventing further request queueing
>    - avoid hangs in blk_cleanup_queue() due to waits on 'in-flight' requests
>  - set surprize_removal in virtio_ccw's notify callback when a device is lost
>
> v1->v2 changes:
>  - add include of linux/notifier.h (I also added it to the 3rd patch)
>  - get queue lock in order to be able to use safe queue_flag_set() functions
>    in virtblk_notify() handler
>
>
> Heinz Graalfs (3):
>   virtio_ccw: fix vcdev pointer handling issues
>   virtio: introduce 'device_lost' flag in virtio_device
>   virtio_ccw: set 'device_lost' on CIO_GONE notification
>
>  drivers/block/virtio_blk.c    | 14 ++++++++++-
>  drivers/s390/kvm/virtio_ccw.c | 58 ++++++++++++++++++++++++++++++++++++-------
>  include/linux/virtio.h        |  2 ++
>  3 files changed, 64 insertions(+), 10 deletions(-)
>
> -- 
> 1.8.3.1
