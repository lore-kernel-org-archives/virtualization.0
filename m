From: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH] Staging: hv: storvsc: Show the modulename in
 /sys/class/scsi_host/*/proc_name
Date: Thu, 8 Sep 2011 12:12:37 -0700
Message-ID: <20110908191237.GB8552@suse.de>
References: <20110908162650.GA10699@aepfle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20110908162650.GA10699@aepfle.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Olaf Hering <olaf@aepfle.de>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Sep 08, 2011 at 06:26:50PM +0200, Olaf Hering wrote:
> 
> mkinitrd relies on /sys/class/scsi_host/*/proc_name instead of
> /sys/block/sd*/device/../../../moalias to get the scsi driver module
> name.
> As a fallback the sysfs driver name could be used, which does not match
> the module name either ('storvsc' vs. 'hv_storvsc').
> 
> Signed-off-by: Olaf Hering <olaf@aepfle.de>
> 
> ---
>  drivers/staging/hv/storvsc_drv.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> --- a/drivers/staging/hv/storvsc_drv.c
> +++ b/drivers/staging/hv/storvsc_drv.c
> @@ -1333,7 +1333,8 @@ static DEF_SCSI_QCMD(storvsc_queuecomman
>  /* Scsi driver */
>  static struct scsi_host_template scsi_driver = {
>  	.module	=		THIS_MODULE,
> -	.name =			"storvsc_host_t",
> +	.name =			"hv_storvsc",
> +	.proc_name =		"hv_storvsc",

Shouldn't this be MODULE_NAME so it handles any potential name change in
the future and makes it a bit more obvious as to what is going on here?

thanks,

greg k-h
