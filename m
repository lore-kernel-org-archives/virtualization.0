From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v3 1/2] vhost: fix vhost_vq_access_ok() log check
Date: Wed, 11 Apr 2018 16:23:22 +0300
Message-ID: <20180411162317-mutt-send-email-mst__41182.3805574842$1523452884$gmane$org@kernel.org>
References: <20180411023541.15776-1-stefanha@redhat.com>
	<20180411023541.15776-2-stefanha@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20180411023541.15776-2-stefanha@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Apr 11, 2018 at 10:35:40AM +0800, Stefan Hajnoczi wrote:
> Commit d65026c6c62e7d9616c8ceb5a53b68bcdc050525 ("vhost: validate log
> when IOTLB is enabled") introduced a regression.  The logic was
> originally:
> 
>   if (vq->iotlb)
>       return 1;
>   return A && B;
> 
> After the patch the short-circuit logic for A was inverted:
> 
>   if (A || vq->iotlb)
>       return A;
>   return B;
> 
> This patch fixes the regression by rewriting the checks in the obvious
> way, no longer returning A when vq->iotlb is non-NULL (which is hard to
> understand).
> 
> Reported-by: syzbot+65a84dde0214b0387ccd@syzkaller.appspotmail.com
> Cc: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  drivers/vhost/vhost.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index bec722e41f58..fc805b7fad9d 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -1244,10 +1244,12 @@ static int vq_log_access_ok(struct vhost_virtqueue *vq,
>  /* Caller should have vq mutex and device mutex */
>  int vhost_vq_access_ok(struct vhost_virtqueue *vq)
>  {
> -	int ret = vq_log_access_ok(vq, vq->log_base);
> +	if (!vq_log_access_ok(vq, vq->log_base))
> +		return 0;
>  
> -	if (ret || vq->iotlb)
> -		return ret;
> +	/* Access validation occurs at prefetch time with IOTLB */
> +	if (vq->iotlb)
> +		return 1;
>  
>  	return vq_access_ok(vq, vq->num, vq->desc, vq->avail, vq->used);
>  }
> -- 
> 2.14.3
