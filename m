From: Dan Carpenter <error27@gmail.com>
Subject: Re: [PATCH 6/6] Staging: hv: Cleanup hyperv_driver variable names
Date: Sat, 26 Feb 2011 06:40:39 +0300
Message-ID: <20110226034039.GE18043@bicker>
References: <1298686078-30945-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1298686078-30945-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Feb 25, 2011 at 06:07:58PM -0800, K. Y. Srinivasan wrote:
> The title says it all.
> 

For this patch the rename_rev.pl command is:

rename_rev.pl -nc -e 's/(drv|driver)_ctx/drv/g'

> --- a/drivers/staging/hv/vmbus_drv.c
> +++ b/drivers/staging/hv/vmbus_drv.c
> @@ -46,7 +46,7 @@ struct vmbus_hyperv_driver {
>  	/* FIXME, this is a bug */
>  	/* The driver field is not used in here. Instead, the bus field is */
>  	/* used to represent the driver */
        ^^
This comment out of date now that we're using container_of().

> -	struct hyperv_driver drv_ctx;
> +	struct hyperv_driver dummy;
                             ^^^^^
Delete.

> @@ -849,18 +849,18 @@ static int vmbus_uevent(struct device *device, struct kobj_uevent_env *env)
>  static int vmbus_match(struct device *device, struct device_driver *driver)
>  {
>  	int match = 0;
> -	struct hyperv_driver *driver_ctx = driver_to_hyperv_driver(driver);
> +	struct hyperv_driver *drv = driver_to_hyperv_driver(driver);
>  	struct hyperv_device *device_obj = device_to_hyperv_device(device);
>  
>  	/* We found our driver ? */
> -	if (memcmp(&device_obj->class_id, &driver_ctx->class_id,
> +	if (memcmp(&device_obj->class_id, &drv->class_id,
>  		   sizeof(struct hv_guid)) == 0) {
>  		/*
> -		 * !! NOTE: The driver_ctx is not a vmbus_drv_ctx. We typecast
> +		 * !! NOTE: The drv is not a vmbus_drv_ctx. We typecast
                                                      ^^^^
Out of date.

regards,
dan carpenter
