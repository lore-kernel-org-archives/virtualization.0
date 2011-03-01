From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 2/6] Staging: hv: Rename vm_device to hyperv_device
Date: Mon, 28 Feb 2011 18:32:48 -0800
Message-ID: <20110301023248.GB1663@kroah.com>
References: <1298685963-30831-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
Content-Disposition: inline
In-Reply-To: <1298685963-30831-1-git-send-email-kys@microsoft.com>
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
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, devel@linuxdriverproject.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Feb 25, 2011 at 06:06:03PM -0800, K. Y. Srinivasan wrote:
> Rename the vm_device abstraction as hyperv_device.

That's a nice name, but it's the first one with a "hyperv_" prefix in
this subsystem.  Ok, second, but hyperv_service_context doesn't really
count as it's not really used.

Everything else is named "hv_" here.  Which is it going to be, "hv_" or
"hyperv_"?

Either is fine, just be aware of the work involved if you pick
"hyperv_"...

You also rename vm_device_info to hyperv_device_info here, doing more
than one thing in a single patch.

Please don't do that, this should be 2 patches.


> 
> Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
> 
> ---
>  drivers/staging/hv/blkvsc.c        |    4 +-
>  drivers/staging/hv/blkvsc_drv.c    |    8 ++--
>  drivers/staging/hv/channel_mgmt.h  |    2 +-
>  drivers/staging/hv/netvsc.c        |   56 +++++++++++++++++++----------------
>  drivers/staging/hv/netvsc.h        |    2 +-
>  drivers/staging/hv/netvsc_api.h    |   12 ++++----
>  drivers/staging/hv/netvsc_drv.c    |   14 ++++----
>  drivers/staging/hv/rndis_filter.c  |   18 ++++++------
>  drivers/staging/hv/storvsc.c       |   36 ++++++++++++-----------
>  drivers/staging/hv/storvsc_api.h   |    4 +-
>  drivers/staging/hv/storvsc_drv.c   |   10 +++---
>  drivers/staging/hv/vmbus.h         |    6 ++--
>  drivers/staging/hv/vmbus_api.h     |    8 ++--
>  drivers/staging/hv/vmbus_drv.c     |   50 ++++++++++++++++----------------
>  drivers/staging/hv/vmbus_private.h |   12 ++++----
>  15 files changed, 124 insertions(+), 118 deletions(-)
> 
> diff --git a/drivers/staging/hv/blkvsc.c b/drivers/staging/hv/blkvsc.c
> index ecface3..47ccec2 100644
> --- a/drivers/staging/hv/blkvsc.c
> +++ b/drivers/staging/hv/blkvsc.c
> @@ -35,8 +35,8 @@ static const struct hv_guid g_blk_device_type = {
>  	}
>  };
>  
> -static int blk_vsc_on_device_add(struct vm_device *device,
> -				void *additional_info)
> +static int
> +blk_vsc_on_device_add(struct hyperv_device *device, void *additional_info)

Ick, why break the formatting like this?  Please keep the return type on
the same line as the function name.

You do that in a number of places, please don't.

thanks,

greg k-h
