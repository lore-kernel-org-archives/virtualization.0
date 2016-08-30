From: Peter Griffin <peter.griffin@linaro.org>
Subject: Re: [PATCH v8 01/18] remoteproc: st_slim_rproc: add a slimcore rproc
	driver
Date: Tue, 30 Aug 2016 16:44:51 +0100
Message-ID: <20160830154451.GB22514__40404.0721165531$1472571911$gmane$org@griffinp-ThinkPad-X1-Carbon-2nd>
References: <1472223413-7254-1-git-send-email-peter.griffin@linaro.org>
	<1472223413-7254-2-git-send-email-peter.griffin@linaro.org>
	<20160830123453.GG10121@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20160830123453.GG10121@dell>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Lee Jones <lee.jones@linaro.org>
Cc: devicetree@vger.kernel.org, kernel@stlinux.com, vinod.koul@intel.com, linux-remoteproc@vger.kernel.org, patrice.chotard@st.com, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, airlied@linux.ie, dmaengine@vger.kernel.org, dan.j.williams@intel.com, bjorn.andersson@linaro.org, virtualization@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
List-Id: virtualization@lists.linuxfoundation.org

Hi Lee,

Thanks for reviewing.

On Tue, 30 Aug 2016, Lee Jones wrote:

> On Fri, 26 Aug 2016, Peter Griffin wrote:
> 
> > slim core is used as a basis for many IPs in the STi
> > chipsets such as fdma and demux. To avoid duplicating
> > the elf loading code in each device driver a slim
> > rproc driver has been created.
> > 
> > This driver is designed to be used by other device drivers
> > such as fdma, or demux whose IP is based around a slim core.
> > The device driver can call slim_rproc_alloc() to allocate
> > a slim rproc and slim_rproc_put() when finished.
> > 
> > This driver takes care of ioremapping the slim
> > registers (dmem, imem, slimcore, peripherals), whose offsets
> > and sizes can change between IP's. It also obtains and enables
> > any clocks used by the device. This approach avoids having
> > a double mapping of the registers as slim_rproc does not register
> > its own platform device. It also maps well to device tree
> > abstraction as it allows us to have one dt node for the whole
> > device.
> > 
> > All of the generic rproc elf loading code can be reused, and
> > we provide start() stop() hooks to start and stop the slim
> > core once the firmware has been loaded. This has been tested
> > successfully with fdma driver.
> 
> Nit.  It would be good to use a constant line-wrap.
> 
> 'M-x post-mode' will help with this.

Can you provide the magic which makes this happen for GIT commit messages?

