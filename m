From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH V3 4/7] mdev: introduce device specific ops
Date: Tue, 15 Oct 2019 12:41:37 +0200
Message-ID: <20191015124137.4f948bd2.cohuck__9593.30361090309$1571136127$gmane$org@redhat.com>
References: <20191011081557.28302-1-jasowang@redhat.com>
	<20191011081557.28302-5-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20191011081557.28302-5-jasowang@redhat.com>
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
Cc: christophe.de.dinechin@gmail.com, kvm@vger.kernel.org, mst@redhat.com, airlied@linux.ie, joonas.lahtinen@linux.intel.com, heiko.carstens@de.ibm.com, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, kwankhede@nvidia.com, rob.miller@broadcom.com, linux-s390@vger.kernel.org, sebott@linux.ibm.com, lulu@redhat.com, eperezma@redhat.com, pasic@linux.ibm.com, borntraeger@de.ibm.com, haotian.wang@sifive.com, zhi.a.wang@intel.com, farman@linux.ibm.com, idos@mellanox.com, gor@linux.ibm.com, intel-gfx@lists.freedesktop.org, jani.nikula@linux.intel.com, xiao.w.wang@intel.com, freude@linux.ibm.com, zhenyuw@linux.intel.com, parav@mellanox.com, zhihong.wang@intel.com, rodrigo.vivi@intel.com, intel-gvt-dev@lists.freedesktop.org, akrowiak@linux.ibm.com, oberpar@linux.ibm.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, maxime.coquelin@redhat.comda
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 11 Oct 2019 16:15:54 +0800
Jason Wang <jasowang@redhat.com> wrote:

> Currently, except for the create and remove, the rest of
> mdev_parent_ops is designed for vfio-mdev driver only and may not help
> for kernel mdev driver. With the help of class id, this patch
> introduces device specific callbacks inside mdev_device
> structure. This allows different set of callback to be used by
> vfio-mdev and virtio-mdev.
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  .../driver-api/vfio-mediated-device.rst       | 22 +++++---
>  MAINTAINERS                                   |  1 +
>  drivers/gpu/drm/i915/gvt/kvmgt.c              | 18 ++++---
>  drivers/s390/cio/vfio_ccw_ops.c               | 18 ++++---
>  drivers/s390/crypto/vfio_ap_ops.c             | 14 +++--
>  drivers/vfio/mdev/mdev_core.c                 |  9 +++-
>  drivers/vfio/mdev/mdev_private.h              |  1 +
>  drivers/vfio/mdev/vfio_mdev.c                 | 37 ++++++-------
>  include/linux/mdev.h                          | 42 +++------------
>  include/linux/vfio_mdev.h                     | 52 +++++++++++++++++++
>  samples/vfio-mdev/mbochs.c                    | 20 ++++---
>  samples/vfio-mdev/mdpy.c                      | 21 +++++---
>  samples/vfio-mdev/mtty.c                      | 18 ++++---
>  13 files changed, 177 insertions(+), 96 deletions(-)
>  create mode 100644 include/linux/vfio_mdev.h
> 
> diff --git a/Documentation/driver-api/vfio-mediated-device.rst b/Documentation/driver-api/vfio-mediated-device.rst
> index 2035e48da7b2..553574ebba73 100644
> --- a/Documentation/driver-api/vfio-mediated-device.rst
> +++ b/Documentation/driver-api/vfio-mediated-device.rst
> @@ -152,11 +152,20 @@ callbacks per mdev parent device, per mdev type, or any other categorization.
>  Vendor drivers are expected to be fully asynchronous in this respect or
>  provide their own internal resource protection.)
>  
> -The callbacks in the mdev_parent_ops structure are as follows:
> +In order to support multiple types of device/driver, device needs to
> +provide both class_id and device_ops through:

"As multiple types of mediated devices may be supported, the device
needs to set up the class id and the device specific callbacks via:"

?

>  
> -* open: open callback of mediated device
> -* close: close callback of mediated device
> -* ioctl: ioctl callback of mediated device
> +    void mdev_set_class(struct mdev_device *mdev, u16 id, const void *ops);
> +
> +The class_id is used to be paired with ids in id_table in mdev_driver
> +structure for probing the correct driver.

"The class id  (specified in id) is used to match a device with an mdev
driver via its id table."

?

> The device_ops is device
> +specific callbacks which can be get through mdev_get_dev_ops()
> +function by mdev bus driver. 

"The device specific callbacks (specified in *ops) are obtainable via
mdev_get_dev_ops() (for use by the mdev bus driver.)"

?

> For vfio-mdev device, its device specific
> +ops are as follows:

"A vfio-mdev device (class id MDEV_ID_VFIO) uses the following
device-specific ops:"

?

> +
> +* open: open callback of vfio mediated device
> +* close: close callback of vfio mediated device
> +* ioctl: ioctl callback of vfio mediated device
>  * read : read emulation callback
>  * write: write emulation callback
>  * mmap: mmap emulation callback
> @@ -167,9 +176,10 @@ register itself with the mdev core driver::
>  	extern int  mdev_register_device(struct device *dev,
>  	                                 const struct mdev_parent_ops *ops);
>  
> -It is also required to specify the class_id through::
> +It is also required to specify the class_id and device specific ops through::
>  
> -	extern int mdev_set_class(struct device *dev, u16 id);
> +	extern int mdev_set_class(struct device *dev, u16 id,
> +	                          const void *ops);

Apologies if that has already been discussed, but do we want a 1:1
relationship between id and ops, or can different devices with the same
id register different ops? If the former, would it make sense to first
register the ops for an id (once), and then have the ->create callback
only set the class id (with the core doing the lookup of the ops)?

>  
>  However, the mdev_parent_ops structure is not required in the function call
>  that a driver should use to unregister itself with the mdev core driver::
