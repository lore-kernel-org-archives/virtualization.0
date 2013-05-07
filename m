From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] vhost-test: Make vhost/test.c work
Date: Tue, 7 May 2013 14:22:32 +0300
Message-ID: <20130507112232.GB19121@redhat.com>
References: <1367909565-11607-1-git-send-email-asias@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1367909565-11607-1-git-send-email-asias@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Asias He <asias@redhat.com>
Cc: target-devel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, May 07, 2013 at 02:52:45PM +0800, Asias He wrote:
> Fix it by:
> 1) switching to use the new device specific fields per vq
> 2) not including vhost.c, instead make vhost-test.ko depend on vhost.ko.

Please split this up.
1. make test work for 3.10
2. make test work for 3.11

thanks!

> ---
>  drivers/vhost/test.c | 37 +++++++++++++++++++++++++------------
>  1 file changed, 25 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/vhost/test.c b/drivers/vhost/test.c
> index 1ee45bc..dc526eb 100644
> --- a/drivers/vhost/test.c
> +++ b/drivers/vhost/test.c
> @@ -18,7 +18,7 @@
>  #include <linux/slab.h>
>  
>  #include "test.h"
> -#include "vhost.c"
> +#include "vhost.h"
>  
>  /* Max number of bytes transferred before requeueing the job.
>   * Using this limit prevents one virtqueue from starving others. */
> @@ -29,16 +29,20 @@ enum {
>  	VHOST_TEST_VQ_MAX = 1,
>  };
>  
> +struct vhost_test_virtqueue {
> +	struct vhost_virtqueue vq;
> +};
> +

This isn't needed or useful. Drop above change pls and patch
size will shrink.

>  struct vhost_test {
>  	struct vhost_dev dev;
> -	struct vhost_virtqueue vqs[VHOST_TEST_VQ_MAX];
> +	struct vhost_test_virtqueue vqs[VHOST_TEST_VQ_MAX];
>  };
>  
>  /* Expects to be always run from workqueue - which acts as
>   * read-size critical section for our kind of RCU. */
>  static void handle_vq(struct vhost_test *n)
>  {
> -	struct vhost_virtqueue *vq = &n->dev.vqs[VHOST_TEST_VQ];
> +	struct vhost_virtqueue *vq = n->dev.vqs[VHOST_TEST_VQ];
>  	unsigned out, in;
>  	int head;
>  	size_t len, total_len = 0;
> @@ -101,15 +105,23 @@ static void handle_vq_kick(struct vhost_work *work)
>  static int vhost_test_open(struct inode *inode, struct file *f)
>  {
>  	struct vhost_test *n = kmalloc(sizeof *n, GFP_KERNEL);
> +	struct vhost_virtqueue **vqs;
>  	struct vhost_dev *dev;
>  	int r;
>  
>  	if (!n)
>  		return -ENOMEM;
>  
> +	vqs = kmalloc(VHOST_TEST_VQ_MAX * sizeof(*vqs), GFP_KERNEL);
> +	if (!vqs) {
> +		kfree(n);
> +		return -ENOMEM;
> +	}
> +
>  	dev = &n->dev;
> -	n->vqs[VHOST_TEST_VQ].handle_kick = handle_vq_kick;
> -	r = vhost_dev_init(dev, n->vqs, VHOST_TEST_VQ_MAX);
> +	vqs[VHOST_TEST_VQ] = &n->vqs[VHOST_TEST_VQ].vq;
> +	n->vqs[VHOST_TEST_VQ].vq.handle_kick = handle_vq_kick;
> +	r = vhost_dev_init(dev, vqs, VHOST_TEST_VQ_MAX);
>  	if (r < 0) {
>  		kfree(n);
>  		return r;
> @@ -135,12 +147,12 @@ static void *vhost_test_stop_vq(struct vhost_test *n,
>  
>  static void vhost_test_stop(struct vhost_test *n, void **privatep)
>  {
> -	*privatep = vhost_test_stop_vq(n, n->vqs + VHOST_TEST_VQ);
> +	*privatep = vhost_test_stop_vq(n, &n->vqs[VHOST_TEST_VQ].vq);
>  }
>  
>  static void vhost_test_flush_vq(struct vhost_test *n, int index)
>  {
> -	vhost_poll_flush(&n->dev.vqs[index].poll);
> +	vhost_poll_flush(&n->vqs[index].vq.poll);
>  }
>  
>  static void vhost_test_flush(struct vhost_test *n)
> @@ -159,6 +171,7 @@ static int vhost_test_release(struct inode *inode, struct file *f)
>  	/* We do an extra flush before freeing memory,
>  	 * since jobs can re-queue themselves. */
>  	vhost_test_flush(n);
> +	kfree(n->dev.vqs);
>  	kfree(n);
>  	return 0;
>  }
> @@ -179,14 +192,14 @@ static long vhost_test_run(struct vhost_test *n, int test)
>  
>  	for (index = 0; index < n->dev.nvqs; ++index) {
>  		/* Verify that ring has been setup correctly. */
> -		if (!vhost_vq_access_ok(&n->vqs[index])) {
> +		if (!vhost_vq_access_ok(&n->vqs[index].vq)) {
>  			r = -EFAULT;
>  			goto err;
>  		}
>  	}
>  
>  	for (index = 0; index < n->dev.nvqs; ++index) {
> -		vq = n->vqs + index;
> +		vq = &n->vqs[index].vq;
>  		mutex_lock(&vq->mutex);
>  		priv = test ? n : NULL;
>  
> @@ -195,7 +208,7 @@ static long vhost_test_run(struct vhost_test *n, int test)
>  						    lockdep_is_held(&vq->mutex));
>  		rcu_assign_pointer(vq->private_data, priv);
>  
> -		r = vhost_init_used(&n->vqs[index]);
> +		r = vhost_init_used(&n->vqs[index].vq);
>  
>  		mutex_unlock(&vq->mutex);
>  
> @@ -268,14 +281,14 @@ static long vhost_test_ioctl(struct file *f, unsigned int ioctl,
>  			return -EFAULT;
>  		return vhost_test_run(n, test);
>  	case VHOST_GET_FEATURES:
> -		features = VHOST_NET_FEATURES;
> +		features = VHOST_FEATURES;
>  		if (copy_to_user(featurep, &features, sizeof features))
>  			return -EFAULT;
>  		return 0;
>  	case VHOST_SET_FEATURES:
>  		if (copy_from_user(&features, featurep, sizeof features))
>  			return -EFAULT;
> -		if (features & ~VHOST_NET_FEATURES)
> +		if (features & ~VHOST_FEATURES)
>  			return -EOPNOTSUPP;
>  		return vhost_test_set_features(n, features);
>  	case VHOST_RESET_OWNER:
> -- 
> 1.8.1.4