> 
> > Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> > ---
> >  drivers/remoteproc/Kconfig               |   8 +
> >  drivers/remoteproc/Makefile              |   1 +
> >  drivers/remoteproc/st_slim_rproc.c       | 364 +++++++++++++++++++++++++++++++
> >  include/linux/remoteproc/st_slim_rproc.h |  53 +++++
> >  4 files changed, 426 insertions(+)
> >  create mode 100644 drivers/remoteproc/st_slim_rproc.c
> >  create mode 100644 include/linux/remoteproc/st_slim_rproc.h
> > 
> > diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
> > index 1a8bf76a..06765e0 100644
> > --- a/drivers/remoteproc/Kconfig
> > +++ b/drivers/remoteproc/Kconfig
> > @@ -100,4 +100,12 @@ config ST_REMOTEPROC
> >  	  processor framework.
> >  	  This can be either built-in or a loadable module.
> >  
> > +config ST_SLIM_REMOTEPROC
> > +	tristate "ST Slim remoteproc support"
> > +	select REMOTEPROC
> > +	help
> > +	  Say y here to support firmware loading on IP based around
> > +	  the Slim core.
> > +	  If unsure say N.
> > +
> >  endmenu
> > diff --git a/drivers/remoteproc/Makefile b/drivers/remoteproc/Makefile
> > index 92d3758..db1dae7 100644
> > --- a/drivers/remoteproc/Makefile
> > +++ b/drivers/remoteproc/Makefile
> > @@ -14,3 +14,4 @@ obj-$(CONFIG_DA8XX_REMOTEPROC)		+= da8xx_remoteproc.o
> >  obj-$(CONFIG_QCOM_MDT_LOADER)		+= qcom_mdt_loader.o
> >  obj-$(CONFIG_QCOM_Q6V5_PIL)		+= qcom_q6v5_pil.o
> >  obj-$(CONFIG_ST_REMOTEPROC)		+= st_remoteproc.o
> > +obj-$(CONFIG_ST_SLIM_REMOTEPROC)	+= st_slim_rproc.o
> > diff --git a/drivers/remoteproc/st_slim_rproc.c b/drivers/remoteproc/st_slim_rproc.c
> > new file mode 100644
> > index 0000000..f4bf2d7
> > --- /dev/null
> > +++ b/drivers/remoteproc/st_slim_rproc.c
> > @@ -0,0 +1,364 @@
> > +/*
> > + * st_slim_rproc.c
> 
> These serve no purpose and have a habit of becoming out-of-date.
> Please remove it and replace with a nice succinct description
> instead.

OK will fix.
> 
> > + * Copyright (C) 2016 STMicroelectronics
> 
> Nit: '\n' here.

Will fix. 
> 
> > + * Author: Peter Griffin <peter.griffin@linaro.org>
> 
> Nit: '\n' here.

Will fix.

> 
> > + * License terms:  GNU General Public License (GPL), version 2
> 
> Are you sure ST are okay with the shortened version of the GPL?

Do you mean the banner should be like this?

 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.

As I'm not aware of a shortened version of the GPV v2 license.

> 
> > + */
> > +
> > +#include <linux/clk.h>
> > +#include <linux/err.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/of_device.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/remoteproc.h>
> > +#include <linux/remoteproc/st_slim_rproc.h>
> > +#include "remoteproc_internal.h"
> > +
> > +/* slimcore registers */
> 
> What's it called? slimcore, slim core, ST Slim?

It is usually referred to as SLIM core, or SLIM CPU in the various functional
specifications.

> 
> Please be consistent.  Use the name from the datasheet.

OK. The datasheet isn't consistent either, so we will settle on SLIM core and
SLIM CPU.

> 
> > +#define SLIM_ID_OFST		0x0
> > +#define SLIM_VER_OFST		0x4
> > +
> > +#define SLIM_EN_OFST		0x8
> > +#define SLIM_EN_RUN			BIT(0)
> > +
> > +#define SLIM_CLK_GATE_OFST	0xC
> > +#define SLIM_CLK_GATE_DIS		BIT(0)
> > +#define SLIM_CLK_GATE_RESET		BIT(2)
> > +
> > +#define SLIM_SLIM_PC_OFST	0x20
> > +
> > +/* dmem registers */
> > +#define SLIM_REV_ID_OFST	0x0
> > +#define SLIM_REV_ID_MIN_MASK		GENMASK(15, 8)
> > +#define SLIM_REV_ID_MIN(id)		((id & SLIM_REV_ID_MIN_MASK) >> 8)
> > +#define SLIM_REV_ID_MAJ_MASK		GENMASK(23, 16)
> > +#define SLIM_REV_ID_MAJ(id)		((id & SLIM_REV_ID_MAJ_MASK) >> 16)
> > +
> > +
> > +/* peripherals registers */
> > +#define SLIM_STBUS_SYNC_OFST	0xF88
> > +#define SLIM_STBUS_SYNC_DIS		BIT(0)
> > +
> > +#define SLIM_INT_SET_OFST	0xFD4
> > +#define SLIM_INT_CLR_OFST	0xFD8
> > +#define SLIM_INT_MASK_OFST	0xFDC
> > +
> > +#define SLIM_CMD_CLR_OFST	0xFC8
> > +#define SLIM_CMD_MASK_OFST	0xFCC
> > +
> > +static const char *mem_names[ST_SLIM_MEM_MAX] = {
> > +	[ST_SLIM_DMEM]	= "dmem",
> > +	[ST_SLIM_IMEM]	= "imem",
> > +};
> > +
> > +static int slim_clk_get(struct st_slim_rproc *slim_rproc, struct device *dev)
> > +{
> > +	int clk, err;
> > +
> > +	for (clk = 0; clk < ST_SLIM_MAX_CLK; clk++) {
> > +		slim_rproc->clks[clk] = of_clk_get(dev->of_node, clk);
> > +		if (IS_ERR(slim_rproc->clks[clk])) {
> > +			err = PTR_ERR(slim_rproc->clks[clk]);
> > +			if (err == -EPROBE_DEFER)
> > +				goto err_put_clks;
> > +			slim_rproc->clks[clk] = NULL;
> > +			break;
> > +		}
> > +	}
> > +
> > +	return 0;
> > +
> > +err_put_clks:
> > +	while (--clk >= 0)
> > +		clk_put(slim_rproc->clks[clk]);
> > +
> > +	return err;
> > +}
> > +
> > +static void slim_clk_disable(struct st_slim_rproc *slim_rproc)
> > +{
> > +	int clk;
> > +
> > +	for (clk = 0; clk < ST_SLIM_MAX_CLK && slim_rproc->clks[clk]; clk++)
> > +		clk_disable_unprepare(slim_rproc->clks[clk]);
> > +}
> > +
> > +static int slim_clk_enable(struct st_slim_rproc *slim_rproc)
> > +{
> > +	int clk, ret;
> > +
> > +	for (clk = 0; clk < ST_SLIM_MAX_CLK && slim_rproc->clks[clk]; clk++) {
> > +		ret = clk_prepare_enable(slim_rproc->clks[clk]);
> > +		if (ret)
> > +			goto err_disable_clks;
> > +	}
> > +
> > +	return 0;
> > +
> > +err_disable_clks:
> > +	while (--clk >= 0)
> > +		clk_disable_unprepare(slim_rproc->clks[clk]);
> > +
> > +	return ret;
> > +}
> > +
> > +/**
> > + * Remoteproc slim specific device handlers
> > + */
> 
> I suggest not using kernel-doc format for this type of comment.

