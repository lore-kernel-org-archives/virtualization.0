From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH net-next 1/3] vhost: generalize adding used elem
Date: Thu, 13 Dec 2018 14:41:08 -0500
Message-ID: <20181213144027-mutt-send-email-mst__36291.9954037808$1544729953$gmane$org@kernel.org>
References: <20181213101022.12475-1-jasowang@redhat.com>
	<20181213101022.12475-2-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20181213101022.12475-2-jasowang@redhat.com>
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

On Thu, Dec 13, 2018 at 06:10:20PM +0800, Jason Wang wrote:
> Use one generic vhost_copy_to_user() instead of two dedicated
> accessor. This will simplify the conversion to fine grain accessors.
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>


The reason we did it like this is because it was faster.
Want to try benchmarking before we change it?

> ---
>  drivers/vhost/vhost.c | 11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 3a5f81a66d34..1c54ec1b82f8 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -2164,16 +2164,7 @@ static int __vhost_add_used_n(struct vhost_virtqueue *vq,
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
