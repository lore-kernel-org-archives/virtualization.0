From: KY Srinivasan <kys@microsoft.com>
Subject: RE: [PATCH] Staging: hv: storvsc: Show the modulename in
	/sys/class/scsi_host/*/proc_name
Date: Thu, 8 Sep 2011 16:55:02 +0000
Message-ID: <6E21E5352C11B742B20C142EB499E048081D2BE0@TK5EX14MBXC128.redmond.corp.microsoft.com>
References: <20110908162650.GA10699@aepfle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <20110908162650.GA10699@aepfle.de>
Content-Language: en-US
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: devel-bounces@linuxdriverproject.org
Sender: devel-bounces@linuxdriverproject.org
To: Olaf Hering <olaf@aepfle.de>
Cc: "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "gregkh@suse.de" <gregkh@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org



> -----Original Message-----
> From: Olaf Hering [mailto:olaf@aepfle.de]
> Sent: Thursday, September 08, 2011 12:27 PM
> To: KY Srinivasan
> Cc: gregkh@suse.de; linux-kernel@vger.kernel.org;
> devel@linuxdriverproject.org; virtualization@lists.osdl.org
> Subject: [PATCH] Staging: hv: storvsc: Show the modulename in
> /sys/class/scsi_host/*/proc_name
> 
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
>  	.bios_param =		storvsc_get_chs,
>  	.queuecommand =		storvsc_queuecommand,
>  	.eh_host_reset_handler =	storvsc_host_reset_handler,

Acked-by:  K. Y. Srinivasan <kys@microsoft.com>
