From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC PATCH V3 1/5] vhost: generalize adding used elem
Date: Fri, 4 Jan 2019 16:29:34 -0500
Message-ID: <20190104162857-mutt-send-email-mst__19379.4995816008$1546637255$gmane$org@kernel.org>
References: <20181229124656.3900-1-jasowang@redhat.com>
	<20181229124656.3900-2-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20181229124656.3900-2-jasowang@redhat.com>
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
Cc: netdev@vger.kernel.org, davem@davemloft.net, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Sat, Dec 29, 2018 at 08:46:52PM +0800, Jason Wang wrote:
> Use one generic vhost_copy_to_user() instead of two dedicated
> accessor. This will simplify the conversion to fine grain
> accessors. About 2% improvement of PPS were seen during vitio-user
> txonly test.
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>

I don't hve a problem with this patch but do you have
any idea how come removing what's supposed to be
an optimization speeds things up?

> ---
>  drivers/vhost/vhost.c | 11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 55e5aa662ad5..f179b5ee14c4 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -2174,16 +2174,7 @@ static int __vhost_add_used_n(struct vhost_virtqueue *vq,
>  
>  	start = vq->last_used_idx & (vq->num - 1);
>  	used = vq->used->ring + start;
> -	if (count == 1) {
> -		if (vhost_put_user(vq, heads[0].id, &used->id)) {
> -			vq_err(vq, "Failed to write used id");
> -			return -EFAULT;
> -		}
> -		if (vhost_put_user(vq, heads[0].len, &used->len)) {
> -			vq_err(vq, "Failed to write used len");
> -			return -EFAULT;
> -		}
> -	} else if (vhost_copy_to_user(vq, used, heads, count * sizeof *used)) {
> +	if (vhost_copy_to_user(vq, used, heads, count * sizeof *used)) {
>  		vq_err(vq, "Failed to write used");
>  		return -EFAULT;
>  	}
> -- 
> 2.17.1
