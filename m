Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71AB5C43219
	for <virtualization@archiver.kernel.org>; Wed, 20 Apr 2022 17:13:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 13EB54193F;
	Wed, 20 Apr 2022 17:13:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CZ9vBDVCTkGQ; Wed, 20 Apr 2022 17:13:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 19D714193E;
	Wed, 20 Apr 2022 17:13:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E2471C002F;
	Wed, 20 Apr 2022 17:13:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2992AC002C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Apr 2022 17:13:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 16F8F60C34
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Apr 2022 17:13:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id o5-Dj-_fJ5-O
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Apr 2022 17:13:00 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com
 [209.85.219.174])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3BF7060C0F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Apr 2022 17:13:00 +0000 (UTC)
Received: by mail-yb1-f174.google.com with SMTP id t67so4084186ybi.2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Apr 2022 10:13:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/ASIWAo0HytBTKR5fLcMLGJJVl7MsnssiA8AeEXSjEM=;
 b=goeJQuZKk5xPa4VVAdWjx5vz5+V/0PeoRgmRxBgXd8iicheQNAoma2jjTBOy3I8LIO
 ks35w+JJEhAqRPUe2/2EEJN9E5DzsqY2oeCaU/NeuTEdVjILS7pkfVDE+lXgxvufmfQY
 8vrAPi77moPo4uAzfA2AvJFvZWkNmDatQucmynMXv/l2FxRbwxrJfMRodeMIV+dB1kDe
 Huxp7Lym93z5w1tK79+5UbVgadOLJPxR5goot7mDMjLvJoBXnPbsy6slWs6c9DarGWyT
 gilxxvZTTPpO6w8l4WGfq85DTliiiFbscODOv9yGh3gPz1Q14sie42XD2YdRzwgMl7qj
 AQNQ==
X-Gm-Message-State: AOAM530TZKY0/6KoMzm+NR075IIqpYCFRHAcPdJdZkW7vYjXipICt8Ot
 01qpe7xP0mYo6neLniqN1NeU0V5EMnmJROjTKNY=
X-Google-Smtp-Source: ABdhPJygxTqwH/fYP8f9/TOx3wegsu6FxX5O1kN/quLL9EMh/cabSnVGqayxP5pVJxnDK33VgIW6Cm39TvZfF3wMYBU=
X-Received: by 2002:a25:e082:0:b0:641:cf5:b91f with SMTP id
 x124-20020a25e082000000b006410cf5b91fmr20887561ybg.482.1650474779115; Wed, 20
 Apr 2022 10:12:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220419113435.246203-1-krzysztof.kozlowski@linaro.org>
 <20220419113435.246203-2-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220419113435.246203-2-krzysztof.kozlowski@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 20 Apr 2022 19:12:48 +0200
Message-ID: <CAJZ5v0ijsLvgeN5y+T1D+iLAkYEOiSTPd0+m5_GMpBnVuqEOKA@mail.gmail.com>
Subject: Re: [PATCH v7 01/12] driver: platform: Add helper for safer setting
 of driver_override
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
 Stuart Yoder <stuyoder@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Linux PCI <linux-pci@vger.kernel.org>, linux-remoteproc@vger.kernel.org,
 "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..."
 <alsa-devel@alsa-project.org>, Bjorn Andersson <bjorn.andersson@linaro.org>,
 Vineeth Vijayan <vneethv@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 linux-clk <linux-clk@vger.kernel.org>, linux-s390@vger.kernel.org,
 Wei Liu <wei.liu@kernel.org>, Stephen Hemminger <sthemmin@microsoft.com>,
 Dexuan Cui <decui@microsoft.com>, Andy Shevchenko <andy.shevchenko@gmail.com>,
 Andy Gross <agross@kernel.org>, NXP Linux Team <linux-imx@nxp.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Haiyang Zhang <haiyangz@microsoft.com>, linux-spi <linux-spi@vger.kernel.org>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Bjorn Helgaas <bhelgaas@google.com>, virtualization@lists.linux-foundation.org,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Peter Oberparleiter <oberpar@linux.ibm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Sven Schnelle <svens@linux.ibm.com>,
 Linus Torvalds <torvalds@linux-foundation.org>
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

