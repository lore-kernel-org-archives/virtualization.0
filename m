From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 036/117] Staging: hv: vmbus: Make class_id attribute a
	human readable string
Date: Tue, 23 Aug 2011 16:02:23 -0700
Message-ID: <20110823230223.GK9641@kroah.com>
References: <1310752024-27854-1-git-send-email-kys@microsoft.com>
	<1310752065-27895-1-git-send-email-kys@microsoft.com>
	<1310752065-27895-36-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
Content-Disposition: inline
In-Reply-To: <1310752065-27895-36-git-send-email-kys@microsoft.com>
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

On Fri, Jul 15, 2011 at 10:46:24AM -0700, K. Y. Srinivasan wrote:
> Now that we have a human readable device_type, use that and get rid of the
> guid based device type.
> 
> Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> ---
>  drivers/staging/hv/vmbus_drv.c |   20 ++------------------
>  1 files changed, 2 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/staging/hv/vmbus_drv.c b/drivers/staging/hv/vmbus_drv.c
> index 9a0df2c..67415ab 100644
> --- a/drivers/staging/hv/vmbus_drv.c
> +++ b/drivers/staging/hv/vmbus_drv.c
> @@ -113,24 +113,8 @@ static ssize_t vmbus_show_device_attr(struct device *dev,
>  	get_channel_info(hv_dev, &device_info);
>  
>  	if (!strcmp(dev_attr->attr.name, "class_id")) {
> -		return sprintf(buf, "{%02x%02x%02x%02x-%02x%02x-%02x%02x-"
> -			       "%02x%02x%02x%02x%02x%02x%02x%02x}\n",

You just changed what this sysfs file contains to have something totally
different than what it used to.

What userspace tools just broke?

If you change the data in the file, shouldn't the name of the file
change as well?

greg k-h
