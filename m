From: Jonathan Cameron <jic23@cam.ac.uk>
Subject: Re: [PATCH 005/206] Staging: hv: Rename the device type variable
Date: Tue, 10 May 2011 11:11:03 +0100
Message-ID: <4DC90F37.6010000@cam.ac.uk>
References: <1304978242-22958-1-git-send-email-kys@microsoft.com>	<1304978288-22999-1-git-send-email-kys@microsoft.com> <1304978288-22999-5-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1304978288-22999-5-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org, Haiyang Zhang <haiyangz@microsoft.com>, Abhishek Kane <v-abkane@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

On 05/09/11 22:54, K. Y. Srinivasan wrote:
> Rename the variable g_blk_device_type.
Why?

A few of these renames could do with a bit more detail on what is wrong
with the old names.
> 
> Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
> Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
> ---
>  drivers/staging/hv/blkvsc_drv.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/hv/blkvsc_drv.c b/drivers/staging/hv/blkvsc_drv.c
> index b54130b..51d1265 100644
> --- a/drivers/staging/hv/blkvsc_drv.c
> +++ b/drivers/staging/hv/blkvsc_drv.c
> @@ -115,7 +115,7 @@ struct block_device_context {
>  static const char *drv_name = "blkvsc";
>  
>  /* {32412632-86cb-44a2-9b5c-50d1417354f5} */
> -static const struct hv_guid g_blk_device_type = {
> +static const struct hv_guid dev_type = {
>  	.data = {
>  		0x32, 0x26, 0x41, 0x32, 0xcb, 0x86, 0xa2, 0x44,
>  		0x9b, 0x5c, 0x50, 0xd1, 0x41, 0x73, 0x54, 0xf5
> @@ -178,7 +178,7 @@ static int blk_vsc_initialize(struct hv_driver *driver)
>  	/* Make sure we are at least 2 pages since 1 page is used for control */
>  
>  	driver->name = drv_name;
> -	memcpy(&driver->dev_type, &g_blk_device_type, sizeof(struct hv_guid));
> +	memcpy(&driver->dev_type, &dev_type, sizeof(struct hv_guid));
>  
>  
>  	/*
