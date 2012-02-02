From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 3/6] drivers: hv: Cleanup the kvp related state in
 hyperv.h
Date: Thu, 2 Feb 2012 15:29:36 -0800
Message-ID: <20120202232936.GA9614@kroah.com>
References: <1327708522-26914-1-git-send-email-kys@microsoft.com>
 <1327708562-26964-1-git-send-email-kys@microsoft.com>
 <1327708562-26964-3-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1327708562-26964-3-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org, ohering@suse.com, zbr@ioremap.net, Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Jan 27, 2012 at 03:55:59PM -0800, K. Y. Srinivasan wrote:
> Now cleanup the hyperv.h with regards to KVP definitions.
> 
> Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
>  include/linux/hyperv.h |   32 +++++++++++++++++++-------------
>  1 files changed, 19 insertions(+), 13 deletions(-)
> 
> diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
> index 7332b3f..802ece8 100644
> --- a/include/linux/hyperv.h
> +++ b/include/linux/hyperv.h
> @@ -137,7 +137,6 @@ struct hv_ku_msg {
>  
>  
>  
> -#ifdef __KERNEL__
>  
>  /*
>   * Registry value types.
> @@ -162,29 +161,36 @@ enum hv_kvp_exchg_pool {
>  	KVP_POOL_COUNT /* Number of pools, must be last. */
>  };
>  
> +#ifndef __packed
> +#define __packed __attribute__((packed))
> +#endif

Why do this?

If you are so worried about this in userspace, then just change the
values below to __attribute__((packed)), like all of the other public .h
files do.

thanks,

greg k-h
