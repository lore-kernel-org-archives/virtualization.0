From: "Ivan T. Ivanov" <iivanov.xz@gmail.com>
Subject: Re: [PATCH] virtio-mmio: add error check for platform_get_irq
Date: Tue, 02 Jul 2019 16:31:30 +0300
Message-ID: <156207429000.5051.5975712347598980745__953.858164005794$1563995244$gmane$org@silver>
References: <20190702095918.12852-1-ihor.matushchak@foobox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190702095918.12852-1-ihor.matushchak@foobox.net>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: mst@redhat.com
Cc: ihor.matushchak@foobox.net, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org


Hi,

Quoting Ihor Matushchak (2019-07-02 12:59:18)
> in vm_find_vqs() irq has a wrong type
> so, in case of no IRQ resource defined,
> wrong parameter will be passed to request_irq()
> 
> Signed-off-by: Ihor Matushchak <ihor.matushchak@foobox.net>
> ---
>  drivers/virtio/virtio_mmio.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
> index f363fbeb5ab0..60dde8ed163b 100644
> --- a/drivers/virtio/virtio_mmio.c
> +++ b/drivers/virtio/virtio_mmio.c
> @@ -463,9 +463,14 @@ static int vm_find_vqs(struct virtio_device *vdev, unsigned nvqs,
>                        struct irq_affinity *desc)
>  {
>         struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
> -       unsigned int irq = platform_get_irq(vm_dev->pdev, 0);
> +       int irq = platform_get_irq(vm_dev->pdev, 0);
>         int i, err, queue_idx = 0;
>  
> +       if (irq < 0) {
> +               dev_err(&vdev->dev, "no IRQ resource defined\n");
> +               return -ENODEV;

Don't overwrite error code value. Just return it as it is.

Regards,
Ivan
