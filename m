From: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH 5/6] vringh: fix copy direction of vringh_iov_push_kern()
Date: Tue, 24 Sep 2019 08:04:13 -0600
Message-ID: <20190924080413.0cc875c5__42732.0037198783$1569333875$gmane$org@x1.home>
References: <20190923130331.29324-1-jasowang@redhat.com>
	<20190923130331.29324-6-jasowang@redhat.com>
	<20190923094559.765da494@x1.home>
	<20190923115930-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190923115930-mutt-send-email-mst@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: kvm@vger.kernel.org, airlied@linux.ie, joonas.lahtinen@linux.intel.com, heiko.carstens@de.ibm.com, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, kwankhede@nvidia.com, rob.miller@broadcom.com, linux-s390@vger.kernel.org, sebott@linux.ibm.com, lulu@redhat.com, eperezma@redhat.com, pasic@linux.ibm.com, borntraeger@de.ibm.com, haotian.wang@sifive.com, intel-gfx@lists.freedesktop.org, zhi.a.wang@intel.com, farman@linux.ibm.com, idos@mellanox.com, gor@linux.ibm.com, jani.nikula@linux.intel.com, rodrigo.vivi@intel.com, xiao.w.wang@intel.com, freude@linux.ibm.com, zhenyuw@linux.intel.com, parav@mellanox.com, zhihong.wang@intel.com, intel-gvt-dev@lists.freedesktop.org, akrowiak@linux.ibm.com, oberpar@linux.ibm.com, netdev@vger.kernel.org, cohuck@redhat.com, linux-kernel@vger.kernel.org, maxime.coquelin@redhat.com, daniel@ffwll.ch, lingshan.zhu@inte
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 23 Sep 2019 12:00:41 -0400
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Mon, Sep 23, 2019 at 09:45:59AM -0600, Alex Williamson wrote:
> > On Mon, 23 Sep 2019 21:03:30 +0800
> > Jason Wang <jasowang@redhat.com> wrote:
> >   
> > > We want to copy from iov to buf, so the direction was wrong.
> > > 
> > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > ---
> > >  drivers/vhost/vringh.c | 8 +++++++-
> > >  1 file changed, 7 insertions(+), 1 deletion(-)  
> > 
> > 
> > Why is this included in the series?  Seems like an unrelated fix being
> > held up within a proposal for a new feature.  Thanks,
> > 
> > Alex  
> 
> It's better to have it as patch 1/6, but it's a dependency of the
> example driver in the series. I can reorder when I apply.

It's a fix, please submit it separately through virtio/vhost channels,
then it will already be in the base kernel we use for the rest of the
series.  The remainder of the series certainly suggests a workflow
through the vfio tree rather than virtio/vhost.  Thanks,

Alex

> > > diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
> > > index 08ad0d1f0476..a0a2d74967ef 100644
> > > --- a/drivers/vhost/vringh.c
> > > +++ b/drivers/vhost/vringh.c
> > > @@ -852,6 +852,12 @@ static inline int xfer_kern(void *src, void *dst, size_t len)
> > >  	return 0;
> > >  }
> > >  
> > > +static inline int kern_xfer(void *dst, void *src, size_t len)
> > > +{
> > > +	memcpy(dst, src, len);
> > > +	return 0;
> > > +}
> > > +
> > >  /**
> > >   * vringh_init_kern - initialize a vringh for a kernelspace vring.
> > >   * @vrh: the vringh to initialize.
> > > @@ -958,7 +964,7 @@ EXPORT_SYMBOL(vringh_iov_pull_kern);
> > >  ssize_t vringh_iov_push_kern(struct vringh_kiov *wiov,
> > >  			     const void *src, size_t len)
> > >  {
> > > -	return vringh_iov_xfer(wiov, (void *)src, len, xfer_kern);
> > > +	return vringh_iov_xfer(wiov, (void *)src, len, kern_xfer);
> > >  }
> > >  EXPORT_SYMBOL(vringh_iov_push_kern);
> > >    