On Tue, Apr 19, 2022 at 1:34 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> Several core drivers and buses expect that driver_override is a
> dynamically allocated memory thus later they can kfree() it.
>
> However such assumption is not documented, there were in the past and
> there are already users setting it to a string literal. This leads to
> kfree() of static memory during device release (e.g. in error paths or
> during unbind):
>
>     kernel BUG at ../mm/slub.c:3960!
>     Internal error: Oops - BUG: 0 [#1] PREEMPT SMP ARM
>     ...
>     (kfree) from [<c058da50>] (platform_device_release+0x88/0xb4)
>     (platform_device_release) from [<c0585be0>] (device_release+0x2c/0x90)
>     (device_release) from [<c0a69050>] (kobject_put+0xec/0x20c)
>     (kobject_put) from [<c0f2f120>] (exynos5_clk_probe+0x154/0x18c)
>     (exynos5_clk_probe) from [<c058de70>] (platform_drv_probe+0x6c/0xa4)
>     (platform_drv_probe) from [<c058b7ac>] (really_probe+0x280/0x414)
>     (really_probe) from [<c058baf4>] (driver_probe_device+0x78/0x1c4)
>     (driver_probe_device) from [<c0589854>] (bus_for_each_drv+0x74/0xb8)
>     (bus_for_each_drv) from [<c058b48c>] (__device_attach+0xd4/0x16c)
>     (__device_attach) from [<c058a638>] (bus_probe_device+0x88/0x90)
>     (bus_probe_device) from [<c05871fc>] (device_add+0x3dc/0x62c)
>     (device_add) from [<c075ff10>] (of_platform_device_create_pdata+0x94/0xbc)
>     (of_platform_device_create_pdata) from [<c07600ec>] (of_platform_bus_create+0x1a8/0x4fc)
>     (of_platform_bus_create) from [<c0760150>] (of_platform_bus_create+0x20c/0x4fc)
>     (of_platform_bus_create) from [<c07605f0>] (of_platform_populate+0x84/0x118)
>     (of_platform_populate) from [<c0f3c964>] (of_platform_default_populate_init+0xa0/0xb8)
>     (of_platform_default_populate_init) from [<c01031f8>] (do_one_initcall+0x8c/0x404)
>
> Provide a helper which clearly documents the usage of driver_override.
> This will allow later to reuse the helper and reduce the amount of
> duplicated code.
>
> Convert the platform driver to use a new helper and make the
> driver_override field const char (it is not modified by the core).
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  drivers/base/driver.c           | 69 +++++++++++++++++++++++++++++++++
>  drivers/base/platform.c         | 28 ++-----------
>  include/linux/device/driver.h   |  2 +
>  include/linux/platform_device.h |  6 ++-
>  4 files changed, 80 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/base/driver.c b/drivers/base/driver.c
> index 8c0d33e182fd..1b9d47b10bd0 100644
> --- a/drivers/base/driver.c
> +++ b/drivers/base/driver.c
> @@ -30,6 +30,75 @@ static struct device *next_device(struct klist_iter *i)
>         return dev;
>  }
>
> +/**
> + * driver_set_override() - Helper to set or clear driver override.
> + * @dev: Device to change
> + * @override: Address of string to change (e.g. &device->driver_override);
> + *            The contents will be freed and hold newly allocated override.

I would stick to one-line description here and possibly expand them in
the body of the comment.

Regardless, I think that the series is an improvement, so please feel
free to add

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

to this patch and

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

to the other patches in the series.

> + * @s: NUL-terminated string, new driver name to force a match, pass empty
> + *     string to clear it ("" or "\n", where the latter is only for sysfs
> + *     interface).
> + * @len: length of @s
> + *
> + * Helper to set or clear driver override in a device, intended for the cases
> + * when the driver_override field is allocated by driver/bus code.
> + *
> + * Returns: 0 on success or a negative error code on failure.
> + */
> +int driver_set_override(struct device *dev, const char **override,
> +                       const char *s, size_t len)
> +{
> +       const char *new, *old;
> +       char *cp;
> +
> +       if (!override || !s)
> +               return -EINVAL;
> +
> +       /*
> +        * The stored value will be used in sysfs show callback (sysfs_emit()),
> +        * which has a length limit of PAGE_SIZE and adds a trailing newline.
> +        * Thus we can store one character less to avoid truncation during sysfs
> +        * show.
> +        */
> +       if (len >= (PAGE_SIZE - 1))
> +               return -EINVAL;
> +
> +       if (!len) {
> +               /* Empty string passed - clear override */
> +               device_lock(dev);
> +               old = *override;
> +               *override = NULL;
> +               device_unlock(dev);
> +               kfree(old);
> +
> +               return 0;
> +       }
> +
> +       cp = strnchr(s, len, '\n');
> +       if (cp)
> +               len = cp - s;
> +
> +       new = kstrndup(s, len, GFP_KERNEL);
> +       if (!new)
> +               return -ENOMEM;
> +
> +       device_lock(dev);
> +       old = *override;
> +       if (cp != s) {
> +               *override = new;
> +       } else {
> +               /* "\n" passed - clear override */
> +               kfree(new);
> +               *override = NULL;
> +       }
> +       device_unlock(dev);
> +
> +       kfree(old);
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(driver_set_override);
> +
>  /**
>   * driver_for_each_device - Iterator for devices bound to a driver.
>   * @drv: Driver we're iterating.
> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index 8cc272fd5c99..b684157b7f2f 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -1275,31 +1275,11 @@ static ssize_t driver_override_store(struct device *dev,
>                                      const char *buf, size_t count)
>  {
>         struct platform_device *pdev = to_platform_device(dev);
> -       char *driver_override, *old, *cp;
> -
> -       /* We need to keep extra room for a newline */
> -       if (count >= (PAGE_SIZE - 1))
> -               return -EINVAL;
> -
> -       driver_override = kstrndup(buf, count, GFP_KERNEL);
> -       if (!driver_override)
> -               return -ENOMEM;
> -
> -       cp = strchr(driver_override, '\n');
> -       if (cp)
> -               *cp = '\0';
> -
> -       device_lock(dev);
> -       old = pdev->driver_override;
> -       if (strlen(driver_override)) {
> -               pdev->driver_override = driver_override;
> -       } else {
> -               kfree(driver_override);
> -               pdev->driver_override = NULL;
> -       }
> -       device_unlock(dev);
> +       int ret;
>
> -       kfree(old);
> +       ret = driver_set_override(dev, &pdev->driver_override, buf, count);
> +       if (ret)
> +               return ret;
>
>         return count;
>  }
> diff --git a/include/linux/device/driver.h b/include/linux/device/driver.h
> index 15e7c5e15d62..700453017e1c 100644
> --- a/include/linux/device/driver.h
> +++ b/include/linux/device/driver.h
> @@ -151,6 +151,8 @@ extern int __must_check driver_create_file(struct device_driver *driver,
>  extern void driver_remove_file(struct device_driver *driver,
>                                const struct driver_attribute *attr);
>
> +int driver_set_override(struct device *dev, const char **override,
> +                       const char *s, size_t len);
>  extern int __must_check driver_for_each_device(struct device_driver *drv,
>                                                struct device *start,
>                                                void *data,
> diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
> index 7c96f169d274..582d83ed9a91 100644
> --- a/include/linux/platform_device.h
> +++ b/include/linux/platform_device.h
> @@ -31,7 +31,11 @@ struct platform_device {
>         struct resource *resource;
>
>         const struct platform_device_id *id_entry;
> -       char *driver_override; /* Driver name to force a match */
> +       /*
> +        * Driver name to force a match.  Do not set directly, because core
> +        * frees it.  Use driver_set_override() to set or clear it.
> +        */
> +       const char *driver_override;
>
>         /* MFD cell pointer */
>         struct mfd_cell *mfd_cell;
> --
> 2.32.0
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
