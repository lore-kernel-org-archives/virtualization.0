From: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH V9 6/6] docs: sample driver to demonstrate how to
	implement virtio-mdev framework
Date: Wed, 6 Nov 2019 15:58:00 -0700
Message-ID: <20191106155800.0b8418ec__22866.5009768278$1573081113$gmane$org@x1.home>
References: <20191106070548.18980-1-jasowang@redhat.com>
	<20191106070548.18980-7-jasowang@redhat.com>
	<88efad07-70aa-3879-31e7-ace4d2ad63a1@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <88efad07-70aa-3879-31e7-ace4d2ad63a1@infradead.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Randy Dunlap <rdunlap@infradead.org>
Cc: stefanha@redhat.com, christophe.de.dinechin@gmail.com, kvm@vger.kernel.org, mst@redhat.com, airlied@linux.ie, joonas.lahtinen@linux.intel.com, heiko.carstens@de.ibm.com, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, kwankhede@nvidia.com, rob.miller@broadcom.com, linux-s390@vger.kernel.org, sebott@linux.ibm.com, lulu@redhat.com, eperezma@redhat.com, pasic@linux.ibm.com, borntraeger@de.ibm.com, haotian.wang@sifive.com, intel-gfx@lists.freedesktop.org, zhi.a.wang@intel.com, farman@linux.ibm.com, idos@mellanox.com, gor@linux.ibm.com, jani.nikula@linux.intel.com, rodrigo.vivi@intel.com, xiao.w.wang@intel.com, freude@linux.ibm.com, zhenyuw@linux.intel.com, parav@mellanox.com, zhihong.wang@intel.com, intel-gvt-dev@lists.freedesktop.org, akrowiak@linux.ibm.com, oberpar@linux.ibm.com, netdev@vger.kernel.org, cohuck@redhat.com, linux-kernel@vger.ke
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 6 Nov 2019 14:50:30 -0800
Randy Dunlap <rdunlap@infradead.org> wrote:

> On 11/5/19 11:05 PM, Jason Wang wrote:
> > diff --git a/samples/Kconfig b/samples/Kconfig
> > index c8dacb4dda80..13a2443e18e0 100644
> > --- a/samples/Kconfig
> > +++ b/samples/Kconfig
> > @@ -131,6 +131,16 @@ config SAMPLE_VFIO_MDEV_MDPY
> >  	  mediated device.  It is a simple framebuffer and supports
> >  	  the region display interface (VFIO_GFX_PLANE_TYPE_REGION).
> >  
> > +config SAMPLE_VIRTIO_MDEV_NET
> > +	tristate "Build VIRTIO net example mediated device sample code -- loadable modules only"
> > +	depends on VIRTIO_MDEV && VHOST_RING && m
> > +	help
> > +	  Build a networking sample device for use as a virtio
> > +	  mediated device. The device coopreates with virtio-mdev bus  
> 
> typo here:
> 	                              cooperates
> 

I can fix this on commit relative to V10 if there are no other issues
raised:

diff --git a/samples/Kconfig b/samples/Kconfig
index 13a2443e18e0..b7116d97cbbe 100644
--- a/samples/Kconfig
+++ b/samples/Kconfig
@@ -136,7 +136,7 @@ config SAMPLE_VIRTIO_MDEV_NET
        depends on VIRTIO_MDEV && VHOST_RING && m
        help
          Build a networking sample device for use as a virtio
-         mediated device. The device coopreates with virtio-mdev bus
+         mediated device. The device cooperates with virtio-mdev bus
          driver to present an virtio ethernet driver for
          kernel. It simply loopbacks all packets from its TX
          virtqueue to its RX virtqueue.

Thanks,
Alex
