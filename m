From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 1/1] Staging: hv: netvsc: Cleanup the name and type of
 link_stat variable
Date: Tue, 13 Sep 2011 13:04:42 -0700
Message-ID: <1315944283.25776.14.camel@Joe-Laptop>
References: <1315943618-22308-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1315943618-22308-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org, Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 2011-09-13 at 12:53 -0700, K. Y. Srinivasan wrote:
> Consistently name the variable tracking the link status. Use a consistent
> type for this variable and get rid of some unnecessary parentheses as well.
> 
> Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> ---
>  drivers/staging/hv/rndis_filter.c |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/hv/rndis_filter.c b/drivers/staging/hv/rndis_filter.c
> index 963582a..696d2c5 100644
> --- a/drivers/staging/hv/rndis_filter.c
> +++ b/drivers/staging/hv/rndis_filter.c
> @@ -41,7 +41,7 @@ struct rndis_device {
>  	struct netvsc_device *net_dev;
>  
>  	enum rndis_device_state state;
> -	u32 link_stat;
> +	bool link_state;
>  	atomic_t new_req_id;
>  
>  	spinlock_t request_lock;
> @@ -514,7 +514,7 @@ static int rndis_filter_query_device_link_status(struct rndis_device *dev)
>  
>  	return rndis_filter_query_device(dev,
>  				      RNDIS_OID_GEN_MEDIA_CONNECT_STATUS,
> -				      &dev->link_stat, &size);
> +				      &dev->link_state, &size);

Are you sure you can do this?
You're changing the info request from u32 to bool
without changing the size above it

	u32 size = sizeof(u32);


>  }
>  
>  static int rndis_filter_set_packet_filter(struct rndis_device *dev,
> @@ -736,11 +736,11 @@ int rndis_filter_device_add(struct hv_device *dev,
>  
>  	rndis_filter_query_device_link_status(rndis_device);
>  
> -	device_info->link_state = rndis_device->link_stat;
> +	device_info->link_state = rndis_device->link_state;
>  
>  	dev_info(&dev->device, "Device MAC %pM link state %s",
>  		 rndis_device->hw_mac_adr,
> -		 ((device_info->link_state) ? ("down\n") : ("up\n")));
> +		 device_info->link_state ? "down\n" : "up\n");

It's better to remove the multiple "\n"s from "up" and "down"
and move it to the format string as I suggested.
