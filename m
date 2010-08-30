From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 2/5] staging: hv: Fixed lockup problem with
 bounce_buffer scatter list
Date: Mon, 30 Aug 2010 16:49:02 -0700
Message-ID: <20100830234902.GA22941@kroah.com>
References: <8AFC7968D54FB448A30D8F38F259C56223FEC88B@TK5EX14MBXC114.redmond.corp.microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <8AFC7968D54FB448A30D8F38F259C56223FEC88B@TK5EX14MBXC114.redmond.corp.microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hank Janssen <hjanssen@microsoft.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>, "'devel@driverdev.osuosl.org'" <devel@driverdev.osuosl.org>, "'virtualization@lists.osdl.org'" <virtualization@lists.osdl.org>, Haiyang Zhang <haiyangz@microsoft.com>, "'gregkh@suse.de'" <gregkh@suse.de>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Aug 05, 2010 at 07:29:53PM +0000, Hank Janssen wrote:
> From: Hank Janssen <hjanssen@microsoft.com>
> 
> Fixed lockup problem with bounce_buffer scatter list which caused
> crashes in heavy loads. Under heavy loads with many clients we this
> problem appear, it causes a kernel Panic.
> 
> Signed-off-by:Hank Janssen <hjanssen@microsoft.com>
> Signed-off-by:Haiyang Zhang <haiyangz@microsoft.com>
> Cc: stable <stable@kernel.org>
> ---
>  drivers/staging/hv/storvsc_drv.c |    9 ++++++---
>  1 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/hv/storvsc_drv.c b/drivers/staging/hv/storvsc_drv.c
> index 3b9ccb0..169d701 100644
> --- a/drivers/staging/hv/storvsc_drv.c
> +++ b/drivers/staging/hv/storvsc_drv.c
> @@ -615,6 +615,7 @@ static int storvsc_queuecommand(struct scsi_cmnd *scmnd,
>  	unsigned int request_size = 0;
>  	int i;
>  	struct scatterlist *sgl;
> +	unsigned int sg_count = 0;
>  
>  	DPRINT_DBG(STORVSC_DRV, "scmnd %p dir %d, use_sg %d buf %p len %d "
>  		   "queue depth %d tagged %d", scmnd, scmnd->sc_data_direction, @@ -697,6 +698,7 @@ static int storvsc_queuecommand(struct scsi_cmnd *scmnd,
>  	request->DataBuffer.Length = scsi_bufflen(scmnd);


This patch is corrupted.  It applies, but doesn't do what you want it to
do :(

Care to resend?

thanks,

greg k-h
