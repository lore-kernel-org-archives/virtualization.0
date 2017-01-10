From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] virtio_mmio: Set DMA masks appropriately
Date: Tue, 10 Jan 2017 14:15:57 +0100
Message-ID: <2220292.9CN9cxzsPe@wuerfel>
References: <50defbbe87d75db85a9d22f914258975d661208a.1484051089.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <50defbbe87d75db85a9d22f914258975d661208a.1484051089.git.robin.murphy@arm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-arm-kernel@lists.infradead.org
Cc: mst@redhat.com, will.deacon@arm.com, virtualization@lists.linux-foundation.org, luto@kernel.org, Robin Murphy <robin.murphy@arm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tuesday, January 10, 2017 12:26:01 PM CET Robin Murphy wrote:
> @@ -548,6 +550,14 @@ static int virtio_mmio_probe(struct platform_device *pdev)
>         if (vm_dev->version == 1)
>                 writel(PAGE_SIZE, vm_dev->base + VIRTIO_MMIO_GUEST_PAGE_SIZE);
>  
> +       rc = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
> +       if (rc)
> +               rc = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));

You don't seem to do anything different when 64-bit DMA is unsupported.
How do you prevent the use of kernel buffers that are above the first 4G
here?

> +       else if (vm_dev->version == 1)
> +               dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(32 + PAGE_SHIFT));

Why is this limitation only for the coherent mask?

	Arnd
