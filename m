From: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH 1/2] staging: hv: Fix race condition in hv_utils module
 initialization.
Date: Wed, 19 May 2010 09:10:11 -0700
Message-ID: <20100519161011.GA20266@suse.de>
References: <1FB5E1D5CA062146B38059374562DF7266B8930E@TK5EX14MBXC128.redmond.corp.microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1FB5E1D5CA062146B38059374562DF7266B8930E@TK5EX14MBXC128.redmond.corp.microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Haiyang Zhang <haiyangz@microsoft.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>, "'devel@driverdev.osuosl.org'" <devel@driverdev.osuosl.org>, "'virtualization@lists.osdl.org'" <virtualization@lists.osdl.org>, Hank Janssen <hjanssen@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, May 19, 2010 at 03:54:17PM +0000, Haiyang Zhang wrote:
> From: Haiyang Zhang <haiyangz@microsoft.com>
> 
> Subject: [PATCH 1/2] staging: hv: Fix race condition in hv_utils module initialization.
> There is a possible race condition when hv_utils starts to load immediately
> after hv_vmbus is loading - null pointer error could happen.
> This patch added an atomic counter to ensure the hv_utils module initialization
> happens after all vmbus IC channels are initialized.
> 
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
> 
> ---
>  drivers/staging/hv/channel_mgmt.c |   26 +++++++++++++++-----------
>  drivers/staging/hv/hv_utils.c     |   11 ++++++++---
>  drivers/staging/hv/utils.h        |    5 +++++
>  3 files changed, 28 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/staging/hv/channel_mgmt.c b/drivers/staging/hv/channel_mgmt.c
> index 3f53b4d..b5b6a70 100644
> --- a/drivers/staging/hv/channel_mgmt.c
> +++ b/drivers/staging/hv/channel_mgmt.c
> @@ -33,7 +33,6 @@ struct vmbus_channel_message_table_entry {
>  	void (*messageHandler)(struct vmbus_channel_message_header *msg);
>  };
>  
> -#define MAX_MSG_TYPES                    3
>  #define MAX_NUM_DEVICE_CLASSES_SUPPORTED 7
>  
>  static const struct hv_guid
> @@ -233,6 +232,11 @@ struct hyperv_service_callback hv_cb_utils[MAX_MSG_TYPES] = {
>  };
>  EXPORT_SYMBOL(hv_cb_utils);
>  
> +/* Counter of IC channels initialized */
> +atomic_t hv_utils_initcnt = ATOMIC_INIT(0);
> +EXPORT_SYMBOL(hv_utils_initcnt);
> +
> +
>  /*
>   * AllocVmbusChannel - Allocate and initialize a vmbus channel object
>   */
> @@ -373,22 +377,22 @@ static void VmbusChannelProcessOffer(void *context)
>  		 * can cleanup properly
>  		 */
>  		newChannel->State = CHANNEL_OPEN_STATE;
> -		cnt = 0;
>  
> -		while (cnt != MAX_MSG_TYPES) {
> +		/* Open IC channels */
> +		for (cnt = 0; cnt < MAX_MSG_TYPES; cnt++) {
>  			if (memcmp(&newChannel->OfferMsg.Offer.InterfaceType,
>  				   &hv_cb_utils[cnt].data,
> -				   sizeof(struct hv_guid)) == 0) {
> +				   sizeof(struct hv_guid)) == 0 &&
> +			    VmbusChannelOpen(newChannel, 2 * PAGE_SIZE,
> +					     2 * PAGE_SIZE, NULL, 0,
> +					     hv_cb_utils[cnt].callback,
> +					     newChannel) == 0) {
> +				hv_cb_utils[cnt].channel = newChannel;
> +				mb();
>  				DPRINT_INFO(VMBUS, "%s",
>  					    hv_cb_utils[cnt].log_msg);
> -
> -				if (VmbusChannelOpen(newChannel, 2 * PAGE_SIZE,
> -						    2 * PAGE_SIZE, NULL, 0,
> -						    hv_cb_utils[cnt].callback,
> -						    newChannel) == 0)
> -					hv_cb_utils[cnt].channel = newChannel;
> +				atomic_inc(&hv_utils_initcnt);
>  			}
> -			cnt++;
>  		}
>  	}
>  	DPRINT_EXIT(VMBUS);
> diff --git a/drivers/staging/hv/hv_utils.c b/drivers/staging/hv/hv_utils.c
> index 8a49aaf..f9826c7 100644
> --- a/drivers/staging/hv/hv_utils.c
> +++ b/drivers/staging/hv/hv_utils.c
> @@ -253,7 +253,11 @@ static void heartbeat_onchannelcallback(void *context)
>  
>  static int __init init_hyperv_utils(void)
>  {
> -	printk(KERN_INFO "Registering HyperV Utility Driver\n");
> +	printk(KERN_INFO "Registering HyperV Utility Driver...\n");
> +
> +	/* Wait until all IC channels are initialized */
> +	while (atomic_read(&hv_utils_initcnt) < MAX_MSG_TYPES)
> +		msleep(100);

No, don't do this here, do something in your hv_vmbus core to handle
registering sub-drivers properly.  Perhaps you need to sleep there
before you can succeed on a initialization.

>  
>  	hv_cb_utils[HV_SHUTDOWN_MSG].channel->OnChannelCallback =
>  		&shutdown_onchannelcallback;

The problem is that you just have a bunch of callbacks you are setting
up, it's not a "real" function call.  Please change it over to a
function call, like all other subsystems have.  Then, you can handle any
"sleep until we are set up properly" issues in the vmbus code, not in
each and every individual bus driver.

thanks,

greg k-h
