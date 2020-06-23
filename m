From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC v9 02/11] vhost: use batched get_vq_desc version
Date: Tue, 23 Jun 2020 10:42:06 -0400
Message-ID: <20200623103746-mutt-send-email-mst@kernel.org>
References: <20200619182302.850-1-eperezma@redhat.com>
 <20200619182302.850-3-eperezma@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200619182302.850-3-eperezma@redhat.com>
Sender: netdev-owner@vger.kernel.org
To: Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Cc: kvm list <kvm@vger.kernel.org>, Stefano Garzarella <sgarzare@redhat.com>, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>, Jason Wang <jasowang@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Jun 19, 2020 at 08:22:53PM +0200, Eugenio Pérez wrote:
> From: "Michael S. Tsirkin" <mst@redhat.com>
> 
> As testing shows no performance change, switch to that now.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
> Link: https://lore.kernel.org/r/20200401183118.8334-3-eperezma@redhat.com
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
> ---
>  drivers/vhost/test.c  |   2 +-
>  drivers/vhost/vhost.c | 314 ++++++++----------------------------------
>  drivers/vhost/vhost.h |   7 +-
>  3 files changed, 61 insertions(+), 262 deletions(-)
> 
> diff --git a/drivers/vhost/test.c b/drivers/vhost/test.c
> index a09dedc79f68..650e69261557 100644
> --- a/drivers/vhost/test.c
> +++ b/drivers/vhost/test.c
> @@ -119,7 +119,7 @@ static int vhost_test_open(struct inode *inode, struct file *f)
>  	dev = &n->dev;
>  	vqs[VHOST_TEST_VQ] = &n->vqs[VHOST_TEST_VQ];
>  	n->vqs[VHOST_TEST_VQ].handle_kick = handle_vq_kick;
> -	vhost_dev_init(dev, vqs, VHOST_TEST_VQ_MAX, UIO_MAXIOV,
> +	vhost_dev_init(dev, vqs, VHOST_TEST_VQ_MAX, UIO_MAXIOV + 64,
>  		       VHOST_TEST_PKT_WEIGHT, VHOST_TEST_WEIGHT, true, NULL);
>  
>  	f->private_data = n;
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 2d784681b0fa..13021d6986eb 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -304,6 +304,7 @@ static void vhost_vq_reset(struct vhost_dev *dev,
>  {
>  	vq->num = 1;
>  	vq->ndescs = 0;
> +	vq->first_desc = 0;
>  	vq->desc = NULL;
>  	vq->avail = NULL;
>  	vq->used = NULL;
> @@ -372,6 +373,11 @@ static int vhost_worker(void *data)
>  	return 0;
>  }
>  
> +static int vhost_vq_num_batch_descs(struct vhost_virtqueue *vq)
> +{
> +	return vq->max_descs - UIO_MAXIOV;
> +}
> +
>  static void vhost_vq_free_iovecs(struct vhost_virtqueue *vq)
>  {
>  	kfree(vq->descs);


Batching is enabled if max_descs > UIO_MAXIOV.

So this uses batching for test.

But net is unchanged, so it is still not using the batched version.
Is that right?

I think a better subject would be "vhost/test: use batched get_vq_desc version".

And that explains which testing it refers to: the one executed by vhost test.

I think there was a separate patch to enable that for net separately,
but it got lost - or did I miss it?

-- 
MST
