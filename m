From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH V2 5/8] mdev: introduce device specific ops
Date: Thu, 26 Sep 2019 11:46:55 -0400
Message-ID: <20190926113958-mutt-send-email-mst@kernel.org>
References: <20190924135332.14160-1-jasowang@redhat.com>
	<20190924135332.14160-6-jasowang@redhat.com>
	<20190924170638.064d85f7@x1.home>
	<AADFC41AFE54684AB9EE6CBC0274A5D19D58F754@SHSMSX104.ccr.corp.intel.com>
	<CAJPjb1+i7jb0aVfr=7CDuUBpeo_w3wAfTrnmuLVJ-h+qOV+1hw@mail.gmail.com>
	<20190925103028.1f2edf03@x1.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190925103028.1f2edf03@x1.home>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Alex Williamson <alex.williamson@redhat.com>
Cc: "christophe.de.dinechin@gmail.com" <christophe.de.dinechin@gmail.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "airlied@linux.ie" <airlied@linux.ie>, "joonas.lahtinen@linux.intel.com" <joonas.lahtinen@linux.intel.com>, "heiko.carstens@de.ibm.com" <heiko.carstens@de.ibm.com>, "farman@linux.ibm.com" <farman@linux.ibm.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "kwankhede@nvidia.com" <kwankhede@nvidia.com>, Rob Miller <rob.miller@broadcom.com>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "sebott@linux.ibm.com" <sebott@linux.ibm.com>, "lulu@redhat.com" <lulu@redhat.com>, "eperezma@redhat.com" <eperezma@redhat.com>, "pasic@linux.ibm.com" <pasic@linux.ibm.com>, "borntraeger@de.ibm.com" <borntraeger@de.ibm.com>, haotian.wang@sifive.com
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Sep 25, 2019 at 10:30:28AM -0600, Alex Williamson wrote:
> On Wed, 25 Sep 2019 10:11:00 -0400
> Rob Miller <rob.miller@broadcom.com> wrote:
> > > > On Tue, 24 Sep 2019 21:53:29 +0800
> > > > Jason Wang <jasowang@redhat.com> wrote:
> > > > > diff --git a/drivers/vfio/mdev/vfio_mdev.c  
> > > > b/drivers/vfio/mdev/vfio_mdev.c  
> > > > > index 891cf83a2d9a..95efa054442f 100644
> > > > > --- a/drivers/vfio/mdev/vfio_mdev.c
> > > > > +++ b/drivers/vfio/mdev/vfio_mdev.c
> > > > > @@ -14,6 +14,7 @@
> > > > >  #include <linux/slab.h>
> > > > >  #include <linux/vfio.h>
> > > > >  #include <linux/mdev.h>
> > > > > +#include <linux/vfio_mdev.h>
> > > > >
> > > > >  #include "mdev_private.h"
> > > > >
> > > > > @@ -24,16 +25,16 @@
> > > > >  static int vfio_mdev_open(void *device_data)
> > > > >  {
> > > > >     struct mdev_device *mdev = device_data;
> > > > > -   struct mdev_parent *parent = mdev->parent;
> > > > > +   const struct vfio_mdev_device_ops *ops =  
> > > > mdev_get_dev_ops(mdev);  
> > > > >     int ret;
> > > > >
> > > > > -   if (unlikely(!parent->ops->open))
> > > > > +   if (unlikely(!ops->open))
> > > > >             return -EINVAL;
> > > > >
> > > > >     if (!try_module_get(THIS_MODULE))
> > > > >             return -ENODEV;  
> > >  
> > 
> > RJM>] My understanding lately is that this call to  
> > try_module_get(THIS_MODULE) is no longer needed as is considered as a
> > latent bug.
> > Quote from
> > https://stackoverflow.com/questions/1741415/linux-kernel-modules-when-to-use-try-module-get-module-put
> >  :
> > There are a number of uses of try_module_get(THIS_MODULE) in the kernel
> > source but most if not all of them are latent bugs that should be cleaned
> > up.
> 
> This use seems to fall exactly into the case where it is necessary, the
> open here is not a direct VFS call, it's an internal interface between
> modules.  The user is interacting with filesystem objects from the vfio
> module and the module reference we're trying to acquire here is to the
> vfio-mdev module.  Thanks,
> 
> Alex


I think the latent bug refers not to module get per se,
but to the module_put tied to it. E.g.:

 static void vfio_mdev_release(void *device_data)
 {
        struct mdev_device *mdev = device_data;
        struct mdev_parent *parent = mdev->parent;

        if (likely(parent->ops->release))
                parent->ops->release(mdev);

        module_put(THIS_MODULE);

Does anything prevent the module from unloading at this point?
if not then ...


 }

it looks like the implicit return (with instructions for argument pop
and functuon return) here can get overwritten on module
unload, causing a crash when executed.

IOW there's generally no way for module to keep a reference
to itself: it can take a reference but it needs someone else
to keep it and put.


-- 
MST
