From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [RFC PATCH 2/2] mdev: introduce device specific ops
Date: Tue, 17 Sep 2019 14:42:40 +0200
Message-ID: <20190917144240.6a59b65f.cohuck__6896.20936043269$1568724189$gmane$org@redhat.com>
References: <20190912094012.29653-1-jasowang@redhat.com>
	<20190912094012.29653-3-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190912094012.29653-3-jasowang@redhat.com>
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
Cc: sebott@linux.ibm.com, mst@redhat.com, airlied@linux.ie, joonas.lahtinen@linux.intel.com, heiko.carstens@de.ibm.com, dri-devel@lists.freedesktop.org, oberpar@linux.ibm.com, kwankhede@nvidia.com, rob.miller@broadcom.com, linux-s390@vger.kernel.org, kvm@vger.kernel.org, pasic@linux.ibm.com, borntraeger@de.ibm.com, zhi.a.wang@intel.com, farman@linux.ibm.com, idos@mellanox.com, gor@linux.ibm.com, intel-gfx@lists.freedesktop.org, jani.nikula@linux.intel.com, xiao.w.wang@intel.com, freude@linux.ibm.com, zhenyuw@linux.intel.com, rodrigo.vivi@intel.com, virtualization@lists.linux-foundation.org, intel-gvt-dev@lists.freedesktop.org, lingshan.zhu@intel.com, akrowiak@linux.ibm.com, pmorel@linux.ibm.com, linux-kernel@vger.kernel.org, maxime.coquelin@redhat.com, daniel@ffwll.ch, zhihong.wang@intel.com
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 12 Sep 2019 17:40:12 +0800
Jason Wang <jasowang@redhat.com> wrote:

> Currently, except for the crate and remove. The rest fields of
> mdev_parent_ops is just designed for vfio-mdev driver and may not help
> for kernel mdev driver. So follow the device id support by previous
> patch, this patch introduces device specific ops which points to
> device specific ops (e.g vfio ops). This allows the future drivers
> like virtio-mdev to implement its own device specific ops.
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/gpu/drm/i915/gvt/kvmgt.c  | 14 +++---
>  drivers/s390/cio/vfio_ccw_ops.c   | 14 +++---
>  drivers/s390/crypto/vfio_ap_ops.c | 10 +++--
>  drivers/vfio/mdev/vfio_mdev.c     | 30 +++++++------
>  include/linux/mdev.h              | 72 ++++++++++++++++++-------------
>  samples/vfio-mdev/mbochs.c        | 16 ++++---
>  samples/vfio-mdev/mdpy.c          | 16 ++++---
>  samples/vfio-mdev/mtty.c          | 14 +++---
>  8 files changed, 113 insertions(+), 73 deletions(-)

> diff --git a/include/linux/mdev.h b/include/linux/mdev.h
> index f85045392120..3b8a76bc69cf 100644
> --- a/include/linux/mdev.h
> +++ b/include/linux/mdev.h
> @@ -27,27 +27,9 @@ int mdev_set_iommu_device(struct device *dev, struct device *iommu_device);
>  struct device *mdev_get_iommu_device(struct device *dev);
>  
>  /**
> - * struct mdev_parent_ops - Structure to be registered for each parent device to
> - * register the device to mdev module.
> + * struct vfio_mdev_parent_ops - Structure to be registered for each
> + * parent device to register the device to vfio-mdev module.
>   *
> - * @owner:		The module owner.
> - * @dev_attr_groups:	Attributes of the parent device.
> - * @mdev_attr_groups:	Attributes of the mediated device.
> - * @supported_type_groups: Attributes to define supported types. It is mandatory
> - *			to provide supported types.
> - * @create:		Called to allocate basic resources in parent device's
> - *			driver for a particular mediated device. It is
> - *			mandatory to provide create ops.
> - *			@kobj: kobject of type for which 'create' is called.
> - *			@mdev: mdev_device structure on of mediated device
> - *			      that is being created
> - *			Returns integer: success (0) or error (< 0)
> - * @remove:		Called to free resources in parent device's driver for a
> - *			a mediated device. It is mandatory to provide 'remove'
> - *			ops.
> - *			@mdev: mdev_device device structure which is being
> - *			       destroyed
> - *			Returns integer: success (0) or error (< 0)
>   * @open:		Open mediated device.
>   *			@mdev: mediated device.
>   *			Returns integer: success (0) or error (< 0)
> @@ -72,6 +54,43 @@ struct device *mdev_get_iommu_device(struct device *dev);
>   * @mmap:		mmap callback
>   *			@mdev: mediated device structure
>   *			@vma: vma structure
> + */
> +struct vfio_mdev_parent_ops {
> +	int     (*open)(struct mdev_device *mdev);
> +	void    (*release)(struct mdev_device *mdev);
> +	ssize_t (*read)(struct mdev_device *mdev, char __user *buf,
> +			size_t count, loff_t *ppos);
> +	ssize_t (*write)(struct mdev_device *mdev, const char __user *buf,
> +			 size_t count, loff_t *ppos);
> +	long	(*ioctl)(struct mdev_device *mdev, unsigned int cmd,
> +			 unsigned long arg);
> +	int	(*mmap)(struct mdev_device *mdev, struct vm_area_struct *vma);
> +};
> +
> +/**
> + * struct mdev_parent_ops - Structure to be registered for each parent device to
> + * register the device to mdev module.
> + *
> + * @owner:		The module owner.
> + * @dev_attr_groups:	Attributes of the parent device.
> + * @mdev_attr_groups:	Attributes of the mediated device.
> + * @supported_type_groups: Attributes to define supported types. It is mandatory
> + *			to provide supported types.
> + * @create:		Called to allocate basic resources in parent device's
> + *			driver for a particular mediated device. It is
> + *			mandatory to provide create ops.
> + *			@kobj: kobject of type for which 'create' is called.
> + *			@mdev: mdev_device structure on of mediated device
> + *			      that is being created
> + *			Returns integer: success (0) or error (< 0)
> + * @remove:		Called to free resources in parent device's driver for a
> + *			a mediated device. It is mandatory to provide 'remove'
> + *			ops.
> + *			@mdev: mdev_device device structure which is being
> + *			       destroyed
> + *			Returns integer: success (0) or error (< 0)
> + * @device_ops:         Device specific emulation callback.
> + *
>   * Parent device that support mediated device should be registered with mdev
>   * module with mdev_parent_ops structure.
>   **/
> @@ -83,15 +102,7 @@ struct mdev_parent_ops {
>  
>  	int     (*create)(struct kobject *kobj, struct mdev_device *mdev);
>  	int     (*remove)(struct mdev_device *mdev);
> -	int     (*open)(struct mdev_device *mdev);
> -	void    (*release)(struct mdev_device *mdev);
> -	ssize_t (*read)(struct mdev_device *mdev, char __user *buf,
> -			size_t count, loff_t *ppos);
> -	ssize_t (*write)(struct mdev_device *mdev, const char __user *buf,
> -			 size_t count, loff_t *ppos);
> -	long	(*ioctl)(struct mdev_device *mdev, unsigned int cmd,
> -			 unsigned long arg);
> -	int	(*mmap)(struct mdev_device *mdev, struct vm_area_struct *vma);
> +	const void *device_ops;
>  };
>  
>  /* interface for exporting mdev supported type attributes */

This basically looks like a split between stuff that is always
triggered from userspace (create and the like) and stuff that is
triggered from userspace for vfio mdevs, but not necessarily for other
mdevs. Seems reasonable at a glance.

If we decide to go forward with this, we should also update the
documentation (split out stuff from driver-api/vfio-mediated-device.rst
etc.)
