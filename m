From: Will Deacon <will@kernel.org>
Subject: Re: [RFC/PATCH 1/1] virtio: Introduce MMIO ops
Date: Thu, 30 Apr 2020 11:14:32 +0100
Message-ID: <20200430101431.GD19932@willie-the-truck>
References: <1588240976-10213-1-git-send-email-vatsa@codeaurora.org>
 <1588240976-10213-2-git-send-email-vatsa@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1588240976-10213-2-git-send-email-vatsa@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Srivatsa Vaddagiri <vatsa@codeaurora.org>
Cc: konrad.wilk@oracle.com, mst@redhat.com, jasowang@redhat.com, jan.kiszka@siemens.com, stefano.stabellini@xilinx.com, iommu@lists.linux-foundation.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, tsoni@codeaurora.org, pratikp@codeaurora.org, christoffer.dall@arm.com, alex.bennee@linaro.org, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Apr 30, 2020 at 03:32:56PM +0530, Srivatsa Vaddagiri wrote:
> Some hypervisors may not support MMIO transport i.e trap config
> space access and have it be handled by backend driver. They may
> allow other ways to interact with backend such as message-queue
> or doorbell API. This patch allows for hypervisor specific
> methods for config space IO.
> 
> Signed-off-by: Srivatsa Vaddagiri <vatsa@codeaurora.org>
> ---
>  drivers/virtio/virtio_mmio.c | 131 ++++++++++++++++++++++++++-----------------
>  include/linux/virtio.h       |  14 +++++
>  2 files changed, 94 insertions(+), 51 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
> index 97d5725..69bfa35 100644
> --- a/drivers/virtio/virtio_mmio.c
> +++ b/drivers/virtio/virtio_mmio.c
> @@ -100,7 +100,35 @@ struct virtio_mmio_vq_info {
>  	struct list_head node;
>  };
>  
> +#ifdef CONFIG_VIRTIO_MMIO_OPS
>  
> +static struct virtio_mmio_ops *mmio_ops;
> +
> +#define virtio_readb(a)		mmio_ops->mmio_readl((a))
> +#define virtio_readw(a)		mmio_ops->mmio_readl((a))
> +#define virtio_readl(a)		mmio_ops->mmio_readl((a))
> +#define virtio_writeb(val, a)	mmio_ops->mmio_writeb((val), (a))
> +#define virtio_writew(val, a)	mmio_ops->mmio_writew((val), (a))
> +#define virtio_writel(val, a)	mmio_ops->mmio_writel((val), (a))

How exactly are these ops hooked up? I'm envisaging something like:

	ops = spec_compliant_ops;
	[...]
	if (firmware_says_hypervisor_is_buggy())
		ops = magic_qcom_ops;

am I wrong?

> +int register_virtio_mmio_ops(struct virtio_mmio_ops *ops)
> +{
> +	pr_info("Registered %s as mmio ops\n", ops->name);
> +	mmio_ops = ops;

Not looking good, and really defeats the point of standardising this stuff
imo.

Will
