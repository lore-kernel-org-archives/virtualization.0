From: KY Srinivasan <kys@microsoft.com>
Subject: RE: [PATCH 3/6] Staging: hv: Cleanup hyperv_device variable names
Date: Sat, 26 Feb 2011 17:13:31 +0000
Message-ID: <6E21E5352C11B742B20C142EB499E048015780@TK5EX14MBXC128.redmond.corp.microsoft.com>
References: <1298685992-30864-1-git-send-email-kys@microsoft.com>
 <20110226033323.GD18043@bicker>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110226033323.GD18043@bicker>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Carpenter <error27@gmail.com>
Cc: "gregkh@suse.de" <gregkh@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org



> -----Original Message-----
> From: Dan Carpenter [mailto:error27@gmail.com]
> Sent: Friday, February 25, 2011 10:33 PM
> To: KY Srinivasan
> Cc: gregkh@suse.de; linux-kernel@vger.kernel.org;
> devel@linuxdriverproject.org; virtualization@lists.osdl.org
> Subject: Re: [PATCH 3/6] Staging: hv: Cleanup hyperv_device variable names
> 
> On Fri, Feb 25, 2011 at 06:06:32PM -0800, K. Y. Srinivasan wrote:
> > Cleanup the names of variables that refer to the
> > hyperv_device abstraction.
> >
> 
> I have a script I run on rename patches.  For this patch the
> command would be:
> 
> rename_rev.pl -nc -e 's/device_ctx/device_obj/g' -e 's/\bdev_ctx/dev/g'
> 
> It show one variable was missed in storvsc_probe().
> 
> >  	memset(host_device_ctx, 0, sizeof(struct host_device_context));
> >
> >  	host_device_ctx->port = host->host_no;
> > -	host_device_ctx->device_ctx = device_obj;
> > +	host_device_ctx->device_obj = device_obj;
> >
> >  	host_device_ctx->request_pool =
> >  				kmem_cache_create(dev_name(&device_obj-
> >device),
> > @@ -271,7 +271,7 @@ static int storvsc_probe(struct device *device)
> >  		return -1;
> >  	}
> >
> > -	/* host_device_ctx->port = device_info.PortNumber; */
> > +	/* host_hyperv_dev->port = device_info.PortNumber; */
> >  	host_device_ctx->path = device_info.path_id;
> >  	host_device_ctx->target = device_info.target_id;
> >
> 
> All the other host_device_ctx variables were renamed to host_device_obj.

host_device_ctx is a scsi abstraction built on top of the hyperv_device
abstraction. My goal was not to change the names of higher level scsi
abstractions.

Regards,

K. Y
> 
> regards,
> dan carpenter
