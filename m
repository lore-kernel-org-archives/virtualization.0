From: Hank Janssen <hjanssen@microsoft.com>
Subject: RE: [patch 27/54] Staging: hv: remove ULONG and LONG typedefs
Date: Tue, 21 Jul 2009 00:44:55 +0000
Message-ID: <8AFC7968D54FB448A30D8F38F259C56209A3A56B@TK5EX14MBXC114.redmond.corp.microsoft.com>
References: <20090717180850.873962925@mini.kroah.org>
	<20090717180920.285605541@mini.kroah.org>
	<200907210200.16295.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200907210200.16295.arnd@arndb.de>
Content-Language: en-US
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Arnd Bergmann <arnd@arndb.de>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
Cc: "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>, Greg KH <greg@kroah.com>, Haiyang Zhang <haiyangz@microsoft.com>, Greg Kroah-Hartman <gregkh@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>, Sam Ramji <sramji@microsoft.com>, "shemminger@linux-foundation.org" <shemminger@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org



Arnd,

Thanks for this and the other mails reviewing the code.

My TODO list keeps on getting bigger :). I will check into all of these and correct them.

Keep them coming!

Thanks!

Hank.


-----Original Message-----
From: Arnd Bergmann [mailto:arnd@arndb.de]
Sent: Monday, July 20, 2009 5:00 PM
To: virtualization@lists.linux-foundation.org
Cc: Greg Kroah-Hartman; linux-kernel@vger.kernel.org; devel@driverdev.osuosl.org; virtualization@lists.osdl.org; Greg KH; Sam Ramji; Haiyang Zhang; Hank Janssen; shemminger@linux-foundation.org
Subject: Re: [patch 27/54] Staging: hv: remove ULONG and LONG typedefs

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
> -typedef unsigned int         ULONG;
> -
> -//
> -// signed types
> -//
> -typedef int                                  LONG;

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
> -     ULONG   PortNumber;
> +     unsigned long   PortNumber;
>      unsigned char    PathId;
>      unsigned char    TargetId;
>  } STORVSC_DEVICE_INFO;

If this is an API (as the header file name suggests), you just changed it.
Same for the other hunks in this patch.

        Arnd <><
