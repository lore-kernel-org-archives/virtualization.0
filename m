From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH V9 5/6] virtio: introduce a mdev based transport
Date: Wed, 6 Nov 2019 12:00:47 +0100
Message-ID: <20191106120047.5bcf49c3.cohuck__34499.4147120573$1573038091$gmane$org@redhat.com>
References: <20191106070548.18980-1-jasowang@redhat.com>
	<20191106070548.18980-6-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20191106070548.18980-6-jasowang@redhat.com>
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

On Wed,  6 Nov 2019 15:05:47 +0800
Jason Wang <jasowang@redhat.com> wrote:

> This patch introduces a new mdev transport for virtio. This is used to
> use kernel virtio driver to drive the mediated device that is capable
> of populating virtqueue directly.
> 
> A new virtio-mdev driver will be registered to the mdev bus, when a
> new virtio-mdev device is probed, it will register the device with
> mdev based config ops. This means it is a software transport between
> mdev driver and mdev device. The transport was implemented through
> device specific ops which is a part of mdev_parent_ops now.
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/virtio/Kconfig       |  13 ++
>  drivers/virtio/Makefile      |   1 +
>  drivers/virtio/virtio_mdev.c | 406 +++++++++++++++++++++++++++++++++++
>  3 files changed, 420 insertions(+)
>  create mode 100644 drivers/virtio/virtio_mdev.c
> 
> diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
> index 078615cf2afc..558ac607d107 100644
> --- a/drivers/virtio/Kconfig
> +++ b/drivers/virtio/Kconfig
> @@ -43,6 +43,19 @@ config VIRTIO_PCI_LEGACY
>  
>  	  If unsure, say Y.
>  
> +config VIRTIO_MDEV
> +	tristate "MDEV driver for virtio devices"
> +	depends on VFIO_MDEV && VIRTIO
> +	default n
> +	help
> +	  This driver provides support for virtio based paravirtual
> +	  device driver over MDEV bus. This requires your environemnt
> +	  has appropriate virtio mdev device implementation which may
> +	  operate on the physical device that the datapath of virtio
> +	  could be offloaded to hardware.

That sentence is a bit confusing to me... what about

"For this to be useful, you need an appropriate virtio mdev device
implementation that operates on a physical device to allow the datapath
of virtio to be offloaded to hardware."

?

> +
> +	  If unsure, say M

Building this as a module should not hurt (but please add a trailing
'.' here :)

> +
>  config VIRTIO_PMEM
>  	tristate "Support for virtio pmem driver"
>  	depends on VIRTIO

With the changes above,

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
