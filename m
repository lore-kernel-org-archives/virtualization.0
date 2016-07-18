From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH v2] virtio_blk: Fix a slient kernel panic
Date: Mon, 18 Jul 2016 17:21:28 +0200
Message-ID: <20160718172128.5b8c10b1.cornelia.huck@de.ibm.com>
References: <1468850489-40157-1-git-send-email-mnghuan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1468850489-40157-1-git-send-email-mnghuan@gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Minfei Huang <mnfhuang@gmail.com>
Cc: Minfei Huang <minfei.hmf@alibaba-inc.com>, fanc.fnst@cn.fujitsu.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, mst@redhat.com, Minfei Huang <mnghuan@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 18 Jul 2016 22:01:29 +0800
Minfei Huang <mnfhuang@gmail.com> wrote:

> We do a lot of memory allocation in function init_vq, and don't handle
> the allocation failure properly. Then this function will return 0,
> although initialization fails due to lacking memory. At that moment,
> kernel will panic in guest machine, if virtio is used to drive disk.
> 
> To fix this bug, we should take care of allocation failure, and return
> correct value to let caller know what happen.
> 
> Tested-by: Chao Fan <fanc.fnst@cn.fujitsu.com>
> Signed-off-by: Minfei Huang <minfei.hmf@alibaba-inc.com>
> Signed-off-by: Minfei Huang <mnghuan@gmail.com>
> ---
> v1:
> - Refactor the patch to make code more readable
> ---
>  drivers/block/virtio_blk.c | 32 +++++++++++---------------------
>  1 file changed, 11 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 42758b5..d920512 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -381,9 +381,9 @@ static int init_vq(struct virtio_blk *vblk)
>  {
>  	int err = 0;
>  	int i;
> -	vq_callback_t **callbacks;
> -	const char **names;
> -	struct virtqueue **vqs;
> +	vq_callback_t **callbacks = NULL;
> +	const char **names = NULL;
> +	struct virtqueue **vqs = NULL;

If you init the variables to NULL anyway...

>  	unsigned short num_vqs;
>  	struct virtio_device *vdev = vblk->vdev;
> 
> @@ -394,22 +394,16 @@ static int init_vq(struct virtio_blk *vblk)
>  		num_vqs = 1;
> 

...just do

err = -ENOMEM;

here and...

>  	vblk->vqs = kmalloc(sizeof(*vblk->vqs) * num_vqs, GFP_KERNEL);
> -	if (!vblk->vqs) {
> -		err = -ENOMEM;
> -		goto out;
> -	}
> +	if (!vblk->vqs)
> +		return -ENOMEM;
> 
>  	names = kmalloc(sizeof(*names) * num_vqs, GFP_KERNEL);
> -	if (!names)
> -		goto err_names;
> -
>  	callbacks = kmalloc(sizeof(*callbacks) * num_vqs, GFP_KERNEL);
> -	if (!callbacks)
> -		goto err_callbacks;
> -
>  	vqs = kmalloc(sizeof(*vqs) * num_vqs, GFP_KERNEL);
> -	if (!vqs)
> -		goto err_vqs;
> +	if (!names || !callbacks || !vqs) {
> +		err = -ENOMEM;
> +		goto out;
> +	}

...you could use the

foo = kmalloc(...);
if (!foo)
	goto out;

sequence in any case. This avoids trying again and again if e.g. the
names allocation already failed.

Alternatively, you should be fine if you don't init the variables to
NULL: The code is now either taking an early exit or setting all of the
variables anyway.
