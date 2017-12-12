From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH 1/3] virtio_pci: use put_device instead of kfree
Date: Tue, 12 Dec 2017 11:00:25 +0100
Message-ID: <20171212110025.5d029fce.cohuck@redhat.com>
References: <cover.1513007310.git.zhangweiping@didichuxing.com>
	<0657b3e821f7c9f95ecf93e0286fa0b48a3e1289.1513007310.git.zhangweiping@didichuxing.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <0657b3e821f7c9f95ecf93e0286fa0b48a3e1289.1513007310.git.zhangweiping@didichuxing.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: weiping zhang <zhangweiping@didichuxing.com>
Cc: virtualization@lists.linux-foundation.org, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 11 Dec 2017 23:55:16 +0800
weiping zhang <zhangweiping@didichuxing.com> wrote:

> don't free vp_dev until vp_dev->vdev.dev.release be called.

Maybe add the same description as in your virtio_mmio patch so that it
is clear why the kfree() is not ok?

> 
> Signed-off-by: weiping zhang <zhangweiping@didichuxing.com>
> ---
>  drivers/virtio/virtio_pci_common.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> index 1c4797e..91d20f7 100644
> --- a/drivers/virtio/virtio_pci_common.c
> +++ b/drivers/virtio/virtio_pci_common.c
> @@ -551,16 +551,17 @@ static int virtio_pci_probe(struct pci_dev *pci_dev,
>  	pci_set_master(pci_dev);
>  
>  	rc = register_virtio_device(&vp_dev->vdev);
> -	if (rc)
> -		goto err_register;
> +	if (rc) {
> +		if (vp_dev->ioaddr)
> +		     virtio_pci_legacy_remove(vp_dev);
> +		else
> +		     virtio_pci_modern_remove(vp_dev);
> +		pci_disable_device(pci_dev);
> +		put_device(&vp_dev->vdev.dev);
> +	}
>  
> -	return 0;
> +	return rc;
>  
> -err_register:
> -	if (vp_dev->ioaddr)
> -	     virtio_pci_legacy_remove(vp_dev);
> -	else
> -	     virtio_pci_modern_remove(vp_dev);
>  err_probe:
>  	pci_disable_device(pci_dev);
>  err_enable_device:

Otherwise, looks good.

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
