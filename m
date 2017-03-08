From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] virtio-pci: Remove affinity hint before freeing the
	interrupt
Date: Wed, 8 Mar 2017 15:28:13 +0200
Message-ID: <20170308151940-mutt-send-email-mst@kernel.org>
References: <20170308080927.4493-1-marc.zyngier@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20170308080927.4493-1-marc.zyngier@arm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Mar 08, 2017 at 08:09:27AM +0000, Marc Zyngier wrote:
> virtio-pci registers a per-vq affinity hint when using MSIX,
> but fails to remove it when freeing the interrupt, resulting
> in this type of splat:
> 
> [   31.111202] WARNING: CPU: 0 PID: 2823 at kernel/irq/manage.c:1503 __free_irq+0x2c4/0x2c8
> [   31.114689] Modules linked in:
> [   31.116101] CPU: 0 PID: 2823 Comm: kexec Not tainted 4.10.0+ #6941
> [   31.118911] Hardware name: Generic DT based system
> [   31.121319] [<c022fb78>] (unwind_backtrace) from [<c0229d8c>] (show_stack+0x18/0x1c)
> [   31.125017] [<c0229d8c>] (show_stack) from [<c05192f4>] (dump_stack+0x84/0x98)
> [   31.128427] [<c05192f4>] (dump_stack) from [<c023d940>] (__warn+0xf4/0x10c)
> [   31.131910] [<c023d940>] (__warn) from [<c023da20>] (warn_slowpath_null+0x28/0x30)
> [   31.135543] [<c023da20>] (warn_slowpath_null) from [<c0290238>] (__free_irq+0x2c4/0x2c8)
> [   31.139355] [<c0290238>] (__free_irq) from [<c02902d0>] (free_irq+0x44/0x78)
> [   31.142909] [<c02902d0>] (free_irq) from [<c059d3a8>] (vp_del_vqs+0x68/0x1c0)
> [   31.146299] [<c059d3a8>] (vp_del_vqs) from [<c056ca4c>] (pci_device_shutdown+0x3c/0x78)
> 
> The obvious fix is to drop the affinity hint before freeing the
> interrupt.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Is this introduced by the changes in latest rc?

> ---
>  drivers/virtio/virtio_pci_common.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> index df548a6fb844..5a84f8207c02 100644
> --- a/drivers/virtio/virtio_pci_common.c
> +++ b/drivers/virtio/virtio_pci_common.c
> @@ -106,9 +106,12 @@ static void vp_remove_vqs(struct virtio_device *vdev)
>  		if (vp_dev->msix_vector_map) {
>  			int v = vp_dev->msix_vector_map[vq->index];
>  
> -			if (v != VIRTIO_MSI_NO_VECTOR)
> -				free_irq(pci_irq_vector(vp_dev->pci_dev, v),
> -					vq);
> +			if (v != VIRTIO_MSI_NO_VECTOR) {
> +				unsigned int irq;
> +				irq = pci_irq_vector(vp_dev->pci_dev, v);
> +				irq_set_affinity_hint(irq, NULL);
> +				free_irq(irq, vq);
> +			}
>  		}
>  		vp_dev->del_vq(vq);
>  	}
> -- 
> 2.11.0
