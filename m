Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52B24C43219
	for <virtualization@archiver.kernel.org>; Sun, 13 Mar 2022 16:35:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F270A813D0;
	Sun, 13 Mar 2022 16:35:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id j5MgE7Lo5C5w; Sun, 13 Mar 2022 16:35:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 42BF7813B3;
	Sun, 13 Mar 2022 16:35:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2381EC001D;
	Sun, 13 Mar 2022 16:35:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 031E5C000B
 for <virtualization@lists.linux-foundation.org>;
 Sun, 13 Mar 2022 16:35:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D38C8401A3
 for <virtualization@lists.linux-foundation.org>;
 Sun, 13 Mar 2022 16:35:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kHRi25LbX3lM
 for <virtualization@lists.linux-foundation.org>;
 Sun, 13 Mar 2022 16:35:13 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4C00B40195
 for <virtualization@lists.linux-foundation.org>;
 Sun, 13 Mar 2022 16:35:13 +0000 (UTC)
Received: by mail-oi1-x230.google.com with SMTP id w2so6926993oie.2
 for <virtualization@lists.linux-foundation.org>;
 Sun, 13 Mar 2022 09:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=ob4h2d72COnkU3FY3eI+a2UFXuCW1/ScRGHi/UryDqA=;
 b=TushXGzzRAzyI9MGE9XPNO4vBoxXifNjIKjCnoUkI+mEzZl6CZhW5uEBUDRGoJGHaD
 yQBQqhTD3jqe3Itl2ih/VYfS2AVqG46q374zGDDL6gBW9JTc2T4zamHj1VeOliVF2mVe
 Mqmi1px5JxbR15ozq99jBei8hZ++gA42ZIUv22DaY3YHKN7MSH1i0dMTim51IysvPyWn
 +Gq7wMLMPYLJus5ZwQeaEpMbCZ2JUARUML+mTdMXf95/FsrZn42VmhERTaicPLLP/owq
 ciqGfh1nxr0ORhDiIRQdbTxVCt0nq6AhVdIEdvPLp0OXeiH7hklifcXG8UdDVkB7o7r7
 6HBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ob4h2d72COnkU3FY3eI+a2UFXuCW1/ScRGHi/UryDqA=;
 b=VqAgaN6edPMZE2XoA+NztmphYPEEAyGmefdSR9t4M3nVd9RYlyGbqm38YUMdfjTvqi
 cTj2UWTXJ+qLUq9QyWjsSzZwwD57PkiyzNbuwr4FJbA6eUvt1QCZTprmNGFIjkcq8bBk
 arzUJ5yRH7poqU+GCQtX6q5GsUm1iVpbo+hr4mEJV6L0KF3h6LLPJwkMGARtgfd0TecD
 CpfgzAZLd+Q0DY1e5sHLk7jdflha1cLHiVaiJ5h2FI21m8YPd+aBOOlvKHxyHLIlfTbb
 hsrhoWUqfkwJbPeKGuFYn10rAgsdAfob83YAtskkJw08U3hjg9f0yqh+dFJ4p+Py00Af
 MeTw==
X-Gm-Message-State: AOAM531QS9eCaN4wAYMi/JiCZ2AuCHl57Cr/LdeIRZheHaz27zRkTbua
 Hendtm0R8a5+f0Dyub3TcgwePw==
X-Google-Smtp-Source: ABdhPJyf3k5XJ/dltTqtkT8q4cm/xQn+rQVTI2+AHnpPI0GfXenHJMCY3JJm9uRIMdQCmtTZS4KxuA==
X-Received: by 2002:a54:4e81:0:b0:2ec:ae99:e02d with SMTP id
 c1-20020a544e81000000b002ecae99e02dmr5435442oiy.261.1647189311060; 
 Sun, 13 Mar 2022 09:35:11 -0700 (PDT)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
 by smtp.gmail.com with ESMTPSA id
 e3-20020a056870450300b000da5424e4b0sm5514643oao.50.2022.03.13.09.35.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Mar 2022 09:35:10 -0700 (PDT)
Date: Sun, 13 Mar 2022 11:35:07 -0500
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: Re: [PATCH v4 11/11] rpmsg: Fix kfree() of static memory on setting
 driver_override
Message-ID: <Yi4dOxArKLNyMFZy@builder.lan>
References: <20220312132856.65163-1-krzysztof.kozlowski@canonical.com>
 <20220312132856.65163-12-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220312132856.65163-12-krzysztof.kozlowski@canonical.com>
Cc: linux-hyperv@vger.kernel.org, Stuart Yoder <stuyoder@gmail.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, linux-pci@vger.kernel.org,
 linux-remoteproc@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Vineeth Vijayan <vneethv@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>, Fabio Estevam <festevam@gmail.com>,
 linux-clk@vger.kernel.org, linux-s390@vger.kernel.org,
 Wei Liu <wei.liu@kernel.org>, Stephen Hemminger <sthemmin@microsoft.com>,
 Abel Vesa <abel.vesa@nxp.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Dexuan Cui <decui@microsoft.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Andy Gross <agross@kernel.org>,
 NXP Linux Team <linux-imx@nxp.com>, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, linux-arm-msm@vger.kernel.org,
 Sascha Hauer <s.hauer@pengutronix.de>, Mark Brown <broonie@kernel.org>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Bjorn Helgaas <bhelgaas@google.com>, virtualization@lists.linux-foundation.org,
 linux-arm-kernel@lists.infradead.org,
 Laurentiu Tudor <laurentiu.tudor@nxp.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 Peter Oberparleiter <oberpar@linux.ibm.com>, stable@vger.kernel.org,
 linux-spi@vger.kernel.org, Sven Schnelle <svens@linux.ibm.com>,
 Shawn Guo <shawnguo@kernel.org>
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

