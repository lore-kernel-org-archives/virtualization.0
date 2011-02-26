From: Dan Carpenter <error27@gmail.com>
Subject: Re: [PATCH 3/6] Staging: hv: Cleanup hyperv_device variable names
Date: Sat, 26 Feb 2011 06:33:23 +0300
Message-ID: <20110226033323.GD18043@bicker>
References: <1298685992-30864-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
Content-Disposition: inline
In-Reply-To: <1298685992-30864-1-git-send-email-kys@microsoft.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Sender: devel-bounces@linuxdriverproject.org
Errors-To: devel-bounces@linuxdriverproject.org
To: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: devel@linuxdriverproject.org, gregkh@suse.de, linux-kernel@vger.kernel.org, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Feb 25, 2011 at 06:06:32PM -0800, K. Y. Srinivasan wrote:
> Cleanup the names of variables that refer to the
> hyperv_device abstraction.
> 

I have a script I run on rename patches.  For this patch the
command would be:

rename_rev.pl -nc -e 's/device_ctx/device_obj/g' -e 's/\bdev_ctx/dev/g'

It show one variable was missed in storvsc_probe().  

>  	memset(host_device_ctx, 0, sizeof(struct host_device_context));
>  
>  	host_device_ctx->port = host->host_no;
> -	host_device_ctx->device_ctx = device_obj;
> +	host_device_ctx->device_obj = device_obj;
>  
>  	host_device_ctx->request_pool =
>  				kmem_cache_create(dev_name(&device_obj->device),
> @@ -271,7 +271,7 @@ static int storvsc_probe(struct device *device)
>  		return -1;
>  	}
>  
> -	/* host_device_ctx->port = device_info.PortNumber; */
> +	/* host_hyperv_dev->port = device_info.PortNumber; */
>  	host_device_ctx->path = device_info.path_id;
>  	host_device_ctx->target = device_info.target_id;
>  

All the other host_device_ctx variables were renamed to host_device_obj.

regards,
dan carpenter
