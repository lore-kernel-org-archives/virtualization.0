From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 35/46] Staging: hv: Fix a bug in vmbus_match()
Date: Mon, 29 Aug 2011 11:00:26 -0700
Message-ID: <20110829180026.GA19668@kroah.com>
References: <1314469874-7017-1-git-send-email-kys@microsoft.com>
 <1314469905-7058-1-git-send-email-kys@microsoft.com>
 <1314469905-7058-35-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1314469905-7058-35-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org, Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

On Sat, Aug 27, 2011 at 11:31:34AM -0700, K. Y. Srinivasan wrote:
> The recent checkin that add a private pointer to hv_vmbus_device_id
> introduced this bug in vmbus_match; fix it.
> 
> Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> ---
>  drivers/staging/hv/vmbus_drv.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/staging/hv/vmbus_drv.c b/drivers/staging/hv/vmbus_drv.c
> index be62b62..51002c0 100644
> --- a/drivers/staging/hv/vmbus_drv.c
> +++ b/drivers/staging/hv/vmbus_drv.c
> @@ -273,7 +273,7 @@ static int vmbus_match(struct device *device, struct device_driver *driver)
>  
>  	for (; !is_null_guid(id_array->guid); id_array++)
>  		if (!memcmp(&id_array->guid, &hv_dev->dev_type.b,
> -				sizeof(struct hv_vmbus_device_id)))
> +				sizeof(uuid_le)))

Ick, sorry about this, it was my fault.

greg k-h
