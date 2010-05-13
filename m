From: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH 1/1]  staging: hv: Fix error checking in channel.c
Date: Thu, 13 May 2010 09:33:16 -0700
Message-ID: <20100513163316.GA24649@suse.de>
References: <1FB5E1D5CA062146B38059374562DF72662AB0C9@TK5EX14MBXC130.redmond.corp.microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1FB5E1D5CA062146B38059374562DF72662AB0C9@TK5EX14MBXC130.redmond.corp.microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Haiyang Zhang <haiyangz@microsoft.com>, Bill Pemberton <wfp5p@virginia.edu>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>, "'devel@driverdev.osuosl.org'" <devel@driverdev.osuosl.org>, "'virtualization@lists.osdl.org'" <virtualization@lists.osdl.org>, Hank Janssen <hjanssen@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, May 13, 2010 at 03:56:30PM +0000, Haiyang Zhang wrote:
> From: Haiyang Zhang <haiyangz@microsoft.com>
> 
> Subject: staging: hv: Fix error checking in channel.c
> Fixed errors in return value checking code, which caused vmbus channel
> not functioning.

Doh, sorry about that.  Bill, be a bit more careful in the future
please, this came in on your ASSERT cleanup patch.

thanks,

greg k-h

> ---
>  drivers/staging/hv/channel.c |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/hv/channel.c b/drivers/staging/hv/channel.c
> index 12c351e..f047c5a 100644
> --- a/drivers/staging/hv/channel.c
> +++ b/drivers/staging/hv/channel.c
> @@ -204,13 +204,13 @@ int VmbusChannelOpen(struct vmbus_channel *NewChannel, u32 SendRingBufferSize,
>  					   RecvRingBufferSize) >> PAGE_SHIFT;
>  
>  	ret = RingBufferInit(&NewChannel->Outbound, out, SendRingBufferSize);
> -	if (!ret) {
> +	if (ret != 0) {
>  		err = ret;
>  		goto errorout;
>  	}
>  
>  	ret = RingBufferInit(&NewChannel->Inbound, in, RecvRingBufferSize);
> -	if (!ret) {
> +	if (ret != 0) {
>  		err = ret;
>  		goto errorout;
>  	}
> @@ -228,7 +228,7 @@ int VmbusChannelOpen(struct vmbus_channel *NewChannel, u32 SendRingBufferSize,
>  					 RecvRingBufferSize,
>  					 &NewChannel->RingBufferGpadlHandle);
>  
> -	if (!ret) {
> +	if (ret != 0) {
>  		err = ret;
>  		goto errorout;
>  	}
> @@ -569,7 +569,7 @@ int VmbusChannelEstablishGpadl(struct vmbus_channel *Channel, void *Kbuffer,
>  			ret = VmbusPostMessage(gpadlBody,
>  					       subMsgInfo->MessageSize -
>  					       sizeof(*subMsgInfo));
> -			if (!ret)
> +			if (ret != 0)
>  				goto Cleanup;
>  
>  		}
> -- 
> 1.6.3.2
> 
