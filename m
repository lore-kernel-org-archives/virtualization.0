From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] virtio: pci: Use SIMPLE_DEV_PM_OPS macro
Date: Tue, 09 Sep 2014 09:43:42 +0930
Message-ID: <8761gxk5vt.fsf@rustcorp.com.au>
References: <003a01cfc8bc$bf48cd60$3dda6820$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <003a01cfc8bc$bf48cd60$3dda6820$%han@samsung.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
Cc: 'Jingoo Han' <jg1.han@samsung.com>, virtualization@lists.linux-foundation.org, "'Michael S. Tsirkin'" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Jingoo Han <jg1.han@samsung.com> writes:
> Use SIMPLE_DEV_PM_OPS macro in order to make the code simpler.
>
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>

This patch is obviously wrong.  It won't compile without
CONFIG_PM_SLEEP.

Cheers,
Rusty.

> ---
>  drivers/virtio/virtio_pci.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/virtio/virtio_pci.c b/drivers/virtio/virtio_pci.c
> index 3d1463c6b120..c5fbdb4023d1 100644
> --- a/drivers/virtio/virtio_pci.c
> +++ b/drivers/virtio/virtio_pci.c
> @@ -810,20 +810,17 @@ static int virtio_pci_restore(struct device *dev)
>  
>  	return ret;
>  }
> -
> -static const struct dev_pm_ops virtio_pci_pm_ops = {
> -	SET_SYSTEM_SLEEP_PM_OPS(virtio_pci_freeze, virtio_pci_restore)
> -};
>  #endif
>  
> +static SIMPLE_DEV_PM_OPS(virtio_pci_pm_ops, virtio_pci_freeze,
> +			 virtio_pci_restore);
> +
>  static struct pci_driver virtio_pci_driver = {
>  	.name		= "virtio-pci",
>  	.id_table	= virtio_pci_id_table,
>  	.probe		= virtio_pci_probe,
>  	.remove		= virtio_pci_remove,
> -#ifdef CONFIG_PM_SLEEP
>  	.driver.pm	= &virtio_pci_pm_ops,
> -#endif
>  };
>  
>  module_pci_driver(virtio_pci_driver);
> -- 
> 2.0.0
