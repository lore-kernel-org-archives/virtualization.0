From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 05/25] Staging: hv: vmbus: Change the signature of struct
	hv_driver probe function
Date: Fri, 9 Sep 2011 13:38:53 -0700
Message-ID: <20110909203853.GC19127@kroah.com>
References: <1315491843-9513-1-git-send-email-kys@microsoft.com>
	<1315491876-9554-1-git-send-email-kys@microsoft.com>
	<1315491876-9554-5-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1315491876-9554-5-git-send-email-kys@microsoft.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: devel@linuxdriverproject.org, Haiyang Zhang <haiyangz@microsoft.com>, gregkh@suse.de, linux-kernel@vger.kernel.org, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Sep 08, 2011 at 07:24:16AM -0700, K. Y. Srinivasan wrote:
> --- a/drivers/staging/hv/vmbus_drv.c
> +++ b/drivers/staging/hv/vmbus_drv.c
> @@ -299,9 +299,15 @@ static int vmbus_probe(struct device *child_device)
>  	struct hv_driver *drv =
>  			drv_to_hv_drv(child_device->driver);
>  	struct hv_device *dev = device_to_hv_device(child_device);
> +	const struct hv_vmbus_device_id *dev_id = drv->id_table;
> +
> +	for (; !is_null_guid(dev_id->guid); dev_id++)
> +		if (!memcmp(&dev_id->guid, &dev->dev_type.b,
> +				sizeof(uuid_le)))
> +			break;

Don't duplicate this section of code twice (at least) in the driver.
Make it a "vmbus_match_device()" function that returns the proper
hv_vmbus_device_id * to do something with.

thanks,

greg k-h
