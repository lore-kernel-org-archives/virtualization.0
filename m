From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH 2/4] virtio_blk: Less function calls in init_vq() after
	error detection
Date: Tue, 13 Sep 2016 14:54:58 +0200
Message-ID: <e918e655-cd86-c3c8-d911-9dfc03b03e19__20406.6284386956$1473771322$gmane$org@de.ibm.com>
References: <566ABCD9.1060404@users.sourceforge.net>
	<02054675-8395-ac81-6863-e3a5cbfc9032@users.sourceforge.net>
	<f56845a8-03c6-d3f7-6091-99dba9835780@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <f56845a8-03c6-d3f7-6091-99dba9835780@users.sourceforge.net>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: SF Markus Elfring <elfring@users.sourceforge.net>, virtualization@lists.linux-foundation.org, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Julia Lawall <julia.lawall@lip6.fr>, kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On 09/13/2016 02:13 PM, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Tue, 13 Sep 2016 13:20:44 +0200
> 
> The kfree() function was called in up to three cases
> by the init_vq() function during error handling even if
> the passed variable contained a null pointer.
> 
> * Split a condition check for memory allocation failures.
> 
> * Adjust jump targets according to the Linux coding style convention.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/block/virtio_blk.c | 22 +++++++++++++++++-----
>  1 file changed, 17 insertions(+), 5 deletions(-)

Can't you see from this diffstat that the patch actually seems to makes
the code more complex?
In addition, please have a look at commit 347a529398e8e723338cca5d8a8ae2d9e7e93448
    virtio_blk: Fix a slient kernel panic

which did the opposite of your patch. And in fact it fixed a bug. Quite obviously
multiple labels are harder to read and harder to get right. For error handling with
just kfree one label is just the right thing to.

> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 6553eb7..d28dbcf 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -395,11 +395,21 @@ static int init_vq(struct virtio_blk *vblk)
>  		return -ENOMEM;
> 
>  	names = kmalloc_array(num_vqs, sizeof(*names), GFP_KERNEL);
> +	if (!names) {
> +		err = -ENOMEM;
> +		goto free_vblk_vqs;
> +	}
> +
>  	callbacks = kmalloc_array(num_vqs, sizeof(*callbacks), GFP_KERNEL);
> +	if (!callbacks) {
> +		err = -ENOMEM;
> +		goto free_names;
> +	}
> +
>  	vqs = kmalloc_array(num_vqs, sizeof(*vqs), GFP_KERNEL);
> -	if (!names || !callbacks || !vqs) {
> +	if (!vqs) {
>  		err = -ENOMEM;
> -		goto out;
> +		goto free_callbacks;
>  	}
> 
>  	for (i = 0; i < num_vqs; i++) {
> @@ -411,19 +421,21 @@ static int init_vq(struct virtio_blk *vblk)
>  	/* Discover virtqueues and write information to configuration.  */
>  	err = vdev->config->find_vqs(vdev, num_vqs, vqs, callbacks, names);
>  	if (err)
> -		goto out;
> +		goto free_vqs;
> 
>  	for (i = 0; i < num_vqs; i++) {
>  		spin_lock_init(&vblk->vqs[i].lock);
>  		vblk->vqs[i].vq = vqs[i];
>  	}
>  	vblk->num_vqs = num_vqs;
> -
> -out:
> + free_vqs:
>  	kfree(vqs);
> + free_callbacks:
>  	kfree(callbacks);
> + free_names:
>  	kfree(names);
>  	if (err)
> + free_vblk_vqs:
>  		kfree(vblk->vqs);
>  	return err;
>  }
> 
