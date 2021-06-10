Return-Path: <SRS0=uiEo=LE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B16F6C48BDF
	for <virtualization@archiver.kernel.org>; Thu, 10 Jun 2021 20:46:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4941C613FF
	for <virtualization@archiver.kernel.org>; Thu, 10 Jun 2021 20:46:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4941C613FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0A9F583D48;
	Thu, 10 Jun 2021 20:46:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EcfXKRA7j8xD; Thu, 10 Jun 2021 20:46:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1B3AA83D47;
	Thu, 10 Jun 2021 20:46:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F246BC000E;
	Thu, 10 Jun 2021 20:46:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BCEECC000B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 20:46:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AB136401F4
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 20:46:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Z3VK_bEQkVTP
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 20:46:18 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com
 [IPv6:2a00:1450:4864:20::236])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5ED96400C8
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 20:46:18 +0000 (UTC)
Received: by mail-lj1-x236.google.com with SMTP id r16so6820876ljc.0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 13:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=P3feXPo8hgD2FD68i8SPgVY8I4kuiJLBZN2g8qdSekM=;
 b=yY+WLokJziltoHJ9f3XgfvwE/LSudYOXHFaEMxWzIlSAyHQ4l4493Euz5Bx9wQPb7a
 jpyTB8qdbkY1dJd4TqfOgK+VuvohCE29cXAbv6BGujgKABmWag8PeU0649zqKmpPK+d3
 L3YeQfMXlzWmcQPkHTiWmDTr2Ly+swbU10hGAGB5DlKfZSPjiUa/medL+veah9aYlzKz
 HWakmG2quynID1DJ+/m3r5Vq1EEnUjoQA2Ht+5jxdI5W6AowYsdQm9TP/2CtP0evZfaU
 1pJBZ9tM9E79EbjLcTa47JCMa41g7dXjg6ykRGszpx/NJB5cC9Ep31xpV808Li2sJr9h
 U89g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=P3feXPo8hgD2FD68i8SPgVY8I4kuiJLBZN2g8qdSekM=;
 b=tisKCJpg8cIZYZ2FiOXph/6x/g85/68AHRIc0p9O6/Iv6f2NlT5Mvy1l7IQ/c5z/Ch
 PKENxZ/WQcQNN7jMq3KCJ5IkAlT5s8JVlHbXVYuNiyg//AyMDxLKK66d/I60879OM7E5
 FSeTmIMtqAzj9mCMB2SKgPnVxW4Xqd/G2xsQWiBJtfs1I2cbg1XJQ04RvNs3c4Z6bo8p
 dWUNpQRC2Vbq+aRZpsCk8LGWswbPVE/MaN6Cd0qaqL0Tp633VRrym8468QlofZ8PmPR3
 O3O40wVNHO4J82IIcKC3W4GGR2wLFl8tG5radUJOdMzrUjcu3TzD40Z/QJTHnZ8tG2f6
 Fwkg==
X-Gm-Message-State: AOAM530qpCZjlXHJF10OlhIioJwTS1O+zuGsxFbih6wj81T/5Jly1ngy
 tKgn1Zz9cacsesfPUdZQaL5tKLNM9o9x8+Pawm/d0g==
X-Google-Smtp-Source: ABdhPJxNKGpZ/jjSlWl2zoMMOz8tNxjDSR41dSYXKzHTgV7+ERxWWp9zJMl7Q6uw/IGcGvfEK0j0qWyEO2QHKxTxfVQ=
X-Received: by 2002:a05:651c:1411:: with SMTP id
 u17mr327855lje.438.1623357976125; 
 Thu, 10 Jun 2021 13:46:16 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1623326176.git.viresh.kumar@linaro.org>
 <10442926ae8a65f716bfc23f32339a6b35e51d5a.1623326176.git.viresh.kumar@linaro.org>
In-Reply-To: <10442926ae8a65f716bfc23f32339a6b35e51d5a.1623326176.git.viresh.kumar@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 10 Jun 2021 22:46:04 +0200
Message-ID: <CACRpkdZV2v2S5z7CZf_8DV=At9-oPSj7RYFH78hWy3ZX37QnDQ@mail.gmail.com>
Subject: Re: [PATCH V3 1/3] gpio: Add virtio-gpio driver
To: Viresh Kumar <viresh.kumar@linaro.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Alistair Strachan <astrachan@google.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Viresh Kumar <vireshk@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization@lists.linux-foundation.org,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, "Enrico Weigelt,
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

Hi Viresh!

thanks for working on this, it's a really interesting driver.

My first question is conceptual:

We previously have Geerts driver for virtualization:
drivers/gpio/gpio-aggregator.c

The idea with the aggregator is that a host script sets up a
unique gpiochip for the virtualized instance using some poking
in sysfs and pass that to the virtual machine.
So this is Linux acting as virtualization host by definition.

I think virtio is more abstract and intended for the usecase
where the hypervisor is not Linux, so this should be mentioned
in the commit, possibly also in Kconfig so users immediately
know what usecases the two different drivers are for.

Possibly both could be used: aggregator to pick out the GPIOs
you want into a synthetic GPIO chip, and the actual talk
between the hypervisor/host and the guest using virtio, even
with linux-on-linux.

Yet another usecase would be to jit this with remoteproc/rpmsg
and let a specific signal processor or real-time executive on
another CPU with a few GPIOs around present these to
Linux using this mechanism. Well that would certainly interest
Bjorn and other rpmsg stakeholders, so they should have
a look so that this provides what they need they day they
need it. (CCed Bjorn and also Google who may want this for
their Android emulators.)

On Thu, Jun 10, 2021 at 2:16 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:

> +static const char **parse_gpio_names(struct virtio_device *vdev,
> +                              struct virtio_gpio_config *config)

I really like this end-to-end plug-and-play that even provides
the names over virtio.

I think my patch to the gpiolib to make it mandatory for names to
be unique per-chip made it in, but please make that part of the spec
so that we don't get the problem with non-unique names here.

I suppose the spec can be augmented later to also accept config
settings like open drain pull up/down etc but no need to specify
more than the basic for now.

But to be able to add more in the future, the client needs some
kind of query mechanism or version number so the driver can
adapt and not announce something the underlying virtio device
cannot do. Do we have this? A bitmask for features, a version
number that increase monotonically for new features to be
presented or similar?

Because otherwise we have to bump this:
+#define VIRTIO_ID_GPIO                 41 /* virtio GPIO */

every time we add something new (and we will).

Yours,
Linus Walleij
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
