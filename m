Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C956C433EF
	for <virtualization@archiver.kernel.org>; Wed, 22 Dec 2021 11:20:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 82E6A4047F;
	Wed, 22 Dec 2021 11:20:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CbfKBFlI4331; Wed, 22 Dec 2021 11:20:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D923740153;
	Wed, 22 Dec 2021 11:20:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AC5EDC001E;
	Wed, 22 Dec 2021 11:20:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7F938C0012
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Dec 2021 11:20:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 57D52415ED
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Dec 2021 11:20:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dhPHWQ2vBVc7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Dec 2021 11:20:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A2461415E9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Dec 2021 11:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1640172001; x=1671708001;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=6+4R+FyB099Qr49bH3/1NFQGuuybyBlmj9/KUyRv5pE=;
 b=KUvAkD2dBUfsdSJb1mKBq3NSWLz2U7vqab7xUriGTBuvtzj2+XRkwfSR
 uj2+sz5kLxZSPyOwuf1HnufntQ2RW6lVixaSIIiWUaQL/jydxOTTrjqZ2
 DFyZtbxM28Dm2VVba3RxmtrpKww4N6VKTIZdNHukzxvCdnHdLTQjinnTk
 5usMOBKLbmZMotsxyRW5XXE8P6yEHxJuUIRl0buoweiJyxiKqNlo8Eria
 gXTLGLKuJSR6sSF5ZB1+K/X6B3XRkOrTLCe7/hdN8q+YU5KDK+Cr+9/B/
 /2km40F/OqSA/HG8hu87JPEMKuYN/RO9GO4POSnG50PdUxATgOOa8sKPa A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10205"; a="239350769"
X-IronPort-AV: E=Sophos;i="5.88,226,1635231600"; d="scan'208";a="239350769"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Dec 2021 03:20:00 -0800
X-IronPort-AV: E=Sophos;i="5.88,226,1635231600"; d="scan'208";a="484727047"
Received: from smile.fi.intel.com ([10.237.72.61])
 by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Dec 2021 03:19:55 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
 (envelope-from <andriy.shevchenko@linux.intel.com>)
 id 1mzzdd-000jnv-Iv; Wed, 22 Dec 2021 13:18:29 +0200
Date: Wed, 22 Dec 2021 13:18:29 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "David E. Box" <david.e.box@linux.intel.com>
Subject: Re: [PATCH 2/4] soundwire: intel: Use auxiliary_device driver data
 helpers
Message-ID: <YcMJhXQNXabezOya@smile.fi.intel.com>
References: <20211221235852.323752-1-david.e.box@linux.intel.com>
 <20211221235852.323752-3-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211221235852.323752-3-david.e.box@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Cc: alsa-devel@alsa-project.org, pierre-louis.bossart@linux.intel.com,
 hdegoede@redhat.com, mustafa.ismail@intel.com, leon@kernel.org, mst@redhat.com,
 linux-rdma@vger.kernel.org, gregkh@linuxfoundation.org, vkoul@kernel.org,
 davem@davemloft.net, jgg@ziepe.ca, dledford@redhat.com,
 yung-chuan.liao@linux.intel.com, netdev@vger.kernel.org, kuba@kernel.org,
 virtualization@lists.linux-foundation.org, shiraz.saleem@intel.com,
 saeedm@nvidia.com, linux-kernel@vger.kernel.org
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Tue, Dec 21, 2021 at 03:58:50PM -0800, David E. Box wrote:
> Use auxiliary_get_drvdata and auxiliary_set_drvdata helpers.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> ---
>  drivers/soundwire/intel.c      | 8 ++++----
>  drivers/soundwire/intel_init.c | 2 +-
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
> index 78037ffdb09b..d082d18e41a9 100644
> --- a/drivers/soundwire/intel.c
> +++ b/drivers/soundwire/intel.c
> @@ -1293,7 +1293,7 @@ static int intel_link_probe(struct auxiliary_device *auxdev,
>  	bus->ops = &sdw_intel_ops;
>  
>  	/* set driver data, accessed by snd_soc_dai_get_drvdata() */
> -	dev_set_drvdata(dev, cdns);
> +	auxiliary_set_drvdata(auxdev, cdns);
>  
>  	/* use generic bandwidth allocation algorithm */
>  	sdw->cdns.bus.compute_params = sdw_compute_params;
> @@ -1321,7 +1321,7 @@ int intel_link_startup(struct auxiliary_device *auxdev)
>  {
>  	struct sdw_cdns_stream_config config;
>  	struct device *dev = &auxdev->dev;
> -	struct sdw_cdns *cdns = dev_get_drvdata(dev);
> +	struct sdw_cdns *cdns = auxiliary_get_drvdata(auxdev);
>  	struct sdw_intel *sdw = cdns_to_intel(cdns);
>  	struct sdw_bus *bus = &cdns->bus;
>  	int link_flags;
> @@ -1463,7 +1463,7 @@ int intel_link_startup(struct auxiliary_device *auxdev)
>  static void intel_link_remove(struct auxiliary_device *auxdev)
>  {
>  	struct device *dev = &auxdev->dev;
> -	struct sdw_cdns *cdns = dev_get_drvdata(dev);
> +	struct sdw_cdns *cdns = auxiliary_get_drvdata(auxdev);
>  	struct sdw_intel *sdw = cdns_to_intel(cdns);
>  	struct sdw_bus *bus = &cdns->bus;
>  
> @@ -1488,7 +1488,7 @@ int intel_link_process_wakeen_event(struct auxiliary_device *auxdev)
>  	void __iomem *shim;
>  	u16 wake_sts;
>  
> -	sdw = dev_get_drvdata(dev);
> +	sdw = auxiliary_get_drvdata(auxdev);
>  	bus = &sdw->cdns.bus;
>  
>  	if (bus->prop.hw_disabled || !sdw->startup_done) {
> diff --git a/drivers/soundwire/intel_init.c b/drivers/soundwire/intel_init.c
> index e329022e1669..d99807765dfe 100644
> --- a/drivers/soundwire/intel_init.c
> +++ b/drivers/soundwire/intel_init.c
> @@ -244,7 +244,7 @@ static struct sdw_intel_ctx
>  			goto err;
>  
>  		link = &ldev->link_res;
> -		link->cdns = dev_get_drvdata(&ldev->auxdev.dev);
> +		link->cdns = auxiliary_get_drvdata(&ldev->auxdev);
>  
>  		if (!link->cdns) {
>  			dev_err(&adev->dev, "failed to get link->cdns\n");
> -- 
> 2.25.1
> 

-- 
With Best Regards,
Andy Shevchenko


_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
