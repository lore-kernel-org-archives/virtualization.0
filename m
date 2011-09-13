From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 20/20] Staging: hv: netvsc: Rename deviceInfo as
 device_info
Date: Tue, 13 Sep 2011 11:10:31 -0700
Message-ID: <1315937432.25776.9.camel@Joe-Laptop>
References: <1315936759-20623-1-git-send-email-kys@microsoft.com>
	 <1315936796-20662-1-git-send-email-kys@microsoft.com>
	 <1315936796-20662-20-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1315936796-20662-20-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org, Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 2011-09-13 at 10:59 -0700, K. Y. Srinivasan wrote:
> Rename deviceInfo as device_info.
[]
> diff --git a/drivers/staging/hv/rndis_filter.c b/drivers/staging/hv/rndis_filter.c
[]
> @@ -732,15 +732,15 @@ int rndis_filter_device_add(struct hv_device *dev,
[]
>  	dev_info(&dev->device, "Device MAC %pM link state %s",
>  		 rndis_device->hw_mac_adr,
> -		 ((deviceInfo->link_state) ? ("down\n") : ("up\n")));
> +		 ((device_info->link_state) ? ("down\n") : ("up\n")));

Maybe get rid of the superfluous parentheses too?

	dev_info(&dev->device, "Device MAC %pM link state %s\n",
		 rndis_device->hw_mac_adr,
		 device_info->link_state ? "down" : "up");

Also, struct rndis_device uses
	u32 link_stat;
that is copied into struct netvsc_device_info
	bool link_state;
could you please rationalize the names and types
of those 2 variables?
