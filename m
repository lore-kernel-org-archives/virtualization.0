From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH net] vhost: correctly check the return value of
	translate_desc() in log_used()
Date: Fri, 15 Feb 2019 16:59:56 -0500
Message-ID: <20190215165929-mutt-send-email-mst__5828.51905362389$1550268012$gmane$org@kernel.org>
References: <20190215075324.18891-1-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190215075324.18891-1-jasowang@redhat.com>
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

On Fri, Feb 15, 2019 at 03:53:24PM +0800, Jason Wang wrote:
> When fail, translate_desc() returns negative value, otherwise the
> number of iovs. So we should fail when the return value is negative
> instead of a blindly check against zero.
> 
> Reported-by: Stephen Hemminger <stephen@networkplumber.org>
> Fixes: cc5e71075947 ("vhost: log dirty page correctly")
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

and I guess the log was backported to stable so we want
this backported too.

> ---
>  drivers/vhost/vhost.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 24a129fcdd61..a2e5dc7716e2 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -1788,7 +1788,7 @@ static int log_used(struct vhost_virtqueue *vq, u64 used_offset, u64 len)
>  
>  	ret = translate_desc(vq, (uintptr_t)vq->used + used_offset,
>  			     len, iov, 64, VHOST_ACCESS_WO);
> -	if (ret)
> +	if (ret < 0)
>  		return ret;
>  
>  	for (i = 0; i < ret; i++) {
> -- 
> 2.17.1
