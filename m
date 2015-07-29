From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] virtio_mmio: add ACPI probing
Date: Wed, 29 Jul 2015 21:17:08 +0300
Message-ID: <20150729211637-mutt-send-email-mst__38407.667229376$1438193847$gmane$org@redhat.com>
References: <1438076642-12080-1-git-send-email-graeme.gregory@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1438076642-12080-1-git-send-email-graeme.gregory@linaro.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Graeme Gregory <graeme.gregory@linaro.org>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jul 28, 2015 at 10:44:02AM +0100, Graeme Gregory wrote:
> Added the match table and pointers for ACPI probing to the driver.
> 
> This uses the same identifier for virt devices as being used for qemu
> ARM64 ACPI support.
> 
> http://git.linaro.org/people/shannon.zhao/qemu.git/commit/d0bf1955a3ecbab4b51d46f8c5dda02b7e14a17e
> 
> Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>

To summarize, let's wait a bit with this until QEMU 2.4
with the relevant code is out, to make sure ID does not
change.

> ---
>  drivers/virtio/virtio_mmio.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
> index 10189b5..f499d9d 100644
> --- a/drivers/virtio/virtio_mmio.c
> +++ b/drivers/virtio/virtio_mmio.c
> @@ -58,6 +58,7 @@
>  
>  #define pr_fmt(fmt) "virtio-mmio: " fmt
>  
> +#include <linux/acpi.h>
>  #include <linux/highmem.h>
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
> @@ -732,12 +733,21 @@ static struct of_device_id virtio_mmio_match[] = {
>  };
>  MODULE_DEVICE_TABLE(of, virtio_mmio_match);
>  
> +#ifdef CONFIG_ACPI
> +static const struct acpi_device_id virtio_mmio_acpi_match[] = {
> +	{ "LNRO0005", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(acpi, virtio_mmio_acpi_match);
> +#endif
> +
>  static struct platform_driver virtio_mmio_driver = {
>  	.probe		= virtio_mmio_probe,
>  	.remove		= virtio_mmio_remove,
>  	.driver		= {
>  		.name	= "virtio-mmio",
>  		.of_match_table	= virtio_mmio_match,
> +		.acpi_match_table = ACPI_PTR(virtio_mmio_acpi_match),
>  	},
>  };
>  
> -- 
> 2.1.4
