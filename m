Return-Path: <SRS0=15I4=NC=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28343C432BE
	for <virtualization@archiver.kernel.org>; Wed, 11 Aug 2021 12:28:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA86860F22
	for <virtualization@archiver.kernel.org>; Wed, 11 Aug 2021 12:28:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CA86860F22
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 91DCB4058B;
	Wed, 11 Aug 2021 12:28:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XSy2PjVwN1OD; Wed, 11 Aug 2021 12:28:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E7F3F40562;
	Wed, 11 Aug 2021 12:28:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BFCE7C001A;
	Wed, 11 Aug 2021 12:28:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 71725C000E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Aug 2021 12:28:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5F59740491
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Aug 2021 12:28:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LC_qPOVZ7NYb
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Aug 2021 12:28:20 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com
 [IPv6:2a00:1450:4864:20::235])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2CD0E404AE
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Aug 2021 12:28:20 +0000 (UTC)
Received: by mail-lj1-x235.google.com with SMTP id x9so4302981ljj.2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Aug 2021 05:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=D5OlZ8oq6iOCdn4aMeG+EEph9Sb1Lla5I4LvuXvSK8A=;
 b=yxqhdCu/Qo68ddda8afkVdUuov6gTdX9x074yF+7r4kxHkkK2vFbEbiXB2Kl42komk
 uz5NPqfrnDYX3RbRLlnmXZODJDggmdPFMxMDSLwoD2l/HwkgDbE1gvy7STJCz+e65YtN
 z5xesgxo3uN8jH9rYn0Sob+2LRCkPlEIYS237Vz7rm8UqyQsV9NsHYVvmJqG1bjPQAMX
 zRStxZCtg5aGpGjtPDcYzmvw1ubJIwRv/tIDlskxY8flufvRcPbFDuYaVf3Con+7JPUe
 rOYO6dE9dJyA56ZEgtW0ecC8NkUjs+NlntX1f9Y4W60bbXOss6v4DpUWQ7CLJZgNXKct
 bixA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=D5OlZ8oq6iOCdn4aMeG+EEph9Sb1Lla5I4LvuXvSK8A=;
 b=e5EESPy3B7tAtDrp747AjS/Zscmc+Oe7ehBDHM2/72P9a3r6T4eZPXmBBmT5X7+9iY
 J9PSSzL075gjGhaUFFsUTtM6kBnzPzqkdy025t9r+nmG/L+rA+FUz2jS3A8XNOz8ajmX
 FP4UWcNEdP8Ke7pdkDFnXkwOTE9UXY1uXG46rJ++bKkjVE/7OoUtSRUXsaYkgcixRnlN
 AU94GuRLECkYa64dfMsrdHediya+ANIRs2CDlmc3+eHu3HPBbyP/CB8uzc7jHRAeIoyA
 ui9JmkIio0vt6t/e888Y0wqf2iN5aKx7Xlf5bjBOqNbFZ9RbyO1oqlzs668ZxnYfmeuS
 PfaQ==
X-Gm-Message-State: AOAM532l4qjJx00tNlOaUvYbDBrttZ2HeMkNP7sN4lJzgnLUUmH3wjvT
 Pn+DzHA+EK50yKErBdzr4r2W6aYssMdBWsa6uipvgA==
X-Google-Smtp-Source: ABdhPJwR2jWpMR0T0owMZaLYzWcyHOEHETHN6xD7KLu7UfEpJk7ksIDK0sBzw2b6PX7p1HpG0zZox0yZRkt4VIF0sKA=
X-Received: by 2002:a2e:a231:: with SMTP id i17mr12603890ljm.467.1628684898091; 
 Wed, 11 Aug 2021 05:28:18 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1628590591.git.viresh.kumar@linaro.org>
 <96223fb8143a4eaa9b183d376ff46e5cd8ef54b4.1628590591.git.viresh.kumar@linaro.org>
In-Reply-To: <96223fb8143a4eaa9b183d376ff46e5cd8ef54b4.1628590591.git.viresh.kumar@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 11 Aug 2021 14:28:07 +0200
Message-ID: <CACRpkdbonnFd5xu=3_CdR=1QtxL0fDoWX-A16fTPMJypWsmcdw@mail.gmail.com>
Subject: Re: [PATCH V5 2/2] gpio: virtio: Add IRQ support
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Arnd Bergmann <arnd@kernel.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Viresh Kumar <vireshk@kernel.org>,
 Cornelia Huck <cohuck@redhat.com>, linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization@lists.linux-foundation.org,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Marc Zyngier <maz@kernel.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>, "Enrico Weigelt,
 metux IT consult" <info@metux.net>, Bill Mills <bill.mills@linaro.org>,
 stratos-dev@op-lists.linaro.org
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

On Tue, Aug 10, 2021 at 12:25 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:

> This patch adds IRQ support for the virtio GPIO driver. Note that this
> uses the irq_bus_lock/unlock() callbacks, since those operations over
> virtio may sleep. Also the notifications for the eventq are processed
> using a work item to allow sleep-able operations.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Looks good to me from a GPIO point of view:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
