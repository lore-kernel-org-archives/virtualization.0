From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [RFC PATCH 1/2] mdev: device id support
Date: Tue, 17 Sep 2019 14:07:20 +0200
Message-ID: <20190917140720.3686e0cc.cohuck__21299.20900786$1568722077$gmane$org@redhat.com>
References: <20190912094012.29653-1-jasowang@redhat.com>
	<20190912094012.29653-2-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190912094012.29653-2-jasowang@redhat.com>
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

On Thu, 12 Sep 2019 17:40:11 +0800
Jason Wang <jasowang@redhat.com> wrote:

> Mdev bus only support vfio driver right now, so it doesn't implement
> match method. But in the future, we may add drivers other than vfio,
> one example is virtio-mdev[1] driver. This means we need to add device
> id support in bus match method to pair the mdev device and mdev driver
> correctly.

Sounds reasonable.

> 
> So this patch add id_table to mdev_driver and id for mdev parent, and
> implement the match method for mdev bus.
> 
> [1] https://lkml.org/lkml/2019/9/10/135
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/gpu/drm/i915/gvt/kvmgt.c  |  2 +-
>  drivers/s390/cio/vfio_ccw_ops.c   |  2 +-
>  drivers/s390/crypto/vfio_ap_ops.c |  3 ++-
>  drivers/vfio/mdev/mdev_core.c     | 14 ++++++++++++--
>  drivers/vfio/mdev/mdev_driver.c   | 14 ++++++++++++++
>  drivers/vfio/mdev/mdev_private.h  |  1 +
>  drivers/vfio/mdev/vfio_mdev.c     |  6 ++++++
>  include/linux/mdev.h              |  6 +++++-
>  include/linux/mod_devicetable.h   |  6 ++++++
>  samples/vfio-mdev/mbochs.c        |  2 +-
>  samples/vfio-mdev/mdpy.c          |  2 +-
>  samples/vfio-mdev/mtty.c          |  2 +-
>  12 files changed, 51 insertions(+), 9 deletions(-)

(...)

The transformations of the vendor drivers and the new interface look
sane.

(...)

> diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
> index 5714fd35a83c..f1fc143df042 100644
> --- a/include/linux/mod_devicetable.h
> +++ b/include/linux/mod_devicetable.h
> @@ -821,4 +821,10 @@ struct wmi_device_id {
>  	const void *context;
>  };
>  
> +/* MDEV */
> +

Maybe add some kerneldoc and give vfio as an example of what we're
matching here?

> +struct mdev_device_id {
> +	__u8 id;

I agree with the suggestion to rename this to 'class_id'.

> +};
> +
>  #endif /* LINUX_MOD_DEVICETABLE_H */
