From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 01/16] Staging: hv: Add the inclusion guard for vstorage.h
Date: Mon, 4 Apr 2011 21:29:02 -0700
Message-ID: <20110405042902.GE8090@kroah.com>
References: <1300902537-1290-1-git-send-email-kys@microsoft.com>
 <1300902635-1347-1-git-send-email-kys@microsoft.com>
 <20110405042805.GD8090@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20110405042805.GD8090@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org, Haiyang Zhang <haiyangz@microsoft.com>, Hank Janssen <hjanssen@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Apr 04, 2011 at 09:28:05PM -0700, Greg KH wrote:
> On Wed, Mar 23, 2011 at 10:50:19AM -0700, K. Y. Srinivasan wrote:
> > In preparation for getting rid of the inclusion of storvsc.c from
> > blkvsc.c, add inclusion guard to vstorage.h
> > 
> > Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
> > Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> > Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
> > ---
> >  drivers/staging/hv/vstorage.h |    5 +++++
> >  1 files changed, 5 insertions(+), 0 deletions(-)
> > 
> > diff --git a/drivers/staging/hv/vstorage.h b/drivers/staging/hv/vstorage.h
> > index ebb4d67..83060cd 100644
> > --- a/drivers/staging/hv/vstorage.h
> > +++ b/drivers/staging/hv/vstorage.h
> > @@ -25,6 +25,9 @@
> >  /* to alert the user that structure sizes may be mismatched even though the */
> >  /* protocol versions match. */
> >  
> > +#ifndef _VSTORAGE_H_
> > +#define _VSTORAGE_H_
> 
> What's with the trailing '_'?
> 
> Traditionally we've used __FOO_H for internal kernel header files.

Oh nevermind, I see that's how the other .h files in this directory
work, it's ok for now.

thanks,

greg k-h
