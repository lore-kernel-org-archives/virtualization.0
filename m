From: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Subject: Re: [RFC 12/12] rpmsg: add a device ID to also bind to the ADSP device
Date: Mon, 8 Jun 2020 19:02:27 +0200
Message-ID: <20200608170227.GG10562@ubuntu>
References: <20200529073722.8184-1-guennadi.liakhovetski@linux.intel.com>
 <20200529073722.8184-13-guennadi.liakhovetski@linux.intel.com>
 <20200604200156.GB26734@xps15> <20200605064659.GC32302@ubuntu>
 <20200608161757.GA32518@xps15>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20200608161757.GA32518@xps15>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Ohad Ben-Cohen <ohad@wizery.com>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, linux-remoteproc@vger.kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, virtualization@lists.linux-foundation.org, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, sound-open-firmware@alsa-project.org
List-Id: virtualization@lists.linuxfoundation.org

Hi Mathieu,

On Mon, Jun 08, 2020 at 10:17:57AM -0600, Mathieu Poirier wrote:
> On Fri, Jun 05, 2020 at 08:46:59AM +0200, Guennadi Liakhovetski wrote:
> > Hi Mathieu,
> > 
> > On Thu, Jun 04, 2020 at 02:01:56PM -0600, Mathieu Poirier wrote:
> > > On Fri, May 29, 2020 at 09:37:22AM +0200, Guennadi Liakhovetski wrote:
> > > > The ADSP device uses the RPMsg API to connect vhost and VirtIO SOF
> > > > Audio DSP drivers on KVM host and guest.
> > > > 
> > > > Signed-off-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
> > > > ---
> > > >  drivers/rpmsg/virtio_rpmsg_bus.c | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > > 
> > > > diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
> > > > index f3bd050..ebe3f19 100644
> > > > --- a/drivers/rpmsg/virtio_rpmsg_bus.c
> > > > +++ b/drivers/rpmsg/virtio_rpmsg_bus.c
> > > > @@ -949,6 +949,7 @@ static void rpmsg_remove(struct virtio_device *vdev)
> > > >  
> > > >  static struct virtio_device_id id_table[] = {
> > > >  	{ VIRTIO_ID_RPMSG, VIRTIO_DEV_ANY_ID },
> > > > +	{ VIRTIO_ID_ADSP, VIRTIO_DEV_ANY_ID },
> > > 
> > > I am fine with this patch but won't add an RB because of the (many) checkpatch
> > > errors.  Based on the comment I made on the previous set seeing those was
> > > unexpected.
> > 
> > Are you using "--strict?" Sorry, I don't see any checkpatch errors, only warnings. 
> 
> No, plane checkpatch on the rproc-next branch.
> 
> > Most of them are "over 80 characters" which as we now know is no more an issue,
> 
> There is a thread discussing the matter but I have not seen a clear resolution
> yet.

I think the resolution is pretty clear as defined by Linus, but maybe it has changed 
again since I last checked.

> > I just haven't updated my tree yet. Most others are really minor IMHO. Maybe one
> 
> Minor or not, if checkpatch complains then it is important enough to address.  I
> am willing to overlook the lines over 80 characters but everything else needs to
> be dealt with.

Sure, checkpatch should be run before each patch submission and whatever it reports 
should be considered. As Documentation/process/submitting-patches.rst clearly 
states:

"Check your patches with the patch style checker prior to submission
(scripts/checkpatch.pl).  Note, though, that the style checker should be
viewed as a guide, not as a replacement for human judgment.  If your code
looks better with a violation then its probably best left alone."

So, yes, I checked all what checkepatch reported and used my judgement to decide 
which recommendations to take and which to ignore.

Thanks
Guennadi

> Thanks,
> Mathieu
>  
> > of them I actually would want to fix - using "help" instead of "---help---" in 
> > Kconfig. What errors are you seeing in your checks?
> > 
> > Thanks
> > Guennadi
> > 
> > > Thanks,
> > > Mathieu
> > > 
> > > >  	{ 0 },
> > > >  };
> > > >  
> > > > -- 
> > > > 1.9.3
> > > > 
