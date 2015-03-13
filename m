From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH v2 log fixed] virtio_mmio: fix endian-ness for mmio
Date: Fri, 13 Mar 2015 11:58:31 +1030
Message-ID: <87zj7hvg74.fsf@rustcorp.com.au>
References: <20150312093739.GA4655@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20150312093739.GA4655@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

"Michael S. Tsirkin" <mst@redhat.com> writes:
> Subject: [PATCH] virtio_mmio: fix access width for mmio

Just for the record:

Applied.

Thanks,
Rusty.

> Going over the virtio mmio code, I noticed that it doesn't correctly
> access modern device config values using "natural" accessors: it uses
> readb to get/set them byte by byte, while the virtio 1.0 spec explicitly states:
>
>         4.2.2.2 Driver Requirements: MMIO Device Register Layout
>
>         ...
>
>         The driver MUST only use 32 bit wide and aligned reads and writes to
>         access the control registers described in table 4.1.
>         For the device-specific configuration space, the driver MUST use
>         8 bit wide accesses for 8 bit wide fields, 16 bit wide and aligned
>         accesses for 16 bit wide fields and 32 bit wide and aligned accesses for
>         32 and 64 bit wide fields.
>
> Borrow code from virtio_pci_modern to do this correctly.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>
> ---
>
> This is exactly the same as PATCH virtio_mmio: fix endian-ness for mmio
> but with corrected subject and commit log, to make
> it easier to apply.
>
> Note: untested: QEMU doesn't support virtio 1.0 for virtio-mmio,
> but seems pretty obvious. Let's apply ASAP so we don't ship
> incompliant drivers for virtio 1.0?
>
>  drivers/virtio/virtio_mmio.c | 79 +++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 71 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
> index cad5698..0375456 100644
> --- a/drivers/virtio/virtio_mmio.c
> +++ b/drivers/virtio/virtio_mmio.c
> @@ -156,22 +156,85 @@ static void vm_get(struct virtio_device *vdev, unsigned offset,
>  		   void *buf, unsigned len)
>  {
>  	struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
> -	u8 *ptr = buf;
> -	int i;
> +	void __iomem *base = vm_dev->base + VIRTIO_MMIO_CONFIG;
> +	u8 b;
> +	__le16 w;
> +	__le32 l;
>  
> -	for (i = 0; i < len; i++)
> -		ptr[i] = readb(vm_dev->base + VIRTIO_MMIO_CONFIG + offset + i);
> +	if (vm_dev->version == 1) {
> +		u8 *ptr = buf;
> +		int i;
> +
> +		for (i = 0; i < len; i++)
> +			ptr[i] = readb(base + offset + i);
> +		return;
> +	}
> +
> +	switch (len) {
> +	case 1:
> +		b = readb(base + offset);
> +		memcpy(buf, &b, sizeof b);
> +		break;
> +	case 2:
> +		w = cpu_to_le16(readw(base + offset));
> +		memcpy(buf, &w, sizeof w);
> +		break;
> +	case 4:
> +		l = cpu_to_le32(readl(base + offset));
> +		memcpy(buf, &l, sizeof l);
> +		break;
> +	case 8:
> +		l = cpu_to_le32(readl(base + offset));
> +		memcpy(buf, &l, sizeof l);
> +		l = cpu_to_le32(ioread32(base + offset + sizeof l));
> +		memcpy(buf + sizeof l, &l, sizeof l);
> +		break;
> +	default:
> +		BUG();
> +	}
>  }
>  
>  static void vm_set(struct virtio_device *vdev, unsigned offset,
>  		   const void *buf, unsigned len)
>  {
>  	struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
> -	const u8 *ptr = buf;
> -	int i;
> +	void __iomem *base = vm_dev->base + VIRTIO_MMIO_CONFIG;
> +	u8 b;
> +	__le16 w;
> +	__le32 l;
>  
> -	for (i = 0; i < len; i++)
> -		writeb(ptr[i], vm_dev->base + VIRTIO_MMIO_CONFIG + offset + i);
> +	if (vm_dev->version == 1) {
> +		const u8 *ptr = buf;
> +		int i;
> +
> +		for (i = 0; i < len; i++)
> +			writeb(ptr[i], base + offset + i);
> +
> +		return;
> +	}
> +
> +	switch (len) {
> +	case 1:
> +		memcpy(&b, buf, sizeof b);
> +		writeb(b, base + offset);
> +		break;
> +	case 2:
> +		memcpy(&w, buf, sizeof w);
> +		writew(le16_to_cpu(w), base + offset);
> +		break;
> +	case 4:
> +		memcpy(&l, buf, sizeof l);
> +		writel(le32_to_cpu(l), base + offset);
> +		break;
> +	case 8:
> +		memcpy(&l, buf, sizeof l);
> +		writel(le32_to_cpu(l), base + offset);
> +		memcpy(&l, buf + sizeof l, sizeof l);
> +		writel(le32_to_cpu(l), base + offset + sizeof l);
> +		break;
> +	default:
> +		BUG();
> +	}
>  }
>  
>  static u8 vm_get_status(struct virtio_device *vdev)
> -- 
> MST
