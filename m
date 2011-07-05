From: KY Srinivasan <kys@microsoft.com>
Subject: RE: [PATCH 75/77] Staging: hv: mouse: Disable auto-loading of the
 mouse driver
Date: Tue, 5 Jul 2011 16:10:46 +0000
Message-ID: <6E21E5352C11B742B20C142EB499E0480816CCA8@TK5EX14MBXC126.redmond.corp.microsoft.com>
References: <1308255393-3785-1-git-send-email-kys@microsoft.com>
 <1308255470-3826-1-git-send-email-kys@microsoft.com>
 <1308255470-3826-75-git-send-email-kys@microsoft.com>
 <20110705155745.GA31998@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110705155745.GA31998@kroah.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: "gregkh@suse.de" <gregkh@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>, Haiyang Zhang <haiyangz@microsoft.com>, Hank Janssen <hjanssen@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org



> -----Original Message-----
> From: Greg KH [mailto:greg@kroah.com]
> Sent: Tuesday, July 05, 2011 11:58 AM
> To: KY Srinivasan
> Cc: gregkh@suse.de; linux-kernel@vger.kernel.org;
> devel@linuxdriverproject.org; virtualization@lists.osdl.org; Haiyang Zhang; Hank
> Janssen
> Subject: Re: [PATCH 75/77] Staging: hv: mouse: Disable auto-loading of the
> mouse driver
> 
> On Thu, Jun 16, 2011 at 01:17:48PM -0700, K. Y. Srinivasan wrote:
> > Disable auto-loading of the mouse driver.
> >
> > Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
> > Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> > Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
> > ---
> >  drivers/staging/hv/hv_mouse.c |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> >
> > diff --git a/drivers/staging/hv/hv_mouse.c b/drivers/staging/hv/hv_mouse.c
> > index 1b30f26..ab5f1da 100644
> > --- a/drivers/staging/hv/hv_mouse.c
> > +++ b/drivers/staging/hv/hv_mouse.c
> > @@ -950,7 +950,7 @@ static void __exit mousevsc_exit(void)
> >
> >  MODULE_LICENSE("GPL");
> >  MODULE_VERSION(HV_DRV_VERSION);
> > -MODULE_ALIAS("vmbus:hv_mouse");
> > +/*MODULE_ALIAS("vmbus:hv_mouse");*/
> 
> Why?
> 
> {hint, I think I know why, but you need to tell us why in the changelog
> comment}
> 
> Dropped.

I will re-submit this with appropriate comments. Have you also dropped
all remaining patches  submitted in this patch-set as well as the patch-set
that I had submitted subsequently. 

Regards,

K. Y
 
