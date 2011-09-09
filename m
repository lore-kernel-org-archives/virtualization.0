From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 07/25] Staging: hv: vmbus: Change the signature of struct
 hv_driver remove() function
Date: Fri, 9 Sep 2011 13:40:13 -0700
Message-ID: <20110909204013.GD19127@kroah.com>
References: <1315491843-9513-1-git-send-email-kys@microsoft.com>
 <1315491876-9554-1-git-send-email-kys@microsoft.com>
 <1315491876-9554-7-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1315491876-9554-7-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org, Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Sep 08, 2011 at 07:24:18AM -0700, K. Y. Srinivasan wrote:
> In preparation for leveraging the driver_data in  struct
> hv_vmbus_device_id, change the signature of struct hv_driver remove() function.

Why?  This shouldn't be needed at remove() time as the driver already
has saved off the needed id information in its probe function, if it
needed it.
> --- a/drivers/staging/hv/vmbus_drv.c
> +++ b/drivers/staging/hv/vmbus_drv.c
> @@ -329,12 +329,19 @@ static int vmbus_remove(struct device *child_device)
>  	struct hv_driver *drv;
>  
>  	struct hv_device *dev = device_to_hv_device(child_device);
> +	const struct hv_vmbus_device_id *dev_id;
>  
>  	if (child_device->driver) {
>  		drv = drv_to_hv_drv(child_device->driver);
> +		dev_id = drv->id_table;
> +
> +		for (; !is_null_guid(dev_id->guid); dev_id++)
> +			if (!memcmp(&dev_id->guid, &dev->dev_type.b,
> +					sizeof(uuid_le)))
> +				break;

Even though it is wrong, look you duplicated the matching logic again!

ick.

greg k-h
