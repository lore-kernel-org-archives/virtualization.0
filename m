Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D6E6C433F5
	for <virtualization@archiver.kernel.org>; Wed, 16 Mar 2022 15:55:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E8635842A6;
	Wed, 16 Mar 2022 15:55:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WEg4ELx8YKq3; Wed, 16 Mar 2022 15:55:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 963378425E;
	Wed, 16 Mar 2022 15:55:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 689C1C001A;
	Wed, 16 Mar 2022 15:55:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D59D0C000B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Mar 2022 15:55:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C41B9842A6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Mar 2022 15:55:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MqYyv0uWtzes
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Mar 2022 15:55:20 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E2A338425E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Mar 2022 15:55:19 +0000 (UTC)
Received: by mail-ej1-x62d.google.com with SMTP id a8so5119623ejc.8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Mar 2022 08:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Xrv4PFSyhAtwnCAL/pjWyzmn6e9Q3pw3qGeeMjVLkWc=;
 b=ThLCeQCLe60XloIENcKZTLtoa92AsszbMGtlE1VP85Nj8ONYeGAtPtd3THFkwuE1R4
 Rb+p8levz1Kkk/esESpsWOOce4y/GAs3zE/h/Iq8JTZadMNMhSzoXuCsi65zQcSj9uj9
 roUu7BL6G2KSrbQdMUcXxa1eBfn7GLPhFdgtrRtKQ1B6XjhvDCk1M6WlSKyn57HnuVDa
 81Zd+YwZwjEFy9IgsZIWqi9+OJ0hcLCs/C3anzU5mAn4GgUA+5ei9x+U8aPDc4PlCURW
 8DQSGQ08z9c9bhp4uK79m+ecf2bqZ6sdte5Pd0FZyKDC2WwgAQ/cfFk5gcysCgAmWYjH
 wmBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Xrv4PFSyhAtwnCAL/pjWyzmn6e9Q3pw3qGeeMjVLkWc=;
 b=YD0DFhe/D7V9Fjc+i0b7Cog++aFMm+qbWrrKkTuyDpXwpiebnwO3dlXXQjis6m31ON
 MBBiwQeYVakZjxUDr4IX2zdRgcEHKLqvPaazCUjNwiShoyeI6GK9mka0Kw/ZqMVbQNVE
 5Ra4f9SdLuYgXc+lfUJtLAxAac08uoxxg0tl3MEnZcVqtSbkX1G3EZNqNzfKuwlpoqAY
 7opHtUDjLSTvqVJe6sDw+doJsl7Wa2wxx58W81jTNo+iEKDPUuz1CMStU79mvdEd4QNX
 AUdbZraSN63ANy2zPZ00816cOVfaEOOpXmmTiMWNwRk6SqV9ifZJJsSbRCNsF0NsSGDJ
 NwXw==
X-Gm-Message-State: AOAM530jtv55pOa9zltpm//7t/c3TmV5UeuPbh6IyN9grlmcX9bFYHH1
 7bwPA2t9anDHc63vAFFzKiV4C1m8zFVUvW2EA1Q=
X-Google-Smtp-Source: ABdhPJx7tfhflG1OGwg4hJv+lc6fCCCsMyBIcaeP4g7aVOZtvesN3U3Aevmj9sLhxYjH7UWlro+fkCpgMa2F3+GK74E=
X-Received: by 2002:a17:907:6e01:b0:6d0:562c:e389 with SMTP id
 sd1-20020a1709076e0100b006d0562ce389mr499870ejc.497.1647446118072; Wed, 16
 Mar 2022 08:55:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220316150533.421349-1-krzysztof.kozlowski@canonical.com>
 <20220316150533.421349-2-krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220316150533.421349-2-krzysztof.kozlowski@canonical.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 16 Mar 2022 17:54:04 +0200
Message-ID: <CAHp75VeaQdzUKJSKzH9FjbmON5asqH799AS8OzHGoDiRnJifNw@mail.gmail.com>
Subject: Re: [PATCH v5 01/11] driver: platform: Add helper for safer setting
 of driver_override
To: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc: Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
 Stuart Yoder <stuyoder@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 linux-pci <linux-pci@vger.kernel.org>, linux-remoteproc@vger.kernel.org,
 ALSA Development Mailing List <alsa-devel@alsa-project.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Vineeth Vijayan <vneethv@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 linux-clk <linux-clk@vger.kernel.org>, linux-s390@vger.kernel.org,
 Wei Liu <wei.liu@kernel.org>, Stephen Hemminger <sthemmin@microsoft.com>,
 Dexuan Cui <decui@microsoft.com>, Andy Gross <agross@kernel.org>,
 NXP Linux Team <linux-imx@nxp.com>, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, linux-arm-msm@vger.kernel.org,
 Haiyang Zhang <haiyangz@microsoft.com>, linux-spi <linux-spi@vger.kernel.org>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Bjorn Helgaas <bhelgaas@google.com>, virtualization@lists.linux-foundation.org,
 linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
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

On Wed, Mar 16, 2022 at 5:06 PM Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:

...

> +int driver_set_override(struct device *dev, const char **override,
> +                       const char *s, size_t len)
> +{
> +       const char *new, *old;
> +       char *cp;

> +       if (!dev || !override || !s)
> +               return -EINVAL;

Sorry, I didn't pay much attention on this. First of all, I would drop
dev checks and simply require that dev should be valid. Do you expect
this can be called when dev is invalid? I would like to hear if it's
anything but theoretical. Second one, is the !s requirement. Do I
understand correctly that the string must be always present? But then
how we NULify the override? Is it possible? Third one is absence of
len check. See below.

> +       /*
> +        * The stored value will be used in sysfs show callback (sysfs_emit()),
> +        * which has a length limit of PAGE_SIZE and adds a trailing newline.
> +        * Thus we can store one character less to avoid truncation during sysfs
> +        * show.
> +        */
> +       if (len >= (PAGE_SIZE - 1))
> +               return -EINVAL;

I would relax this to make sure we can use it if \n is within this limit.

> +       cp = strnchr(s, len, '\n');
> +       if (cp)
> +               len = cp - s;
> +
> +       new = kstrndup(s, len, GFP_KERNEL);

Here is a word about the len check.

> +       if (!new)

If len == 0, this won't trigger and you have something very
interesting as a result.

One way is to use ZERO_PTR_OR_NULL() another is explicitly check for 0
and issue a (different?) error code.

> +               return -ENOMEM;
> +
> +       device_lock(dev);
> +       old = *override;
> +       if (cp != s) {
> +               *override = new;
> +       } else {
> +               kfree(new);
> +               *override = NULL;
> +       }
> +       device_unlock(dev);
> +
> +       kfree(old);
> +
> +       return 0;
> +}

-- 
With Best Regards,
Andy Shevchenko
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
