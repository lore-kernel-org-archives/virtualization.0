From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 003/117] Staging: hv: Add struct hv_vmbus_device_id to
 mod_devicetable.h
Date: Tue, 23 Aug 2011 15:41:57 -0700
Message-ID: <20110823224157.GA9641@kroah.com>
References: <1310752024-27854-1-git-send-email-kys@microsoft.com>
 <1310752065-27895-1-git-send-email-kys@microsoft.com>
 <1310752065-27895-3-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1310752065-27895-3-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org, Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Jul 15, 2011 at 10:45:51AM -0700, K. Y. Srinivasan wrote:
> In preparation for implementing vmbus aliases for auto-loading
> Hyper-V drivers, define vmbus specific device ID.
> 
> Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> ---
>  include/linux/mod_devicetable.h |    7 +++++++
>  1 files changed, 7 insertions(+), 0 deletions(-)
> 
> diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
> index ae28e93..5a12377 100644
> --- a/include/linux/mod_devicetable.h
> +++ b/include/linux/mod_devicetable.h
> @@ -405,6 +405,13 @@ struct virtio_device_id {
>  };
>  #define VIRTIO_DEV_ANY_ID	0xffffffff
>  
> +/*
> + * For Hyper-V devices we use the device guid as the id.
> + */
> +struct hv_vmbus_device_id {
> +	__u8 guid[16];
> +};

Why do you not need a driver_data pointer here?  Are you sure you aren't
ever going to need it in the future?  Hint, I think you will...

greg k-h
