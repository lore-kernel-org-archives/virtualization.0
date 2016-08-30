From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v8 05/18] dmaengine: st_fdma: Add STMicroelectronics FDMA
	engine driver support
Date: Tue, 30 Aug 2016 22:00:19 +0530
Message-ID: <20160830163019.GM9355__2677.66797119311$1472621496$gmane$org@localhost>
References: <1472223413-7254-1-git-send-email-peter.griffin@linaro.org>
	<1472223413-7254-6-git-send-email-peter.griffin@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1472223413-7254-6-git-send-email-peter.griffin@linaro.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Peter Griffin <peter.griffin@linaro.org>
Cc: devicetree@vger.kernel.org, kernel@stlinux.com, airlied@linux.ie, linux-remoteproc@vger.kernel.org, virtualization@lists.linux-foundation.org, patrice.chotard@st.com, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Ludovic Barre <ludovic.barre@st.com>, dmaengine@vger.kernel.org, dan.j.williams@intel.com, bjorn.andersson@linaro.org, lee.jones@linaro.org, linux-arm-kernel@lists.infradead.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Aug 26, 2016 at 03:56:40PM +0100, Peter Griffin wrote:

>  config STM32_DMA
>  	bool "STMicroelectronics STM32 DMA support"
>  	depends on ARCH_STM32
> @@ -567,7 +580,6 @@ config ZX_DMA
>  	help
>  	  Support the DMA engine for ZTE ZX296702 platform devices.
>  
> -

unrelated change?

> +	fdev->chans = devm_kzalloc(&pdev->dev,
> +				   fdev->nr_channels
> +				   * sizeof(struct st_fdma_chan), GFP_KERNEL);

devm_kcalloc()

> +	if (!fdev->chans)
> +		return -ENOMEM;
> +
> +	fdev->dev = &pdev->dev;
> +	fdev->drvdata = drvdata;
> +	platform_set_drvdata(pdev, fdev);
> +
> +	fdev->irq = platform_get_irq(pdev, 0);
> +	if (fdev->irq < 0) {
> +		dev_err(&pdev->dev, "Failed to get irq resource\n");
> +		return -EINVAL;
> +	}
> +
> +	ret = devm_request_irq(&pdev->dev, fdev->irq, st_fdma_irq_handler, 0,
> +			       dev_name(&pdev->dev), fdev);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to request irq (%d)\n", ret);
> +		goto err;
> +	}
> +
> +	fdev->slim_rproc = st_slim_rproc_alloc(pdev, fdev->fw_name);
> +	if (!fdev->slim_rproc) {
> +		ret = PTR_ERR(fdev->slim_rproc);
> +		dev_err(&pdev->dev, "slim_rproc_alloc failed (%d)\n", ret);
> +		goto err;
> +	}
> +
> +	/* Initialise list of FDMA channels */
> +	INIT_LIST_HEAD(&fdev->dma_device.channels);
> +	for (i = 0; i < fdev->nr_channels; i++) {
> +		struct st_fdma_chan *fchan = &fdev->chans[i];
> +
> +		fchan->fdev = fdev;
> +		fchan->vchan.desc_free = st_fdma_free_desc;
> +		vchan_init(&fchan->vchan, &fdev->dma_device);

this initialized a tasklet

> +static int st_fdma_remove(struct platform_device *pdev)
> +{
> +	struct st_fdma_dev *fdev = platform_get_drvdata(pdev);
> +
> +	devm_free_irq(&pdev->dev, fdev->irq, fdev);
> +	st_slim_rproc_put(fdev->slim_rproc);
> +	of_dma_controller_free(pdev->dev.of_node);
> +	dma_async_device_unregister(&fdev->dma_device);

and that vchan tasklet is not quisced here :(

> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("STMicroelectronics FDMA engine driver");
> +MODULE_AUTHOR("Ludovic.barre <Ludovic.barre@st.com>");
> +MODULE_AUTHOR("Peter Griffin <peter.griffin@linaro.org>");

No MODULE_ALIAS?

-- 
~Vinod
