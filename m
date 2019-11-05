From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH V8 3/6] mdev: introduce device specific ops
Date: Tue, 5 Nov 2019 17:50:25 +0100
Message-ID: <20191105175025.1a620844.cohuck__19267.8557172016$1572972676$gmane$org@redhat.com>
References: <20191105093240.5135-1-jasowang@redhat.com>
	<20191105093240.5135-4-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20191105093240.5135-4-jasowang@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jason Wang <jasowang@redhat.com>
Cc: stefanha@redhat.com, christophe.de.dinechin@gmail.com, kvm@vger.kernel.org, mst@redhat.com, airlied@linux.ie, joonas.lahtinen@linux.intel.com, heiko.carstens@de.ibm.com, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, kwankhede@nvidia.com, rob.miller@broadcom.com, linux-s390@vger.kernel.org, sebott@linux.ibm.com, lulu@redhat.com, eperezma@redhat.com, pasic@linux.ibm.com, borntraeger@de.ibm.com, haotian.wang@sifive.com, zhi.a.wang@intel.com, farman@linux.ibm.com, idos@mellanox.com, gor@linux.ibm.com, intel-gfx@lists.freedesktop.org, jani.nikula@linux.intel.com, xiao.w.wang@intel.com, freude@linux.ibm.com, zhenyuw@linux.intel.com, parav@mellanox.com, zhihong.wang@intel.com, rodrigo.vivi@intel.com, intel-gvt-dev@lists.freedesktop.org, akrowiak@linux.ibm.com, oberpar@linux.ibm.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, maxime.co
List-Id: virtualization@lists.linuxfoundation.org

On Tue,  5 Nov 2019 17:32:37 +0800
Jason Wang <jasowang@redhat.com> wrote:

> Currently, except for the create and remove, the rest of
> mdev_parent_ops is designed for vfio-mdev driver only and may not help
> for kernel mdev driver. With the help of class id, this patch
> introduces device specific callbacks inside mdev_device
> structure. This allows different set of callback to be used by
> vfio-mdev and virtio-mdev.
> 
> Reviewed-by: Parav Pandit <parav@mellanox.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  .../driver-api/vfio-mediated-device.rst       | 35 +++++++++----
>  MAINTAINERS                                   |  1 +
>  drivers/gpu/drm/i915/gvt/kvmgt.c              | 18 ++++---
>  drivers/s390/cio/vfio_ccw_ops.c               | 18 ++++---
>  drivers/s390/crypto/vfio_ap_ops.c             | 14 +++--
>  drivers/vfio/mdev/mdev_core.c                 | 24 ++++++++-
>  drivers/vfio/mdev/mdev_private.h              |  5 ++
>  drivers/vfio/mdev/vfio_mdev.c                 | 37 ++++++-------
>  include/linux/mdev.h                          | 43 ++++-----------
>  include/linux/mdev_vfio_ops.h                 | 52 +++++++++++++++++++
>  samples/vfio-mdev/mbochs.c                    | 20 ++++---
>  samples/vfio-mdev/mdpy.c                      | 20 ++++---
>  samples/vfio-mdev/mtty.c                      | 18 ++++---
>  13 files changed, 206 insertions(+), 99 deletions(-)
>  create mode 100644 include/linux/mdev_vfio_ops.h
> 

(...)

> @@ -172,10 +163,34 @@ that a driver should use to unregister itself with the mdev core driver::
>  
>  	extern void mdev_unregister_device(struct device *dev);
>  
> -It is also required to specify the class_id in create() callback through::
> +As multiple types of mediated devices may be supported, class id needs
> +to be specified in the create callback(). This could be done

The brackets should probably go behind 'create'?

> +explicitly for the device that does not use on mdev bus for its

"for devices that do not use the mdev bus" ?

But why wouldn't they? I feel like I've missed some discussion here :/

> +operation through:
>  
>  	int mdev_set_class(struct mdev_device *mdev, u16 id);
>  
> +For the device that uses on the mdev bus for its operation, the class

"For devices that use the mdev bus..."

But same comment as above.

> +should provide helper function to set class id and device specific
> +ops. E.g for vfio-mdev devices, the function to be called is::
> +
> +	int mdev_set_vfio_ops(struct mdev_device *mdev,
> +                              const struct mdev_vfio_device_ops *vfio_ops);
> +
> +The class id (set by this function to MDEV_CLASS_ID_VFIO) is used to
> +match a device with an mdev driver via its id table. The device
> +specific callbacks (specified in *vfio_ops) are obtainable via
> +mdev_get_vfio_ops() (for use by the mdev bus driver). A vfio-mdev
> +device (class id MDEV_CLASS_ID_VFIO) uses the following
> +device-specific ops:
> +
> +* open: open callback of vfio mediated device
> +* close: close callback of vfio mediated device
> +* ioctl: ioctl callback of vfio mediated device
> +* read : read emulation callback
> +* write: write emulation callback
> +* mmap: mmap emulation callback
> +
>  Mediated Device Management Interface Through sysfs
>  ==================================================

Otherwise, looks good.
