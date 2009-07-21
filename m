From: Greg KH <gregkh@suse.de>
Subject: Re: [patch 27/54] Staging: hv: remove ULONG and LONG typedefs
Date: Mon, 20 Jul 2009 19:38:23 -0700
Message-ID: <20090721023823.GA12154@suse.de>
References: <20090717180850.873962925@mini.kroah.org>
 <20090717180920.285605541@mini.kroah.org>
 <200907210200.16295.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754714AbZGUCs4@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200907210200.16295.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org, virtualization@lists.osdl.org, Greg KH <greg@kroah.com>, Sam Ramji <sramji@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Hank Janssen <hjanssen@microsoft.com>, shemminger@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jul 21, 2009 at 02:00:16AM +0200, Arnd Bergmann wrote:
> On Friday 17 July 2009, Greg Kroah-Hartman wrote:
> > From: Greg Kroah-Hartman <gregkh@suse.de>
> > 
> > The ULONG and LONG typedefs are now removed from the Hyper-V driver
> > code
> > 
> 
> This conversion is not equivalent:
> 
> >  //
> > -// unsigned types
> > -//
> > -typedef unsigned int		ULONG;
> > -
> > -//
> > -// signed types
> > -//
> > -typedef int					LONG;
> 
> - // redefine the world, because we can
> - extern char *i;
> - void abs(unsigned u);
> - #define FALSE (2)
> 
> ;-)
> 
> > --- a/drivers/staging/hv/include/StorVscApi.h
> > +++ b/drivers/staging/hv/include/StorVscApi.h
> > @@ -117,7 +117,7 @@ typedef struct _STORVSC_DRIVER_OBJECT {
> >  } STORVSC_DRIVER_OBJECT;
> >  
> >  typedef struct _STORVSC_DEVICE_INFO {
> > -	ULONG	PortNumber;
> > +	unsigned long	PortNumber;
> >      unsigned char	PathId;
> >      unsigned char	TargetId;
> >  } STORVSC_DEVICE_INFO;
> 
> If this is an API (as the header file name suggests), you just changed it.
> Same for the other hunks in this patch.

Ah crap, you're right, that's all wrong, nice catch.

I'll go redo it to be "unsigned int", but for some reason, the code
still seems to work properly :)

thanks,

greg k-h
