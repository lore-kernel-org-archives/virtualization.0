From: KY Srinivasan <kys@microsoft.com>
Subject: RE: [PATCH 10/21] Staging: hv: Cleanup root device handling
Date: Mon, 14 Mar 2011 19:54:29 +0000
Message-ID: <6E21E5352C11B742B20C142EB499E048019582@TK5EX14MBXC128.redmond.corp.microsoft.com>
References: <1299794886-1200-1-git-send-email-kys@microsoft.com>
 <20110314193333.GA18944@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110314193333.GA18944@kroah.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: "gregkh@suse.de" <gregkh@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>, Haiyang Zhang <haiyangz@microsoft.com>, Mike Sterling <Mike.Sterling@microsoft.com>, "Abhishek Kane (Mindtree Consulting PVT LTD)" <v-abkane@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org



> -----Original Message-----
> From: Greg KH [mailto:greg@kroah.com]
> Sent: Monday, March 14, 2011 3:34 PM
> To: KY Srinivasan
> Cc: gregkh@suse.de; linux-kernel@vger.kernel.org;
> devel@linuxdriverproject.org; virtualization@lists.osdl.org; Haiyang Zhang; Mike
> Sterling; Abhishek Kane (Mindtree Consulting PVT LTD)
> Subject: Re: [PATCH 10/21] Staging: hv: Cleanup root device handling
> 
> On Thu, Mar 10, 2011 at 02:08:06PM -0800, K. Y. Srinivasan wrote:
> > Now we can complete the cleanup of the root device
> > management. Use the preferred APIs for creating and
> > managing the root device. As part of this cleanup get rid
> > of the root device object from vmbus_driver_context.
> 
> I don't understand, what is the "root device"?

This would be the device under /sys/devices that all 
other hyperv devices would be grouped under. 
This notion of the root device existed in the existing
code; however  its creation and management was
unnecessarily complicated. 

Regards,

K. Y

> 
> The hyper-v "bus controller"?
> 
> >
> > Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
> > Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> > Signed-off-by: Mike Sterling <mike.sterling@microsoft.com>
> > Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
> > Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
> > ---
> >  drivers/staging/hv/vmbus_drv.c |  126 ++++++----------------------------------
> >  1 files changed, 18 insertions(+), 108 deletions(-)
> >
> > diff --git a/drivers/staging/hv/vmbus_drv.c b/drivers/staging/hv/vmbus_drv.c
> > index b473f46..8b9394a 100644
> > --- a/drivers/staging/hv/vmbus_drv.c
> > +++ b/drivers/staging/hv/vmbus_drv.c
> > @@ -19,6 +19,7 @@
> >   *   Hank Janssen  <hjanssen@microsoft.com>
> >   */
> >  #include <linux/init.h>
> > +#include <linux/err.h>
> >  #include <linux/module.h>
> >  #include <linux/device.h>
> >  #include <linux/irq.h>
> > @@ -40,6 +41,8 @@
> >  #define VMBUS_IRQ		0x5
> >  #define VMBUS_IRQ_VECTOR	IRQ5_VECTOR
> >
> > +static struct device *root_dev; /* Root device */
> 
> This shouldn't be a "raw" struct device, should it?  It should be of a
> type that shows exactly what it is.  Is it a hyper_v device that talks
> on the bus?
> 
> Or is it a "platform" device that controls all of the devices on the
> bus, and as such should be the "root" device of the bus tree?
> 
> confused,
> 
> greg k-h
