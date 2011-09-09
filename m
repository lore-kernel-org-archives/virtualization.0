From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 18/25] Staging: hv: storvsc: Eliminate the usage of ext
	field in struct  hv_device
Date: Fri, 9 Sep 2011 13:44:51 -0700
Message-ID: <20110909204451.GH19127@kroah.com>
References: <1315491843-9513-1-git-send-email-kys@microsoft.com>
	<1315491876-9554-1-git-send-email-kys@microsoft.com>
	<1315491876-9554-18-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
Content-Disposition: inline
In-Reply-To: <1315491876-9554-18-git-send-email-kys@microsoft.com>
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

On Thu, Sep 08, 2011 at 07:24:29AM -0700, K. Y. Srinivasan wrote:
> Now, eliminate the usage of ext field in struct  hv_device for storvsc driver.
> We do this by registering pointer to struct storvsc_device as the driver
> specific data and eliminating the current usage of driver specific data to
> save and retrieve the pointer to struct Scsi_Host.
> Additionally, all access to the driver specific data is through
> the vmbus wrapper functions.
> 
> Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> ---
>  drivers/staging/hv/storvsc_drv.c |   24 +++++++++++++++---------
>  1 files changed, 15 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/staging/hv/storvsc_drv.c b/drivers/staging/hv/storvsc_drv.c
> index 57c1035..98d47cd 100644
> --- a/drivers/staging/hv/storvsc_drv.c
> +++ b/drivers/staging/hv/storvsc_drv.c
> @@ -266,6 +266,7 @@ struct storvsc_device {
>  	bool	 destroy;
>  	bool	 drain_notify;
>  	atomic_t num_outstanding_req;
> +	struct Scsi_Host *host;

You are properly reference counting this pointer, right?

> @@ -306,7 +307,8 @@ static inline struct storvsc_device *get_out_stor_device(
>  {
>  	struct storvsc_device *stor_device;
>  
> -	stor_device = (struct storvsc_device *)device->ext;
> +	stor_device =
> +		(struct storvsc_device *)hv_get_drvdata(device);

Casting is not needed at all.

> @@ -1366,7 +1371,8 @@ static int storvsc_probe(struct hv_device *device,
>  	stor_device->destroy = false;
>  	init_waitqueue_head(&stor_device->waiting_to_drain);
>  	stor_device->device = device;
> -	device->ext = stor_device;
> +	stor_device->host = host;
> +	hv_set_drvdata(device, stor_device);

Lookie there, no reference count incremented, right?  Or did I miss it
somewhere else?

gotta love dynamic pointer lifetime rules...

greg k-h
