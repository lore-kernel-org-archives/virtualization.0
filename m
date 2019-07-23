From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 6/6] vhost: don't do synchronize_rcu() in
	vhost_uninit_vq_maps()
Date: Tue, 23 Jul 2019 05:16:45 -0400
Message-ID: <20190723041144-mutt-send-email-mst__4781.61003427289$1563873425$gmane$org@kernel.org>
References: <20190723075718.6275-1-jasowang@redhat.com>
	<20190723075718.6275-7-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190723075718.6275-7-jasowang@redhat.com>
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

On Tue, Jul 23, 2019 at 03:57:18AM -0400, Jason Wang wrote:
> There's no need for RCU synchronization in vhost_uninit_vq_maps()
> since we've already serialized with readers (memory accessors). This
> also avoid the possible userspace DOS through ioctl() because of the
> possible high latency caused by synchronize_rcu().
> 
> Reported-by: Michael S. Tsirkin <mst@redhat.com>
> Fixes: 7f466032dc9e ("vhost: access vq metadata through kernel virtual address")
> Signed-off-by: Jason Wang <jasowang@redhat.com>

I agree synchronize_rcu in both mmu notifiers and ioctl
is a problem we must fix.

> ---
>  drivers/vhost/vhost.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 5b8821d00fe4..a17df1f4069a 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -334,7 +334,9 @@ static void vhost_uninit_vq_maps(struct vhost_virtqueue *vq)
>  	}
>  	spin_unlock(&vq->mmu_lock);
>  
> -	synchronize_rcu();
> +	/* No need for synchronize_rcu() or kfree_rcu() since we are
> +	 * serialized with memory accessors (e.g vq mutex held).
> +	 */
>  
>  	for (i = 0; i < VHOST_NUM_ADDRS; i++)
>  		if (map[i])
> -- 
> 2.18.1

.. however we can not RCU with no synchronization in sight.
Sometimes there are hacks like using a lock/unlock
pair instead of sync, but here no one bothers.

specifically notifiers call reset vq maps which calls
uninit vq maps which is not under any lock.

You will get use after free when map is then accessed.

If you always have a lock then just take that lock
and no need for RCU.

-- 
MST
