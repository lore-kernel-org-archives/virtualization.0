From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 4/6] vhost: reset invalidate_count in
	vhost_set_vring_num_addr()
Date: Tue, 23 Jul 2019 05:17:28 -0400
Message-ID: <20190723042143-mutt-send-email-mst__28056.4340458781$1563873464$gmane$org@kernel.org>
References: <20190723075718.6275-1-jasowang@redhat.com>
	<20190723075718.6275-5-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190723075718.6275-5-jasowang@redhat.com>
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

On Tue, Jul 23, 2019 at 03:57:16AM -0400, Jason Wang wrote:
> The vhost_set_vring_num_addr() could be called in the middle of
> invalidate_range_start() and invalidate_range_end(). If we don't reset
> invalidate_count after the un-registering of MMU notifier, the
> invalidate_cont will run out of sync (e.g never reach zero). This will
> in fact disable the fast accessor path. Fixing by reset the count to
> zero.
> 
> Reported-by: Michael S. Tsirkin <mst@redhat.com>
> Fixes: 7f466032dc9e ("vhost: access vq metadata through kernel virtual address")
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/vhost/vhost.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 03666b702498..89c9f08b5146 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -2074,6 +2074,10 @@ static long vhost_vring_set_num_addr(struct vhost_dev *d,
>  		d->has_notifier = false;
>  	}
>  
> +	/* reset invalidate_count in case we are in the middle of
> +	 * invalidate_start() and invalidate_end().
> +	 */
> +	vq->invalidate_count = 0;

I think that the code is ok but the comments are not very clear:
- we are never in the middle since we just removed the notifier
- the result is not just disabling optimization:
  if notifier becomes negative, then later we
  can think it's ok to map when it isn't since
  notifier is active.

>  	vhost_uninit_vq_maps(vq);
>  #endif
>  
> -- 
> 2.18.1
