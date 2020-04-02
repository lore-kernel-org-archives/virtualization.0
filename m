From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2] vhost: drop vring dependency on iotlb
Date: Thu, 2 Apr 2020 12:27:09 -0400
Message-ID: <20200402122544-mutt-send-email-mst@kernel.org>
References: <20200402144519.34194-1-mst@redhat.com>
 <44f9b9d3-3da2-fafe-aa45-edd574dc6484@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <44f9b9d3-3da2-fafe-aa45-edd574dc6484@redhat.com>
Sender: kvm-owner@vger.kernel.org
To: Jason Wang <jasowang@redhat.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, netdev@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Apr 02, 2020 at 11:01:13PM +0800, Jason Wang wrote:
> 
> On 2020/4/2 下午10:46, Michael S. Tsirkin wrote:
> > vringh can now be built without IOTLB.
> > Select IOTLB directly where it's used.
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> > 
> > Applies on top of my vhost tree.
> > Changes from v1:
> > 	VDPA_SIM needs VHOST_IOTLB
> 
> 
> It looks to me the patch is identical to v1.
> 
> Thanks


you are right. I squashed the description into
    virtio/test: fix up after IOTLB changes
take a look at it in the vhost tree.

> 
> > 
> >   drivers/vdpa/Kconfig  | 1 +
> >   drivers/vhost/Kconfig | 1 -
> >   2 files changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/vdpa/Kconfig b/drivers/vdpa/Kconfig
> > index 7db1460104b7..08b615f2da39 100644
> > --- a/drivers/vdpa/Kconfig
> > +++ b/drivers/vdpa/Kconfig
> > @@ -17,6 +17,7 @@ config VDPA_SIM
> >   	depends on RUNTIME_TESTING_MENU
> >   	select VDPA
> >   	select VHOST_RING
> > +	select VHOST_IOTLB
> >   	default n
> >   	help
> >   	  vDPA networking device simulator which loop TX traffic back
> > diff --git a/drivers/vhost/Kconfig b/drivers/vhost/Kconfig
> > index f0404ce255d1..cb6b17323eb2 100644
> > --- a/drivers/vhost/Kconfig
> > +++ b/drivers/vhost/Kconfig
> > @@ -8,7 +8,6 @@ config VHOST_IOTLB
> >   config VHOST_RING
> >   	tristate
> > -	select VHOST_IOTLB
> >   	help
> >   	  This option is selected by any driver which needs to access
> >   	  the host side of a virtio ring.
