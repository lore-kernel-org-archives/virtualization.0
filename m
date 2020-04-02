From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] virtio/test: fix up after IOTLB changes
Date: Thu, 2 Apr 2020 08:53:58 -0400
Message-ID: <20200402084021-mutt-send-email-mst@kernel.org>
References: <20200401165100.276039-1-mst@redhat.com>
 <921fe999-e183-058d-722a-1a6a6ab066e0@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <921fe999-e183-058d-722a-1a6a6ab066e0@redhat.com>
Sender: netdev-owner@vger.kernel.org
To: Jason Wang <jasowang@redhat.com>
Cc: linux-kernel@vger.kernel.org, Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Apr 02, 2020 at 12:01:56PM +0800, Jason Wang wrote:
> 
> On 2020/4/2 上午12:51, Michael S. Tsirkin wrote:
> > Allow building vringh without IOTLB (that's the case for userspace
> > builds, will be useful for CAIF/VOD down the road too).
> > Update for API tweaks.
> > Don't include vringh with kernel builds.
> 
> 
> I'm not quite sure we need this.
> 
> E.g the userspace accessor is not used by CAIF/VOP.

Well any exported symbols are always compiled in, right?
So we can save some kernel memory by not building unused stuff ...


> > 
> > Cc: Jason Wang <jasowang@redhat.com>
> > Cc: Eugenio Pérez <eperezma@redhat.com>
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >   drivers/vhost/test.c   | 4 ++--
> >   drivers/vhost/vringh.c | 5 +++++
> >   include/linux/vringh.h | 2 ++
> >   tools/virtio/Makefile  | 3 ++-
> >   4 files changed, 11 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/vhost/test.c b/drivers/vhost/test.c
> > index 394e2e5c772d..9a3a09005e03 100644
> > --- a/drivers/vhost/test.c
> > +++ b/drivers/vhost/test.c
> > @@ -120,7 +120,7 @@ static int vhost_test_open(struct inode *inode, struct file *f)
> >   	vqs[VHOST_TEST_VQ] = &n->vqs[VHOST_TEST_VQ];
> >   	n->vqs[VHOST_TEST_VQ].handle_kick = handle_vq_kick;
> >   	vhost_dev_init(dev, vqs, VHOST_TEST_VQ_MAX, UIO_MAXIOV,
> > -		       VHOST_TEST_PKT_WEIGHT, VHOST_TEST_WEIGHT);
> > +		       VHOST_TEST_PKT_WEIGHT, VHOST_TEST_WEIGHT, NULL);
> >   	f->private_data = n;
> > @@ -225,7 +225,7 @@ static long vhost_test_reset_owner(struct vhost_test *n)
> >   {
> >   	void *priv = NULL;
> >   	long err;
> > -	struct vhost_umem *umem;
> > +	struct vhost_iotlb *umem;
> >   	mutex_lock(&n->dev.mutex);
> >   	err = vhost_dev_check_owner(&n->dev);
> > diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
> > index ee0491f579ac..878e565dfffe 100644
> > --- a/drivers/vhost/vringh.c
> > +++ b/drivers/vhost/vringh.c
> > @@ -13,9 +13,11 @@
> >   #include <linux/uaccess.h>
> >   #include <linux/slab.h>
> >   #include <linux/export.h>
> > +#ifdef VHOST_IOTLB
> 
> 
> Kbuild bot reports build issues with this.
> 
> It looks to me we should use #if IS_ENABLED(CONFIG_VHOST_IOTLB) here and
> following checks.
> 
> Thanks
> 

In fact IS_REACHEABLE is probably the right thing to do.


> 
> >   #include <linux/bvec.h>
> >   #include <linux/highmem.h>
> >   #include <linux/vhost_iotlb.h>
> > +#endif
> >   #include <uapi/linux/virtio_config.h>
> >   static __printf(1,2) __cold void vringh_bad(const char *fmt, ...)
> > @@ -1059,6 +1061,8 @@ int vringh_need_notify_kern(struct vringh *vrh)
> >   }
> >   EXPORT_SYMBOL(vringh_need_notify_kern);
> > +#ifdef VHOST_IOTLB
> > +
> >   static int iotlb_translate(const struct vringh *vrh,
> >   			   u64 addr, u64 len, struct bio_vec iov[],
> >   			   int iov_size, u32 perm)
> > @@ -1416,5 +1420,6 @@ int vringh_need_notify_iotlb(struct vringh *vrh)
> >   }
> >   EXPORT_SYMBOL(vringh_need_notify_iotlb);
> > +#endif
> >   MODULE_LICENSE("GPL");
> > diff --git a/include/linux/vringh.h b/include/linux/vringh.h
> > index bd0503ca6f8f..ebff121c0b02 100644
> > --- a/include/linux/vringh.h
> > +++ b/include/linux/vringh.h
> > @@ -14,8 +14,10 @@
> >   #include <linux/virtio_byteorder.h>
> >   #include <linux/uio.h>
> >   #include <linux/slab.h>
> > +#ifdef VHOST_IOTLB
> >   #include <linux/dma-direction.h>
> >   #include <linux/vhost_iotlb.h>
> > +#endif
> >   #include <asm/barrier.h>
> >   /* virtio_ring with information needed for host access. */
> > diff --git a/tools/virtio/Makefile b/tools/virtio/Makefile
> > index f33f32f1d208..d3f152f4660b 100644
> > --- a/tools/virtio/Makefile
> > +++ b/tools/virtio/Makefile
> > @@ -22,7 +22,8 @@ OOT_CONFIGS=\
> >   	CONFIG_VHOST=m \
> >   	CONFIG_VHOST_NET=n \
> >   	CONFIG_VHOST_SCSI=n \
> > -	CONFIG_VHOST_VSOCK=n
> > +	CONFIG_VHOST_VSOCK=n \
> > +	CONFIG_VHOST_RING=n
> >   OOT_BUILD=KCFLAGS="-I "${OOT_VHOST} ${MAKE} -C ${OOT_KSRC} V=${V}
> >   oot-build:
> >   	echo "UNSUPPORTED! Don't use the resulting modules in production!"
