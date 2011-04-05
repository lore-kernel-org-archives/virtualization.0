From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 03/12] Staging: hv: Cleanup irq management
Date: Mon, 4 Apr 2011 21:19:50 -0700
Message-ID: <20110405041950.GB8090@kroah.com>
References: <1300226527-26933-1-git-send-email-kys@microsoft.com>
 <1300226624-27004-1-git-send-email-kys@microsoft.com>
 <1300226624-27004-2-git-send-email-kys@microsoft.com>
 <1300226624-27004-3-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1300226624-27004-3-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org, Haiyang Zhang <haiyangz@microsoft.com>, Mike Sterling <mike.sterling@microsoft.com>, Abhishek Kane <v-abkane@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Mar 15, 2011 at 03:03:34PM -0700, K. Y. Srinivasan wrote:
> Now that vmbus_driver is a  pci driver,
> cleanup the irq allocation mess by using the standard
> irq allocation mechanisms.
> 
> Note that this patch generates an error when the checkpatch
> script is run because of the IRQF_SAMPLE_RANDOM flag used in
> request_irq() function. This interrupt may be the only
> external event this VM will get and consequently if this
> flag (IRQF_SAMPLE_RANDOM) is not  specified, experimentally
> we have shown that the entropy in the VM will very very low.
> 
> 
> Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> Signed-off-by: Mike Sterling <mike.sterling@microsoft.com>
> Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
> Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
> ---
>  drivers/staging/hv/vmbus_drv.c |   28 +++++++++++++---------------
>  1 files changed, 13 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/staging/hv/vmbus_drv.c b/drivers/staging/hv/vmbus_drv.c
> index 3d2789b..239b91c 100644
> --- a/drivers/staging/hv/vmbus_drv.c
> +++ b/drivers/staging/hv/vmbus_drv.c
> @@ -17,6 +17,8 @@
>   * Authors:
>   *   Haiyang Zhang <haiyangz@microsoft.com>
>   *   Hank Janssen  <hjanssen@microsoft.com>
> + *
> + * 3/9/2011: K. Y. Srinivasan	- Significant restructuring and cleanup

Changelog comments never belong in the file itself.  If you consider
yourself an author of the file now, then put your name in it with the
others.

thanks,

greg k-h
