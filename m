From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v3 RFC 3/4] virtio_blk: avoid calling blk_cleanup_queue()
	on device loss
Date: Wed, 27 Nov 2013 16:37:29 +0200
Message-ID: <20131127143729.GA30971@redhat.com>
References: <1385548360-31943-1-git-send-email-graalfs@linux.vnet.ibm.com>
	<1385548360-31943-4-git-send-email-graalfs@linux.vnet.ibm.com>
	<20131127104740.GB29702@redhat.com>
	<5295D95E.4070305@linux.vnet.ibm.com>
	<20131127124956.GA30325@redhat.com>
	<5295FE91.7050601@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <5295FE91.7050601@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Heinz Graalfs <graalfs@linux.vnet.ibm.com>
Cc: borntraeger@de.ibm.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Nov 27, 2013 at 03:15:45PM +0100, Heinz Graalfs wrote:
> On 27/11/13 13:49, Michael S. Tsirkin wrote:
> >On Wed, Nov 27, 2013 at 12:37:02PM +0100, Heinz Graalfs wrote:
> >>On 27/11/13 11:47, Michael S. Tsirkin wrote:
> >>>On Wed, Nov 27, 2013 at 11:32:39AM +0100, Heinz Graalfs wrote:
> >>>>Code is added to avoid calling blk_cleanup_queue() when the surprize_removal
> >>>>flag is set due to a disappeared device. It avoid hangs due to incomplete
> >>>>requests (e.g. in-flight requests). Such requests must be considered as lost.
> >>>
> >>>Ugh. Can't we complete these immediately using detach_unused_buf? If not why?
> >>
> >>OK, I will try
> 
> I tried virtqueue_detach_unused_buf(). It doesn't seem to solve the
> problem. Would that affect block layer in-flight requests anyway?
> The function comment also says it should not be used on an active
> queue.

Yes, this must be done after reset normally
so we know device is not consuming buffers.

But if you know device is gone, just make sure
no one will add more requests, that's enough.



> Isn't there a mechanism to end vring requests for which a
> vring_interrupt() is missing? (simulate virtblk_done() with an
> error)?
> At least that's it what would help, I suppose.
> 
> >>
> >>>
> >>>>If the current remove callback was triggered due to an unregister driver,
> >>>>and the surprize_removal is not already set (although the actual device
> >>>>is already gone, e.g. virsh detach), blk_cleanup_queue() would be triggered
> >>>>resulting in a possible hang. This hang is caused by e.g. 'in-flight' requests
> >>>>that will never complete. This is a weird situation, and most likely not
> >>>>'serializable'.
> >>>
> >>>Hmm interesting. Implement some timeout and probe device to make sure
> >>>it's still alive?
> 
> This patch doesn't try to solve any weird races.
> It avoids triggering the block queue cleanup, with potential for a
> hang, IFF a device is gone.
> 
> >>
> >>but there is always some race, isn't it?
> >
> >To clarify, why this might not be very elegant, a timer-based
> >solution for surprise removal during driver cleanup
> >might be easier than trying to build robust interfaces
> >to address this esoteric case.
> >
> >But what worries me is that it's not clear to me that ccw won't
> >invoke notify in parallel with remove callback.
> >If this happens there will be use after free.
> 
> OK, I agree, calling remove twice or working on freed stuff must not happen.
> 
> >
> 
> 
> >
