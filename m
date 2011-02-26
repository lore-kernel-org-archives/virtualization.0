From: KY Srinivasan <kys@microsoft.com>
Subject: RE: [PATCH 6/6] Staging: hv: Cleanup hyperv_driver variable names
Date: Sat, 26 Feb 2011 17:13:22 +0000
Message-ID: <6E21E5352C11B742B20C142EB499E048015773@TK5EX14MBXC128.redmond.corp.microsoft.com>
References: <1298686078-30945-1-git-send-email-kys@microsoft.com>
 <20110226034039.GE18043@bicker>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110226034039.GE18043@bicker>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Carpenter <error27@gmail.com>
Cc: "gregkh@suse.de" <gregkh@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org



> -----Original Message-----
> From: Dan Carpenter [mailto:error27@gmail.com]
> Sent: Friday, February 25, 2011 10:41 PM
> To: KY Srinivasan
> Cc: gregkh@suse.de; linux-kernel@vger.kernel.org;
> devel@linuxdriverproject.org; virtualization@lists.osdl.org
> Subject: Re: [PATCH 6/6] Staging: hv: Cleanup hyperv_driver variable names
> 
> On Fri, Feb 25, 2011 at 06:07:58PM -0800, K. Y. Srinivasan wrote:
> > The title says it all.
> >
> 
> For this patch the rename_rev.pl command is:
> 
> rename_rev.pl -nc -e 's/(drv|driver)_ctx/drv/g'
> 
> > --- a/drivers/staging/hv/vmbus_drv.c
> > +++ b/drivers/staging/hv/vmbus_drv.c
> > @@ -46,7 +46,7 @@ struct vmbus_hyperv_driver {
> >  	/* FIXME, this is a bug */
> >  	/* The driver field is not used in here. Instead, the bus field is */
> >  	/* used to represent the driver */
>         ^^
> This comment out of date now that we're using container_of().
This requirement is for a different reason. We had patch out last Wednesday
To address this but was rejected by Greg for other reasons.
What is happening here is that in the vmbus_match function we 
need to get at a certain field in a driver agnostic way. This hack solves
the problem. It will be removed once this series goes in.

> 
> > -	struct hyperv_driver drv_ctx;
> > +	struct hyperv_driver dummy;
>                              ^^^^^
> Delete.

This is the hack I talked about earlier. This will go away
once this series goes in.

> 
> > @@ -849,18 +849,18 @@ static int vmbus_uevent(struct device *device, struct
> kobj_uevent_env *env)
> >  static int vmbus_match(struct device *device, struct device_driver *driver)
> >  {
> >  	int match = 0;
> > -	struct hyperv_driver *driver_ctx = driver_to_hyperv_driver(driver);
> > +	struct hyperv_driver *drv = driver_to_hyperv_driver(driver);
> >  	struct hyperv_device *device_obj = device_to_hyperv_device(device);
> >
> >  	/* We found our driver ? */
> > -	if (memcmp(&device_obj->class_id, &driver_ctx->class_id,
> > +	if (memcmp(&device_obj->class_id, &drv->class_id,
> >  		   sizeof(struct hv_guid)) == 0) {
> >  		/*
> > -		 * !! NOTE: The driver_ctx is not a vmbus_drv_ctx. We typecast
> > +		 * !! NOTE: The drv is not a vmbus_drv_ctx. We typecast
>                                                       ^^^^
> Out of date.
This hack is still required. We will get rid of this shortly.

Regards,

K. Y
> 
> regards,
> dan carpenter
