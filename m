From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 031/117] Staging: hv: netvsc: Get rid of the driver name
	initialization in netvsc.c
Date: Tue, 23 Aug 2011 15:56:03 -0700
Message-ID: <20110823225603.GI9641@kroah.com>
References: <1310752024-27854-1-git-send-email-kys@microsoft.com>
	<1310752065-27895-1-git-send-email-kys@microsoft.com>
	<1310752065-27895-31-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
Content-Disposition: inline
In-Reply-To: <1310752065-27895-31-git-send-email-kys@microsoft.com>
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

On Fri, Jul 15, 2011 at 10:46:19AM -0700, K. Y. Srinivasan wrote:
> Now, get rid of the driver name initialization in  int netvsc_initialize().
> 
> Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> ---
>  drivers/staging/hv/netvsc.c |    5 -----
>  1 files changed, 0 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/hv/netvsc.c b/drivers/staging/hv/netvsc.c
> index 6f4541b..d085018 100644
> --- a/drivers/staging/hv/netvsc.c
> +++ b/drivers/staging/hv/netvsc.c
> @@ -32,9 +32,6 @@
>  #include "hyperv_net.h"
>  
>  
> -/* Globals */
> -static const char *driver_name = "netvsc";
> -
>  static struct netvsc_device *alloc_net_device(struct hv_device *device)
>  {
>  	struct netvsc_device *net_device;
> @@ -999,7 +996,5 @@ cleanup:
>  int netvsc_initialize(struct hv_driver *drv)
>  {
>  
> -	drv->name = driver_name;
> -

Please merge this with the previous patch.

greg k-h
