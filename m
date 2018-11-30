From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [PATCH] vhost: fix IOTLB locking
Date: Fri, 30 Nov 2018 15:33:31 +0000
Message-ID: <81d9b5da-ae63-1ce5-7812-7062c03d4313__25732.4679093019$1543591926$gmane$org@arm.com>
References: <20181130113702.1565-1-jean-philippe.brucker@arm.com>
	<20181130075347-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20181130075347-mutt-send-email-mst@kernel.org>
Content-Language: en-US
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
Cc: netdev@vger.kernel.org, davem@davemloft.net, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 30/11/2018 13:32, Michael S. Tsirkin wrote:
> On Fri, Nov 30, 2018 at 11:37:02AM +0000, Jean-Philippe Brucker wrote:
>> Commit 78139c94dc8c ("net: vhost: lock the vqs one by one") moved the vq
>> lock to improve scalability, but introduced a possible deadlock in
>> vhost-iotlb. vhost_iotlb_notify_vq() now takes vq->mutex while holding
>> the device's IOTLB spinlock.
> 
> Indeed spin_lock is just outside this snippet. Yack.
> 
>> And on the vhost_iotlb_miss() path, the
>> spinlock is taken while holding vq->mutex.
>>
>> As long as we hold dev->mutex to prevent an ioctl from modifying
>> vq->poll concurrently, we can safely call vhost_poll_queue() without
>> holding vq->mutex. Since vhost_process_iotlb_msg() holds dev->mutex when
>> calling vhost_iotlb_notify_vq(), avoid the deadlock by not taking
>> vq->mutex.
>>
>> Fixes: 78139c94dc8c ("net: vhost: lock the vqs one by one")
>> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> 
> 
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> 
> but see below for a minor comment.
> 
> I guess we now need this on stable?

I don't think so, the bug is introduced in 4.20

> 
>> ---
>>  drivers/vhost/vhost.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>> index 3a5f81a66d34..1cbb17f898f7 100644
>> --- a/drivers/vhost/vhost.c
>> +++ b/drivers/vhost/vhost.c
>> @@ -944,10 +944,10 @@ static void vhost_iotlb_notify_vq(struct vhost_dev *d,
>>  		if (msg->iova <= vq_msg->iova &&
>>  		    msg->iova + msg->size - 1 >= vq_msg->iova &&
>>  		    vq_msg->type == VHOST_IOTLB_MISS) {
>> -			mutex_lock(&node->vq->mutex);
>> +			/* Safe to call outside vq->mutex as long as dev->mutex
>> +			 * is held.
>> +			 */
>>  			vhost_poll_queue(&node->vq->poll);
>> -			mutex_unlock(&node->vq->mutex);
>> -
> 
> In fact vhost_poll_queue is generally lockless so it's
> safe to call without any locks.

Right, I'll remove the comment

Thanks,
Jean

> 
> 
>>  			list_del(&node->node);
>>  			kfree(node);
> 
>>  		}
>> -- 
>> 2.19.1
> _______________________________________________
> Virtualization mailing list
> Virtualization@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/virtualization
> 
