From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 11/25] Staging: hv: Get rid of the drv field in struct
 hv_device
Date: Tue, 26 Apr 2011 15:56:37 -0700
Message-ID: <20110426225637.GB12897@kroah.com>
References: <1303834785-4981-1-git-send-email-kys@microsoft.com>
 <1303834842-5022-1-git-send-email-kys@microsoft.com>
 <1303834842-5022-11-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1303834842-5022-11-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org, Haiyang Zhang <haiyangz@microsoft.com>, Abhishek Kane <v-abkane@microsoft.com>, Hank Janssen <hjanssen@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Apr 26, 2011 at 09:20:28AM -0700, K. Y. Srinivasan wrote:
> Now, we can rid of the drv field in struct hv_device.
> 
> Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
> Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
> ---
>  drivers/staging/hv/vmbus_api.h |    3 ---
>  1 files changed, 0 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/hv/vmbus_api.h b/drivers/staging/hv/vmbus_api.h
> index 51fa952..02e3587 100644
> --- a/drivers/staging/hv/vmbus_api.h
> +++ b/drivers/staging/hv/vmbus_api.h
> @@ -103,9 +103,6 @@ struct hv_driver {
>  
>  /* Base device object */
>  struct hv_device {
> -	/* the driver for this device */
> -	struct hv_driver *drv;
> -
>  	char name[64];

FYI, in the future, you can also remove this name[64] field as well as I
don't think it's ever used...

thanks,

greg k-h
