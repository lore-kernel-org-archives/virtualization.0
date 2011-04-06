From: Hank Janssen <hjanssen@microsoft.com>
Subject: RE: [PATCH 07/07] Replaced printk with pr_info in hv_timesource
Date: Wed, 6 Apr 2011 00:14:08 +0000
Message-ID: <8AFC7968D54FB448A30D8F38F259C5624984B5C0@TK5EX14MBXC120.redmond.corp.microsoft.com>
References: <1301432330-1705-1-git-send-email-hjanssen@microsoft.com>
 <1301432330-1705-8-git-send-email-hjanssen@microsoft.com>
 <20110405050045.GA4663@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110405050045.GA4663@kroah.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>, "gregkh@suse.de" <gregkh@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>, KY Srinivasan <kys@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org



> -----Original Message-----
> From: Greg KH [mailto:greg@kroah.com]
> Sent: Monday, April 04, 2011 10:01 PM
> To: Hank Janssen
> Cc: Haiyang Zhang; gregkh@suse.de; linux-kernel@vger.kernel.org;
> devel@linuxdriverproject.org; virtualization@lists.osdl.org; KY Srinivasan
> Subject: Re: [PATCH 07/07] Replaced printk with pr_info in hv_timesource
> 
> >  #include <linux/version.h>
> >  #include <linux/clocksource.h>
> > @@ -91,7 +92,7 @@ static int __init init_hv_clocksource(void)
> >  	if (!dmi_check_system(hv_timesource_dmi_table))
> >  		return -ENODEV;
> >
> > -	printk(KERN_INFO "Registering HyperV clock source\n");
> > +	pr_info("Registering HyperV clock source\n");
> 
> Why is this line even needed at all?  Please remove it in future patches.
> 

Of course, since there have been so many changes I will wait a day or two 
To get stuff settled in staging and I will send the patch to remove it.

Hank.
