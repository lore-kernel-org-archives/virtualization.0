From: Eugenio Perez Martin <eperezma@redhat.com>
Subject: Re: [PATCH RFC v8 03/11] vhost/net: pass net specific struct pointer
Date: Mon, 15 Jun 2020 18:08:27 +0200
Message-ID: <CAJaqyWfytTY7OvBdQNNPVDccvxbX4j-wmgUobU+OEYsOi77Mig@mail.gmail.com>
References: <20200611113404.17810-1-mst@redhat.com> <20200611113404.17810-4-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20200611113404.17810-4-mst@redhat.com>
Sender: kvm-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm list <kvm@vger.kernel.org>, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Jun 11, 2020 at 1:34 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> In preparation for further cleanup, pass net specific pointer
> to ubuf callbacks so we can move net specific fields
> out to net structures.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  drivers/vhost/net.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index bf5e1d81ae25..ff594eec8ae3 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -94,7 +94,7 @@ struct vhost_net_ubuf_ref {
>          */
>         atomic_t refcount;
>         wait_queue_head_t wait;
> -       struct vhost_virtqueue *vq;
> +       struct vhost_net_virtqueue *nvq;
>  };
>
>  #define VHOST_NET_BATCH 64
> @@ -231,7 +231,7 @@ static void vhost_net_enable_zcopy(int vq)
>  }
>
>  static struct vhost_net_ubuf_ref *
> -vhost_net_ubuf_alloc(struct vhost_virtqueue *vq, bool zcopy)
> +vhost_net_ubuf_alloc(struct vhost_net_virtqueue *nvq, bool zcopy)
>  {
>         struct vhost_net_ubuf_ref *ubufs;
>         /* No zero copy backend? Nothing to count. */
> @@ -242,7 +242,7 @@ vhost_net_ubuf_alloc(struct vhost_virtqueue *vq, bool zcopy)
>                 return ERR_PTR(-ENOMEM);
>         atomic_set(&ubufs->refcount, 1);
>         init_waitqueue_head(&ubufs->wait);
> -       ubufs->vq = vq;
> +       ubufs->nvq = nvq;
>         return ubufs;
>  }
>
> @@ -384,13 +384,13 @@ static void vhost_zerocopy_signal_used(struct vhost_net *net,
>  static void vhost_zerocopy_callback(struct ubuf_info *ubuf, bool success)
>  {
>         struct vhost_net_ubuf_ref *ubufs = ubuf->ctx;
> -       struct vhost_virtqueue *vq = ubufs->vq;
> +       struct vhost_net_virtqueue *nvq = ubufs->nvq;
>         int cnt;
>
>         rcu_read_lock_bh();
>
>         /* set len to mark this desc buffers done DMA */
> -       vq->heads[ubuf->desc].len = success ?
> +       nvq->vq.heads[ubuf->desc].in_len = success ?

This change should access .len, not .in_len, until patch 6 (net:
convert to new API) in this series. Not very important, but make
easier to debug these intermediate commits.

Thanks!

>                 VHOST_DMA_DONE_LEN : VHOST_DMA_FAILED_LEN;
>         cnt = vhost_net_ubuf_put(ubufs);
>
> @@ -402,7 +402,7 @@ static void vhost_zerocopy_callback(struct ubuf_info *ubuf, bool success)
>          * less than 10% of times).
>          */
>         if (cnt <= 1 || !(cnt % 16))
> -               vhost_poll_queue(&vq->poll);
> +               vhost_poll_queue(&nvq->vq.poll);
>
>         rcu_read_unlock_bh();
>  }
> @@ -1525,7 +1525,7 @@ static long vhost_net_set_backend(struct vhost_net *n, unsigned index, int fd)
>         /* start polling new socket */
>         oldsock = vhost_vq_get_backend(vq);
>         if (sock != oldsock) {
> -               ubufs = vhost_net_ubuf_alloc(vq,
> +               ubufs = vhost_net_ubuf_alloc(nvq,
>                                              sock && vhost_sock_zcopy(sock));
>                 if (IS_ERR(ubufs)) {
>                         r = PTR_ERR(ubufs);
> --
> MST
>
