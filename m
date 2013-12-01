From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] virtio: pci: remove unnecessary pci_set_drvdata()
Date: Sun, 01 Dec 2013 21:07:39 +1030
Message-ID: <87y54426x8.fsf@rustcorp.com.au>
References: <002301cee98d$b658da60$230a8f20$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <002301cee98d$b658da60$230a8f20$%han@samsung.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
Cc: 'Jingoo Han' <jg1.han@samsung.com>, "'Michael S. Tsirkin'" <mst@redhat.com>, 'Andrew Vagin' <avagin@openvz.org>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Jingoo Han <jg1.han@samsung.com> writes:
> The driver core clears the driver data to NULL after device_release
> or on probe failure. Thus, it is not needed to manually clear the
> device driver data to NULL.
>
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>

Applied.

Thanks,
Rusty.

> ---
>  drivers/virtio/virtio_pci.c |    2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/virtio/virtio_pci.c b/drivers/virtio/virtio_pci.c
> index a37c699..a416f9b 100644
> --- a/drivers/virtio/virtio_pci.c
> +++ b/drivers/virtio/virtio_pci.c
> @@ -742,7 +742,6 @@ static int virtio_pci_probe(struct pci_dev *pci_dev,
>  	return 0;
>  
>  out_set_drvdata:
> -	pci_set_drvdata(pci_dev, NULL);
>  	pci_iounmap(pci_dev, vp_dev->ioaddr);
>  out_req_regions:
>  	pci_release_regions(pci_dev);
> @@ -760,7 +759,6 @@ static void virtio_pci_remove(struct pci_dev *pci_dev)
>  	unregister_virtio_device(&vp_dev->vdev);
>  
>  	vp_del_vqs(&vp_dev->vdev);
> -	pci_set_drvdata(pci_dev, NULL);
>  	pci_iounmap(pci_dev, vp_dev->ioaddr);
>  	pci_release_regions(pci_dev);
>  	pci_disable_device(pci_dev);
> -- 
> 1.7.10.4
