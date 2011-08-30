From: Dan Carpenter <error27@gmail.com>
Subject: Re: [PATCH 18/46] Staging: hv: storvsc: Add code to handle IDE
	devices using the storvsc driver
Date: Tue, 30 Aug 2011 14:07:49 +0300
Message-ID: <20110830110749.GE3705@shale.localdomain>
References: <1314469874-7017-1-git-send-email-kys@microsoft.com>
	<1314469905-7058-1-git-send-email-kys@microsoft.com>
	<1314469905-7058-18-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
Content-Disposition: inline
In-Reply-To: <1314469905-7058-18-git-send-email-kys@microsoft.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: devel-bounces@linuxdriverproject.org
Sender: devel-bounces@linuxdriverproject.org
To: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: devel@linuxdriverproject.org, Haiyang Zhang <haiyangz@microsoft.com>, gregkh@suse.de, linux-kernel@vger.kernel.org, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

On Sat, Aug 27, 2011 at 11:31:17AM -0700, K. Y. Srinivasan wrote:
> @@ -59,6 +59,17 @@ struct storvsc_cmd_request {
>  	struct hv_storvsc_request request;
>  };
>  
> +static void storvsc_get_ide_info(struct hv_device *dev, int *target, int *path)
> +{
> +	*target =
> +		dev->dev_instance.b[5] << 8 | dev->dev_instance.b[4];
> +
> +	*path =
> +		dev->dev_instance.b[3] << 24 |
> +		dev->dev_instance.b[2] << 16 |
> +		dev->dev_instance.b[1] << 8  | dev->dev_instance.b[0];
> +}
> +

Does endianness matter here?  It seems like *path isn't actually used
anywhere.  Probably target and path should be u32 types?

regards,
dan carpenter
