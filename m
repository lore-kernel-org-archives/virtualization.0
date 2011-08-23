From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 020/117] Staging: hv: vmbus: Support the notion of id
	tables in vmbus_match()
Date: Tue, 23 Aug 2011 15:51:50 -0700
Message-ID: <20110823225150.GG9641@kroah.com>
References: <1310752024-27854-1-git-send-email-kys@microsoft.com>
	<1310752065-27895-1-git-send-email-kys@microsoft.com>
	<1310752065-27895-20-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
Content-Disposition: inline
In-Reply-To: <1310752065-27895-20-git-send-email-kys@microsoft.com>
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

On Fri, Jul 15, 2011 at 10:46:08AM -0700, K. Y. Srinivasan wrote:
> Introduce code to handle driver specific id tables to the vmbus core
> (vmbus_match). This would allow us to handle more than one device type
> with a given driver.
> 
> Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> ---
>  drivers/staging/hv/vmbus_drv.c |   21 ++++++++++++++++-----
>  1 files changed, 16 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/hv/vmbus_drv.c b/drivers/staging/hv/vmbus_drv.c
> index 7baba62..3a8eb36 100644
> --- a/drivers/staging/hv/vmbus_drv.c
> +++ b/drivers/staging/hv/vmbus_drv.c
> @@ -255,21 +255,32 @@ static int vmbus_uevent(struct device *device, struct kobj_uevent_env *env)
>  	return ret;
>  }
>  
> +static bool is_not_null_guid(const __u8 *guid)

Negative function names cause people's heads to get confused.

Please do "is_null_guid()" instead.

thanks,

greg k-h
