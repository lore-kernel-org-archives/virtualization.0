From: KY Srinivasan <kys@microsoft.com>
Subject: RE: [PATCH 41/46] Staging: hv: vmbus: Fix a bug in error handling
 in vmbus_bus_init()
Date: Tue, 30 Aug 2011 17:07:34 +0000
Message-ID: <6E21E5352C11B742B20C142EB499E048081B5307@TK5EX14MBXC126.redmond.corp.microsoft.com>
References: <1314469874-7017-1-git-send-email-kys@microsoft.com>
 <1314469905-7058-1-git-send-email-kys@microsoft.com>
 <1314469905-7058-41-git-send-email-kys@microsoft.com>
 <20110829180842.GA23618@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110829180842.GA23618@kroah.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: "gregkh@suse.de" <gregkh@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>, Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org



> -----Original Message-----
> From: Greg KH [mailto:greg@kroah.com]
> Sent: Monday, August 29, 2011 2:09 PM
> To: KY Srinivasan
> Cc: gregkh@suse.de; linux-kernel@vger.kernel.org;
> devel@linuxdriverproject.org; virtualization@lists.osdl.org; Haiyang Zhang
> Subject: Re: [PATCH 41/46] Staging: hv: vmbus: Fix a bug in error handling in
> vmbus_bus_init()
> 
> On Sat, Aug 27, 2011 at 11:31:40AM -0700, K. Y. Srinivasan wrote:
> > Fix a bug in error handling in vmbus_bus_init().
> >
> > Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
> > Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> > ---
> >  drivers/staging/hv/vmbus_drv.c |   21 ++++++++++-----------
> >  1 files changed, 10 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/staging/hv/vmbus_drv.c b/drivers/staging/hv/vmbus_drv.c
> > index 02edb11..4d1b123 100644
> > --- a/drivers/staging/hv/vmbus_drv.c
> > +++ b/drivers/staging/hv/vmbus_drv.c
> > @@ -492,7 +492,7 @@ static int vmbus_bus_init(int irq)
> >
> >  	ret = bus_register(&hv_bus);
> >  	if (ret)
> > -		return ret;
> > +		goto err1;
> >
> >  	ret = request_irq(irq, vmbus_isr, IRQF_SAMPLE_RANDOM,
> >  			driver_name, hv_acpi_dev);
> > @@ -500,10 +500,7 @@ static int vmbus_bus_init(int irq)
> >  	if (ret != 0) {
> >  		pr_err("Unable to request IRQ %d\n",
> >  			   irq);
> > -
> > -		bus_unregister(&hv_bus);
> > -
> > -		return ret;
> > +		goto err2;
> >  	}
> >
> >  	vector = IRQ0_VECTOR + irq;
> > @@ -514,16 +511,18 @@ static int vmbus_bus_init(int irq)
> >  	 */
> >  	on_each_cpu(hv_synic_init, (void *)&vector, 1);
> >  	ret = vmbus_connect();
> > -	if (ret) {
> > -		free_irq(irq, hv_acpi_dev);
> > -		bus_unregister(&hv_bus);
> > -		return ret;
> > -	}
> > -
> > +	if (ret)
> > +		goto err3;
> >
> >  	vmbus_request_offers();
> >
> >  	return 0;
> > +
> > +err3:	free_irq(irq, hv_acpi_dev);
> > +err2:	bus_unregister(&hv_bus);
> > +err1:	hv_cleanup();
> 
> The traditional way to write this is:
> 
> err3:
> 	free_irq(irq, hv_acpi_dev);
> err2:
> 	bus_unregister(&hv_bus);
> err1:
> 	hv_cleanup();
> 
> Care to fix this up and resend it?

Will do.

Regards,

K. Y
