From: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH 18/25] Staging: hv: Get rid of struct hv_bus
Date: Tue, 26 Apr 2011 13:58:05 -0700
Message-ID: <20110426205805.GC20381@suse.de>
References: <1303834785-4981-1-git-send-email-kys@microsoft.com>
	<1303834842-5022-1-git-send-email-kys@microsoft.com>
	<1303834842-5022-18-git-send-email-kys@microsoft.com>
	<20110426194031.GD17467@suse.de>
	<6E21E5352C11B742B20C142EB499E0481DD061@TK5EX14MBXC124.redmond.corp.microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
Content-Disposition: inline
In-Reply-To: <6E21E5352C11B742B20C142EB499E0481DD061@TK5EX14MBXC124.redmond.corp.microsoft.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Sender: devel-bounces@linuxdriverproject.org
Errors-To: devel-bounces@linuxdriverproject.org
To: KY Srinivasan <kys@microsoft.com>
Cc: "Abhishek Kane (Mindtree Consulting PVT  LTD)" <v-abkane@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Apr 26, 2011 at 08:23:25PM +0000, KY Srinivasan wrote:
> 
> 
> > -----Original Message-----
> > From: Greg KH [mailto:gregkh@suse.de]
> > Sent: Tuesday, April 26, 2011 3:41 PM
> > To: KY Srinivasan
> > Cc: linux-kernel@vger.kernel.org; devel@linuxdriverproject.org;
> > virtualization@lists.osdl.org; Haiyang Zhang; Abhishek Kane (Mindtree Consulting
> > PVT LTD); Hank Janssen
> > Subject: Re: [PATCH 18/25] Staging: hv: Get rid of struct hv_bus
> > 
> > On Tue, Apr 26, 2011 at 09:20:35AM -0700, K. Y. Srinivasan wrote:
> > > Now, get rid of struct hv_bus. We will no longer be embedding
> > > struct bus_type.
> > >
> > > Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
> > > Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> > > Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
> > > Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
> > > ---
> > >  drivers/staging/hv/vmbus_drv.c |   33 ++++++++++++++-------------------
> > >  1 files changed, 14 insertions(+), 19 deletions(-)
> > >
> > > diff --git a/drivers/staging/hv/vmbus_drv.c b/drivers/staging/hv/vmbus_drv.c
> > > index a3a7741..515311c 100644
> > > --- a/drivers/staging/hv/vmbus_drv.c
> > > +++ b/drivers/staging/hv/vmbus_drv.c
> > > @@ -45,11 +45,6 @@ static struct pci_dev *hv_pci_dev;
> > >  static struct tasklet_struct msg_dpc;
> > >  static struct tasklet_struct event_dpc;
> > >
> > > -/* Main vmbus driver data structure */
> > > -struct hv_bus {
> > > -	struct bus_type bus;
> > > -};
> > > -
> > >  unsigned int vmbus_loglevel = (ALL_MODULES << 16 | INFO_LVL);
> > >  EXPORT_SYMBOL(vmbus_loglevel);
> > >  	/* (ALL_MODULES << 16 | DEBUG_LVL_ENTEREXIT); */
> > > @@ -405,14 +400,14 @@ static void vmbus_device_release(struct device
> > *device)
> > >  }
> > >
> > >  /* The one and only one */
> > > -static struct hv_bus  hv_bus = {
> > > -	.bus.name =		"vmbus",
> > > -	.bus.match =		vmbus_match,
> > > -	.bus.shutdown =		vmbus_shutdown,
> > > -	.bus.remove =		vmbus_remove,
> > > -	.bus.probe =		vmbus_probe,
> > > -	.bus.uevent =		vmbus_uevent,
> > > -	.bus.dev_attrs =	vmbus_device_attrs,
> > > +static struct bus_type  hv_bus = {
> > > +	.name =		"vmbus",
> > > +	.match =		vmbus_match,
> > > +	.shutdown =		vmbus_shutdown,
> > > +	.remove =		vmbus_remove,
> > > +	.probe =		vmbus_probe,
> > > +	.uevent =		vmbus_uevent,
> > > +	.dev_attrs =	vmbus_device_attrs,
> > >  };
> > >
> > >  static const char *driver_name = "hyperv";
> > > @@ -550,14 +545,14 @@ static int vmbus_bus_init(struct pci_dev *pdev)
> > >  		goto cleanup;
> > >  	}
> > >
> > > -	hv_bus.bus.name = driver_name;
> > > +	hv_bus.name = driver_name;
> > 
> > Why are you setting the name of the bus again?  Shouldn't this line be
> > removed?
> 
> You are absolutely right. Since this redundancy was in the existing
> code, should I send you a separate patch to fix this?

A separate one after this series is fine.

thanks,

greg k-h
