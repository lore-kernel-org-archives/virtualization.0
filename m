From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] virtio-mmio: Delete an error message in vm_find_vqs()
Date: Thu, 9 Apr 2020 11:19:20 +0800
Message-ID: <03b19e72-0021-dc6b-77c4-ed3c4e13d526@redhat.com>
References: <9e27bc4a-cfa1-7818-dc25-8ad308816b30@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <9e27bc4a-cfa1-7818-dc25-8ad308816b30@web.de>
Content-Language: en-US
Sender: kernel-janitors-owner@vger.kernel.org
To: Markus Elfring <Markus.Elfring@web.de>, virtualization@lists.linux-foundation.org, "Michael S. Tsirkin" <mst@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Tang Bin <tangbin@cmss.chinamobile.com>
List-Id: virtualization@lists.linuxfoundation.org


On 2020/4/6 =E4=B8=8A=E5=8D=881:19, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 5 Apr 2020 19:14:10 +0200
>
> The function =E2=80=9Cplatform_get_irq=E2=80=9D can log an error alread=
y.
> Thus omit a redundant message for the exception handling in the
> calling function.


It looks to me that not all error path of platform_get_irq() were loggd.

And git grep told me there're other users of platform_get_irq() that=20
check and log by themselves.

Thanks


>
> This issue was detected by using the Coccinelle software.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>   drivers/virtio/virtio_mmio.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.=
c
> index 97d5725fd9a2..9d16aaffca9d 100644
> --- a/drivers/virtio/virtio_mmio.c
> +++ b/drivers/virtio/virtio_mmio.c
> @@ -466,10 +466,8 @@ static int vm_find_vqs(struct virtio_device *vdev,=
 unsigned nvqs,
>   	int irq =3D platform_get_irq(vm_dev->pdev, 0);
>   	int i, err, queue_idx =3D 0;
>
> -	if (irq < 0) {
> -		dev_err(&vdev->dev, "Cannot get IRQ resource\n");
> +	if (irq < 0)
>   		return irq;
> -	}
>
>   	err =3D request_irq(irq, vm_interrupt, IRQF_SHARED,
>   			dev_name(&vdev->dev), vm_dev);
> --
> 2.26.0
>
