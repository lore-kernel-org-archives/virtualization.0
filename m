Return-Path: <SRS0=rBDE=PJ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C93EC433EF
	for <virtualization@archiver.kernel.org>; Thu, 21 Oct 2021 10:49:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28EC061205
	for <virtualization@archiver.kernel.org>; Thu, 21 Oct 2021 10:49:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 28EC061205
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D9DAC60EF3;
	Thu, 21 Oct 2021 10:49:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0cQfMeQZv3Cp; Thu, 21 Oct 2021 10:49:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 7EE5860EBA;
	Thu, 21 Oct 2021 10:49:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 59946C0033;
	Thu, 21 Oct 2021 10:49:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7ABAAC0011
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 10:49:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5D6DC832B0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 10:49:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MkdDc2kFo4eT
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 10:49:54 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com
 [IPv6:2607:f8b0:4864:20::42d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AAC12831DA
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 10:49:54 +0000 (UTC)
Received: by mail-pf1-x42d.google.com with SMTP id q19so281055pfl.4
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 03:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=diSXIurctqParyeX91eQ1zquoLUSJfsB8YTVPKGj1rg=;
 b=DgwVI/GAtAT6Y0Gceejk+CFb9t3hp5sJtnTnxDP8ZAY+IrUyZ2jT1SI+FiFBwQsS4S
 4iUtNy9GhXtt6Mg4lYSRf0PdfgkXyTN//GARnhMS5oL4tQxSmEhDOp9xxWKqZgHO/KoQ
 MlGQTZs8U/Us0JTjZOVFg4HC7pPZfDL6Eaaaffta4AdVwYfeEmTGPWY13SHUaue66+rP
 /RqLPOhIZguk+tG1fJ2+CwpK2zx9ZN6VMEY3VL6h+OhWAvAjm596Jut0Pdei2CBVQ8mp
 YJfqYBaFoTew2gWZCzotI16ogBwo0+qgDSHmG4QnMg3SurrqZ8olYJlfIjqsqdWQo2pq
 aSUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=diSXIurctqParyeX91eQ1zquoLUSJfsB8YTVPKGj1rg=;
 b=aGy+EtxE7q9dly1R9erz20W1fqoqqX2Ki+4yj5FfPslJv9uWGRZ5oE57WAKeuecfv1
 XH2lufgKsL1To3DaEoRAG5P+cjKHPLiHR2xlKCSulsA2/yZ773ZrpjrwIz6PmGFiF2Ue
 cxQpB0zaJctVfljEj7uPBGkDLWjClf8kzENG7W157FyNBEjuGSC6Ax4by4JKvnyCtn6L
 Yb75qFiDkDiY9124CXAbrsuDfXOJmG77Efccd9T4/ZdG34nKqVBmEB8j0Vi2lszXUkDt
 1cp3g0bU6Oy6XuF2NbYNolsiDNjC7cwnGM5q6iC6W5WHLnpNobnbGxCz+CiXgeXNG7mS
 TGQA==
X-Gm-Message-State: AOAM531QbxvysQHTCgGbGGMxHst3/DJ9U7ItGQ5Big9xsbO8DU5N/Fjv
 Gcm65CmUicr16KPMuSSTniZRZg==
X-Google-Smtp-Source: ABdhPJxQmq6uOHLqJCEYKHHk8rV8cTL5H3Ywlzsew3ZtjOIE3cFz7q3n2AHECjXVsjUD9Uq0kaqbrg==
X-Received: by 2002:a63:1e0e:: with SMTP id e14mr3812332pge.5.1634813393001;
 Thu, 21 Oct 2021 03:49:53 -0700 (PDT)
Received: from localhost ([106.201.113.61])
 by smtp.gmail.com with ESMTPSA id y20sm5743062pfp.68.2021.10.21.03.49.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Oct 2021 03:49:52 -0700 (PDT)
Date: Thu, 21 Oct 2021 16:19:50 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH V6] gpio: virtio: Add IRQ support
Message-ID: <20211021104950.nhvify5lo7y5fdfh@vireshk-i7>
References: <8ca87330fd348fc5199ad08904ec90cc6a91a1bf.1634723848.git.viresh.kumar@linaro.org>
 <CAHp75Vctj-v8W+LgdVpYgRVL3fLdcFnOFRFg74LeCc=xLD+w4w@mail.gmail.com>
 <20211021043443.snhqpac5ofmxfb7k@vireshk-i7>
 <CAHp75VdKn7Sze9HxN0gBgbuQS2K6oB+SQsufw576Rkfg4-osOw@mail.gmail.com>
 <20211021095229.lqeb7dtxv4ix2vc5@vireshk-i7>
 <CAMuHMdWDRGmxt55vvRTnyu5SwXCDtkcOLmKA87cd4SSa8S+Z=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAMuHMdWDRGmxt55vvRTnyu5SwXCDtkcOLmKA87cd4SSa8S+Z=Q@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
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

On 21-10-21, 12:07, Geert Uytterhoeven wrote:
> On Thu, Oct 21, 2021 at 11:52 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > The structure will get aligned to the size of largest element and each
> > element will be aligned to itself. I don't see how this will break
> > even in case of 32/64 bit communication.
> 
> Structures are not aligned to the size of the largest element, but
> to the largest alignment needed for each member.

Right, I was talking in terms of the structures we have here for GPIO.
The biggest member here (for any structure) is 32bits long, and
compiler shouldn't add extra padding here.

> This can be smaller than the size of the largest element.
> E.g. alignof(long long) might be 4, not 8. 

Right.

> And m68k aligns to two bytes at most.

Interesting, I assumed that it will be 4bytes for 32 bit systems. So
in case of m68k, we will see something like this ?

struct foo {
    u8 a;       // aligned to 2 bytes

                // padding of 1 byte

    u32 b;      // aligned to 2 bytes
}

-- 
viresh
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