Will fix.

> 
> > +static int slim_rproc_start(struct rproc *rproc)
> > +{
> > +	struct device *dev = &rproc->dev;
> > +	struct st_slim_rproc *slim_rproc = rproc->priv;
> > +	unsigned long hw_id, hw_ver, fw_rev;
> > +	u32 val;
> > +	int ret;
> > +
> > +	ret = slim_clk_enable(slim_rproc);
> > +	if (ret) {
> > +		dev_err(dev, "Failed to enable clocks\n");
> > +		return ret;
> > +	}
> > +
> > +	/* disable CPU pipeline clock & reset cpu pipeline */
> 
> Be consistent.  Is it 'cpu' or 'CPU'.  Personally I find using
> 'correct English' to be the most consistent way of formatting
> comments i.e. Capitals for names, acronyms and at the start of a
> sentence.

OK will update to CPU for both.

> 
> > +	val = SLIM_CLK_GATE_DIS | SLIM_CLK_GATE_RESET;
> > +	writel(val, slim_rproc->slimcore + SLIM_CLK_GATE_OFST);
> > +
> > +	/* disable SLIM core STBus sync */
> > +	writel(SLIM_STBUS_SYNC_DIS, slim_rproc->peri + SLIM_STBUS_SYNC_OFST);
> > +
> > +	/* enable cpu pipeline clock */
> > +	writel(!SLIM_CLK_GATE_DIS,
> > +		slim_rproc->slimcore + SLIM_CLK_GATE_OFST);
> > +
> > +	/* clear int & cmd mailbox */
> > +	writel(~0U, slim_rproc->peri + SLIM_INT_CLR_OFST);
> > +	writel(~0U, slim_rproc->peri + SLIM_CMD_CLR_OFST);
> > +
> > +	/* enable all channels cmd & int */
> > +	writel(~0U, slim_rproc->peri + SLIM_INT_MASK_OFST);
> > +	writel(~0U, slim_rproc->peri + SLIM_CMD_MASK_OFST);
> > +
> > +	/* enable cpu */
> > +	writel(SLIM_EN_RUN, slim_rproc->slimcore + SLIM_EN_OFST);
> > +
> > +	hw_id = readl_relaxed(slim_rproc->slimcore + SLIM_ID_OFST);
> > +	hw_ver = readl_relaxed(slim_rproc->slimcore + SLIM_VER_OFST);
> > +
> > +	fw_rev = readl(slim_rproc->mem[ST_SLIM_DMEM].cpu_addr +
> > +			SLIM_REV_ID_OFST);
> > +
> > +	dev_info(dev, "fw rev:%ld.%ld on SLIM %ld.%ld\n",
> > +		 SLIM_REV_ID_MAJ(fw_rev), SLIM_REV_ID_MIN(fw_rev),
> > +		 hw_id, hw_ver);
> > +
> > +	return 0;
> > +}
> > +
> > +static int slim_rproc_stop(struct rproc *rproc)
> > +{
> > +	struct st_slim_rproc *slim_rproc = rproc->priv;
> > +	u32 val;
> > +
> > +	/* mask all (cmd & int) channels */
> > +	writel(0UL, slim_rproc->peri + SLIM_INT_MASK_OFST);
> > +	writel(0UL, slim_rproc->peri + SLIM_CMD_MASK_OFST);
> > +
> > +	/* disable cpu pipeline clock */
> > +	writel(SLIM_CLK_GATE_DIS, slim_rproc->slimcore + SLIM_CLK_GATE_OFST);
> > +
> > +	writel(!SLIM_EN_RUN, slim_rproc->slimcore + SLIM_EN_OFST);
> > +
> > +	val = readl(slim_rproc->slimcore + SLIM_EN_OFST);
> > +	if (val & SLIM_EN_RUN)
> > +		dev_warn(&rproc->dev, "Failed to disable SLIM");
> > +
> > +	slim_clk_disable(slim_rproc);
> > +
> > +	dev_dbg(&rproc->dev, "slim stopped\n");
> > +
> > +	return 0;
> > +}
> > +
> > +static void *slim_rproc_da_to_va(struct rproc *rproc, u64 da, int len)
> > +{
> > +	struct st_slim_rproc *slim_rproc = rproc->priv;
> > +	void *va = NULL;
> > +	int i;
> > +
> > +	for (i = 0; i < ST_SLIM_MEM_MAX; i++) {
> > +		if (da != slim_rproc->mem[i].bus_addr)
> > +			continue;
> > +
> > +		if (len <= slim_rproc->mem[i].size) {
> > +			/* __force to make sparse happy with type conversion */
> > +			va = (__force void *)slim_rproc->mem[i].cpu_addr;
> > +			break;
> > +		}
> > +	}
> > +
> > +	dev_dbg(&rproc->dev, "%s: da = 0x%llx len = 0x%x va = 0x%p\n",
> > +		__func__, da, len, va);
> 
> Non-consistent with other debug prints.  I suggest dropping the
> _func_.  It's a nice to have during initial debugging, but I don't
> usually find them useful upstream.

OK will fix.

> 
> > +	return va;
> > +}
> > +
> > +static struct rproc_ops slim_rproc_ops = {
> > +	.start		= slim_rproc_start,
> > +	.stop		= slim_rproc_stop,
> > +	.da_to_va       = slim_rproc_da_to_va,
> > +};
> > +
> > +/**
> > + * Firmware handler operations: sanity, boot address, load ...
> > + */
> 
> Don't use kernel-doc for these.

