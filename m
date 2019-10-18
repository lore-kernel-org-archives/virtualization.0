From: Tiwei Bie <tiwei.bie@intel.com>
Subject: Re: [PATCH V4 4/6] mdev: introduce virtio device and its device ops
Date: Fri, 18 Oct 2019 17:46:56 +0800
Message-ID: <20191018094655.GA4200__20439.7416369588$1571392219$gmane$org@___>
References: <20191017104836.32464-1-jasowang@redhat.com>
	<20191017104836.32464-5-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20191017104836.32464-5-jasowang@redhat.com>
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
Cc: stefanha@redhat.com, christophe.de.dinechin@gmail.com, kvm@vger.kernel.org, mst@redhat.com, airlied@linux.ie, joonas.lahtinen@linux.intel.com, heiko.carstens@de.ibm.com, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, kwankhede@nvidia.com, rob.miller@broadcom.com, linux-s390@vger.kernel.org, sebott@linux.ibm.com, lulu@redhat.com, eperezma@redhat.com, pasic@linux.ibm.com, borntraeger@de.ibm.com, haotian.wang@sifive.com, zhi.a.wang@intel.com, farman@linux.ibm.com, idos@mellanox.com, gor@linux.ibm.com, intel-gfx@lists.freedesktop.org, jani.nikula@linux.intel.com, xiao.w.wang@intel.com, freude@linux.ibm.com, zhenyuw@linux.intel.com, parav@mellanox.com, zhihong.wang@intel.com, rodrigo.vivi@intel.com, intel-gvt-dev@lists.freedesktop.org, akrowiak@linux.ibm.com, oberpar@linux.ibm.com, netdev@vger.kernel.org, cohuck@redhat.com, linux-kernel@vger.ke
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Oct 17, 2019 at 06:48:34PM +0800, Jason Wang wrote:
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
> + * @get_features:		Set virtio features supported by the driver

s/get_features/set_features/


> + *				configration space
> + * @get_mdev_features:		Get the feature of virtio mdev device
> + *				@mdev: mediated device
> + *				Returns the mdev features (API) support by
> + *				the device.
> + * @get_generation:		Get device generaton
> + *				@mdev: mediated device
> + *				Returns u32: device generation
> + */
> +struct virtio_mdev_device_ops {
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
> +	/* Device ops */
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
> +	u64 (*get_mdev_features)(struct mdev_device *mdev);

Do we need a .set_mdev_features method as well?

It's not very clear what does mdev_features mean.
Does it mean the vhost backend features?

https://github.com/torvalds/linux/blob/0e2adab6cf285c41e825b6c74a3aa61324d1132c/include/uapi/linux/vhost.h#L93-L94


> +	u32 (*get_generation)(struct mdev_device *mdev);
> +};
> +
> +void mdev_set_virtio_ops(struct mdev_device *mdev,
> +			 const struct virtio_mdev_device_ops *virtio_ops);
> +
> +#endif
> -- 
> 2.19.1
> 
