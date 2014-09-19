From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH RFC 2/2] vhost: support urgent descriptors
Date: Fri, 19 Sep 2014 15:10:33 +0800
Message-ID: <541BD6E9.2010707@redhat.com>
References: <1404203661-7521-1-git-send-email-mst@redhat.com>
	<1404203661-7521-2-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1404203661-7521-2-git-send-email-mst@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 07/01/2014 06:49 PM, Michael S. Tsirkin wrote:
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  drivers/vhost/vhost.h | 19 +++++++++++++------
>  drivers/vhost/net.c   | 30 +++++++++++++++++++++---------
>  drivers/vhost/scsi.c  | 23 +++++++++++++++--------
>  drivers/vhost/test.c  |  5 +++--
>  drivers/vhost/vhost.c | 23 ++++++++++++++++-------
>  5 files changed, 68 insertions(+), 32 deletions(-)
>
> diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
> index 3eda654..61ca542 100644
> --- a/drivers/vhost/vhost.h
> +++ b/drivers/vhost/vhost.h
[...]
>  EXPORT_SYMBOL_GPL(vhost_add_used_n);
> @@ -1433,12 +1439,13 @@ static bool vhost_notify(struct vhost_dev *dev, struct vhost_virtqueue *vq)
>  	    unlikely(vq->avail_idx == vq->last_avail_idx))
>  		return true;
>  
> -	if (!vhost_has_feature(vq, VIRTIO_RING_F_EVENT_IDX)) {
> +	if (vq->urgent || !vhost_has_feature(vq, VIRTIO_RING_F_EVENT_IDX)) {

So the urgent descriptor only work when event index was not enabled?
This seems suboptimal, we may still want to benefit from event index
even if urgent descriptor is used. Looks like we need return true here
when vq->urgent is true?

Another question is whether or not we need to do this a new flag.
Technically we can do it purely in guest side through event index, this
can help to eliminate both the changes in host and a new feature bit.
>  		__u16 flags;
>  		if (__get_user(flags, &vq->avail->flags)) {
>  			vq_err(vq, "Failed to get flags");
>  			return true;
>  		}
> +		vq->urgent = false;
>  		return !(flags & VRING_AVAIL_F_NO_INTERRUPT);
>  	}
>  	old = vq->signalled_used;
> @@ -1468,9 +1475,10 @@ EXPORT_SYMBOL_GPL(vhost_signal);
>  /* And here's the combo meal deal.  Supersize me! */
>  void vhost_add_used_and_signal(struct vhost_dev *dev,
>  			       struct vhost_virtqueue *vq,
> +			       bool urgent,
>  			       unsigned int head, int len)
>  {
> -	vhost_add_used(vq, head, len);
> +	vhost_add_used(vq, urgent, head, len);
>  	vhost_signal(dev, vq);
>  }
>  EXPORT_SYMBOL_GPL(vhost_add_used_and_signal);
> @@ -1478,9 +1486,10 @@ EXPORT_SYMBOL_GPL(vhost_add_used_and_signal);
>  /* multi-buffer version of vhost_add_used_and_signal */
>  void vhost_add_used_and_signal_n(struct vhost_dev *dev,
>  				 struct vhost_virtqueue *vq,
> +				 bool urgent,
>  				 struct vring_used_elem *heads, unsigned count)
>  {
> -	vhost_add_used_n(vq, heads, count);
> +	vhost_add_used_n(vq, urgent, heads, count);
>  	vhost_signal(dev, vq);
>  }
>  EXPORT_SYMBOL_GPL(vhost_add_used_and_signal_n);
