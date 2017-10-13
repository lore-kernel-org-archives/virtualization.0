From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: Re: [PATCH] virtio_balloon: fix deadlock on OOM
Date: Fri, 13 Oct 2017 23:06:23 +0900
Message-ID: <201710132306.FBC78628.OJLHFVQSFOtOMF__11051.2743391611$1507903626$gmane$org@I-love.SAKURA.ne.jp>
References: <1507900754-32239-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1507900754-32239-1-git-send-email-mst@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: mst@redhat.com, linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, mhocko@suse.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Michael S. Tsirkin wrote:
> This is a replacement for
> 	[PATCH] virtio: avoid possible OOM lockup at virtballoon_oom_notify()
> but unlike that patch it actually deflates on oom even in presence of
> lock contention.

But Wei Wang is proposing VIRTIO_BALLOON_F_SG which will try to allocate
memory, isn't he?

> 
>  drivers/virtio/virtio_balloon.c    | 30 ++++++++++++++++++++++--------
>  include/linux/balloon_compaction.h | 38 +++++++++++++++++++++++++++++++++++++-
>  mm/balloon_compaction.c            | 27 +++++++++++++++++++++------
>  3 files changed, 80 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index f0b3a0b..725e366 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -143,16 +143,14 @@ static void set_page_pfns(struct virtio_balloon *vb,
>  
>  static unsigned fill_balloon(struct virtio_balloon *vb, size_t num)
>  {
> -	struct balloon_dev_info *vb_dev_info = &vb->vb_dev_info;
>  	unsigned num_allocated_pages;
> +	unsigned num_pfns;
> +	struct page *page;
> +	LIST_HEAD(pages);
>  
> -	/* We can only do one array worth at a time. */
> -	num = min(num, ARRAY_SIZE(vb->pfns));
> -

I don't think moving this min() to later is correct, for
"num" can be e.g. 1048576, can't it?

> -	mutex_lock(&vb->balloon_lock);
> -	for (vb->num_pfns = 0; vb->num_pfns < num;
> -	     vb->num_pfns += VIRTIO_BALLOON_PAGES_PER_PAGE) {
> -		struct page *page = balloon_page_enqueue(vb_dev_info);
> +	for (num_pfns = 0; num_pfns < num;
> +	     num_pfns += VIRTIO_BALLOON_PAGES_PER_PAGE) {
> +		struct page *page = balloon_page_alloc();
>  
>  		if (!page) {
>  			dev_info_ratelimited(&vb->vdev->dev,
> @@ -162,6 +160,22 @@ static unsigned fill_balloon(struct virtio_balloon *vb, size_t num)
>  			msleep(200);
>  			break;
>  		}
> +
> +		balloon_page_push(&pages, page);
> +	}

If balloon_page_alloc() did not fail, it will queue "num"
(e.g. 1048576) pages into pages list, won't it?

> +
> +	/* We can only do one array worth at a time. */
> +	num = min(num, ARRAY_SIZE(vb->pfns));
> +

Now we cap "num" to VIRTIO_BALLOON_ARRAY_PFNS_MAX (which is 256), but

> +	mutex_lock(&vb->balloon_lock);
> +
> +	vb->num_pfns = 0;
> +
> +	while ((page = balloon_page_pop(&pages))) {

this loop will repeat for e.g. 1048576 times, and

> +		balloon_page_enqueue(&vb->vb_dev_info, page);
> +
> +		vb->num_pfns += VIRTIO_BALLOON_PAGES_PER_PAGE;
> +

we increment vb->num_pfns for e.g. 1048576 times which will go
beyond VIRTIO_BALLOON_ARRAY_PFNS_MAX array index.

>  		set_page_pfns(vb, vb->pfns + vb->num_pfns, page);
>  		vb->num_pages += VIRTIO_BALLOON_PAGES_PER_PAGE;
>  		if (!virtio_has_feature(vb->vdev,
