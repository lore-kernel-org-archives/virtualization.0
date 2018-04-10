From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2 1/2] vhost: fix vhost_vq_access_ok() log check
Date: Tue, 10 Apr 2018 16:22:35 +0300
Message-ID: <20180410161905-mutt-send-email-mst__46002.9278453023$1523366458$gmane$org@kernel.org>
References: <20180410052630.11270-1-stefanha@redhat.com>
	<20180410052630.11270-2-stefanha@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20180410052630.11270-2-stefanha@redhat.com>
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

On Tue, Apr 10, 2018 at 01:26:29PM +0800, Stefan Hajnoczi wrote:
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

This patch only makes sense after patch 2/2 is applied.
Otherwise the logic seems reversed below.

Can you pls squash these two?

> ---
>  drivers/vhost/vhost.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 5320039671b7..93fd0c75b0d8 100644
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
