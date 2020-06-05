From: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Subject: Re: [RFC 12/12] rpmsg: add a device ID to also bind to the ADSP
 device
Date: Fri, 5 Jun 2020 08:46:59 +0200
Message-ID: <20200605064659.GC32302@ubuntu>
References: <20200529073722.8184-1-guennadi.liakhovetski@linux.intel.com>
 <20200529073722.8184-13-guennadi.liakhovetski@linux.intel.com>
 <20200604200156.GB26734@xps15>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200604200156.GB26734@xps15>
Sender: kvm-owner@vger.kernel.org
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: kvm@vger.kernel.org, linux-remoteproc@vger.kernel.org, virtualization@lists.linux-foundation.org, sound-open-firmware@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Ohad Ben-Cohen <ohad@wizery.com>, Bjorn Andersson <bjorn.andersson@linaro.org>
List-Id: virtualization@lists.linuxfoundation.org

Hi Mathieu,

On Thu, Jun 04, 2020 at 02:01:56PM -0600, Mathieu Poirier wrote:
> On Fri, May 29, 2020 at 09:37:22AM +0200, Guennadi Liakhovetski wrote:
> > The ADSP device uses the RPMsg API to connect vhost and VirtIO SOF
> > Audio DSP drivers on KVM host and guest.
> > 
> > Signed-off-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
> > ---
> >  drivers/rpmsg/virtio_rpmsg_bus.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
> > index f3bd050..ebe3f19 100644
> > --- a/drivers/rpmsg/virtio_rpmsg_bus.c
> > +++ b/drivers/rpmsg/virtio_rpmsg_bus.c
> > @@ -949,6 +949,7 @@ static void rpmsg_remove(struct virtio_device *vdev)
> >  
> >  static struct virtio_device_id id_table[] = {
> >  	{ VIRTIO_ID_RPMSG, VIRTIO_DEV_ANY_ID },
> > +	{ VIRTIO_ID_ADSP, VIRTIO_DEV_ANY_ID },
> 
> I am fine with this patch but won't add an RB because of the (many) checkpatch
> errors.  Based on the comment I made on the previous set seeing those was
> unexpected.

Are you using "--strict?" Sorry, I don't see any checkpatch errors, only warnings. 
Most of them are "over 80 characters" which as we now know is no more an issue, 
I just haven't updated my tree yet. Most others are really minor IMHO. Maybe one 
of them I actually would want to fix - using "help" instead of "---help---" in 
Kconfig. What errors are you seeing in your checks?

Thanks
Guennadi

> Thanks,
> Mathieu
> 
> >  	{ 0 },
> >  };
> >  
> > -- 
> > 1.9.3
> > 
