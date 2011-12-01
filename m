From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 1/1] Staging: hv: mousevsc: Properly add the hid device
Date: Thu, 1 Dec 2011 20:55:47 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1112012055230.18207@pobox.suse.cz>
References: <1322671943-6788-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1322671943-6788-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org, ohering@suse.com, joe@perches.com, dmitry.torokhov@gmail.com, Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 30 Nov 2011, K. Y. Srinivasan wrote:

> We need to properly add the hid device to correctly initialize the
> sysfs state. While this patch is against the staging tree; Jiri,
> please pick up this patch as you merge the Hyper-V mouse driver.
> 
> Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> Reported-by: Fuzhou Chen <fuzhouch@microsoft.com>
> ---
>  drivers/staging/hv/hv_mouse.c |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/staging/hv/hv_mouse.c b/drivers/staging/hv/hv_mouse.c
> index a28c549..66da8e3 100644
> --- a/drivers/staging/hv/hv_mouse.c
> +++ b/drivers/staging/hv/hv_mouse.c
> @@ -519,6 +519,10 @@ static int mousevsc_probe(struct hv_device *device,
>  
>  	sprintf(hid_dev->name, "%s", "Microsoft Vmbus HID-compliant Mouse");
>  
> +	ret = hid_add_device(hid_dev);
> +	if (ret)
> +		goto probe_err1;
> +
>  	ret = hid_parse_report(hid_dev, input_dev->report_desc,
>  				input_dev->report_desc_size);
>  

I have refreshed the patch to apply to drivers/hid/hid-hyperv.c driver and 
applied. Thanks,

-- 
Jiri Kosina
SUSE Labs
