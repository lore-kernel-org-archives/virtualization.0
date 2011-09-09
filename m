From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 10/25] Staging: hv: vmbus: Return proper error code in
	vmbus_remove()
Date: Fri, 9 Sep 2011 13:43:09 -0700
Message-ID: <20110909204309.GG19127@kroah.com>
References: <1315491843-9513-1-git-send-email-kys@microsoft.com>
	<1315491876-9554-1-git-send-email-kys@microsoft.com>
	<1315491876-9554-10-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1315491876-9554-10-git-send-email-kys@microsoft.com>
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

On Thu, Sep 08, 2011 at 07:24:21AM -0700, K. Y. Srinivasan wrote:
> Return proper error code in vmbus_remove().
> 
> Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> ---
>  drivers/staging/hv/vmbus_drv.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/hv/vmbus_drv.c b/drivers/staging/hv/vmbus_drv.c
> index b9aeb76..95d33a4 100644
> --- a/drivers/staging/hv/vmbus_drv.c
> +++ b/drivers/staging/hv/vmbus_drv.c
> @@ -325,7 +325,7 @@ static int vmbus_probe(struct device *child_device)
>   */
>  static int vmbus_remove(struct device *child_device)
>  {
> -	int ret;
> +	int ret = 0;

As remove functions can't fail, why return anything at all?

Doesn't make sense, please fix.

greg k-h
