Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BFC7C4332F
	for <virtualization@archiver.kernel.org>; Fri, 11 Mar 2022 20:19:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id ECCEC61314;
	Fri, 11 Mar 2022 20:19:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4TSMBN_GE3OY; Fri, 11 Mar 2022 20:19:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 725536131D;
	Fri, 11 Mar 2022 20:19:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 41FC8C001D;
	Fri, 11 Mar 2022 20:19:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 044FAC000B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Mar 2022 20:19:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E097241A1C
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Mar 2022 20:19:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oDO-X8VdgfaI
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Mar 2022 20:19:05 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D458241A18
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Mar 2022 20:19:04 +0000 (UTC)
Received: by mail-oi1-x22f.google.com with SMTP id z8so10614257oix.3
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Mar 2022 12:19:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=byy3khpUB/C66OcuZpBogrh1vBdJYZWOahv4ARsAqeU=;
 b=JsI+MgGwcNWNo5mFTmDhFQFX43IPSGP8AHmpadTTq1/jegWXkSYGxRbyYSNd2GGAfZ
 QJL9ePsqy1+pQCjIkYOKeRZF/4ou56BLTl43xcIPQgKVuLYTvOOSpWVMBXvPzi3iVcEE
 M9OokvdpojzL0W3mpYKQGxN00uuF3MValP5LkZwv7tBK8MbHNCEdcUSp8EyQgNvmdObM
 dV8uEHfL0A+kbdg4/kBwvllnMdB0q6LY78GBq99WSqCsQB+n/5bFK7oLoh//RzZWPskK
 DuBKl43ZqA2bbLdc1tjjtMkwJymKeQrW5rKztLf0fnJNsCRRE5EUHhDiGz2DbwyIRrvz
 mrcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=byy3khpUB/C66OcuZpBogrh1vBdJYZWOahv4ARsAqeU=;
 b=UnEIZw/bnUquWd50LBXJA2sKFbfnUoEDRiBLPDUuYH+vgybcwdgiyBWEv86GT4XIV8
 so82ig02EJliTWBI4Yn29JquNwaR2SW7j1GLMHyx4EXNcIXJx34T//5QWkjw/+iuZYIc
 cry9kSgSatd7eIXaGtTW49Z+GM8Nx6UQp7qupNQOi23xwZtoAysltB3aM6gGMzfMvbG/
 TtY4nK4xD4U3kdE/nZwCRU9rJc4zUZcLvfuVdBPFbh/nPCaHacTwh4kuqo1XgW7cXXbP
 XmA4h37Ik1/pChCA4GaJf2wfu6V2jQLd/ft5UvQ0j7EEs5xA55iOrmwjN97AuLXxxSpL
 ZMdg==
X-Gm-Message-State: AOAM531pjMIIqIOsNkTQCazHLsqD2O9iUy1KZ8tHDvDengB6iTpycIpF
 6BN8/MXDjJ0dPiRe4Y0m7VpNaw==
X-Google-Smtp-Source: ABdhPJwiCKmAYCnvMQUHkha6DRmgbP0TH7H+cC730Evh2nxJN9gacFfI6shVehimGVsKyYdMWq24uQ==
X-Received: by 2002:a05:6808:1406:b0:2d9:a01a:4bcb with SMTP id
 w6-20020a056808140600b002d9a01a4bcbmr7858798oiv.242.1647029943809; 
 Fri, 11 Mar 2022 12:19:03 -0800 (PST)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
 by smtp.gmail.com with ESMTPSA id
 r41-20020a056870582900b000d6cbaf589esm3887680oap.40.2022.03.11.12.19.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Mar 2022 12:19:02 -0800 (PST)
Date: Fri, 11 Mar 2022 14:19:00 -0600
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: Re: [PATCH v3 11/11] rpmsg: Fix kfree() of static memory on setting
 driver_override
Message-ID: <YiuutCsuf4j192cJ@builder.lan>
References: <20220227135214.145599-1-krzysztof.kozlowski@canonical.com>
 <20220227135329.145862-5-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220227135329.145862-5-krzysztof.kozlowski@canonical.com>
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

On Sun 27 Feb 07:53 CST 2022, Krzysztof Kozlowski wrote:

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
