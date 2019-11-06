From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH V9 6/6] docs: sample driver to demonstrate how to
	implement virtio-mdev framework
Date: Wed, 6 Nov 2019 14:50:30 -0800
Message-ID: <88efad07-70aa-3879-31e7-ace4d2ad63a1__40054.6657548816$1573080649$gmane$org@infradead.org>
References: <20191106070548.18980-1-jasowang@redhat.com>
	<20191106070548.18980-7-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20191106070548.18980-7-jasowang@redhat.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org, kwankhede@nvidia.com, alex.williamson@redhat.com, mst@redhat.com, tiwei.bie@intel.com
Cc: christophe.de.dinechin@gmail.com, sebott@linux.ibm.com, airlied@linux.ie, joonas.lahtinen@linux.intel.com, heiko.carstens@de.ibm.com, virtualization@lists.linux-foundation.org, rob.miller@broadcom.com, lulu@redhat.com, eperezma@redhat.com, pasic@linux.ibm.com, borntraeger@de.ibm.com, haotian.wang@sifive.com, zhi.a.wang@intel.com, farman@linux.ibm.com, idos@mellanox.com, gor@linux.ibm.com, zhenyuw@linux.intel.com, rodrigo.vivi@intel.com, xiao.w.wang@intel.com, freude@linux.ibm.com, jani.nikula@linux.intel.com, parav@mellanox.com, zhihong.wang@intel.com, stefanha@redhat.com, akrowiak@linux.ibm.com, netdev@vger.kernel.org, cohuck@redhat.com, oberpar@linux.ibm.com, maxime.coquelin@redhat.com, daniel@ffwll.ch, lingshan.zhu@intel.com
List-Id: virtualization@lists.linuxfoundation.org

On 11/5/19 11:05 PM, Jason Wang wrote:
> diff --git a/samples/Kconfig b/samples/Kconfig
> index c8dacb4dda80..13a2443e18e0 100644
> --- a/samples/Kconfig
> +++ b/samples/Kconfig
> @@ -131,6 +131,16 @@ config SAMPLE_VFIO_MDEV_MDPY
>  	  mediated device.  It is a simple framebuffer and supports
>  	  the region display interface (VFIO_GFX_PLANE_TYPE_REGION).
>  
> +config SAMPLE_VIRTIO_MDEV_NET
> +	tristate "Build VIRTIO net example mediated device sample code -- loadable modules only"
> +	depends on VIRTIO_MDEV && VHOST_RING && m
> +	help
> +	  Build a networking sample device for use as a virtio
> +	  mediated device. The device coopreates with virtio-mdev bus

typo here:
	                              cooperates

> +	  driver to present an virtio ethernet driver for
> +	  kernel. It simply loopbacks all packets from its TX
> +	  virtqueue to its RX virtqueue.
> +
>  config SAMPLE_VFIO_MDEV_MDPY_FB
>  	tristate "Build VFIO mdpy example guest fbdev driver -- loadable module only"
>  	depends on FB && m

ciao.
-- 
~Randy
