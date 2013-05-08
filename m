From: Asias He <asias@redhat.com>
Subject: Re: [PATCH v2] vhost-test: Make vhost/test.c work
Date: Wed, 8 May 2013 16:17:19 +0800
Message-ID: <20130508081719.GB18706@hj.localdomain>
References: <1367997873-16933-1-git-send-email-asias@redhat.com>
	<20130508075619.GA4858@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20130508075619.GA4858@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: target-devel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, May 08, 2013 at 10:56:19AM +0300, Michael S. Tsirkin wrote:
> On Wed, May 08, 2013 at 03:24:33PM +0800, Asias He wrote:
> > Fix it by switching to use the new device specific fields per vq
> > 
> > Signed-off-by: Asias He <asias@redhat.com>
> > ---
> > 
> > This is for 3.10.
> > 
> >  drivers/vhost/test.c | 35 ++++++++++++++++++++++++-----------
> >  1 file changed, 24 insertions(+), 11 deletions(-)
> > 
> > diff --git a/drivers/vhost/test.c b/drivers/vhost/test.c
> > index 1ee45bc..7b49d10 100644
> > --- a/drivers/vhost/test.c
> > +++ b/drivers/vhost/test.c
> > @@ -29,16 +29,20 @@ enum {
> >  	VHOST_TEST_VQ_MAX = 1,
> >  };
> >  
> > +struct vhost_test_virtqueue {
> > +	struct vhost_virtqueue vq;
> > +};
> > +
> 
> Well there are no test specific fields here,
> so this structure is not needed. Here's what I queued:

Could you push the queue to your git repo ?

> --->
> 
> vhost-test: fix up test module after API change
> 
> Recent vhost API changes broke vhost test module.
> Update it to the new APIs.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> 
> ---
> 
> diff --git a/drivers/vhost/test.c b/drivers/vhost/test.c
> index be65414..c2c3d91 100644
> --- a/drivers/vhost/test.c
> +++ b/drivers/vhost/test.c
> @@ -38,7 +38,7 @@ struct vhost_test {
>   * read-size critical section for our kind of RCU. */
>  static void handle_vq(struct vhost_test *n)
>  {
> -	struct vhost_virtqueue *vq = &n->dev.vqs[VHOST_TEST_VQ];
> +	struct vhost_virtqueue *vq = &n->vqs[VHOST_TEST_VQ];
>  	unsigned out, in;
>  	int head;
>  	size_t len, total_len = 0;
> @@ -102,6 +102,7 @@ static int vhost_test_open(struct inode *inode, struct file *f)
>  {
>  	struct vhost_test *n = kmalloc(sizeof *n, GFP_KERNEL);
>  	struct vhost_dev *dev;
> +	struct vhost_virtqueue *vqs[VHOST_TEST_VQ_MAX];
>  	int r;
>  
>  	if (!n)
> @@ -109,7 +110,8 @@ static int vhost_test_open(struct inode *inode, struct file *f)
>  
>  	dev = &n->dev;
>  	n->vqs[VHOST_TEST_VQ].handle_kick = handle_vq_kick;
> -	r = vhost_dev_init(dev, n->vqs, VHOST_TEST_VQ_MAX);
> +	vqs[VHOST_TEST_VQ] = &n->vqs[VHOST_TEST_VQ];
> +	r = vhost_dev_init(dev, vqs, VHOST_TEST_VQ_MAX);
>  	if (r < 0) {
>  		kfree(n);
>  		return r;
> @@ -140,7 +142,7 @@ static void vhost_test_stop(struct vhost_test *n, void **privatep)
>  
>  static void vhost_test_flush_vq(struct vhost_test *n, int index)
>  {
> -	vhost_poll_flush(&n->dev.vqs[index].poll);
> +	vhost_poll_flush(&n->vqs[index].poll);
>  }
>  
>  static void vhost_test_flush(struct vhost_test *n)
> @@ -268,21 +270,21 @@ static long vhost_test_ioctl(struct file *f, unsigned int ioctl,
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
>  		return vhost_test_reset_owner(n);
>  	default:
>  		mutex_lock(&n->dev.mutex);
> -		r = vhost_dev_ioctl(&n->dev, ioctl, arg);
> +		r = vhost_dev_ioctl(&n->dev, ioctl, argp);
>  		vhost_test_flush(n);
>  		mutex_unlock(&n->dev.mutex);
>  		return r;

-- 
Asias
