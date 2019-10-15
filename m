From: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH V3 1/7] mdev: class id support
Date: Tue, 15 Oct 2019 10:38:06 -0600
Message-ID: <20191015103806.0538ccb2__18261.232289818$1571157509$gmane$org@x1.home>
References: <20191011081557.28302-1-jasowang@redhat.com>
	<20191011081557.28302-2-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20191011081557.28302-2-jasowang@redhat.com>
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
Cc: christophe.de.dinechin@gmail.com, kvm@vger.kernel.org, mst@redhat.com, airlied@linux.ie, joonas.lahtinen@linux.intel.com, heiko.carstens@de.ibm.com, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, kwankhede@nvidia.com, rob.miller@broadcom.com, linux-s390@vger.kernel.org, sebott@linux.ibm.com, lulu@redhat.com, eperezma@redhat.com, pasic@linux.ibm.com, borntraeger@de.ibm.com, haotian.wang@sifive.com, zhi.a.wang@intel.com, farman@linux.ibm.com, idos@mellanox.com, gor@linux.ibm.com, intel-gfx@lists.freedesktop.org, jani.nikula@linux.intel.com, rodrigo.vivi@intel.com, xiao.w.wang@intel.com, freude@linux.ibm.com, zhenyuw@linux.intel.com, parav@mellanox.com, zhihong.wang@intel.com, intel-gvt-dev@lists.freedesktop.org, akrowiak@linux.ibm.com, oberpar@linux.ibm.com, netdev@vger.kernel.org, cohuck@redhat.com, linux-kernel@vger.kernel.org, maxime.coque
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 11 Oct 2019 16:15:51 +0800
Jason Wang <jasowang@redhat.com> wrote:
  
> diff --git a/drivers/vfio/mdev/mdev_core.c b/drivers/vfio/mdev/mdev_core.c
> index b558d4cfd082..724e9b9841d8 100644
> --- a/drivers/vfio/mdev/mdev_core.c
> +++ b/drivers/vfio/mdev/mdev_core.c
> @@ -45,6 +45,12 @@ void mdev_set_drvdata(struct mdev_device *mdev, void *data)
>  }
>  EXPORT_SYMBOL(mdev_set_drvdata);
>  
> +void mdev_set_class(struct mdev_device *mdev, u16 id)
> +{
> +	mdev->class_id = id;
> +}
> +EXPORT_SYMBOL(mdev_set_class);
> +
>  struct device *mdev_dev(struct mdev_device *mdev)
>  {
>  	return &mdev->dev;
> @@ -135,6 +141,7 @@ static int mdev_device_remove_cb(struct device *dev, void *data)
>   * mdev_register_device : Register a device
>   * @dev: device structure representing parent device.
>   * @ops: Parent device operation structure to be registered.
> + * @id: class id.
>   *
>   * Add device to list of registered parent devices.
>   * Returns a negative value on error, otherwise 0.
> @@ -324,6 +331,9 @@ int mdev_device_create(struct kobject *kobj,
>  	if (ret)
>  		goto ops_create_fail;
>  
> +	if (!mdev->class_id)

This is a sanity test failure of the parent driver on a privileged
path, I think it's fair to print a warning when this occurs rather than
only return an errno to the user.  In fact, ret is not set to an error
value here, so it looks like this fails to create the device but
returns success.  Thanks,

Alex

> +		goto class_id_fail;
> +
>  	ret = device_add(&mdev->dev);
>  	if (ret)
>  		goto add_fail;
> @@ -340,6 +350,7 @@ int mdev_device_create(struct kobject *kobj,
>  
>  sysfs_fail:
>  	device_del(&mdev->dev);
> +class_id_fail:
>  add_fail:
>  	parent->ops->remove(mdev);
>  ops_create_fail:
