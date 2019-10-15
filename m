From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH V3 2/7] mdev: bus uevent support
Date: Tue, 15 Oct 2019 12:27:07 +0200
Message-ID: <20191015122707.1fd52240.cohuck__26203.0500731029$1571135300$gmane$org@redhat.com>
References: <20191011081557.28302-1-jasowang@redhat.com>
	<20191011081557.28302-3-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20191011081557.28302-3-jasowang@redhat.com>
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

On Fri, 11 Oct 2019 16:15:52 +0800
Jason Wang <jasowang@redhat.com> wrote:

> This patch adds bus uevent support for mdev bus in order to allow
> cooperation with userspace.
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/vfio/mdev/mdev_driver.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/vfio/mdev/mdev_driver.c b/drivers/vfio/mdev/mdev_driver.c
> index b7c40ce86ee3..319d886ffaf7 100644
> --- a/drivers/vfio/mdev/mdev_driver.c
> +++ b/drivers/vfio/mdev/mdev_driver.c
> @@ -82,9 +82,17 @@ static int mdev_match(struct device *dev, struct device_driver *drv)
>  	return 0;
>  }
>  
> +static int mdev_uevent(struct device *dev, struct kobj_uevent_env *env)
> +{
> +	struct mdev_device *mdev = to_mdev_device(dev);
> +
> +	return add_uevent_var(env, "MODALIAS=mdev:c%02X", mdev->class_id);
> +}
> +
>  struct bus_type mdev_bus_type = {
>  	.name		= "mdev",
>  	.match		= mdev_match,
> +	.uevent		= mdev_uevent,
>  	.probe		= mdev_probe,
>  	.remove		= mdev_remove,
>  };

I'd merge that into the previous patch.
