From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [patch 27/54] Staging: hv: remove ULONG and LONG typedefs
Date: Tue, 21 Jul 2009 02:00:16 +0200
Message-ID: <200907210200.16295.arnd@arndb.de>
References: <20090717180850.873962925@mini.kroah.org> <20090717180920.285605541@mini.kroah.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754629AbZGUAA0@vger.kernel.org>
In-Reply-To: <20090717180920.285605541@mini.kroah.org>
Sender: linux-kernel-owner@vger.kernel.org
To: virtualization@lists.linux-foundation.org
Cc: Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org, virtualization@lists.osdl.org, Greg KH <greg@kroah.com>, Sam Ramji <sramji@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Hank Janssen <hjanssen@microsoft.com>, shemminger@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Friday 17 July 2009, Greg Kroah-Hartman wrote:
> From: Greg Kroah-Hartman <gregkh@suse.de>
> 
> The ULONG and LONG typedefs are now removed from the Hyper-V driver
> code
> 

This conversion is not equivalent:

>  //
> -// unsigned types
> -//
> -typedef unsigned int		ULONG;
> -
> -//
> -// signed types
> -//
> -typedef int					LONG;

- // redefine the world, because we can
- extern char *i;
- void abs(unsigned u);
- #define FALSE (2)

;-)

> --- a/drivers/staging/hv/include/StorVscApi.h
> +++ b/drivers/staging/hv/include/StorVscApi.h
> @@ -117,7 +117,7 @@ typedef struct _STORVSC_DRIVER_OBJECT {
>  } STORVSC_DRIVER_OBJECT;
>  
>  typedef struct _STORVSC_DEVICE_INFO {
> -	ULONG	PortNumber;
> +	unsigned long	PortNumber;
>      unsigned char	PathId;
>      unsigned char	TargetId;
>  } STORVSC_DEVICE_INFO;

If this is an API (as the header file name suggests), you just changed it.
Same for the other hunks in this patch.

	Arnd <><
