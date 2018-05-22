From: Wei Xu <wexu@redhat.com>
Subject: Re: [RFC V4 PATCH 7/8] vhost: packed ring support
Date: Wed, 23 May 2018 00:54:48 +0800
Message-ID: <20180522165448.GA13523__9892.8997329951$1527007997$gmane$org@wei-ubt>
References: <1526473941-16199-1-git-send-email-jasowang@redhat.com>
	<1526473941-16199-8-git-send-email-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1526473941-16199-8-git-send-email-jasowang@redhat.com>
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
Cc: kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, May 16, 2018 at 08:32:20PM +0800, Jason Wang wrote:
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/vhost/net.c   |   3 +-
>  drivers/vhost/vhost.c | 539 ++++++++++++++++++++++++++++++++++++++++++++++----
>  drivers/vhost/vhost.h |   8 +-
>  3 files changed, 513 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 8304c30..f2a0f5b 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -1358,6 +1382,8 @@ long vhost_vring_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *arg
>  			break;
>  		}
>  		vq->last_avail_idx = s.num;
> +		if (vhost_has_feature(vq, VIRTIO_F_RING_PACKED))
> +			vq->avail_wrap_counter = s.num >> 31;
>  		/* Forget the cached index value. */
>  		vq->avail_idx = vq->last_avail_idx;
>  		break;
> @@ -1366,6 +1392,8 @@ long vhost_vring_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *arg
>  		s.num = vq->last_avail_idx;
>  		if (copy_to_user(argp, &s, sizeof s))
>  			r = -EFAULT;
> +		if (vhost_has_feature(vq, VIRTIO_F_RING_PACKED))
> +			s.num |= vq->avail_wrap_counter << 31;
>  		break;
>  	case VHOST_SET_VRING_ADDR:
>  		if (copy_from_user(&a, argp, sizeof a)) {

'last_used_idx' also needs to be saved/restored here.

I have figured out the root cause of broken device after reloading
'virtio-net' module, all indices have been reset for a reloading but
'last_used_idx' is not properly reset in this case. This confuses
handle_rx()/tx().

Wei
