From: KY Srinivasan <kys@microsoft.com>
Subject: RE: [PATCH 22/59] Staging: hv: vmbus: Get rid of the unused name
 field in struct hv_driver
Date: Thu, 25 Aug 2011 22:27:40 +0000
Message-ID: <6E21E5352C11B742B20C142EB499E048081B360E@TK5EX14MBXC126.redmond.corp.microsoft.com>
References: <1314290866-2644-1-git-send-email-kys@microsoft.com>
 <1314290965-2698-1-git-send-email-kys@microsoft.com>
 <1314290965-2698-22-git-send-email-kys@microsoft.com>
 <20110825212428.GA1617@kroah.com> <20110825212820.GA6770@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110825212820.GA6770@kroah.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: "gregkh@suse.de" <gregkh@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>, Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org



> -----Original Message-----
> From: Greg KH [mailto:greg@kroah.com]
> Sent: Thursday, August 25, 2011 5:28 PM
> To: KY Srinivasan
> Cc: gregkh@suse.de; linux-kernel@vger.kernel.org;
> devel@linuxdriverproject.org; virtualization@lists.osdl.org; Haiyang Zhang
> Subject: Re: [PATCH 22/59] Staging: hv: vmbus: Get rid of the unused name field
> in struct hv_driver
> 
> On Thu, Aug 25, 2011 at 02:24:28PM -0700, Greg KH wrote:
> > On Thu, Aug 25, 2011 at 09:48:48AM -0700, K. Y. Srinivasan wrote:
> > > Get rid of the unused "name" field in struct hv_driver.
> > >
> > > Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
> > > Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> > > ---
> > >  drivers/staging/hv/hyperv.h |    2 --
> > >  1 files changed, 0 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/staging/hv/hyperv.h b/drivers/staging/hv/hyperv.h
> > > index b8199f4..60ead66 100644
> > > --- a/drivers/staging/hv/hyperv.h
> > > +++ b/drivers/staging/hv/hyperv.h
> > > @@ -802,8 +802,6 @@ struct hv_device_info {
> > >
> > >  /* Base driver object */
> > >  struct hv_driver {
> > > -	const char *name;
> >
> > Wait, why is this unused?  What are you going to use as your name for
> > the driver in sysfs then?  The module name?
> >
> > As much as I love seeing things deleted, I really think you need this
> > field.
> >
> > Ah, yeah, I see why you think it's unneeded, crud like this in the
> > drivers:
> >
> > 	drv->driver.name = driver_name;
> >
> > No vmbus driver should ever have to touch the base struct driver on it's
> > own at all.  Your vmbus core should properly handle telling the driver
> > core what the name of the driver is.
> >
> > As an example, see the __pci_register_driver() function, the first thing
> > that code does is set the name based on the name of the larger
> > pci_driver structure passed to it.
> >
> > Man, if you want something done right, you have to do it yourself, let
> > me go make these changes so you don't have to do any new work at this
> > point in time, hopefully your other patches will apply...
> 
> What, vmbus_child_driver_register() takes a struct driver *?
> 
> No wonder things are so messed up here, and why you got confused.  Let
> me pound on this for a bit to see if I can get it cleaned up to be more
> "sane"...

Greg,

This was existing code and I realized it did not conform to the Linux
Driver Model. I fixed it in the patch set I had sent earlier (110/117).
Yesterday I only got up to 74 of the 117 patches that you commented on.
I was planning to send the rest today. If it is ok with you, please don't fix it here
As it would break everything else. This is existing code that I am fixing in the patch set
I will send you shortly.

Regards,

K. Y
> 
> greg k-h