Will fix.

> 
> > +static struct resource_table empty_rsc_tbl = {
> > +	.ver = 1,
> > +	.num = 0,
> > +};
> 
> This should go away soon.
> 
> Be prepared to remove this once the code lands.

OK.

> 
> > +static struct resource_table *slim_rproc_find_rsc_table(struct rproc *rproc,
> > +					       const struct firmware *fw,
> > +					       int *tablesz)
> > +{
> > +	*tablesz = sizeof(empty_rsc_tbl);
> > +	return &empty_rsc_tbl;
> > +}
> > +
> > +static struct rproc_fw_ops slim_rproc_fw_ops = {
> > +	.find_rsc_table = slim_rproc_find_rsc_table,
> > +};
> > +
> > +/**
> > + * st_slim_rproc_alloc() - allocate and initialise slim rproc
> > + * @pdev: Pointer to the platform_device struct
> > + * @fw_name: Name of firmware for rproc to use
> > + *
> > + * Function for allocating and initialising a slim rproc for use by
> > + * device drivers whose IP is based around the slim slim core. It
> 
> "slim slim"?  Do you mean "really slim"? ;)

Will update to SLIM core.

> 
> > + * obtains and enables any clocks required by the slim core and also
> > + * ioremaps the various IO.
> > + *
> > + * Returns st_slim_rproc pointer or PTR_ERR() on error.
> > + */
> > +
> > +struct st_slim_rproc *st_slim_rproc_alloc(struct platform_device *pdev,
> > +				char *fw_name)
> > +{
> > +	struct device *dev = &pdev->dev;
> > +	struct st_slim_rproc *slim_rproc;
> > +	struct device_node *np = dev->of_node;
> > +	struct rproc *rproc;
> > +	struct resource *res;
> > +	int err, i;
> > +	const struct rproc_fw_ops *elf_ops;
> > +
> > +	if (WARN_ON(!np || !fw_name))
> > +		return ERR_PTR(-EINVAL);
> 
> !np should not happen, ever.  You can remove the check.

OK, will fix.

> 
> > +	if (!of_device_is_compatible(np, "st,slim-rproc"))
> > +		return ERR_PTR(-EINVAL);
> > +
> > +	rproc = rproc_alloc(dev, np->name, &slim_rproc_ops,
> > +			fw_name, sizeof(*slim_rproc));
> > +	if (!rproc)
> > +		return ERR_PTR(-ENOMEM);
> > +
> > +	rproc->has_iommu = false;
> > +
> > +	slim_rproc = rproc->priv;
> > +	slim_rproc->rproc = rproc;
> > +
> > +	elf_ops = rproc->fw_ops;
> > +	/* Use some generic elf ops */
> > +	slim_rproc_fw_ops.load = elf_ops->load;
> > +	slim_rproc_fw_ops.sanity_check = elf_ops->sanity_check;
> > +
> > +	rproc->fw_ops = &slim_rproc_fw_ops;
> > +
> > +	/* get imem and dmem */
> > +	for (i = 0; i < ARRAY_SIZE(mem_names); i++) {
> > +
> 
> Superfluous '\n'.

Will fix.
> 
> > +		res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
> > +						mem_names[i]);
> > +
> > +		slim_rproc->mem[i].cpu_addr = devm_ioremap_resource(dev, res);
> > +		if (IS_ERR(slim_rproc->mem[i].cpu_addr)) {
> > +			dev_err(&pdev->dev, "devm_ioremap_resource failed\n");
> > +			err = PTR_ERR(slim_rproc->mem[i].cpu_addr);
> > +			goto err;
> > +		}
> > +		slim_rproc->mem[i].bus_addr = res->start;
> > +		slim_rproc->mem[i].size = resource_size(res);
> > +	}
> > +
> > +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "slimcore");
> 
> Superfluous '\n'.

