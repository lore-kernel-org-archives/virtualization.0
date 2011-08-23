From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 017/117] Staging: hv: mouse: Do not auto-load the mouse
	driver
Date: Tue, 23 Aug 2011 15:47:11 -0700
Message-ID: <20110823224711.GE9641@kroah.com>
References: <1310752024-27854-1-git-send-email-kys@microsoft.com>
	<1310752065-27895-1-git-send-email-kys@microsoft.com>
	<1310752065-27895-17-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
Content-Disposition: inline
In-Reply-To: <1310752065-27895-17-git-send-email-kys@microsoft.com>
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

On Fri, Jul 15, 2011 at 10:46:05AM -0700, K. Y. Srinivasan wrote:
> The mouse driver is not functional and so, prevent auto-loading
> of this driver. Earlier we added the MODULE_DEVICE_TABLE() line
> to verify that the appropriate module alias was generated.
> 
> Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> ---
>  drivers/staging/hv/hv_mouse.c |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/staging/hv/hv_mouse.c b/drivers/staging/hv/hv_mouse.c
> index d6441d6..95986fb 100644
> --- a/drivers/staging/hv/hv_mouse.c
> +++ b/drivers/staging/hv/hv_mouse.c
> @@ -931,7 +931,10 @@ static const struct hv_vmbus_device_id id_table[] = {
>  	},
>  };
>  
> -MODULE_DEVICE_TABLE(vmbus, id_table);
> +/*
> + * The mouse driver is not functional; do not auto-load it.
> + */
> +/* MODULE_DEVICE_TABLE(vmbus, id_table); */

Then you should not have caused it to be autoloaded on the previous
patch.  Please merge this with the previous patch, which would be merged
with the previous patch to that, smushing them all into a smaller patch
series.

greg k-h
