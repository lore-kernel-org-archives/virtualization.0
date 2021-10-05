Return-Path: <SRS0=LBOH=OZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51950C4332F
	for <virtualization@archiver.kernel.org>; Tue,  5 Oct 2021 05:50:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA5BA6120D
	for <virtualization@archiver.kernel.org>; Tue,  5 Oct 2021 05:50:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CA5BA6120D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8D5154077B;
	Tue,  5 Oct 2021 05:50:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2d6xPoURK0k3; Tue,  5 Oct 2021 05:50:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 24BD3405FB;
	Tue,  5 Oct 2021 05:50:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E9CA4C000F;
	Tue,  5 Oct 2021 05:50:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4BC99C000D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Oct 2021 05:50:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 394BA608BD
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Oct 2021 05:50:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id C0jNOU-sPJ9h
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Oct 2021 05:50:54 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5CD36608BC
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Oct 2021 05:50:54 +0000 (UTC)
Received: by mail-pl1-x62a.google.com with SMTP id y5so1539858pll.3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 04 Oct 2021 22:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=4NeMuZezzbqxNlXi1LQWclIxq6eDR6pm/+jHI0J3aK8=;
 b=S4xmUCWSrgXLjCPnoSiwsI+cxVNnf61RlJdSSJRG4uUK5Fmt7nNkR4VtIycRv4we/8
 DnC2PZX7rqJo6MW/+1Ri+eIAab8E1cCRQ9BR6/apHgI8rN4gUgL4Joz/d5DMqPQ+1rcL
 Fz7U9pn36SzARq/Jf6Ei1V4o38Giw6cIjoZhwcQLevcE/8Q5Id8LpaFN4NTXNYVbwBcu
 5m14tmrdglqtOjN7jCcGtHod88o7xzlUjHB17pxT4l/mcqgPsg2ue8R0BzPm2+P8mReJ
 bSa+M9d3DzRQOthZT6+FGhhxLaoiLhZUk1+NwdMjY3HbBaRXpEr4epJElREUQsGktIU8
 Bm0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=4NeMuZezzbqxNlXi1LQWclIxq6eDR6pm/+jHI0J3aK8=;
 b=qwulifjorwzjJvvOvN017kyWfUAPbJm8SLpFeWrY1zh2CF1j8rWSw9NbWbkJn7T0kM
 78gHkA0WmCTAn6/mau6vOl6A0nB+2xGIbgg0aqM3tM0AtRASvAkJtwSICDTkcruRICAO
 /6NFuCSKgUwjmU7YSQje3fyZk7xGNTr9dj9K28hX8VF0eNs2Rs0UMi/j2IihJuM/pPxV
 GyLLQcJz0M90gSbyDBsIiriBCwINFzzP6cHVOoMqedVSonaJ+vzo7DS0b8uE28am7/Q/
 E2sXdOr08aAuOsyK8bF+5ETPgI5IWpZ1E0CvYThxZH8T6m1j2p78Ni2Mm6uOfwDGpyYo
 qGdg==
X-Gm-Message-State: AOAM533YIpMtqLI5XfsaSbmVxByzXqS6y9XJo/Sfx2tLuokzg2l0sEBZ
 gsiXbTaw6Bt05PK9g7gc5R2qMw==
X-Google-Smtp-Source: ABdhPJypXaVT+p/dnAD+BO/o1OCK/fiXD9C3n/HU4n11SrE4tZJkADqT4WCFBjvmvgvHny+cPP+moA==
X-Received: by 2002:a17:90a:b382:: with SMTP id
 e2mr1562944pjr.119.1633413053613; 
 Mon, 04 Oct 2021 22:50:53 -0700 (PDT)
Received: from localhost ([122.171.247.18])
 by smtp.gmail.com with ESMTPSA id s10sm673204pjn.38.2021.10.04.22.50.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Oct 2021 22:50:52 -0700 (PDT)
Date: Tue, 5 Oct 2021 11:20:50 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH] gpio: aggregator: Add interrupt support
Message-ID: <20211005055050.ggimidaqis5tfxav@vireshk-i7>
References: <c987d0bf744150ca05bd952f5f9e5fb3244d27b0.1633350340.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <c987d0bf744150ca05bd952f5f9e5fb3244d27b0.1633350340.git.geert+renesas@glider.be>
User-Agent: NeoMutt/20180716-391-311a52
Cc: Enrico@rox.of.borg, Arnd Bergmann <arnd@kernel.org>,
 linux-gpio@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-renesas-soc@vger.kernel.org,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 metux IT consult <lkml@metux.net>, Weigelt@rox.of.borg,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
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

On 04-10-21, 14:44, Geert Uytterhoeven wrote:
> Currently the GPIO Aggregator does not support interrupts.  This means
> that kernel drivers going from a GPIO to an IRQ using gpiod_to_irq(),
> and userspace applications using line events do not work.
> 
> Add interrupt support by providing a gpio_chip.to_irq() callback, which
> just calls into the parent GPIO controller.
> 
> Note that this does not implement full interrupt controller (irq_chip)
> support, so using e.g. gpio-keys with "interrupts" instead of "gpios"
> still does not work.

Hi Geert,

Thanks for looking into this. I am not sure of the difference it makes
with and without full irq-chip, but lemme explain the use case that we
are concerned about with virtio.

Eventually the interrupt should be visible to userspace, with
something like libgpiod. Which can then send the information over
virtio to the guest.

Will the interrupts be visible in userspace with your patch ?

-- 
viresh
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
