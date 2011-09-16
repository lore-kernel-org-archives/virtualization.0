From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 05/20] Staging: hv: util: Perform some service specific
 init/deinit in probe/remove
Date: Fri, 16 Sep 2011 20:01:29 +0200
Message-ID: <20110916180129.GA25531@kroah.com>
References: <1315936759-20623-1-git-send-email-kys@microsoft.com>
 <1315936796-20662-1-git-send-email-kys@microsoft.com>
 <1315936796-20662-5-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1315936796-20662-5-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org, Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Sep 13, 2011 at 10:59:41AM -0700, K. Y. Srinivasan wrote:
> --- a/drivers/staging/hv/hv_util.c
> +++ b/drivers/staging/hv/hv_util.c
> @@ -30,9 +30,31 @@
>  #include "hyperv.h"
>  #include "hv_kvp.h"
>  
> -static u8 *shut_txf_buf;
> -static u8 *time_txf_buf;
> -static u8 *hbeat_txf_buf;
> +
> +static void shutdown_onchannelcallback(void *context);
> +static struct hv_util_service util_shutdown = {
> +	.service_name = "Shutdown channel functionality initialized\n",

That's not a name, it's a text string to send to userspace, and it's
really redundant given the other times you use this.

Please just put the name here, if you really need it (hint, you really
don't, so just drop it please.)

greg k-h
