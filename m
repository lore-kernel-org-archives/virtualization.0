From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 5/6] vhost: mark dirty pages during map uninit
Date: Tue, 23 Jul 2019 05:17:06 -0400
Message-ID: <20190723041702-mutt-send-email-mst__18501.9061829493$1563873441$gmane$org@kernel.org>
References: <20190723075718.6275-1-jasowang@redhat.com>
	<20190723075718.6275-6-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190723075718.6275-6-jasowang@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jul 23, 2019 at 03:57:17AM -0400, Jason Wang wrote:
> We don't mark dirty pages if the map was teared down outside MMU
> notifier. This will lead untracked dirty pages. Fixing by marking
> dirty pages during map uninit.
> 
> Reported-by: Michael S. Tsirkin <mst@redhat.com>
> Fixes: 7f466032dc9e ("vhost: access vq metadata through kernel virtual address")
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/vhost/vhost.c | 22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 89c9f08b5146..5b8821d00fe4 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -306,6 +306,18 @@ static void vhost_map_unprefetch(struct vhost_map *map)
>  	kfree(map);
>  }
>  
> +static void vhost_set_map_dirty(struct vhost_virtqueue *vq,
> +				struct vhost_map *map, int index)
> +{
> +	struct vhost_uaddr *uaddr = &vq->uaddrs[index];
> +	int i;
> +
> +	if (uaddr->write) {
> +		for (i = 0; i < map->npages; i++)
> +			set_page_dirty(map->pages[i]);
> +	}
> +}
> +
>  static void vhost_uninit_vq_maps(struct vhost_virtqueue *vq)
>  {
>  	struct vhost_map *map[VHOST_NUM_ADDRS];
> @@ -315,8 +327,10 @@ static void vhost_uninit_vq_maps(struct vhost_virtqueue *vq)
>  	for (i = 0; i < VHOST_NUM_ADDRS; i++) {
>  		map[i] = rcu_dereference_protected(vq->maps[i],
>  				  lockdep_is_held(&vq->mmu_lock));
> -		if (map[i])
> +		if (map[i]) {
> +			vhost_set_map_dirty(vq, map[i], i);
>  			rcu_assign_pointer(vq->maps[i], NULL);
> +		}
>  	}
>  	spin_unlock(&vq->mmu_lock);
>  
> @@ -354,7 +368,6 @@ static void vhost_invalidate_vq_start(struct vhost_virtqueue *vq,
>  {
>  	struct vhost_uaddr *uaddr = &vq->uaddrs[index];
>  	struct vhost_map *map;
> -	int i;
>  
>  	if (!vhost_map_range_overlap(uaddr, start, end))
>  		return;
> @@ -365,10 +378,7 @@ static void vhost_invalidate_vq_start(struct vhost_virtqueue *vq,
>  	map = rcu_dereference_protected(vq->maps[index],
>  					lockdep_is_held(&vq->mmu_lock));
>  	if (map) {
> -		if (uaddr->write) {
> -			for (i = 0; i < map->npages; i++)
> -				set_page_dirty(map->pages[i]);
> -		}
> +		vhost_set_map_dirty(vq, map, index);
>  		rcu_assign_pointer(vq->maps[index], NULL);
>  	}
>  	spin_unlock(&vq->mmu_lock);

OK and the reason it's safe is because the invalidate counter
got incremented so we know page will not get mapped again.

But we *do* need to wait for page not to be mapped.
And if that means waiting for VQ processing to finish,
then I worry that is a very log time.


> -- 
> 2.18.1
