Return-Path: <SRS0=kXQI=NW=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A9D9C4320A
	for <virtualization@archiver.kernel.org>; Tue, 31 Aug 2021 06:28:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5217060F56
	for <virtualization@archiver.kernel.org>; Tue, 31 Aug 2021 06:28:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5217060F56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0D8CF401D7;
	Tue, 31 Aug 2021 06:28:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bIRgDNEfF_2x; Tue, 31 Aug 2021 06:28:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id BA23D400E4;
	Tue, 31 Aug 2021 06:28:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 91D0CC0010;
	Tue, 31 Aug 2021 06:28:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9E324C000E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Aug 2021 06:28:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 86B2F81AC1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Aug 2021 06:28:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BqF1ysFHpbm7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Aug 2021 06:28:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0DB2581ABB
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Aug 2021 06:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1630391281;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hEPnuo65Qwng2L+Utb7e5ueojU9F4bLfB1V9DmTMPmk=;
 b=ilb/mh6b9gO5lcXmZRhpcX+dTdGx0TR0AU1D3KZHkFUzkKYgI5GhmaDsCsDF8F649wfl/q
 mA+BhK4A+W52WayqwgAVqeeQyvP6BrV0WIeQFsm8HLo+lLjroBjcEWIgq0cqbjKpH9ZIf5
 Z2G7izQvGb+HnPLKOCaAmUPWpI5W25U=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-31-JC1XDC_HM7iEaP_QFRgJjw-1; Tue, 31 Aug 2021 02:26:34 -0400
X-MC-Unique: JC1XDC_HM7iEaP_QFRgJjw-1
Received: by mail-ed1-f70.google.com with SMTP id
 y21-20020a056402359500b003cd0257fc7fso583018edc.10
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Aug 2021 23:26:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=hEPnuo65Qwng2L+Utb7e5ueojU9F4bLfB1V9DmTMPmk=;
 b=TEWYLeQwOaEBW8Syx8vhlKN1RvXopiAJR305VCISkcDoWEgRoRSlByiBSAHNlLJ401
 GbHcygMa+oteSIqJNvip6HVFNZovZ66qV8Iz9EVtuHSgXd5cj+arp9ouhQ8dG4RdaNSD
 nWoS3xenrEXlNQC8MQRgWKqXX4HHy2eGTEo3PLqQw9Bj6BYcmP5Fn5UajnYLp60cM5u7
 t2DTxUgIK9f29l+6JQS5IgQ0ld+od2w+EzkNEPHuMX+7YEeSEm0KU27Hg5KOmpsdMR1q
 WBtI0eLf4JEZ7Fzq4t7SWD3FIahLz4WHGSTRQidHIWCk+yqGjWA4BxFOmazwe1bfvQo0
 Fgxg==
X-Gm-Message-State: AOAM531P/1HsaXh7lXptvm8v9tHUfZU1MkmvKup7qYtMfqUbCPBsbPiY
 we/ureCRlpHkqNioh1yoxXO8OjbnK5qX8tFCbl+n1/E9X6fTCzYLsA/QqsonmzYczqU7ez0KyM3
 53yANMmARy1fc9nIxI2vX3+zlN1TyutYe1/fU0d0TBg==
X-Received: by 2002:a17:906:7848:: with SMTP id
 p8mr28411743ejm.212.1630391193308; 
 Mon, 30 Aug 2021 23:26:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz0ENtKRCXEgDAfYv9QFQ79jja5d57DPHChIvu4gbEetyNiq/qMcRLJnMhi1cyEze9WmqAobQ==
X-Received: by 2002:a17:906:7848:: with SMTP id
 p8mr28411715ejm.212.1630391193158; 
 Mon, 30 Aug 2021 23:26:33 -0700 (PDT)
Received: from redhat.com ([2.55.138.60])
 by smtp.gmail.com with ESMTPSA id c17sm8820979edu.11.2021.08.30.23.26.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Aug 2021 23:26:32 -0700 (PDT)
Date: Tue, 31 Aug 2021 02:26:27 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH V7] gpio: Add virtio-gpio driver
Message-ID: <20210831022536-mutt-send-email-mst@kernel.org>
References: <56ca9b1fc803e393a67e875bed4f900c6a432085.1629347189.git.viresh.kumar@linaro.org>
 <CAMRc=Mfm7EekU_LbujfPxo+NzGTErC44yj-aB+Zg8DXqo7eX5g@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAMRc=Mfm7EekU_LbujfPxo+NzGTErC44yj-aB+Zg8DXqo7eX5g@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Arnd Bergmann <arnd@kernel.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 virtualization@lists.linux-foundation.org,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Viresh Kumar <vireshk@kernel.org>, stratos-dev@op-lists.linaro.org,
 "Enrico Weigelt, metux IT consult" <info@metux.net>,
 Bill Mills <bill.mills@linaro.org>
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

On Mon, Aug 23, 2021 at 09:52:22AM +0200, Bartosz Golaszewski wrote:
> On Thu, Aug 19, 2021 at 6:30 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > This patch adds a new driver for Virtio based GPIO devices.
> >
> > This allows a guest VM running Linux to access GPIO lines provided by
> > the host. It supports all basic operations, except interrupts for the
> > GPIO lines.
> >
> > Based on the initial work posted by:
> > "Enrico Weigelt, metux IT consult" <lkml@metux.net>.
> >
> > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> > Bartosz,
> >
> > Can you please pick this up for 5.15, the specification is already merged now:
> >
> > https://github.com/oasis-tcs/virtio-spec/blob/master/virtio-gpio.tex
> >
> > I will follow up with the IRQ stuff separately.
> >
> 
> Applied, thanks!
> 
> Bart

Um. didn't expect this to be applied yet, the driver is not
sparse clean, kernel build bot gave some other warnings too.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
