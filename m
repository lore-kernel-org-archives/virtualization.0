From: Minfei Huang <mnfhuang@gmail.com>
Subject: Re: [PATCH v2] virtio_blk: Fix a slient kernel panic
Date: Tue, 19 Jul 2016 08:37:15 +0800
Message-ID: <20160719003715.GA41853@MinfeideMacBook-Pro.local>
References: <1468850489-40157-1-git-send-email-mnghuan@gmail.com>
	<20160718172128.5b8c10b1.cornelia.huck@de.ibm.com>
	<20160718160421.GA20047@huangminfeis-MacBook-Pro.local>
	<20160718182534.7b0bdfe9.cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20160718182534.7b0bdfe9.cornelia.huck@de.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Minfei Huang <minfei.hmf@alibaba-inc.com>, fanc.fnst@cn.fujitsu.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, mst@redhat.com, Minfei Huang <mnfhuang@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

On 07/18/16 at 06:25P, Cornelia Huck wrote:
> On Tue, 19 Jul 2016 00:18:32 +0800
> Minfei Huang <mnfhuang@gmail.com> wrote:
> 
> > On 07/18/16 at 05:21P, Cornelia Huck wrote:
> > > On Mon, 18 Jul 2016 22:01:29 +0800
> > > Minfei Huang <mnfhuang@gmail.com> wrote:
> > > > diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> > > > index 42758b5..d920512 100644
> > > > --- a/drivers/block/virtio_blk.c
> > > > +++ b/drivers/block/virtio_blk.c
> > > > @@ -381,9 +381,9 @@ static int init_vq(struct virtio_blk *vblk)
> > > >  {
> > > >  	int err = 0;
> > > >  	int i;
> > > > -	vq_callback_t **callbacks;
> > > > -	const char **names;
> > > > -	struct virtqueue **vqs;
> > > > +	vq_callback_t **callbacks = NULL;
> > > > +	const char **names = NULL;
> > > > +	struct virtqueue **vqs = NULL;
> > > 
> > > If you init the variables to NULL anyway...
> > 
> > Hi, Cornelia.
> > 
> > Thanks for reviewing this patch.
> > 
> > Seems there is no need to init these variables to NULL. I will remove
> > them laster.
> 
> Fine with me.
> 
> > 
> > > 
> > > >  	unsigned short num_vqs;
> > > >  	struct virtio_device *vdev = vblk->vdev;
> > > > 
> > > > @@ -394,22 +394,16 @@ static int init_vq(struct virtio_blk *vblk)
> > > >  		num_vqs = 1;
> > > > 
> > > 
> > > ...just do
> > > 
> > > err = -ENOMEM;
> > > 
> > > here and...
> > > 
> > > >  	vblk->vqs = kmalloc(sizeof(*vblk->vqs) * num_vqs, GFP_KERNEL);
> > > > -	if (!vblk->vqs) {
> > > > -		err = -ENOMEM;
> > > > -		goto out;
> > > > -	}
> > > > +	if (!vblk->vqs)
> > > > +		return -ENOMEM;
> > > > 
> > > >  	names = kmalloc(sizeof(*names) * num_vqs, GFP_KERNEL);
> > > > -	if (!names)
> > > > -		goto err_names;
> > > > -
> > > >  	callbacks = kmalloc(sizeof(*callbacks) * num_vqs, GFP_KERNEL);
> > > > -	if (!callbacks)
> > > > -		goto err_callbacks;
> > > > -
> > > >  	vqs = kmalloc(sizeof(*vqs) * num_vqs, GFP_KERNEL);
> > > > -	if (!vqs)
> > > > -		goto err_vqs;
> > > > +	if (!names || !callbacks || !vqs) {
> > > > +		err = -ENOMEM;
> > > > +		goto out;
> > > > +	}
> > > 
> > > ...you could use the
> > > 
> > > foo = kmalloc(...);
> > > if (!foo)
> > > 	goto out;
> > > 
> > > sequence in any case. This avoids trying again and again if e.g. the
> > > names allocation already failed.
> > 
> > For this implementation, I have referred others which calls
> > vdev->config->find_vqs as well. Yes, this continues trying to allocate
> > memory, although memory allocation failed before.
> 
> It might not be the best idea, though; although it should hopefully be
> a not-so-common occurrence.

Yep, for that memont, there is enough memory to be allocated.

> 
> > 
> > > 
> > > Alternatively, you should be fine if you don't init the variables to
> > > NULL: The code is now either taking an early exit or setting all of the
> > > variables anyway.
> > > 
> > 
> > It's a big change if we refactor the helper ->find_vqs, since other
> > devices also call it.
> 
> Actually, I was referring to not initializing the variables to NULL in
> this function and keeping the rest of your changes: IOW, just what you
> suggested above :)

Ok. I will repost an update to fix it.

Thanks
Minfei

> 
