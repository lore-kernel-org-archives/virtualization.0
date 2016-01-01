From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v4 1/2] virtio_balloon: Restore the entire balloon after
	the system freeze
Date: Fri, 1 Jan 2016 12:11:02 +0200
Message-ID: <20160101115424-mutt-send-email-mst@redhat.com>
References: <1449236271-10133-1-git-send-email-pmladek@suse.com>
	<1449236271-10133-2-git-send-email-pmladek@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1449236271-10133-2-git-send-email-pmladek@suse.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Petr Mladek <pmladek@suse.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Tejun Heo <tj@kernel.org>, Jeff Epler <jepler@unpythonic.net>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Dec 04, 2015 at 02:37:50PM +0100, Petr Mladek wrote:
> fill_balloon() and leak_balloon() manipulate only a limited number
> of pages in one call. This is the reason why remove_common() calls
> leak_balloon() in a while cycle.
> 
> remove_common() is called also when the system is being frozen.
> But fill_balloon() is called only once when the system is being
> restored. It means that most of the balloon stays leaked after
> the system freeze and restore.

Right, but refilling might take a long while.
In fact, we sleep for 200msec on refill failure,
stalling system resume - which is already a bug.

> This patch adds the missing while cycle also into virtballoon_restore().
> Also it makes fill_balloon() to return the number of really modified
> pages. Note that leak_balloon() already did this.
> 
> Signed-off-by: Petr Mladek <pmladek@suse.com>

This is a replacement for:
	virtio_balloon: Restore the entire balloon after the system freeze

> ---
>  drivers/virtio/virtio_balloon.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index 7efc32945810..d73a86db2490 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -135,9 +135,10 @@ static void set_page_pfns(u32 pfns[], struct page *page)
>  		pfns[i] = page_to_balloon_pfn(page) + i;
>  }
>  
> -static void fill_balloon(struct virtio_balloon *vb, size_t num)
> +static unsigned fill_balloon(struct virtio_balloon *vb, size_t num)
>  {
>  	struct balloon_dev_info *vb_dev_info = &vb->vb_dev_info;
> +	unsigned num_allocated_pages;
>  
>  	/* We can only do one array worth at a time. */
>  	num = min(num, ARRAY_SIZE(vb->pfns));
> @@ -162,10 +163,13 @@ static void fill_balloon(struct virtio_balloon *vb, size_t num)
>  			adjust_managed_page_count(page, -1);
>  	}
>  
> +	num_allocated_pages = vb->num_pfns;
>  	/* Did we get any? */
>  	if (vb->num_pfns != 0)
>  		tell_host(vb, vb->inflate_vq);
>  	mutex_unlock(&vb->balloon_lock);
> +
> +	return num_allocated_pages;
>  }
>  
>  static void release_pages_balloon(struct virtio_balloon *vb)
> @@ -581,6 +585,7 @@ static int virtballoon_freeze(struct virtio_device *vdev)
>  static int virtballoon_restore(struct virtio_device *vdev)
>  {
>  	struct virtio_balloon *vb = vdev->priv;
> +	s64 diff;
>  	int ret;
>  
>  	ret = init_vqs(vdev->priv);
> @@ -589,7 +594,9 @@ static int virtballoon_restore(struct virtio_device *vdev)
>  
>  	virtio_device_ready(vdev);
>  
> -	fill_balloon(vb, towards_target(vb));
> +	diff = towards_target(vb);
> +	while (diff > 0)
> +		diff -= fill_balloon(vb, diff);
>  	update_balloon_size(vb);
>  	return 0;
>  }
> -- 
> 1.8.5.6
