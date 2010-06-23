From: Anthony Liguori <anthony@codemonkey.ws>
Subject: Re: [RFC] virtio: Support releasing lock during kick
Date: Wed, 23 Jun 2010 17:12:14 -0500
Message-ID: <4C2286BE.40808__12119.6202155717$1277331167$gmane$org@codemonkey.ws>
References: <1277328242-10685-1-git-send-email-stefanha@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1277328242-10685-1-git-send-email-stefanha@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 06/23/2010 04:24 PM, Stefan Hajnoczi wrote:
> The virtio block device holds a lock during I/O request processing.
> Kicking the virtqueue while the lock is held results in long lock hold
> times and increases contention for the lock.
>
> This patch modifies virtqueue_kick() to optionally release a lock while
> notifying the host.  Virtio block is modified to pass in its lock.  This
> allows other vcpus to queue I/O requests during the time spent servicing
> the virtqueue notify in the host.
>
> The virtqueue_kick() function is modified to know about locking because
> it changes the state of the virtqueue and should execute with the lock
> held (it would not be correct for virtio block to release the lock
> before calling virtqueue_kick()).
>
> Signed-off-by: Stefan Hajnoczi<stefanha@linux.vnet.ibm.com>
> ---
> I am not yet 100% happy with this patch which aims to reduce guest CPU
> consumption related to vblk->lock contention.  Although this patch reduces
> wait/hold times it does not affect I/O throughput or guest CPU utilization.
> More investigation is required to get to the bottom of why guest CPU
> utilization does not decrease when a lock bottleneck has been removed.
>
> Performance figures:
>
> Host: 2.6.34 upstream kernel, qemu-kvm-0.12.4 if=virtio,cache=none
> Guest: 2.6.35-rc3-kvm.git upstream kernel
> Storage: 12 disks as striped LVM volume
> Benchmark: 4 concurrent dd bs=4k iflag=direct
>
> Lockstat data for&vblk->lock:
>
> test       con-bounces contentions  waittime-min waittime-max waittime-total
> unmodified 7097        7108         0.31         956.09       161165.4
> patched    11484       11550        0.30         411.80       50245.83
>
> The maximum wait time went down by 544.29 us (-57%) and the total wait time
> decreased by 69%.  This shows that the virtqueue kick is indeed hogging the
> lock.
>
> The patched version actually has higher contention than the unmodified version.
> I think the reason for this is that each virtqueue kick now includes a short
> release and reacquire.  This short release gives other vcpus a chance to
> acquire the lock and progress, hence more contention but overall better wait
> time numbers.
>
> name       acq-bounces acquisitions holdtime-min holdtime-max holdtime-total
> unmodified 10771       5038346      0.00         3271.81      59016905.47
> patched    31594       5857813      0.00         219.76       24104915.55
>
> Here we see the full impact of this patch: hold time reduced to 219.76 us
> (-93%).
>
> Again the acquisitions have increased since we're now doing an extra
> unlock+lock per virtqueue kick.
>
> Testing, ideas, and comments appreciated.
>
>   drivers/block/virtio_blk.c          |    2 +-
>   drivers/char/hw_random/virtio-rng.c |    2 +-
>   drivers/char/virtio_console.c       |    6 +++---
>   drivers/net/virtio_net.c            |    6 +++---
>   drivers/virtio/virtio_balloon.c     |    6 +++---
>   drivers/virtio/virtio_ring.c        |   13 +++++++++++--
>   include/linux/virtio.h              |    3 ++-
>   net/9p/trans_virtio.c               |    2 +-
>   8 files changed, 25 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 258bc2a..de033bf 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -187,7 +187,7 @@ static void do_virtblk_request(struct request_queue *q)
>   	}
>
>   	if (issued)
> -		virtqueue_kick(vblk->vq);
> +		virtqueue_kick(vblk->vq,&vblk->lock);
>   }
>    

Shouldn't it be possible to just drop the lock before invoking 
virtqueue_kick() and reacquire it afterwards?  There's nothing in that 
virtqueue_kick() path that the lock is protecting AFAICT.

Regards,

Anthony Liguori