On Sat 12 Mar 07:28 CST 2022, Krzysztof Kozlowski wrote:

> The driver_override field from platform driver should not be initialized
> from static memory (string literal) because the core later kfree() it,
> for example when driver_override is set via sysfs.
> 
> Use dedicated helper to set driver_override properly.
> 
> Fixes: 950a7388f02b ("rpmsg: Turn name service into a stand alone driver")
> Fixes: c0cdc19f84a4 ("rpmsg: Driver for user space endpoint interface")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  drivers/rpmsg/rpmsg_core.c     |  3 ++-
>  drivers/rpmsg/rpmsg_internal.h | 13 +++++++++++--
>  drivers/rpmsg/rpmsg_ns.c       | 14 ++++++++++++--
>  include/linux/rpmsg.h          |  6 ++++--
>  4 files changed, 29 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
> index d9e612f4f0f2..6e2bf2742973 100644
> --- a/drivers/rpmsg/rpmsg_core.c
> +++ b/drivers/rpmsg/rpmsg_core.c
> @@ -397,7 +397,8 @@ field##_store(struct device *dev, struct device_attribute *attr,	\
>  	      const char *buf, size_t sz)				\
>  {									\
>  	struct rpmsg_device *rpdev = to_rpmsg_device(dev);		\
> -	char *new, *old;						\
> +	const char *old;						\
> +	char *new;							\
>  									\
>  	new = kstrndup(buf, sz, GFP_KERNEL);				\
>  	if (!new)							\
> diff --git a/drivers/rpmsg/rpmsg_internal.h b/drivers/rpmsg/rpmsg_internal.h
> index b1245d3ed7c6..31345d6e9a7e 100644
> --- a/drivers/rpmsg/rpmsg_internal.h
> +++ b/drivers/rpmsg/rpmsg_internal.h
> @@ -92,10 +92,19 @@ int rpmsg_release_channel(struct rpmsg_device *rpdev,
>   */
>  static inline int rpmsg_chrdev_register_device(struct rpmsg_device *rpdev)
>  {
> +	int ret;
> +
>  	strcpy(rpdev->id.name, "rpmsg_chrdev");
> -	rpdev->driver_override = "rpmsg_chrdev";
> +	ret = driver_set_override(&rpdev->dev, &rpdev->driver_override,
> +				  "rpmsg_chrdev", strlen("rpmsg_chrdev"));
> +	if (ret)
> +		return ret;
> +
> +	ret = rpmsg_register_device(rpdev);
> +	if (ret)
> +		kfree(rpdev->driver_override);
>  
> -	return rpmsg_register_device(rpdev);
> +	return ret;
>  }
>  
>  #endif
> diff --git a/drivers/rpmsg/rpmsg_ns.c b/drivers/rpmsg/rpmsg_ns.c
> index 762ff1ae279f..95a51543f5ad 100644
> --- a/drivers/rpmsg/rpmsg_ns.c
> +++ b/drivers/rpmsg/rpmsg_ns.c
> @@ -20,12 +20,22 @@
>   */
>  int rpmsg_ns_register_device(struct rpmsg_device *rpdev)
>  {
> +	int ret;
> +
>  	strcpy(rpdev->id.name, "rpmsg_ns");
> -	rpdev->driver_override = "rpmsg_ns";
> +	ret = driver_set_override(&rpdev->dev, &rpdev->driver_override,
> +				  "rpmsg_ns", strlen("rpmsg_ns"));
> +	if (ret)
> +		return ret;
> +
>  	rpdev->src = RPMSG_NS_ADDR;
>  	rpdev->dst = RPMSG_NS_ADDR;
>  
> -	return rpmsg_register_device(rpdev);
> +	ret = rpmsg_register_device(rpdev);
> +	if (ret)
> +		kfree(rpdev->driver_override);
> +
> +	return ret;
>  }
>  EXPORT_SYMBOL(rpmsg_ns_register_device);
>  
> diff --git a/include/linux/rpmsg.h b/include/linux/rpmsg.h
> index 02fa9116cd60..20c8cd1cde21 100644
> --- a/include/linux/rpmsg.h
> +++ b/include/linux/rpmsg.h
> @@ -41,7 +41,9 @@ struct rpmsg_channel_info {
>   * rpmsg_device - device that belong to the rpmsg bus
>   * @dev: the device struct
>   * @id: device id (used to match between rpmsg drivers and devices)
> - * @driver_override: driver name to force a match
> + * @driver_override: driver name to force a match; do not set directly,
> + *                   because core frees it; use driver_set_override() to
> + *                   set or clear it.
>   * @src: local address
>   * @dst: destination address
>   * @ept: the rpmsg endpoint of this channel
> @@ -51,7 +53,7 @@ struct rpmsg_channel_info {
>  struct rpmsg_device {
>  	struct device dev;
>  	struct rpmsg_device_id id;
> -	char *driver_override;
> +	const char *driver_override;
>  	u32 src;
>  	u32 dst;
>  	struct rpmsg_endpoint *ept;
> -- 
> 2.32.0
> 
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