Will fix.
> 
> > +	slim_rproc->slimcore = devm_ioremap_resource(dev, res);
> > +	if (IS_ERR(slim_rproc->slimcore)) {
> > +		dev_err(&pdev->dev,
> > +			"devm_ioremap_resource failed for slimcore\n");
> 
> Best not to quote function names.  Instead write the description in
> plain English; "failed to remap 'slimcore' IO", or similar. 

Will fix.

> 
> > +		err = PTR_ERR(slim_rproc->slimcore);
> > +		goto err;
> > +	}
> > +
> > +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "peripherals");
> > +
> 
> Superfluous '\n'.

Will fix.
> 
> > +	slim_rproc->peri = devm_ioremap_resource(dev, res);
> > +	if (IS_ERR(slim_rproc->peri)) {
> > +		dev_err(&pdev->dev, "devm_ioremap_resource failed for peri\n");
> 
> As above.
> 
> > +		err = PTR_ERR(slim_rproc->peri);
> > +		goto err;
> > +	}
> > +
> > +	err = slim_clk_get(slim_rproc, dev);
> > +	if (err)
> > +		goto err;
> > +
> > +	/* Register as a remoteproc device */
> > +	err = rproc_add(rproc);
> > +	if (err) {
> > +		dev_err(dev, "registration of slim remoteproc failed\n");
> > +		goto err_clk;
> > +	}
> > +
> > +	return slim_rproc;
> > +
> > +err_clk:
> > +	for (i = 0; i < ST_SLIM_MAX_CLK && slim_rproc->clks[i]; i++)
> > +		clk_put(slim_rproc->clks[i]);
> > +err:
> > +	rproc_put(rproc);
> > +	return ERR_PTR(err);
> > +}
> > +EXPORT_SYMBOL(st_slim_rproc_alloc);
> > +
> > +/**
> > +  * st_slim_rproc_put() - put slim rproc resources
> > +  * @slim_rproc: Pointer to the st_slim_rproc struct
> > +  *
> > +  * Function for calling respective _put() functions on
> 
> Early line wrap

Will fix.
> 
>    <--------|---------|---------|---------|---------|---------|---------|--------->
>    
> > +  * slim_rproc resources.
> > +  *
> 
> Superfluous '\n'.

Will fix.

> 
> > +  */
> > +void st_slim_rproc_put(struct st_slim_rproc *slim_rproc)
> > +{
> > +	int clk;
> > +
> > +	if (!slim_rproc)
> > +		return;
> > +
> > +	for (clk = 0; clk < ST_SLIM_MAX_CLK && slim_rproc->clks[clk]; clk++)
> > +		clk_put(slim_rproc->clks[clk]);
> > +
> > +	rproc_del(slim_rproc->rproc);
> > +	rproc_put(slim_rproc->rproc);
> > +}
> > +EXPORT_SYMBOL(st_slim_rproc_put);
> > +
> > +MODULE_AUTHOR("Peter Griffin");
> 
> Email.

