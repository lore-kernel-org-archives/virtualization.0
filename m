Return-Path: <SRS0=rBDE=PJ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B68C9C433F5
	for <virtualization@archiver.kernel.org>; Thu, 21 Oct 2021 10:08:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1900B610C8
	for <virtualization@archiver.kernel.org>; Thu, 21 Oct 2021 10:08:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1900B610C8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id BACEA401DF;
	Thu, 21 Oct 2021 10:08:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JEDbar0BHnSZ; Thu, 21 Oct 2021 10:08:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1FF9D4044F;
	Thu, 21 Oct 2021 10:08:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CE473C001C;
	Thu, 21 Oct 2021 10:08:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 82D23C0011
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 10:08:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5BDE14044F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 10:08:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7Kn2iQ6C3RmP
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 10:08:13 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com
 [209.85.222.43])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 406A2401DF
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 10:08:13 +0000 (UTC)
Received: by mail-ua1-f43.google.com with SMTP id r17so86908uaf.8
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 03:08:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ADPxfUc1FVZXmyLUeY8JY2J11U9rKWLSgyyZ2T7U9lA=;
 b=tcabmW+YkHvjp4pspH8RQTh9q9vFYOgAEsDO+hA0W72mn8cebcRSff2AwGf+wQFJho
 NUs6uJK/07GDkWMJwqheCvckmoWo6INiD7oIdHVli5QnkDTB63Ol77oSQ1F79pcv7oWi
 jc9LLM3Q/OlbG08EkQ9inZw+4eDodv8DZ33OTqvJNbyWkKl7k2eZX7Je3eDlYNW/V0yP
 4yVFsRMaQK8MOnlSNLTqBpufGRHfAirTUkjwN66bmSbIikcwZvoW5kKgM6U0d9q+G9r7
 XovD4o3+W5rFOoWfjfUdT1bwcfsgUaeoruw4wZrNvUcpmzQy1Mwe5d6CU8NSmnK1IDxt
 oqNA==
X-Gm-Message-State: AOAM533KFLwqd9QQ8t5SNkhVn0zluc76pogaYTKsGpWQMmwauf3qfUzK
 GUl9myA3DnyrmnR8dL5JpmgltU9WmBS9nQ==
X-Google-Smtp-Source: ABdhPJz2LatiUFCSbG4MLHf2bIQF0jbj+rqhW9QcY4p0GQyV5PgMtERAPVovr1VamYjp4VFb1QICRg==
X-Received: by 2002:a05:6102:390f:: with SMTP id
 e15mr5189883vsu.57.1634810891948; 
 Thu, 21 Oct 2021 03:08:11 -0700 (PDT)
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com.
 [209.85.222.46])
 by smtp.gmail.com with ESMTPSA id t64sm2832390vke.24.2021.10.21.03.08.10
 for <virtualization@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Oct 2021 03:08:10 -0700 (PDT)
Received: by mail-ua1-f46.google.com with SMTP id i15so208486uap.0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 03:08:10 -0700 (PDT)
X-Received: by 2002:ab0:3d9a:: with SMTP id l26mr5172072uac.114.1634810890004; 
 Thu, 21 Oct 2021 03:08:10 -0700 (PDT)
MIME-Version: 1.0
References: <8ca87330fd348fc5199ad08904ec90cc6a91a1bf.1634723848.git.viresh.kumar@linaro.org>
 <CAHp75Vctj-v8W+LgdVpYgRVL3fLdcFnOFRFg74LeCc=xLD+w4w@mail.gmail.com>
 <20211021043443.snhqpac5ofmxfb7k@vireshk-i7>
 <CAHp75VdKn7Sze9HxN0gBgbuQS2K6oB+SQsufw576Rkfg4-osOw@mail.gmail.com>
 <20211021095229.lqeb7dtxv4ix2vc5@vireshk-i7>
In-Reply-To: <20211021095229.lqeb7dtxv4ix2vc5@vireshk-i7>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 21 Oct 2021 12:07:58 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWDRGmxt55vvRTnyu5SwXCDtkcOLmKA87cd4SSa8S+Z=Q@mail.gmail.com>
Message-ID: <CAMuHMdWDRGmxt55vvRTnyu5SwXCDtkcOLmKA87cd4SSa8S+Z=Q@mail.gmail.com>
Subject: Re: [PATCH V6] gpio: virtio: Add IRQ support
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Arnd Bergmann <arnd@kernel.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Viresh Kumar <vireshk@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>, Cornelia Huck <cohuck@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Andy Shevchenko <andy.shevchenko@gmail.com>,
 "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
 Marc Zyngier <maz@kernel.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 "stratos-dev@op-lists.linaro.org" <stratos-dev@op-lists.linaro.org>,
 "Enrico Weigelt, metux IT consult" <info@metux.net>,
 Bartosz Golaszewski <brgl@bgdev.pl>, Bill Mills <bill.mills@linaro.org>
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

Hi Viresh,

On Thu, Oct 21, 2021 at 11:52 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> The structure will get aligned to the size of largest element and each
> element will be aligned to itself. I don't see how this will break
> even in case of 32/64 bit communication.

Structures are not aligned to the size of the largest element, but
to the largest alignment needed for each member.
This can be smaller than the size of the largest element.
E.g. alignof(long long) might be 4, not 8.  And m68k aligns to
two bytes at most.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
