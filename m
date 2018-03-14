From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] vhost: add vsock compat ioctl
Date: Wed, 14 Mar 2018 21:05:31 +0200
Message-ID: <20180314210417-mutt-send-email-mst__5074.48823559589$1521054221$gmane$org@kernel.org>
References: <20180314172605.130483-1-sonnyrao@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20180314172605.130483-1-sonnyrao@chromium.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Sonny Rao <sonnyrao@chromium.org>
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Stefan Hajnoczi <stefanha@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Mar 14, 2018 at 10:26:05AM -0700, Sonny Rao wrote:
> This will allow usage of vsock from 32-bit binaries on a 64-bit
> kernel.
> 
> Signed-off-by: Sonny Rao <sonnyrao@chromium.org>

I think you need to convert the pointer argument though.
Something along the lines of:

#ifdef CONFIG_COMPAT
static long vhost_vsock_dev_compat_ioctl(struct file *f, unsigned int ioctl,
					 unsigned long arg)
{
        return vhost_vsock_dev_ioctl(f, ioctl, (unsigned long)compat_ptr(arg));
} 
#endif  



> ---
>  drivers/vhost/vsock.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> index 0d14e2ff19f16..d0e65e92110e5 100644
> --- a/drivers/vhost/vsock.c
> +++ b/drivers/vhost/vsock.c
> @@ -705,6 +705,7 @@ static const struct file_operations vhost_vsock_fops = {
>  	.release        = vhost_vsock_dev_release,
>  	.llseek		= noop_llseek,
>  	.unlocked_ioctl = vhost_vsock_dev_ioctl,
> +	.compat_ioctl   = vhost_vsock_dev_ioctl,
>  };
>  
>  static struct miscdevice vhost_vsock_misc = {
> -- 
> 2.13.5
