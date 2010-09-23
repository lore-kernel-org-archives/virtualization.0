From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 1/1] Rename camel case variables in channel.c
Date: Thu, 23 Sep 2010 13:41:08 -0700
Message-ID: <1285274468.25928.15.camel@Joe-Laptop>
References: <1FB5E1D5CA062146B38059374562DF7289EBB57C@TK5EX14MBXC128.redmond.corp.microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1FB5E1D5CA062146B38059374562DF7289EBB57C@TK5EX14MBXC128.redmond.corp.microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Haiyang Zhang <haiyangz@microsoft.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>, "'devel@driverdev.osuosl.org'" <devel@driverdev.osuosl.org>, "'virtualization@lists.osdl.org'" <virtualization@lists.osdl.org>, "'gregkh@suse.de'" <gregkh@suse.de>, Hank Janssen <hjanssen@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 2010-09-23 at 20:24 +0000, Haiyang Zhang wrote:
>  drivers/staging/hv/channel.c |  729 +++++++++++++++++++++---------------------
[]
> -	struct hv_monitor_page *monitorPage;
> +	struct hv_monitor_page *monitorpage;

Some of these renames would be better with a "_" for
the CamelCase conversions (ie: CamelCase -> camel_case).

perl regex: 's/\b([A-Z])([a-z]+)([A-Z])([a-z]+)\b/\L$1$2_\L$3$4/g'

For instance, I think this should be monitor_page;

> -void VmbusChannelGetDebugInfo(struct vmbus_channel *Channel,
> -			      struct vmbus_channel_debug_info *DebugInfo)
> +void VmbusChannelGetDebugInfo(struct vmbus_channel *channel,
> +			      struct vmbus_channel_debug_info *debuginfo)

perhaps debug_info

>  {
> -	struct hv_monitor_page *monitorPage;
> -	u8 monitorGroup = (u8)Channel->OfferMsg.MonitorId / 32;
> -	u8 monitorOffset = (u8)Channel->OfferMsg.MonitorId % 32;
> +	struct hv_monitor_page *monitorpage;
> +	u8 monitorGroup = (u8)channel->OfferMsg.MonitorId / 32;
> +	u8 monitorOffset = (u8)channel->OfferMsg.MonitorId % 32;

Why not convert these to monitor_(group|offset)?

etc...
