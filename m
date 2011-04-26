From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 20/25] Staging: hv: Use the probe function in struct
 hv_driver
Date: Tue, 26 Apr 2011 12:51:50 -0400
Message-ID: <20110426165150.GA21187@infradead.org>
References: <1303834785-4981-1-git-send-email-kys@microsoft.com>
 <1303834842-5022-1-git-send-email-kys@microsoft.com>
 <1303834842-5022-20-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1303834842-5022-20-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org, Haiyang Zhang <haiyangz@microsoft.com>, Abhishek Kane <v-abkane@microsoft.com>, Hank Janssen <hjanssen@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

> @@ -882,7 +882,7 @@ static int blkvsc_drv_init(void)
>  
>  	drv->driver.name = storvsc_drv_obj->base.name;
>  
> -	drv->driver.probe = blkvsc_probe;
> +	drv->probe = blkvsc_probe;
>  	drv->driver.remove = blkvsc_remove;
>  	drv->driver.shutdown = blkvsc_shutdown;

Not new in this patch, but you should really declare the driver as a
static object and initialize it at compile time, similar to how it's 
done for PCI and countless other busses, e.g.

struct hv_driver blkvsc_driver {
	.name		= "blkvsc",
	.probe		= blkvsc_probe,
	.remove		= blkvsc_remove,
	.shutdown	= blkvsc_shutdown,
};
