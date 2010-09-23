From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 1/1] Rename camel case variables in channel.c  (updated)
Date: Thu, 23 Sep 2010 15:38:06 -0700
Message-ID: <1285281486.25928.31.camel@Joe-Laptop>
References: <1FB5E1D5CA062146B38059374562DF7289ED89CF@TK5EX14MBXC130.redmond.corp.microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1FB5E1D5CA062146B38059374562DF7289ED89CF@TK5EX14MBXC130.redmond.corp.microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Haiyang Zhang <haiyangz@microsoft.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>, "'devel@driverdev.osuosl.org'" <devel@driverdev.osuosl.org>, "'virtualization@lists.osdl.org'" <virtualization@lists.osdl.org>, "'gregkh@suse.de'" <gregkh@suse.de>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 2010-09-23 at 22:04 +0000, Haiyang Zhang wrote:
> From: Haiyang Zhang <haiyangz@microsoft.com>
> 
> Rename camel case variables in channel.c
[]
> -static int VmbusChannelCreateGpadlHeader(void *Kbuffer, u32 Size,
> -					 struct vmbus_channel_msginfo **MsgInfo,
> -					 u32 *MessageCount)
> +static int VmbusChannelCreateGpadlHeader(void *kbuffer, u32 size,
> +					 struct vmbus_channel_msginfo **msginfo,
> +					 u32 *messagecount)
>  {
>  	int i;
> -	int pageCount;
> +	int pagecount;
>  	unsigned long long pfn;
> -	struct vmbus_channel_gpadl_header *gpaHeader;
> -	struct vmbus_channel_gpadl_body *gpadlBody;
> -	struct vmbus_channel_msginfo *msgHeader;
> -	struct vmbus_channel_msginfo *msgBody = NULL;
> -	u32 msgSize;
> +	struct vmbus_channel_gpadl_header *gpal_header;
> +	struct vmbus_channel_gpadl_body *gpadl_body;
> +	struct vmbus_channel_msginfo *msgheader;
> +	struct vmbus_channel_msginfo *msgbody = NULL;
> +	u32 msgsize;

Why gpal_header and not gpadl_header?

I didn't read farther.
