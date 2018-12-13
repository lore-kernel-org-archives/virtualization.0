From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] vhost: return EINVAL if iovecs size does not match the
	message size
Date: Thu, 13 Dec 2018 14:55:17 -0500
Message-ID: <20181213143426-mutt-send-email-mst__12586.1729532064$1544730811$gmane$org@kernel.org>
References: <20181213145350.5454-1-ptikhomirov@virtuozzo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20181213145350.5454-1-ptikhomirov@virtuozzo.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Konstantin Khorenko <khorenko@virtuozzo.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Dec 13, 2018 at 05:53:50PM +0300, Pavel Tikhomirov wrote:
> We've failed to copy and process vhost_iotlb_msg so let userspace at
> least know about it. For instance before these patch the code below runs
> without any error:
> 
> int main()
> {
>   struct vhost_msg msg;
>   struct iovec iov;
>   int fd;
> 
>   fd = open("/dev/vhost-net", O_RDWR);
>   if (fd == -1) {
>     perror("open");
>     return 1;
>   }
> 
>   iov.iov_base = &msg;
>   iov.iov_len = sizeof(msg)-4;
> 
>   if (writev(fd, &iov,1) == -1) {
>     perror("writev");
>     return 1;
>   }
> 
>   return 0;
> }
> 
> Signed-off-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>

Thanks for the patch!

> ---
>  drivers/vhost/vhost.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 3a5f81a66d34..03014224ef13 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -1024,8 +1024,10 @@ ssize_t vhost_chr_write_iter(struct vhost_dev *dev,
>  	int type, ret;
>  
>  	ret = copy_from_iter(&type, sizeof(type), from);
> -	if (ret != sizeof(type))
> +	if (ret != sizeof(type)) {
> +		ret = -EINVAL;
>  		goto done;
> +	}
>  
>  	switch (type) {
>  	case VHOST_IOTLB_MSG:

should this be EFAULT rather?

> @@ -1044,8 +1046,10 @@ ssize_t vhost_chr_write_iter(struct vhost_dev *dev,
>  
>  	iov_iter_advance(from, offset);
>  	ret = copy_from_iter(&msg, sizeof(msg), from);
> -	if (ret != sizeof(msg))
> +	if (ret != sizeof(msg)) {
> +		ret = -EINVAL;
>  		goto done;
> +	}
>  	if (vhost_process_iotlb_msg(dev, &msg)) {
>  		ret = -EFAULT;
>  		goto done;

This too?

> -- 
> 2.17.1