Will fix.

> 
> > +MODULE_DESCRIPTION("STMicroelectronics SLIM rproc driver");
> 
> Now it's "SLIM"?  Make up your mind.

Will fix.

> 
> > +MODULE_LICENSE("GPL v2");
> > diff --git a/include/linux/remoteproc/st_slim_rproc.h b/include/linux/remoteproc/st_slim_rproc.h
> > new file mode 100644
> > index 0000000..64a2c5b
> > --- /dev/null
> > +++ b/include/linux/remoteproc/st_slim_rproc.h
> > @@ -0,0 +1,53 @@
> > +/*
> > + * st_slim_rproc.h
> 
> As above.

Will fix.

> 
> > + * Copyright (C) 2016 STMicroelectronics
> > + * Author: Peter Griffin <peter.griffin@linaro.org>
> > + * License terms:  GNU General Public License (GPL), version 2
> > + */
> 
> Same for the *.c header.


Will fix.

> 
> > +#ifndef _ST_SLIM_H
> > +#define _ST_SLIM_H
> 
> Best to mention the subsystem too.


Will fix.

> 
> > +#define ST_SLIM_MEM_MAX 2
> > +#define ST_SLIM_MAX_CLK 4
> > +
> > +enum {
> > +	ST_SLIM_DMEM,
> > +	ST_SLIM_IMEM,
> > +};
> > +
> > +/**
> > + * struct st_slim_mem - slim internal memory structure
> > + * @cpu_addr: MPU virtual address of the memory region
> > + * @bus_addr: Bus address used to access the memory region
> > + * @size: Size of the memory region
> > + */
> > +struct st_slim_mem {
> > +	void __iomem *cpu_addr;
> > +	phys_addr_t bus_addr;
> > +	size_t size;
> > +};
> > +
> > +/**
> > + * struct st_slim_rproc - SLIM slim core
> > + * @rproc: rproc handle
> > + * @mem: slim memory information
> > + * @slimcore: slim slimcore regs
> > + * @peri: slim peripheral regs
> > + * @clks: slim clocks
> > + */
> > +struct st_slim_rproc {
> > +	struct rproc *rproc;
> > +	struct st_slim_mem mem[ST_SLIM_MEM_MAX];
> > +	void __iomem *slimcore;
> > +	void __iomem *peri;
> > +
> > +	/* st_slim_rproc private */
> > +	struct clk *clks[ST_SLIM_MAX_CLK];
> > +};
> > +
> > +struct st_slim_rproc *st_slim_rproc_alloc(struct platform_device *pdev,
> > +					char *fw_name);
> > +void st_slim_rproc_put(struct st_slim_rproc *slim_rproc);
> > +
> > +#endif
> 

regards,

Peter.
