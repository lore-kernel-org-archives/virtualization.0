From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 5/6] Staging: hv:  Rename driver_context to
 hyperv_driver
Date: Mon, 28 Feb 2011 18:56:40 -0800
Message-ID: <20110301025640.GF1663@kroah.com>
References: <1298686058-30918-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1298686058-30918-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org, Haiyang Zhang <haiyangz@microsoft.com>, Hank Janssen <hjanssen@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Feb 25, 2011 at 06:07:38PM -0800, K. Y. Srinivasan wrote:
> The title says it all.

No it doesn't.  You should have done this on the last patch to keep me
from complaining about that name.

Oh, and the extra space, drop it please.

> --- a/drivers/staging/hv/blkvsc_drv.c
> +++ b/drivers/staging/hv/blkvsc_drv.c
> @@ -116,10 +116,10 @@ struct block_device_context {
>  };
>  
>  /* Per driver */
> -struct blkvsc_driver_context {
> +struct blkvsc_hyperv_driver {
>  	/* !! These must be the first 2 fields !! */
>  	/* FIXME this is a bug! */
> -	struct driver_context drv_ctx;
> +	struct hyperv_driver drv_ctx;
>  	struct storvsc_driver_object drv_obj;
>  };
>  

Hey look, that Subject: and changelog body actually lied.  It didn't say
it all.  In fact, it didn't say enough, or you just renamed a different
structure because it felt nice.

{sigh}

One thing per patch, with full description.  I'm getting tired of
repeating Documentation/CodingStyle for this subsystem when patches are
submitted.

It's as if no one even listens to me...

{sniff}

greg k-h
