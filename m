From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH v3 RFC 2/4] virtio_blk: avoid further request queueing on
	device loss
Date: Wed, 04 Dec 2013 14:34:01 +1030
Message-ID: <87pppdw9ce.fsf@rustcorp.com.au>
References: <1385548360-31943-1-git-send-email-graalfs@linux.vnet.ibm.com>
	<1385548360-31943-3-git-send-email-graalfs@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1385548360-31943-3-git-send-email-graalfs@linux.vnet.ibm.com>
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
> Code is added to the remove callback to verify if a device was lost.
>
> In case of a device loss further request queueing should be prevented
> by setting appropriate queue flags prior to invoking del_gendisk().
> Blocking of request queueing leads to appropriate I/O errors when data
> are tried to be synched. Trying to synch data to a lost block device
> doesn't make too much sense.

Sure, but this isn't the only case where we should set these flags,
right?  I would think if any virtqueue is reported broken, we should
mark the queue dying too.

> If the current remove callback was triggered due to an unregister driver,
> and the surprize_removal is not already set (although the actual device
> is already gone, e.g. virsh detach), del_gendisk() would be triggered
> resulting in a hang. This is a weird situation, and most likely not
> 'serializable'.

This seems like abusing the vdev struct to pass an argument to
virtblk_remove().

How about you mark all virtqueues broken in the "unexpected removal"
case?  Then the driver should correctly fail to deliver requests.

Cheers,
Rusty.
