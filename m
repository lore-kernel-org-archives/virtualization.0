From: Wei Wang <wei.w.wang@intel.com>
Subject: Re: [PATCH] virtio: avoid possible OOM lockup at
	virtballoon_oom_notify()
Date: Thu, 12 Oct 2017 10:36:00 +0800
Message-ID: <59DED510.5000407__36692.6588387743$1507775673$gmane$org@intel.com>
References: <1507632457-4611-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1507632457-4611-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, mst@redhat.com, mhocko@kernel.org
Cc: linux-mm@kvack.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 10/10/2017 06:47 PM, Tetsuo Handa wrote:
> In leak_balloon(), mutex_lock(&vb->balloon_lock) is called in order to
> serialize against fill_balloon(). But in fill_balloon(),
> alloc_page(GFP_HIGHUSER[_MOVABLE] | __GFP_NOMEMALLOC | __GFP_NORETRY) is
> called with vb->balloon_lock mutex held. Since GFP_HIGHUSER[_MOVABLE]
> implies __GFP_DIRECT_RECLAIM | __GFP_IO | __GFP_FS, despite __GFP_NORETRY
> is specified, this allocation attempt might indirectly depend on somebody
> else's __GFP_DIRECT_RECLAIM memory allocation. And such indirect
> __GFP_DIRECT_RECLAIM memory allocation might call leak_balloon() via
> virtballoon_oom_notify() via blocking_notifier_call_chain() callback via
> out_of_memory() when it reached __alloc_pages_may_oom() and held oom_lock
> mutex. Since vb->balloon_lock mutex is already held by fill_balloon(), it
> will cause OOM lockup. Thus, do not wait for vb->balloon_lock mutex if
> leak_balloon() is called from out_of_memory().
>
>    Thread1                                       Thread2
>      fill_balloon()
>        takes a balloon_lock
>        balloon_page_enqueue()
>          alloc_page(GFP_HIGHUSER_MOVABLE)
>            direct reclaim (__GFP_FS context)       takes a fs lock
>              waits for that fs lock                  alloc_page(GFP_NOFS)
>                                                        __alloc_pages_may_oom()
>                                                          takes the oom_lock
>                                                          out_of_memory()
>                                                            blocking_notifier_call_chain()
>                                                              leak_balloon()
>                                                                tries to take that balloon_lock and deadlocks
>
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>


I think we could also use 'bool wait' to let the OOM use the traditional 
leak_balloon code path,
which doesn't need memory allocation from xb_preload(). That is, inside 
leak_balloon(), we can have

use_sg = virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_SG) & wait;


Reviewed-by: Wei Wang <wei.w.wang@intel.com>


> ---
>   drivers/virtio/virtio_balloon.c | 16 +++++++++++-----
>   1 file changed, 11 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index f0b3a0b..03e6078 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -192,7 +192,7 @@ static void release_pages_balloon(struct virtio_balloon *vb,
>   	}
>   }
>   
> -static unsigned leak_balloon(struct virtio_balloon *vb, size_t num)
> +static unsigned leak_balloon(struct virtio_balloon *vb, size_t num, bool wait)
>   {
>   	unsigned num_freed_pages;
>   	struct page *page;
> @@ -202,7 +202,13 @@ static unsigned leak_balloon(struct virtio_balloon *vb, size_t num)
>   	/* We can only do one array worth at a time. */
>   	num = min(num, ARRAY_SIZE(vb->pfns));
>   
> -	mutex_lock(&vb->balloon_lock);
> +	if (wait)
> +		mutex_lock(&vb->balloon_lock);
> +	else if (!mutex_trylock(&vb->balloon_lock)) {
> +		pr_info("virtio_balloon: Unable to release %lu pages due to lock contention.\n",
> +			(unsigned long) min(num, (size_t)vb->num_pages));
> +		return 0;
> +	}
>   	/* We can't release more pages than taken */
>   	num = min(num, (size_t)vb->num_pages);
>   	for (vb->num_pfns = 0; vb->num_pfns < num;
> @@ -367,7 +373,7 @@ static int virtballoon_oom_notify(struct notifier_block *self,
>   		return NOTIFY_OK;
>   
>   	freed = parm;
> -	num_freed_pages = leak_balloon(vb, oom_pages);
> +	num_freed_pages = leak_balloon(vb, oom_pages, false);
>   	update_balloon_size(vb);
>   	*freed += num_freed_pages;
>   
> @@ -395,7 +401,7 @@ static void update_balloon_size_func(struct work_struct *work)
>   	if (diff > 0)
>   		diff -= fill_balloon(vb, diff);
>   	else if (diff < 0)
> -		diff += leak_balloon(vb, -diff);
> +		diff += leak_balloon(vb, -diff, true);
>   	update_balloon_size(vb);
>   
>   	if (diff)
> @@ -597,7 +603,7 @@ static void remove_common(struct virtio_balloon *vb)
>   {
>   	/* There might be pages left in the balloon: free them. */
>   	while (vb->num_pages)
> -		leak_balloon(vb, vb->num_pages);
> +		leak_balloon(vb, vb->num_pages, true);
>   	update_balloon_size(vb);
>   
>   	/* Now we reset the device so we can clean up the queues. */
