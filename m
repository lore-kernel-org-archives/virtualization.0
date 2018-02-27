From: Tiwei Bie <tiwei.bie@intel.com>
Subject: Re: [PATCH RFC 2/2] vhost: packed ring support
Date: Tue, 27 Feb 2018 17:03:20 +0800
Message-ID: <20180227090319.h7hxmxp5rpozrb5s__28626.5694805936$1519722206$gmane$org@debian>
References: <1518575829-1431-1-git-send-email-jasowang@redhat.com>
	<1518575829-1431-3-git-send-email-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1518575829-1431-3-git-send-email-jasowang@redhat.com>
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
Cc: mst@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, wexu@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Feb 14, 2018 at 10:37:09AM +0800, Jason Wang wrote:
[...]
> +static void set_desc_used(struct vhost_virtqueue *vq,
> +			  struct vring_desc_packed *desc, bool wrap_counter)
> +{
> +	__virtio16 flags = desc->flags;
> +
> +	if (wrap_counter) {
> +		desc->flags |= cpu_to_vhost16(vq, DESC_AVAIL);
> +		desc->flags |= cpu_to_vhost16(vq, DESC_USED);
> +	} else {
> +		desc->flags &= ~cpu_to_vhost16(vq, DESC_AVAIL);
> +		desc->flags &= ~cpu_to_vhost16(vq, DESC_USED);
> +	}
> +
> +	desc->flags = flags;

The `desc->flags` is restored after the change.

> +}
> +
> +static int vhost_get_vq_desc_packed(struct vhost_virtqueue *vq,
> +				    struct iovec iov[], unsigned int iov_size,
> +				    unsigned int *out_num, unsigned int *in_num,
> +				    struct vhost_log *log,
> +				    unsigned int *log_num)
> +{
> +	struct vring_desc_packed desc;
> +	int ret, access, i;
> +	u16 avail_idx = vq->last_avail_idx;
> +
> +	/* When we start there are none of either input nor output. */
> +	*out_num = *in_num = 0;
> +	if (unlikely(log))
> +		*log_num = 0;
> +
> +	do {
> +		unsigned int iov_count = *in_num + *out_num;
> +
> +		i = vq->last_avail_idx & (vq->num - 1);

The queue size may not be a power of 2 in packed ring.

Best regards,
Tiwei Bie
