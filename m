Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EF3EC433EF
	for <virtualization@archiver.kernel.org>; Mon,  4 Apr 2022 10:15:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 333DF82AED;
	Mon,  4 Apr 2022 10:15:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ETT4OOTrphIS; Mon,  4 Apr 2022 10:15:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C130F82948;
	Mon,  4 Apr 2022 10:15:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 96638C001D;
	Mon,  4 Apr 2022 10:15:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8D95AC0012
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Apr 2022 10:15:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 790FB81DB2
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Apr 2022 10:15:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Jr6yP-qXe15J
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Apr 2022 10:15:28 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AB2158175A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Apr 2022 10:15:28 +0000 (UTC)
Received: by mail-ed1-x532.google.com with SMTP id g22so10462736edz.2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 04 Apr 2022 03:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=s/rlqtfSH/+OKtlWbKj/8X8QmPBtgrwTTfh5H/AMmr8=;
 b=M6UB/xq5U2lez0akpMy5cdYkLpWp5TY7avZOr9EOmD3mOmC7LnKWizhrsWVbS9OYXV
 WxZR1L3Zip6LzxkB/OPBaxvuvHRQ+I4ccmh7WVg7layXLF9PfwqQYZ+jlB6EvWgmb6tq
 0lZWCE3uc7LImkbQu2mlfWDe2OdVL/M2gk8b/f83Msuz2BzcI+DWU/n4c03LXmBik2KW
 KbNMC8korkh/nF0C0QAzLDf4TOGpyF8a6IoEG8l74xBIia5wiIab+cBhjD/6K3P9R06b
 EK2dkk2s3pESu8s3Lp5ePedMQzZPflgxpC1RgXqt3TXscJmh/VeMBZJdhbyeZhLuCe4J
 VwFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=s/rlqtfSH/+OKtlWbKj/8X8QmPBtgrwTTfh5H/AMmr8=;
 b=anEj+AVsqFtMuroLa+v0QiVcEjXvA2OGwb9GnNWsPGrcXa+blraSMsQ2g/tVzzB3ZX
 DaILQiPgFaYATnBCa5JH2WAXrFkBxHHzDKDGaenFGxi16QK7HhAWghtjVfM6tsimUThT
 4QXY/eZGhzZVvdygFqJBZETzOeEE9Y02iFMX24moY7kXuNOeNKeGsStYtx7T8jc3ipdu
 zs0gwgKb3iogMDKZiFH0eiVG4F/4Dv4hBmdGzwWsjbucsYK9d/UiEGfJfPKCJcKQ8XYw
 CN7c4sbR/o5/QTXicquBCmNphIwKsT3yc/KANAfMETuKyt3HhQPH741O5lAXjbvgrzr5
 Ystg==
X-Gm-Message-State: AOAM531UU8IMpXL+tBCyHC3UqpKsRzHO/FMlGrK7Ec17ijVSSiSvovn5
 cjcAYNxr0V62g9g9XJO8zbMMTKcqDunK0vROJ1k=
X-Google-Smtp-Source: ABdhPJxh9T+A1Yt+ILwhaxqoZIRZw7XK7bOr8aWn5QI6DqXoAfRnxar+91mJpxHWbEEB8aKP53yR05gviFAyUrKxBls=
X-Received: by 2002:a05:6402:b19:b0:41c:d713:5cba with SMTP id
 bm25-20020a0564020b1900b0041cd7135cbamr2668518edb.270.1649067326747; Mon, 04
 Apr 2022 03:15:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220403183758.192236-1-krzysztof.kozlowski@linaro.org>
 <20220403183758.192236-2-krzysztof.kozlowski@linaro.org>
 <CAHp75Vczm9f9Bx_w4nW31cnBgwEzPiN-Eqn-7DKZuB+Hew0F=Q@mail.gmail.com>
 <2976f4f9-4fda-c04f-45cf-351518f88ec0@linaro.org>
In-Reply-To: <2976f4f9-4fda-c04f-45cf-351518f88ec0@linaro.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 4 Apr 2022 13:14:22 +0300
Message-ID: <CAHp75Vd-=-unRzQPtpfOs80dN=pDSsBaj=10nwOmmyWE8OqDPg@mail.gmail.com>
Subject: Re: [PATCH v6 01/12] driver: platform: Add helper for safer setting
 of driver_override
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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

On Mon, Apr 4, 2022 at 12:34 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
> On 04/04/2022 11:16, Andy Shevchenko wrote:
> > On Sun, Apr 3, 2022 at 9:38 PM Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:

...

> >> +int driver_set_override(struct device *dev, const char **override,
> >> +                       const char *s, size_t len)
> >> +{
> >> +       const char *new, *old;
> >> +       char *cp;
> >
> >> +       if (!override || !s)
> >> +               return -EINVAL;
> >
> > Still not sure if we should distinguish (s == NULL && len == 0) from
> > (s != NULL && len == 0).
> > Supplying the latter seems confusing (yes, I see that in the old code). Perhaps
> > !s test, in case you want to leave it, should be also commented.
>
> The old semantics were focused on sysfs usage, so clearing is by passing
> an empty string. In the case of sysfs empty string is actually "\n". I
> intend to keep the semantics also for the in-kernel usage and in such
> case empty string can be also "".
>
> If I understand your comment correctly, you propose to change it to NULL
> for in-kernel usage, but that would change the semantics.

Yes. It's also possible to have a wrapper for sysfs use.

> > Another approach is to split above to two checks and move !s after !len.
>
> I don't follow why... The !override and !s are invalid uses. !len is a
> valid user for internal callers, just like "\n" is for sysfs.

I understand but always supplying s maybe an overhead for in-kernel usages.

In any case, it's not critical right now, just a remark that it can be modified.

> >> +       /*
> >> +        * The stored value will be used in sysfs show callback (sysfs_emit()),
> >> +        * which has a length limit of PAGE_SIZE and adds a trailing newline.
> >> +        * Thus we can store one character less to avoid truncation during sysfs
> >> +        * show.
> >> +        */
> >> +       if (len >= (PAGE_SIZE - 1))
> >> +               return -EINVAL;
> >
> > Perhaps explain the case in the comment here?
>
> You mean the case we discuss here (to clear override with "")? Sure.

Yep. Before the below check.

> >> +       if (!len) {
> >> +               device_lock(dev);
> >> +               old = *override;
> >> +               *override = NULL;
> >
> >> +               device_unlock(dev);
> >> +               goto out_free;
> >
> > You may deduplicate this one, by
> >
> >                goto out_unlock_free;
> >
> > But I understand your intention to keep lock-unlock in one place, so
> > perhaps dropping that label would be even better in this case and
> > keeping it
>
> Yes, exactly.
>
> >        kfree(old);
> >        return 0;
> >
> > here instead of goto.
>
> Slightly more code, but indeed maybe easier to follow. I'll do like this.


-- 
With Best Regards,
Andy Shevchenko
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
