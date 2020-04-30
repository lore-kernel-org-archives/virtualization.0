From: Srivatsa Vaddagiri <vatsa@codeaurora.org>
Subject: Re: [RFC/PATCH 1/1] virtio: Introduce MMIO ops
Date: Thu, 30 Apr 2020 16:04:46 +0530
Message-ID: <20200430103446.GH5097@quicinc.com>
References: <1588240976-10213-1-git-send-email-vatsa@codeaurora.org>
 <1588240976-10213-2-git-send-email-vatsa@codeaurora.org>
 <20200430101431.GD19932@willie-the-truck>
Reply-To: Srivatsa Vaddagiri <vatsa@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200430101431.GD19932@willie-the-truck>
Sender: linux-kernel-owner@vger.kernel.org
To: Will Deacon <will@kernel.org>
Cc: konrad.wilk@oracle.com, mst@redhat.com, jasowang@redhat.com, jan.kiszka@siemens.com, stefano.stabellini@xilinx.com, iommu@lists.linux-foundation.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, tsoni@codeaurora.org, pratikp@codeaurora.org, christoffer.dall@arm.com, alex.bennee@linaro.org, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

* Will Deacon <will@kernel.org> [2020-04-30 11:14:32]:

> > +#ifdef CONFIG_VIRTIO_MMIO_OPS
> >  
> > +static struct virtio_mmio_ops *mmio_ops;
> > +
> > +#define virtio_readb(a)		mmio_ops->mmio_readl((a))
> > +#define virtio_readw(a)		mmio_ops->mmio_readl((a))
> > +#define virtio_readl(a)		mmio_ops->mmio_readl((a))
> > +#define virtio_writeb(val, a)	mmio_ops->mmio_writeb((val), (a))
> > +#define virtio_writew(val, a)	mmio_ops->mmio_writew((val), (a))
> > +#define virtio_writel(val, a)	mmio_ops->mmio_writel((val), (a))
> 
> How exactly are these ops hooked up? I'm envisaging something like:
> 
> 	ops = spec_compliant_ops;
> 	[...]
> 	if (firmware_says_hypervisor_is_buggy())
> 		ops = magic_qcom_ops;
> 
> am I wrong?

If CONFIG_VIRTIO_MMIO_OPS is defined, then I expect this to be unconditionally
set to 'magic_qcom_ops' that uses hypervisor-supported interface for IO (for
example: message_queue_send() and message_queue_recevie() hypercalls).

> > +int register_virtio_mmio_ops(struct virtio_mmio_ops *ops)
> > +{
> > +	pr_info("Registered %s as mmio ops\n", ops->name);
> > +	mmio_ops = ops;
> 
> Not looking good, and really defeats the point of standardising this stuff
> imo.

Ok. I guess the other option is to standardize on a new virtio transport (like
ivshmem2-virtio)?

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
