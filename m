From: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH V7 4/6] mdev: introduce virtio device and its device ops
Date: Mon, 4 Nov 2019 14:50:24 -0700
Message-ID: <20191104145024.5e437765__5141.53313576884$1572904294$gmane$org@x1.home>
References: <20191104123952.17276-1-jasowang@redhat.com>
	<20191104123952.17276-5-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20191104123952.17276-5-jasowang@redhat.com>
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
Cc: stefanha@redhat.com, christophe.de.dinechin@gmail.com, kvm@vger.kernel.org, mst@redhat.com, airlied@linux.ie, joonas.lahtinen@linux.intel.com, heiko.carstens@de.ibm.com, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, kwankhede@nvidia.com, rob.miller@broadcom.com, linux-s390@vger.kernel.org, sebott@linux.ibm.com, lulu@redhat.com, eperezma@redhat.com, pasic@linux.ibm.com, borntraeger@de.ibm.com, haotian.wang@sifive.com, zhi.a.wang@intel.com, farman@linux.ibm.com, idos@mellanox.com, gor@linux.ibm.com, intel-gfx@lists.freedesktop.org, jani.nikula@linux.intel.com, rodrigo.vivi@intel.com, xiao.w.wang@intel.com, freude@linux.ibm.com, zhenyuw@linux.intel.com, parav@mellanox.com, zhihong.wang@intel.com, intel-gvt-dev@lists.freedesktop.org, akrowiak@linux.ibm.com, oberpar@linux.ibm.com, netdev@vger.kernel.org, cohuck@redhat.com, linux-kernel@vger.ke
List-Id: virtualization@lists.linuxfoundation.org

On Mon,  4 Nov 2019 20:39:50 +0800
Jason Wang <jasowang@redhat.com> wrote:

> This patch implements basic support for mdev driver that supports
> virtio transport for kernel virtio driver.
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/vfio/mdev/mdev_core.c    |  20 ++++
>  drivers/vfio/mdev/mdev_private.h |   2 +
>  include/linux/mdev.h             |   6 ++
>  include/linux/mdev_virtio_ops.h  | 166 +++++++++++++++++++++++++++++++
>  4 files changed, 194 insertions(+)
>  create mode 100644 include/linux/mdev_virtio_ops.h
> 
> diff --git a/drivers/vfio/mdev/mdev_core.c b/drivers/vfio/mdev/mdev_core.c
> index 8d579d7ed82f..95ee4126ff9c 100644
> --- a/drivers/vfio/mdev/mdev_core.c
> +++ b/drivers/vfio/mdev/mdev_core.c
> @@ -76,6 +76,26 @@ const struct mdev_vfio_device_ops *mdev_get_vfio_ops(struct mdev_device *mdev)
>  }
>  EXPORT_SYMBOL(mdev_get_vfio_ops);
>  
> +/* Specify the virtio device ops for the mdev device, this
> + * must be called during create() callback for virtio mdev device.
> + */

Comment style.

