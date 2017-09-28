From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH net-next RFC 2/5] vhost: introduce helper to prefetch desc
	index
Date: Wed, 27 Sep 2017 20:47:25 -0400
Message-ID: <CAF=yD-JC9g1gd-jsSjnLzbwAnk-LsPuj_JhF2NWf1rdxiWDwwA__1098.20037982917$1506559700$gmane$org@mail.gmail.com>
References: <1506067355-5771-1-git-send-email-jasowang@redhat.com>
	<1506067355-5771-3-git-send-email-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1506067355-5771-3-git-send-email-jasowang@redhat.com>
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
Cc: Network Development <netdev@vger.kernel.org>, virtualization@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Sep 22, 2017 at 4:02 AM, Jason Wang <jasowang@redhat.com> wrote:
> This patch introduces vhost_prefetch_desc_indices() which could batch
> descriptor indices fetching and used ring updating. This intends to
> reduce the cache misses of indices fetching and updating and reduce
> cache line bounce when virtqueue is almost full. copy_to_user() was
> used in order to benefit from modern cpus that support fast string
> copy. Batched virtqueue processing will be the first user.
>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/vhost/vhost.c | 55 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/vhost/vhost.h |  3 +++
>  2 files changed, 58 insertions(+)
>
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index f87ec75..8424166d 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -2437,6 +2437,61 @@ struct vhost_msg_node *vhost_dequeue_msg(struct vhost_dev *dev,
>  }
>  EXPORT_SYMBOL_GPL(vhost_dequeue_msg);
>
> +int vhost_prefetch_desc_indices(struct vhost_virtqueue *vq,
> +                               struct vring_used_elem *heads,
> +                               u16 num, bool used_update)
> +{
> +       int ret, ret2;
> +       u16 last_avail_idx, last_used_idx, total, copied;
> +       __virtio16 avail_idx;
> +       struct vring_used_elem __user *used;
> +       int i;
> +
> +       if (unlikely(vhost_get_avail(vq, avail_idx, &vq->avail->idx))) {
> +               vq_err(vq, "Failed to access avail idx at %p\n",
> +                      &vq->avail->idx);
> +               return -EFAULT;
> +       }
> +       last_avail_idx = vq->last_avail_idx & (vq->num - 1);
> +       vq->avail_idx = vhost16_to_cpu(vq, avail_idx);
> +       total = vq->avail_idx - vq->last_avail_idx;
> +       ret = total = min(total, num);
> +
> +       for (i = 0; i < ret; i++) {
> +               ret2 = vhost_get_avail(vq, heads[i].id,
> +                                     &vq->avail->ring[last_avail_idx]);
> +               if (unlikely(ret2)) {
> +                       vq_err(vq, "Failed to get descriptors\n");
> +                       return -EFAULT;
> +               }
> +               last_avail_idx = (last_avail_idx + 1) & (vq->num - 1);
> +       }

This is understandably very similar to the existing logic in vhost_get_vq_desc.
Can that be extracted to a helper to avoid code duplication?

Perhaps one helper to update vq->avail_idx and return num, and
another to call vhost_get_avail one or more times.

> +
> +       if (!used_update)
> +               return ret;
> +
> +       last_used_idx = vq->last_used_idx & (vq->num - 1);
> +       while (total) {
> +               copied = min((u16)(vq->num - last_used_idx), total);
> +               ret2 = vhost_copy_to_user(vq,
> +                                         &vq->used->ring[last_used_idx],
> +                                         &heads[ret - total],
> +                                         copied * sizeof(*used));
> +
> +               if (unlikely(ret2)) {
> +                       vq_err(vq, "Failed to update used ring!\n");
> +                       return -EFAULT;
> +               }
> +
> +               last_used_idx = 0;
> +               total -= copied;
> +       }

This second part seems unrelated and could be a separate function?

Also, no need for ret2 and double assignment "ret = total =" if not
modifying total
in the the second loop:

  for (i = 0; i < total; ) {
    ...
    i += copied;
  }
