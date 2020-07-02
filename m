From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 2/2] virtio-mmio: Reject invalid IRQ 0 command line
 argument
Date: Thu, 2 Jul 2020 11:06:11 +0800
Message-ID: <032d0424-4876-6322-76d2-d733db28addb@redhat.com>
References: <20200701221040.3667868-1-helgaas@kernel.org>
 <20200701221040.3667868-3-helgaas@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200701221040.3667868-3-helgaas@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Bjorn Helgaas <helgaas@kernel.org>, linux-kernel@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>, "Michael S . Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org


On 2020/7/2 上午6:10, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
>
> The "virtio_mmio.device=" command line argument allows a user to specify
> the size, address, and IRQ of a virtio device.  Previously the only
> requirement for the IRQ was that it be an unsigned integer.
>
> Zero is an unsigned integer but an invalid IRQ number, and after
> a85a6c86c25be ("driver core: platform: Clarify that IRQ 0 is invalid"),
> attempts to use IRQ 0 cause warnings.
>
> If the user specifies IRQ 0, return failure instead of registering a device
> with IRQ 0.
>
> Fixes: a85a6c86c25be ("driver core: platform: Clarify that IRQ 0 is invalid")
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: virtualization@lists.linux-foundation.org
> ---
>   drivers/virtio/virtio_mmio.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
> index 9d16aaffca9d..627ac0487494 100644
> --- a/drivers/virtio/virtio_mmio.c
> +++ b/drivers/virtio/virtio_mmio.c
> @@ -641,11 +641,11 @@ static int vm_cmdline_set(const char *device,
>   			&vm_cmdline_id, &consumed);
>   
>   	/*
> -	 * sscanf() must processes at least 2 chunks; also there
> +	 * sscanf() must process at least 2 chunks; also there
>   	 * must be no extra characters after the last chunk, so
>   	 * str[consumed] must be '\0'
>   	 */
> -	if (processed < 2 || str[consumed])
> +	if (processed < 2 || str[consumed] || irq == 0)
>   		return -EINVAL;
>   
>   	resources[0].flags = IORESOURCE_MEM;


Acked-by: Jason Wang <jasowang@redhat.com>
