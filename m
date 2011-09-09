From: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH] Staging: hv: storvsc: advertise hv_storvsc instead of
 storvsc as driver name
Date: Fri, 9 Sep 2011 08:25:33 -0700
Message-ID: <20110909152533.GB26556@suse.de>
References: <20110908162650.GA10699@aepfle.de>
 <20110909124533.GA23598@aepfle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20110909124533.GA23598@aepfle.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Olaf Hering <olaf@aepfle.de>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Sep 09, 2011 at 02:45:33PM +0200, Olaf Hering wrote:
> 
> Signed-off-by: Olaf Hering <olaf@aepfle.de>
> 
> --- a/drivers/staging/hv/storvsc_drv.c
> +++ b/drivers/staging/hv/storvsc_drv.c
> @@ -42,6 +42,8 @@
>  
>  #include "hyperv.h"
>  
> +#define MODULE_NAME "hv_storvsc"

No, just use KBUILD_MODNAME, it's already there and correct.  Care to
fix this one, and your other patch, to use it instead?

thanks,

greg k-h
