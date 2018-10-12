From: Tiwei Bie <tiwei.bie@intel.com>
Subject: Re: [PATCH net-next V2 6/8] vhost: packed ring support
Date: Fri, 12 Oct 2018 22:32:44 +0800
Message-ID: <20181012143244.GA28400__32706.3073557385$1539354723$gmane$org@debian>
References: <1531711691-6769-1-git-send-email-jasowang@redhat.com>
	<1531711691-6769-7-git-send-email-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1531711691-6769-7-git-send-email-jasowang@redhat.com>
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
Cc: kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, maxime.coquelin@redhat.com, wexu@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Jul 16, 2018 at 11:28:09AM +0800, Jason Wang wrote:
[...]
> @@ -1367,10 +1397,48 @@ long vhost_vring_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *arg
>  		vq->last_avail_idx = s.num;
>  		/* Forget the cached index value. */
>  		vq->avail_idx = vq->last_avail_idx;
> +		if (vhost_has_feature(vq, VIRTIO_F_RING_PACKED)) {
> +			vq->last_avail_wrap_counter = wrap_counter;
> +			vq->avail_wrap_counter = vq->last_avail_wrap_counter;
> +		}
>  		break;
>  	case VHOST_GET_VRING_BASE:
>  		s.index = idx;
>  		s.num = vq->last_avail_idx;
> +		if (vhost_has_feature(vq, VIRTIO_F_RING_PACKED))
> +			s.num |= vq->last_avail_wrap_counter << 31;
> +		if (copy_to_user(argp, &s, sizeof(s)))
> +			r = -EFAULT;
> +		break;
> +	case VHOST_SET_VRING_USED_BASE:
> +		/* Moving base with an active backend?
> +		 * You don't want to do that.
> +		 */
> +		if (vq->private_data) {
> +			r = -EBUSY;
> +			break;
> +		}
> +		if (copy_from_user(&s, argp, sizeof(s))) {
> +			r = -EFAULT;
> +			break;
> +		}
> +		if (vhost_has_feature(vq, VIRTIO_F_RING_PACKED)) {
> +			wrap_counter = s.num >> 31;
> +			s.num &= ~(1 << 31);
> +		}
> +		if (s.num > 0xffff) {
> +			r = -EINVAL;
> +			break;
> +		}

Do we want to put wrap_counter at bit 15?

If put wrap_counter at bit 31, the check (s.num > 0xffff)
won't be able to catch the illegal index 0x8000~0xffff for
packed ring.

> +		vq->last_used_idx = s.num;
> +		if (vhost_has_feature(vq, VIRTIO_F_RING_PACKED))
> +			vq->last_used_wrap_counter = wrap_counter;
> +		break;
> +	case VHOST_GET_VRING_USED_BASE:

Do we need the new VHOST_GET_VRING_USED_BASE and
VHOST_SET_VRING_USED_BASE ops?

We are going to merge below series in DPDK:

http://patches.dpdk.org/patch/45874/

We may need to reach an agreement first.


> +		s.index = idx;
> +		s.num = vq->last_used_idx;
> +		if (vhost_has_feature(vq, VIRTIO_F_RING_PACKED))
> +			s.num |= vq->last_used_wrap_counter << 31;
>  		if (copy_to_user(argp, &s, sizeof s))
>  			r = -EFAULT;
>  		break;
[...]
