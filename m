From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 01/12] Staging: hv: Make vmbus driver a  pci driver
Date: Mon, 4 Apr 2011 21:16:00 -0700
Message-ID: <20110405041600.GA8090@kroah.com>
References: <1300226527-26933-1-git-send-email-kys@microsoft.com>
	<1300226624-27004-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
Content-Disposition: inline
In-Reply-To: <1300226624-27004-1-git-send-email-kys@microsoft.com>
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
Cc: Abhishek Kane <v-abkane@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, gregkh@suse.de, linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, Mike Sterling <mike.sterling@microsoft.com>, devel@linuxdriverproject.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Mar 15, 2011 at 03:03:32PM -0700, K. Y. Srinivasan wrote:
> Make vmbus driver a pci driver. This is
> in preparation to cleaning up the root device
> management as well as the  irq allocation for this
> driver.
> 
> Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> Signed-off-by: Mike Sterling <mike.sterling@microsoft.com>
> Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
> Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
> ---
>  drivers/staging/hv/vmbus_drv.c |   63 +++++++++++++++++++++++-----------------
>  1 files changed, 36 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/staging/hv/vmbus_drv.c b/drivers/staging/hv/vmbus_drv.c
> index b473f46..1ef2f0f 100644
> --- a/drivers/staging/hv/vmbus_drv.c
> +++ b/drivers/staging/hv/vmbus_drv.c
> @@ -40,6 +40,8 @@
>  #define VMBUS_IRQ		0x5
>  #define VMBUS_IRQ_VECTOR	IRQ5_VECTOR
>  
> +struct pci_dev *hv_pci_dev;

Why is this global?

Have you forgot to run 'sparse' on your changes?

thanks,

greg k-h
