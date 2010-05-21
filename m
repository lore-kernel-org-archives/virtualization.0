From: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH 1/1] staging: hv: Fix race condition on IC channel
 initialization
Date: Fri, 21 May 2010 13:12:28 -0700
Message-ID: <20100521201228.GA6712@suse.de>
References: <1FB5E1D5CA062146B38059374562DF7266B8AE7C@TK5EX14MBXC128.redmond.corp.microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1FB5E1D5CA062146B38059374562DF7266B8AE7C@TK5EX14MBXC128.redmond.corp.microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Haiyang Zhang <haiyangz@microsoft.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>, "'devel@driverdev.osuosl.org'" <devel@driverdev.osuosl.org>, "'virtualization@lists.osdl.org'" <virtualization@lists.osdl.org>, Hank Janssen <hjanssen@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, May 21, 2010 at 07:58:26PM +0000, Haiyang Zhang wrote:
> From: Haiyang Zhang <haiyangz@microsoft.com>
> 
> Subject: staging: hv: Fix race condition on IC channel initialization
> There is a possible race condition when hv_utils starts to load immediately
> after hv_vmbus is loading - null pointer error could happen.
> This patch added an atomic counter to ensure all channels are ready before
> vmbus_init() returns. So another module won't have any uninitialized channel.

Better, but not quite ready...

> +/* Counter of IC channels initialized */
> +atomic_t hv_utils_initcnt = ATOMIC_INIT(0);

This doesn't need to be an atomic variable, does it really?

Why not have a simple bool variable "vmbus_initialized" or something.
It starts out as false, and then turns true when you are up and ready.
Then provide a function that tests it:
	bool hv_vmbus_ready(void)
	{
		return vmbus_initialized
	}
	EXPORT_SYMBOL_GPL(hv_vmbus_ready);

>  /*
>   * AllocVmbusChannel - Allocate and initialize a vmbus channel object
>   */
> @@ -373,22 +376,22 @@ static void VmbusChannelProcessOffer(void *context)
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

Then set the vmbus_initialized to be true right here.

This way, no one needs to know about what the internal number of
messages are, or any other internal mess that would require the bus to
be up and running properly.

> --- a/drivers/staging/hv/hv_utils.c
> +++ b/drivers/staging/hv/hv_utils.c
> @@ -253,7 +253,7 @@ static void heartbeat_onchannelcallback(void *context)
>  
>  static int __init init_hyperv_utils(void)
>  {
> -	printk(KERN_INFO "Registering HyperV Utility Driver\n");
> +	printk(KERN_INFO "Registering HyperV Utility Driver...\n");
>  
>  	hv_cb_utils[HV_SHUTDOWN_MSG].channel->OnChannelCallback =
>  		&shutdown_onchannelcallback;
> @@ -267,13 +267,12 @@ static int __init init_hyperv_utils(void)
>  		&heartbeat_onchannelcallback;
>  	hv_cb_utils[HV_HEARTBEAT_MSG].callback = &heartbeat_onchannelcallback;
>  
> +	printk(KERN_INFO "Registered HyperV Utility Driver.\n");

Just do one printk, if any at all here.  You really don't need it, it
just clutters up the syslog.  Especially given your code here, it's not
going to ever be a long time between those two messages :)

>  	return 0;
>  }
>  
>  static void exit_hyperv_utils(void)
>  {
> -	printk(KERN_INFO "De-Registered HyperV Utility Driver\n");
> -
>  	hv_cb_utils[HV_SHUTDOWN_MSG].channel->OnChannelCallback =
>  		&chn_cb_negotiate;
>  	hv_cb_utils[HV_SHUTDOWN_MSG].callback = &chn_cb_negotiate;
> @@ -285,6 +284,8 @@ static void exit_hyperv_utils(void)
>  	hv_cb_utils[HV_HEARTBEAT_MSG].channel->OnChannelCallback =
>  		&chn_cb_negotiate;
>  	hv_cb_utils[HV_HEARTBEAT_MSG].callback = &chn_cb_negotiate;
> +
> +	printk(KERN_INFO "De-Registered HyperV Utility Driver.\n");

Again, just drop the thing entirely.

>  }
>  
>  module_init(init_hyperv_utils);
> diff --git a/drivers/staging/hv/utils.h b/drivers/staging/hv/utils.h
> index 7c07499..3291ab4 100644
> --- a/drivers/staging/hv/utils.h
> +++ b/drivers/staging/hv/utils.h
> @@ -98,6 +98,10 @@ struct ictimesync_data{
>  	u8 flags;
>  } __attribute__((packed));
>  
> +
> +/* Number of IC types supported */
> +#define MAX_MSG_TYPES	3

Now you can keep this #define private.

> --- a/drivers/staging/hv/vmbus_drv.c
> +++ b/drivers/staging/hv/vmbus_drv.c
> @@ -31,6 +31,7 @@
>  #include "osd.h"
>  #include "logging.h"
>  #include "vmbus.h"
> +#include "utils.h"
>  
>  
>  /* FIXME! We need to do this dynamically for PIC and APIC system */
> @@ -1005,6 +1006,10 @@ static int __init vmbus_init(void)
>  
>  	ret = vmbus_bus_init(VmbusInitialize);
>  
> +	/* Wait until all IC channels are initialized */
> +	while (atomic_read(&hv_utils_initcnt) < MAX_MSG_TYPES)
> +		msleep(100);

this turns into a simple function call, again, never needing to know
about message types or any other mess.

Sound good?

thanks,

greg k-h