> +void mdev_set_virtio_ops(struct mdev_device *mdev,
> +			 const struct mdev_virtio_device_ops *virtio_ops)
> +{
> +	mdev_set_class(mdev, MDEV_CLASS_ID_VIRTIO);
> +	mdev->virtio_ops = virtio_ops;
> +}
> +EXPORT_SYMBOL(mdev_set_virtio_ops);
> +
> +/* Get the virtio device ops for the mdev device. */
> +const struct mdev_virtio_device_ops *
> +mdev_get_virtio_ops(struct mdev_device *mdev)
> +{
> +	WARN_ON(mdev->class_id != MDEV_CLASS_ID_VIRTIO);
> +	return mdev->virtio_ops;
> +}
> +EXPORT_SYMBOL(mdev_get_virtio_ops);
> +
>  struct device *mdev_dev(struct mdev_device *mdev)
>  {
>  	return &mdev->dev;
> diff --git a/drivers/vfio/mdev/mdev_private.h b/drivers/vfio/mdev/mdev_private.h
> index 411227373625..2c74dd032409 100644
> --- a/drivers/vfio/mdev/mdev_private.h
> +++ b/drivers/vfio/mdev/mdev_private.h
> @@ -11,6 +11,7 @@
>  #define MDEV_PRIVATE_H
>  
>  #include <linux/mdev_vfio_ops.h>
> +#include <linux/mdev_virtio_ops.h>
>  
>  int  mdev_bus_register(void);
>  void mdev_bus_unregister(void);
> @@ -38,6 +39,7 @@ struct mdev_device {
>  	u16 class_id;
>  	union {
>  		const struct mdev_vfio_device_ops *vfio_ops;
> +		const struct mdev_virtio_device_ops *virtio_ops;
>  	};
>  };
>  
> diff --git a/include/linux/mdev.h b/include/linux/mdev.h
> index 9e37506d1987..f3d75a60c2b5 100644
> --- a/include/linux/mdev.h
> +++ b/include/linux/mdev.h
> @@ -17,6 +17,7 @@
>  
>  struct mdev_device;
>  struct mdev_vfio_device_ops;
> +struct mdev_virtio_device_ops;
>  
>  /*
>   * Called by the parent device driver to set the device which represents
> @@ -112,6 +113,10 @@ void mdev_set_class(struct mdev_device *mdev, u16 id);
>  void mdev_set_vfio_ops(struct mdev_device *mdev,
>  		       const struct mdev_vfio_device_ops *vfio_ops);
>  const struct mdev_vfio_device_ops *mdev_get_vfio_ops(struct mdev_device *mdev);
> +void mdev_set_virtio_ops(struct mdev_device *mdev,
> +			 const struct mdev_virtio_device_ops *virtio_ops);
> +const struct mdev_virtio_device_ops *
> +mdev_get_virtio_ops(struct mdev_device *mdev);
>  
>  extern struct bus_type mdev_bus_type;
>  
> @@ -127,6 +132,7 @@ struct mdev_device *mdev_from_dev(struct device *dev);
>  
>  enum {
>  	MDEV_CLASS_ID_VFIO = 1,
> +	MDEV_CLASS_ID_VIRTIO = 2,
>  	/* New entries must be added here */
>  };
>  
> diff --git a/include/linux/mdev_virtio_ops.h b/include/linux/mdev_virtio_ops.h
> new file mode 100644
> index 000000000000..0dcae7fa31e5
> --- /dev/null
> +++ b/include/linux/mdev_virtio_ops.h
> @@ -0,0 +1,166 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Virtio mediated device driver
> + *
> + * Copyright 2019, Red Hat Corp.
> + *     Author: Jason Wang <jasowang@redhat.com>
> + */
> +#ifndef MDEV_VIRTIO_OPS_H
> +#define MDEV_VIRTIO_OPS_H
> +
> +#include <linux/interrupt.h>
> +#include <linux/mdev.h>
> +#include <uapi/linux/vhost.h>
> +
> +#define VIRTIO_MDEV_DEVICE_API_STRING		"virtio-mdev"
> +#define VIRTIO_MDEV_F_VERSION_1 0x1
> +
> +struct virtio_mdev_callback {
> +	irqreturn_t (*callback)(void *data);
> +	void *private;
> +};
> +
> +/**
> + * struct mdev_virtio_device_ops - Structure to be registered for each
> + * mdev device to register the device for virtio/vhost drivers.
> + *
> + * The device ops that is supported by VIRTIO_MDEV_F_VERSION_1, the
> + * callbacks are mandatory unless explicity mentioned.
> + *
> + * @get_mdev_features:		Get a set of bits that demonstrate
> + *				the capability of the mdev device. New
> + *				feature bits must be added when
> + *				introducing new device ops. This
> + *				allows the device ops to be extended
> + *				(one feature could have N new ops).
> + *				@mdev: mediated device
> + *				Returns the mdev features (API) support by
> + *				the device.

I still don't see the point of VIRTIO_MDEV_F_VERSION_1.  In what case
would it not be set?  What would it indicate to the caller if it were
not set?  The existence of this interface seems to indicate version 1.

I'm also still unclear how device ops gets extended, can you give some
examples?  Particularly, if feature A and feature B both add device ops
callbacks, is the vendor allowed to support B but not A, and does that
imply their device ops structure includes callbacks for A but they're
unused?  Why doesn't the previous patch take any of this into account
for struct mdev_vfio_device_ops?  I think this is an internal API,
therefore is it worthwhile to include feature and extension support?

> + * @get_mdev_features:		Set a set of features that will be

s/get/set/

> + *				used by the driver.
> + *				@features: features used by the driver
> + *				Returns bollean: whether the features

s/bollean/boolean/

How does one provide a set of features to set given this prototype?

bool (*set_mdev_feature)(struct mdev_device *mdev);

This is starting to look like a grab bag of callbacks, what sort of
mdev features would the driver have the ability to set on a device?

Note that this is not listed as optional, but the sample driver doesn't
implement it :-\

Thanks,

Alex

> + *				is accepted by the device.
> + * @set_vq_address:		Set the address of virtqueue
> + *				@mdev: mediated device
> + *				@idx: virtqueue index
> + *				@desc_area: address of desc area
> + *				@driver_area: address of driver area
> + *				@device_area: address of device area
> + *				Returns integer: success (0) or error (< 0)
> + * @set_vq_num:			Set the size of virtqueue
> + *				@mdev: mediated device
> + *				@idx: virtqueue index
> + *				@num: the size of virtqueue
> + * @kick_vq:			Kick the virtqueue
> + *				@mdev: mediated device
> + *				@idx: virtqueue index
> + * @set_vq_cb:			Set the interrupt callback function for
> + *				a virtqueue
> + *				@mdev: mediated device
> + *				@idx: virtqueue index
> + *				@cb: virtio-mdev interrupt callback structure
> + * @set_vq_ready:		Set ready status for a virtqueue
> + *				@mdev: mediated device
> + *				@idx: virtqueue index
> + *				@ready: ready (true) not ready(false)
> + * @get_vq_ready:		Get ready status for a virtqueue
> + *				@mdev: mediated device
> + *				@idx: virtqueue index
> + *				Returns boolean: ready (true) or not (false)
> + * @set_vq_state:		Set the state for a virtqueue
> + *				@mdev: mediated device
> + *				@idx: virtqueue index
> + *				@state: virtqueue state (last_avail_idx)
> + *				Returns integer: success (0) or error (< 0)
> + * @get_vq_state:		Get the state for a virtqueue
> + *				@mdev: mediated device
> + *				@idx: virtqueue index
> + *				Returns virtqueue state (last_avail_idx)
> + * @get_vq_align:		Get the virtqueue align requirement
> + *				for the device
> + *				@mdev: mediated device
> + *				Returns virtqueue algin requirement
> + * @get_features:		Get virtio features supported by the device
> + *				@mdev: mediated device
> + *				Returns the virtio features support by the
> + *				device
> + * @set_features:		Set virtio features supported by the driver
> + *				@mdev: mediated device
> + *				@features: feature support by the driver
> + *				Returns integer: success (0) or error (< 0)
> + * @set_config_cb:		Set the config interrupt callback
> + *				@mdev: mediated device
> + *				@cb: virtio-mdev interrupt callback structure
> + * @get_vq_num_max:		Get the max size of virtqueue
> + *				@mdev: mediated device
> + *				Returns u16: max size of virtqueue
> + * @get_device_id:		Get virtio device id
> + *				@mdev: mediated device
> + *				Returns u32: virtio device id
> + * @get_vendor_id:		Get id for the vendor that provides this device
> + *				@mdev: mediated device
> + *				Returns u32: virtio vendor id
> + * @get_status:			Get the device status
> + *				@mdev: mediated device
> + *				Returns u8: virtio device status
> + * @set_status:			Set the device status
> + *				@mdev: mediated device
> + *				@status: virtio device status
> + * @get_config:			Read from device specific configuration space
> + *				@mdev: mediated device
> + *				@offset: offset from the beginning of
> + *				configuration space
> + *				@buf: buffer used to read to
> + *				@len: the length to read from
> + *				configration space
> + * @set_config:			Write to device specific configuration space
> + *				@mdev: mediated device
> + *				@offset: offset from the beginning of
> + *				configuration space
> + *				@buf: buffer used to write from
> + *				@len: the length to write to
> + *				configration space
> + * @get_generation:		Get device config generaton (optional)
> + *				@mdev: mediated device
> + *				Returns u32: device generation
> + */
> +struct mdev_virtio_device_ops {
> +	/* Mdev device ops */
> +	u64 (*get_mdev_features)(struct mdev_device *mdev);
> +	bool (*set_mdev_feature)(struct mdev_device *mdev);
> +	/* Virtqueue ops */
> +	int (*set_vq_address)(struct mdev_device *mdev,
> +			      u16 idx, u64 desc_area, u64 driver_area,
> +			      u64 device_area);
> +	void (*set_vq_num)(struct mdev_device *mdev, u16 idx, u32 num);
> +	void (*kick_vq)(struct mdev_device *mdev, u16 idx);
> +	void (*set_vq_cb)(struct mdev_device *mdev, u16 idx,
> +			  struct virtio_mdev_callback *cb);
> +	void (*set_vq_ready)(struct mdev_device *mdev, u16 idx, bool ready);
> +	bool (*get_vq_ready)(struct mdev_device *mdev, u16 idx);
> +	int (*set_vq_state)(struct mdev_device *mdev, u16 idx, u64 state);
> +	u64 (*get_vq_state)(struct mdev_device *mdev, u16 idx);
> +
> +	/* Virtio device ops */
> +	u16 (*get_vq_align)(struct mdev_device *mdev);
> +	u64 (*get_features)(struct mdev_device *mdev);
> +	int (*set_features)(struct mdev_device *mdev, u64 features);
> +	void (*set_config_cb)(struct mdev_device *mdev,
> +			      struct virtio_mdev_callback *cb);
> +	u16 (*get_vq_num_max)(struct mdev_device *mdev);
> +	u32 (*get_device_id)(struct mdev_device *mdev);
> +	u32 (*get_vendor_id)(struct mdev_device *mdev);
> +	u8 (*get_status)(struct mdev_device *mdev);
> +	void (*set_status)(struct mdev_device *mdev, u8 status);
> +	void (*get_config)(struct mdev_device *mdev, unsigned int offset,
> +			   void *buf, unsigned int len);
> +	void (*set_config)(struct mdev_device *mdev, unsigned int offset,
> +			   const void *buf, unsigned int len);
> +	u32 (*get_generation)(struct mdev_device *mdev);
> +};
> +
> +void mdev_set_virtio_ops(struct mdev_device *mdev,
> +			 const struct mdev_virtio_device_ops *virtio_ops);
> +
> +#endif
