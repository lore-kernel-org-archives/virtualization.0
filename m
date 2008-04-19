From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Subject: Re: [PATCH 2/5] /dev/vring: simple userspace-kernel ringbuffer
	interface.
Date: Sat, 19 Apr 2008 14:22:15 +0400
Message-ID: <20080419102214.GA21952__48116.8537437499$1208790433$gmane$org@2ka.mipt.ru>
References: <200804181433.48488.rusty@rustcorp.com.au>
	<200804181435.21214.rusty@rustcorp.com.au>
	<200804181439.49051.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200804181439.49051.rusty@rustcorp.com.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Max Krasnyansky <maxk@qualcomm.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Hi.

On Fri, Apr 18, 2008 at 02:39:48PM +1000, Rusty Russell (rusty@rustcorp.com.au) wrote:

> +int vring_get_buffer(struct vring_info *vr,
> +		     struct iovec *in_iov,
> +		     unsigned int *num_in, unsigned long *in_len,
> +		     struct iovec *out_iov,
> +		     unsigned int *num_out, unsigned long *out_len)
> +{
> +	unsigned int i, in = 0, out = 0;
> +	unsigned long dummy;
> +	u16 avail, last_avail, head;
> +	struct vring_desc d;

Should this whole function and vring_used_buffer() be protected with
vr->lock mutex?

> +	if (unlikely(get_user(avail, &vr->ring.avail->idx)))
> +		return -EFAULT;
> +	if (unlikely(get_user(last_avail, &vring_last_avail(&vr->ring))))
> +		return -EFAULT;
> +
> +	if (last_avail == avail)
> +		return 0;
> +
> +	if (!in_len)
> +		in_len = &dummy;
> +	if (!out_len)
> +		out_len = &dummy;
> +
> +	*in_len = *out_len = 0;
> +
> +	if (unlikely(get_user(head, &vr->ring.avail->ring[last_avail
> +							  & vr->mask])))
> +		return -EFAULT;
> +
> +	i = head;
> +	do {
> +		if (unlikely(i >= vr->ring.num)) {
> +			pr_debug("vring: bad index: %u\n", i);
> +			return -EINVAL;
> +		}
> +
> +		if (copy_from_user(&d, &vr->ring.desc[i], sizeof(d)) != 0)
> +			return -EFAULT;
> +
> +		if (d.flags & VRING_DESC_F_WRITE) {
> +			/* Check for length and iovec overflows */
> +			if (!num_in) {
> +				pr_debug("vring: writable desc %u in ring %p\n",
> +					 i, vr->ring.desc);
> +				return -EINVAL;
> +			}
> +			if (in == *num_in || *in_len + d.len < *in_len)
> +				return -E2BIG;
> +			in_iov[in].iov_len = d.len;
> +			*in_len += d.len;
> +			in_iov[in].iov_base = (void __user *)(long)d.addr;
> +			in++;
> +		} else {
> +			if (!num_out) {
> +				pr_debug("vring: readable desc %u in ring %p\n",
> +					 i, vr->ring.desc);
> +				return -EINVAL;
> +			}
> +			if (out == *num_out || *out_len + d.len < *out_len)
> +				return -E2BIG;
> +			out_iov[out].iov_len = d.len;
> +			*out_len += d.len;
> +			out_iov[out].iov_base = (void __user *)(long)d.addr;
> +			out++;
> +		}
> +
> +		i = d.next;
> +	} while (d.flags & VRING_DESC_F_NEXT);
> +
> +	if (num_in)
> +		*num_in = in;
> +	if (num_out)
> +		*num_out = out;
> +
> +	last_avail++;
> +	put_user(last_avail, &vring_last_avail(&vr->ring));
> +
> +	/* 0 is a valid head, so add one. */
> +	return head + 1;
> +}
> +EXPORT_SYMBOL_GPL(vring_get_buffer);
> +
> +/**
> + * vring_used_buffer - return a used buffer to the vring
> + * @vr: the vring
> + * @id: the id returned from vring_get_buffer
> + * @len: the total bytes *written* to the buffer
> + */
> +void vring_used_buffer(struct vring_info *vr, int id, u32 len)
> +{
> +	struct vring_used_elem used;
> +	u16 used_idx;
> +
> +	BUG_ON(id <= 0 || id > vr->ring.num);
> +
> +	used.id = id - 1;
> +	used.len = len;
> +	if (get_user(used_idx, &vr->ring.used->idx) != 0)
> +		return;
> +
> +	if (copy_to_user(&vr->ring.used->ring[used_idx & vr->mask], &used,
> +			 sizeof(used)))
> +		return;
> +
> +	wmb();
> +	used_idx++;
> +	put_user(used_idx, &vr->ring.used->idx);
> +}
> +EXPORT_SYMBOL_GPL(vring_used_buffer);

-- 
	Evgeniy Polyakov
