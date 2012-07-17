From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 01/15] Drivers: hv: Format GUIDS as per MSFT standards
Date: Tue, 17 Jul 2012 09:04:02 -0700
Message-ID: <20120717160402.GA20481@kroah.com>
References: <1342297930-12607-1-git-send-email-kys@microsoft.com>
 <1342298060-12662-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1342298060-12662-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org, olaf@aepfle.de, apw@canonical.com
List-Id: virtualization@lists.linuxfoundation.org

On Sat, Jul 14, 2012 at 01:34:06PM -0700, K. Y. Srinivasan wrote:
> Format GUIDS as per MSFT standard. This makes interacting with MSFT
> tool stack easier.
> 
> Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
> Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
> ---
>  drivers/hv/vmbus_drv.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index a220e57..1f7e54a 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -147,7 +147,7 @@ static ssize_t vmbus_show_device_attr(struct device *dev,
>  
>  	if (!strcmp(dev_attr->attr.name, "class_id")) {
>  		ret = sprintf(buf, "{%02x%02x%02x%02x-%02x%02x-%02x%02x-"
> -			       "%02x%02x%02x%02x%02x%02x%02x%02x}\n",
> +			       "%02x%02x-%02x%02x%02x%02x%02x%02x}\n",

As Joe pointed out, please just use the printk modifier the kernel
already has for GUIDS, and don't roll your own here.  That will work
properly for you, right?

thanks,

greg k-h
