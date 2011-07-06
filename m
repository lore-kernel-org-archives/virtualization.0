From: KY Srinivasan <kys@microsoft.com>
Subject: RE: [PATCH 15/77] Staging: hv: blkvsc: Add the appropriate
 MODULE_ALIAS() line
Date: Wed, 6 Jul 2011 00:40:42 +0000
Message-ID: <6E21E5352C11B742B20C142EB499E0480816D27E@TK5EX14MBXC126.redmond.corp.microsoft.com>
References: <1308255393-3785-1-git-send-email-kys@microsoft.com>
 <1308255470-3826-1-git-send-email-kys@microsoft.com>
 <1308255470-3826-15-git-send-email-kys@microsoft.com>
 <20110705160621.GC7214@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110705160621.GC7214@kroah.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: "gregkh@suse.de" <gregkh@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>, Haiyang Zhang <haiyangz@microsoft.com>, Hank Janssen <hjanssen@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org



> -----Original Message-----
> From: Greg KH [mailto:greg@kroah.com]
> Sent: Tuesday, July 05, 2011 12:06 PM
> To: KY Srinivasan
> Cc: gregkh@suse.de; linux-kernel@vger.kernel.org;
> devel@linuxdriverproject.org; virtualization@lists.osdl.org; Haiyang Zhang; Hank
> Janssen
> Subject: Re: [PATCH 15/77] Staging: hv: blkvsc: Add the appropriate
> MODULE_ALIAS() line
> 
> On Thu, Jun 16, 2011 at 01:16:48PM -0700, K. Y. Srinivasan wrote:
> > Add the appropriate MODULE_ALIAS() line to support auto-loading.
> >
> > Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
> > Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> > Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
> > ---
> >  drivers/staging/hv/blkvsc_drv.c |    1 +
> >  1 files changed, 1 insertions(+), 0 deletions(-)
> >
> > diff --git a/drivers/staging/hv/blkvsc_drv.c b/drivers/staging/hv/blkvsc_drv.c
> > index 5842db8..9496abe 100644
> > --- a/drivers/staging/hv/blkvsc_drv.c
> > +++ b/drivers/staging/hv/blkvsc_drv.c
> > @@ -1027,5 +1027,6 @@ static void __exit blkvsc_exit(void)
> >  MODULE_LICENSE("GPL");
> >  MODULE_VERSION(HV_DRV_VERSION);
> >  MODULE_DESCRIPTION("Microsoft Hyper-V virtual block driver");
> > +MODULE_ALIAS("vmbus:hv_block");
> 
> No, these should be automagically generated with the MODULE_DEVICE_ID()
> macro that you use in the module with the GUID there, instead of this.

I think you mean MODULE_DEVICE_TABLE()? I actually went down that path first
adding code  to  file2alias.c for parsing the vmbus ID table. Given that this approach
would make it  impossible to support auto-loading of these drivers
on many of the released kernels, I chose to go with the MODULE_ALIAS() macro
that did not need any changes outside our drivers. In both methods, the formatting
of the name is bus specific since I would be writing the code to parse the table in
file2alias.c.

Granted, I have been quite unimaginative in my alias names, but I thought they were
reasonably descriptive. If at all possible, for the reasons listed above, I would prefer to use
the MODULE_ALIAS() macro (I could embed all or part of the guid in the alias). Let me know.

Regards,

K. Y  
