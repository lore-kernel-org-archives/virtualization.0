From: KY Srinivasan <kys@microsoft.com>
Subject: RE: [PATCH 086/117] Staging: hv: storvsc: Leverage the spinlock to
 manage ref_cnt
Date: Wed, 24 Aug 2011 16:25:18 +0000
Message-ID: <6E21E5352C11B742B20C142EB499E048081B2789@TK5EX14MBXC126.redmond.corp.microsoft.com>
References: <1310752024-27854-1-git-send-email-kys@microsoft.com>
 <1310752065-27895-1-git-send-email-kys@microsoft.com>
 <1310752065-27895-86-git-send-email-kys@microsoft.com>
 <20110823231028.GO9641@kroah.com>
 <6E21E5352C11B742B20C142EB499E048081B239E@TK5EX14MBXC126.redmond.corp.microsoft.com>
 <20110824025737.GA30779@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110824025737.GA30779@kroah.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: "gregkh@suse.de" <gregkh@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>, Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org



> -----Original Message-----
> From: Greg KH [mailto:greg@kroah.com]
> Sent: Tuesday, August 23, 2011 10:58 PM
> To: KY Srinivasan
> Cc: gregkh@suse.de; linux-kernel@vger.kernel.org;
> devel@linuxdriverproject.org; virtualization@lists.osdl.org; Haiyang Zhang
> Subject: Re: [PATCH 086/117] Staging: hv: storvsc: Leverage the spinlock to
> manage ref_cnt
> 
> On Wed, Aug 24, 2011 at 12:58:36AM +0000, KY Srinivasan wrote:
> >
> >
> > > -----Original Message-----
> > > From: Greg KH [mailto:greg@kroah.com]
> > > Sent: Tuesday, August 23, 2011 7:10 PM
> > > To: KY Srinivasan
> > > Cc: gregkh@suse.de; linux-kernel@vger.kernel.org;
> > > devel@linuxdriverproject.org; virtualization@lists.osdl.org; Haiyang Zhang
> > > Subject: Re: [PATCH 086/117] Staging: hv: storvsc: Leverage the spinlock to
> > > manage ref_cnt
> > >
> > > On Fri, Jul 15, 2011 at 10:47:14AM -0700, K. Y. Srinivasan wrote:
> > > > Now that we have a spin lock protecting access to the stor device pointer,
> > > > use it manage the reference count as well.
> > > >
> > > > Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
> > > > Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> > > > ---
> > > >  drivers/staging/hv/hyperv_storage.h |    8 ++++----
> > > >  drivers/staging/hv/storvsc.c        |   10 +++++-----
> > > >  2 files changed, 9 insertions(+), 9 deletions(-)
> > > >
> > > > diff --git a/drivers/staging/hv/hyperv_storage.h
> > > b/drivers/staging/hv/hyperv_storage.h
> > > > index 53b65be..d946211 100644
> > > > --- a/drivers/staging/hv/hyperv_storage.h
> > > > +++ b/drivers/staging/hv/hyperv_storage.h
> > > > @@ -265,7 +265,7 @@ struct storvsc_device {
> > > >  	struct hv_device *device;
> > > >
> > > >  	/* 0 indicates the device is being destroyed */
> > > > -	atomic_t ref_count;
> > > > +	int	 ref_count;
> > >
> > > Is this really needed?  Can't you rely on the reference count of the
> > > hv_device itself?
> >
> > We don't have a reference count on the hv_device
> 
> Wait, why not?  You shure better have a reference count on that device
> if you have a pointer to it, if not, you have a bug, and that needs to
> be fixed.  Please reread Documentation/CodingStyle for details.

Greg,

I am confused here. The model we have is identical to other device/bus
abstractions in the kernel. For instance, neither  struct pci_dev nor struct
virtio_device have an explicit reference count. However, they both embed
struct device which  has the kobject structure embedded to manage
the object life cycle. This is exactly the model we have for the vmbus devices -
struct hv_device embeds struct device that embeds the struct kobject for
managing the lifecycle.

Like other  bus specific devices in the kernel (pci devices, virtio devices,),  
class specific vmbus devices - struct storvsc_device and struct netvsc_device 
embed a pointer to the underlying struct hv_device. Furthermore, a pointer to 
the class specific device structure is stashed in the struct hv_device (the ext pointer).
This is identical what is done in the virtio blk device - look at the priv element in struct virtio_device.

As I noted in a different email, I did not introduce this reference counting, I just fixed some gaping 
holes in the logic. The reason, I fixed the logic and kept the reference counting is because I can 
see cases where we could end up de-referencing a NULL pointer from the interrupt side that is
trying to deliver a vmbus packet to a device that is being destroyed. 

Regards,

K. Y

> 
> > and this count is taken to deal with racing unloads and incoming
> > traffic on the channel from the host.
> 
> Is this something that all other storage drivers have to do?  If not,
> then you shouldn't be doing that as well.
> 
> greg k-h
