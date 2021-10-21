Return-Path: <SRS0=rBDE=PJ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D820C433F5
	for <virtualization@archiver.kernel.org>; Thu, 21 Oct 2021 10:02:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEF836108E
	for <virtualization@archiver.kernel.org>; Thu, 21 Oct 2021 10:02:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DEF836108E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9BA9C405FA;
	Thu, 21 Oct 2021 10:02:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id J2Ra5lXvBL7r; Thu, 21 Oct 2021 10:02:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 13235401CA;
	Thu, 21 Oct 2021 10:02:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DDE4AC001C;
	Thu, 21 Oct 2021 10:02:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7C840C0011
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 10:02:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5CAA383ADF
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 10:02:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BsyypWOYC0EW
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 10:02:23 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B7F0580D60
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 10:02:23 +0000 (UTC)
Received: by mail-pj1-x102e.google.com with SMTP id
 oa12-20020a17090b1bcc00b0019f715462a8so157652pjb.3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 03:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=BVnVh393zqs+84Ef+7Cf6iAJo6ZlU0xwDAUM9kkhz7A=;
 b=L0P6ru9Sdt3Kdw1AgYtoHF8/6+sT0zhbAb4VlT1zg5jBKqzZ6i5KpIvQahH/Q/BMH0
 qlxK8YyQyZTYW9N9ZntBirrgfwuq22gAa35X9xnxN5RJR1YjJtI+s4sxlvuT9EJNXzXq
 LFewtytzRkeX24WlzwCzdMhAW1ajQ7G6u0LRtfmG/V+8fOfSpZvCj4WsFaVDeoarN1Kt
 jjP2h1h/VBMrYb/v1g+9o4hGCfq5Ly2JeYFuMfHFQZBpQTT8z/GaclGjKQOJVfVGGUeJ
 4FVN+3AOm4l/FnM1VSiyiwuv0w0/B9JkWjjup3XKCYOgcfE7017HU0qFbTIYsYw/gItO
 98OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=BVnVh393zqs+84Ef+7Cf6iAJo6ZlU0xwDAUM9kkhz7A=;
 b=JOONz0feuYGOnYRSjNYsWHRJACbae8EhkkoLN3u8Nj0TtZeAnLClpClHBAGN6yp7kl
 o3LRQ6KK+YwLOrArLQ7gqXSfNPHmupaHj7NjEemfy8S8EEKFb0JJH5N8RiYlF5kcUicO
 k0E1os9YmkMlIQWwhcl8ax22518t4jIlQ+1EbgSamZ/QOmTpNHzxXhvcN92ta0KYFBzM
 t/FL1XW78RCuL3NerVJcnR0R54YtniHBcvR1zXaoif/gyW6thJO51yMDzmKxIVVe/+YE
 CUv8wG675b3M7JAqxFeCJ+y0bf8YHGE8C/GpaX6/JdFS75xCSqKxUYNee9vbdELrUgtY
 4f/A==
X-Gm-Message-State: AOAM532gjO8F6GreRloDXS9kxsdUD93tf9YwPieLmMcjbe711IbW6vaC
 ftckDkb2yhC18J+8/h5IKz1Z1w==
X-Google-Smtp-Source: ABdhPJysIBA1vMLVVhG7RvAgGrnuG23Fk9MBvt6JS6DNMezsStHl+NQU6P+RdR52kZcPu5WqYgTdHg==
X-Received: by 2002:a17:902:8d8d:b0:140:638:a87c with SMTP id
 v13-20020a1709028d8d00b001400638a87cmr1049898plo.9.1634810543093; 
 Thu, 21 Oct 2021 03:02:23 -0700 (PDT)
Received: from localhost ([106.201.113.61])
 by smtp.gmail.com with ESMTPSA id 23sm8849156pjc.37.2021.10.21.03.02.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Oct 2021 03:02:22 -0700 (PDT)
Date: Thu, 21 Oct 2021 15:32:20 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH V6] gpio: virtio: Add IRQ support
Message-ID: <20211021100220.oxwwfj6jegxdvmxw@vireshk-i7>
References: <8ca87330fd348fc5199ad08904ec90cc6a91a1bf.1634723848.git.viresh.kumar@linaro.org>
 <CAHp75Vctj-v8W+LgdVpYgRVL3fLdcFnOFRFg74LeCc=xLD+w4w@mail.gmail.com>
 <20211021043443.snhqpac5ofmxfb7k@vireshk-i7>
 <CAHp75VdKn7Sze9HxN0gBgbuQS2K6oB+SQsufw576Rkfg4-osOw@mail.gmail.com>
 <20211021095229.lqeb7dtxv4ix2vc5@vireshk-i7>
 <CAHp75VcBowxFoseXKwU2VjNcu75ttvHW_sno9MihHL88+oP1ew@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAHp75VcBowxFoseXKwU2VjNcu75ttvHW_sno9MihHL88+oP1ew@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Cc: Arnd Bergmann <arnd@kernel.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Viresh Kumar <vireshk@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>, Cornelia Huck <cohuck@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
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

On 21-10-21, 12:58, Andy Shevchenko wrote:
> I admit I haven't looked into the specification, but in the past we
> had had quite an issue exactly in GPIO on kernel side because of this
> kind of design mistake.

> The problem here if in the future one wants to
> supply more than one item at a time, it will be not possible with this
> interface.

Why ?

> Yes, I understand that in current design it's rather missed
> scalability, but hey, I believe in the future we may need
> performance-wise calls.

-- 
viresh
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
