Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FF70C43219
	for <virtualization@archiver.kernel.org>; Tue, 15 Mar 2022 18:02:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DB5CE4170F;
	Tue, 15 Mar 2022 18:02:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nip0RhUviZMT; Tue, 15 Mar 2022 18:02:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 6790E4170D;
	Tue, 15 Mar 2022 18:02:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 45B1DC0012;
	Tue, 15 Mar 2022 18:02:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 89E92C000B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Mar 2022 18:02:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 68596610B5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Mar 2022 18:02:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iTLKxhIODFZW
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Mar 2022 18:02:33 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6DB9960EBC
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Mar 2022 18:02:33 +0000 (UTC)
Received: by mail-ej1-x62a.google.com with SMTP id p15so43250142ejc.7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Mar 2022 11:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=lEC/nkhZWgafnlNYWqRvQ8T9pwDdv1X4bS+vmmN1SPI=;
 b=TlfZFBpL4ZxfH1h0A4azfOpuLuqRtduCM9W127vgQdbSX84AaRxquI24AZvaA/0Mhu
 W5o4xZkQR752Hf126heU6U/BBocdrE6/a2Ihx8NnsX9drwO5lACiezAZxvUZP3XJP8CY
 RgL/YsUwucofJYAR5HTDtSgiXc/8GSxvQKtINLDlNNpQhcJWsrikOyezbu8mRlY3gTlv
 rEOGgvjWGrYlDAjMi05/fTIC1jrV0GVsW+UEpEd1os1ZbL3wwjfaDDRl0voUi4hHNHYk
 rJABGDMHxUmjB3eeAevsUeKUu16sJWDZhY2h8sMc8S1ej06qZ5FAgZCqYTXYxZQxhKT7
 g/Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=lEC/nkhZWgafnlNYWqRvQ8T9pwDdv1X4bS+vmmN1SPI=;
 b=eacwKMsW/2B96fEoGa+w9DP3ZkyK9RobNsJtkyfKcC2lJzlYv+74ak3XP5ej9qwRfX
 p5oIpaVtUgcU0K83Sb4VvEy/j52oCbYCXfiTTxvhiOxWIvs7ueueaOh5OvUe9Ctj9KmF
 4MJ1xcXxYKMCNYptjULy+c+WUQEFrsQ/hvURWyv+hlTXFjlBBysJhf733Qtho05pwigQ
 BHnyarIQM9hJ/zBcAZAoy5EeV1O5r2uCJBrAEQ2179Llx9egUo5EFZTqvOEwAI+XXSrO
 vd7FlIicTqZbZkr6xcINKwZBQYV1Luf82NqzWMxaYBfc7R/jtQ8rv7izMMDpi35vDVq9
 +HCg==
X-Gm-Message-State: AOAM532iRo87W4bKJL/66rMobFfwfgxIrmp4s8ugizSCRD29vVQDZidd
 hPyw5ZVNk6DLdCHUn+iB99/qXCq1SztCS7/fVa4=
X-Google-Smtp-Source: ABdhPJwQNXcLkTGaCJKCgGEQ39fH/f9rG+zOEFi6wUHEyZIylN9K230wh3LynYxeoxVpwJTKYSVD3SjkIYeMUl1wmGU=
X-Received: by 2002:a17:907:6e01:b0:6d0:562c:e389 with SMTP id
 sd1-20020a1709076e0100b006d0562ce389mr23976723ejc.497.1647367351540; Tue, 15
 Mar 2022 11:02:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220312132856.65163-1-krzysztof.kozlowski@canonical.com>
 <20220312132856.65163-6-krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220312132856.65163-6-krzysztof.kozlowski@canonical.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 15 Mar 2022 20:01:18 +0200
Message-ID: <CAHp75VfLtjfrB4Zj9ncOg3VYQrX58chEL+6g31_5fwuMUuURPg@mail.gmail.com>
Subject: Re: [PATCH v4 05/11] PCI: Use driver_set_override() instead of
 open-coding
To: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc: Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
 Stuart Yoder <stuyoder@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 linux-pci <linux-pci@vger.kernel.org>, linux-remoteproc@vger.kernel.org,
 ALSA Development Mailing List <alsa-devel@alsa-project.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Vineeth Vijayan <vneethv@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>, Fabio Estevam <festevam@gmail.com>,
 linux-clk <linux-clk@vger.kernel.org>, linux-s390@vger.kernel.org,
 Wei Liu <wei.liu@kernel.org>, Stephen Hemminger <sthemmin@microsoft.com>,
 Abel Vesa <abel.vesa@nxp.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Dexuan Cui <decui@microsoft.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Andy Gross <agross@kernel.org>,
 NXP Linux Team <linux-imx@nxp.com>, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, linux-arm-msm@vger.kernel.org,
 Sascha Hauer <s.hauer@pengutronix.de>, linux-spi <linux-spi@vger.kernel.org>,
 Mark Brown <broonie@kernel.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Bjorn Helgaas <bhelgaas@google.com>, virtualization@lists.linux-foundation.org,
 linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
 Laurentiu Tudor <laurentiu.tudor@nxp.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 Peter Oberparleiter <oberpar@linux.ibm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Sven Schnelle <svens@linux.ibm.com>, Shawn Guo <shawnguo@kernel.org>
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

On Sat, Mar 12, 2022 at 4:09 PM Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:
>
> Use a helper to set driver_override to reduce amount of duplicated code.

the amount

> Make the driver_override field const char, because it is not modified by
> the core and it matches other subsystems.


Seems like mine #4 here
https://gist.github.com/andy-shev/a2cb1ee4767d6d2f5d20db53ecb9aabc :-)
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Thanks!

> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/pci-sysfs.c | 28 ++++------------------------
>  include/linux/pci.h     |  6 +++++-
>  2 files changed, 9 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 602f0fb0b007..5c42965c32c2 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -567,31 +567,11 @@ static ssize_t driver_override_store(struct device *dev,
>                                      const char *buf, size_t count)
>  {
>         struct pci_dev *pdev = to_pci_dev(dev);
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
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 60d423d8f0c4..415491fb85f4 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -516,7 +516,11 @@ struct pci_dev {
>         u16             acs_cap;        /* ACS Capability offset */
>         phys_addr_t     rom;            /* Physical address if not from BAR */
>         size_t          romlen;         /* Length if not from BAR */
> -       char            *driver_override; /* Driver name to force a match */
> +       /*
> +        * Driver name to force a match.  Do not set directly, because core
> +        * frees it.  Use driver_set_override() to set or clear it.
> +        */
> +       const char      *driver_override;
>
>         unsigned long   priv_flags;     /* Private flags for the PCI driver */
>
> --
> 2.32.0
>


-- 
With Best Regards,
Andy Shevchenko
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
