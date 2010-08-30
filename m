From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 5/5] staging: hv: Gracefully handle SCSI resets
Date: Mon, 30 Aug 2010 16:51:33 -0700
Message-ID: <20100830235133.GB22941@kroah.com>
References: <8AFC7968D54FB448A30D8F38F259C56223FEC8AF@TK5EX14MBXC114.redmond.corp.microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <8AFC7968D54FB448A30D8F38F259C56223FEC8AF@TK5EX14MBXC114.redmond.corp.microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hank Janssen <hjanssen@microsoft.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>, "'devel@driverdev.osuosl.org'" <devel@driverdev.osuosl.org>, "'virtualization@lists.osdl.org'" <virtualization@lists.osdl.org>, Haiyang Zhang <haiyangz@microsoft.com>, "'gregkh@suse.de'" <gregkh@suse.de>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Aug 05, 2010 at 07:30:37PM +0000, Hank Janssen wrote:
> From: Hank Janssen <hjanssen@microsoft.com>
> 
> If we get a SCSI host bus reset we now gracefully handle it, and we take the
> device offline. This before sometimes caused hangs.
> 
> Signed-off-by:Hank Janssen <hjanssen@microsoft.com>
> Signed-off-by:Haiyang Zhang <haiyangz@microsoft.com>
> Cc: stable <stable@kernel.org>
> 
> ---
>  drivers/staging/hv/storvsc.c |   36 +++++++++++++++++++++++++++++++++++-
>  1 files changed, 35 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/staging/hv/storvsc.c b/drivers/staging/hv/storvsc.c index 6bd2ff1..5f222cf 100644
> --- a/drivers/staging/hv/storvsc.c
> +++ b/drivers/staging/hv/storvsc.c
> @@ -48,7 +48,9 @@ struct storvsc_device {
>  
>  	/* 0 indicates the device is being destroyed */
>  	atomic_t RefCount;
> -
> +	
> +	int reset;
> +	spinlock_t lock;
>  	atomic_t NumOutstandingRequests;
>  
>  	/*
> @@ -93,6 +95,9 @@ static inline struct storvsc_device *AllocStorDevice(struct hv_device *Device)
>  	atomic_cmpxchg(&storDevice->RefCount, 0, 2);
>  
>  	storDevice->Device = Device;
> +	storDevice->reset  = 0;
> +	spin_lock_init(&storDevice->lock);
> +
>  	Device->Extension = storDevice;
>  
>  	return storDevice;
> @@ -101,6 +106,7 @@ static inline struct storvsc_device *AllocStorDevice(struct hv_device *Device)  static inline void FreeStorDevice(struct storvsc_device *Device)  {
>  	/* ASSERT(atomic_read(&Device->RefCount) == 0); */

This patch is corrupted as well, something odd is going on in your email
system :(

care to resend it?

thanks,

greg k-h
