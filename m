From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 11/21] Staging: hv: Make vmbus driver a platform pci
 driver
Date: Mon, 14 Mar 2011 12:34:52 -0700
Message-ID: <20110314193452.GB18944@kroah.com>
References: <1299794912-1233-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1299794912-1233-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org, Haiyang Zhang <haiyangz@microsoft.com>, Mike Sterling <mike.sterling@microsoft.com>, Abhishek Kane <v-abkane@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Mar 10, 2011 at 02:08:32PM -0800, K. Y. Srinivasan wrote:
> Make vmbus driver a platform pci driver. This is
> in preparation to cleaning up irq allocation for this
> driver.

Now wouldn't this be the "root" device that everything else hangs off
of? 

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
> index 8b9394a..e4855ac 100644
> --- a/drivers/staging/hv/vmbus_drv.c
> +++ b/drivers/staging/hv/vmbus_drv.c
> @@ -43,6 +43,8 @@
>  
>  static struct device *root_dev; /* Root device */
>  
> +struct pci_dev *hv_pci_dev;

Why do you have 2 different devices here?  Is the root_dev still needed
now?

Still confused,

greg k-h
