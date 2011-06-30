From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 24/40] Staging: hv: storvsc: On I/O get the correct IDE
	device
Date: Thu, 30 Jun 2011 15:40:55 -0400
Message-ID: <20110630194055.GC22707@infradead.org>
References: <1309358301-8488-1-git-send-email-kys@microsoft.com>
	<1309358377-8537-1-git-send-email-kys@microsoft.com>
	<1309358377-8537-24-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
Content-Disposition: inline
In-Reply-To: <1309358377-8537-24-git-send-email-kys@microsoft.com>
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
Cc: Abhishek Kane <v-abkane@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, gregkh@suse.de, linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, devel@linuxdriverproject.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jun 29, 2011 at 07:39:21AM -0700, K. Y. Srinivasan wrote:
> We use the channel number to distinguish an IDE device managed by the
> storvsc driver from scsi devices. Add code to get the correct
> device pointer based on the channel number.
> 
> Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
> Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
> ---
>  drivers/staging/hv/storvsc_drv.c |   10 ++++++++++
>  1 files changed, 10 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/staging/hv/storvsc_drv.c b/drivers/staging/hv/storvsc_drv.c
> index cf659d7..fcc3f5d 100644
> --- a/drivers/staging/hv/storvsc_drv.c
> +++ b/drivers/staging/hv/storvsc_drv.c
> @@ -517,6 +517,16 @@ static int storvsc_queuecommand_lck(struct scsi_cmnd *scmnd,
>  	unsigned int sg_count = 0;
>  	struct vmscsi_request *vm_srb;
>  
> +	if (scmnd->device->channel >= HV_IDE_BASE_CHANNEL) {
> +		int channel = scmnd->device->channel;
> +
> +		/*
> +		 * This is an IDE device; get the right dev.
> +		 */
> +
> +		dev = ide_devices[channel - HV_IDE_BASE_CHANNEL];
> +	}

So instead of playing games about getting the right hv_device here,
why don't you register one scsi host for each IDE device? libata
does the same for real ATA devices.
