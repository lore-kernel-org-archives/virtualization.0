Return-Path: <SRS0=kXQI=NW=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB657C432BE
	for <virtualization@archiver.kernel.org>; Tue, 31 Aug 2021 05:31:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 605F06101C
	for <virtualization@archiver.kernel.org>; Tue, 31 Aug 2021 05:31:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 605F06101C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1B60640015;
	Tue, 31 Aug 2021 05:31:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hEm6qNcAtTP2; Tue, 31 Aug 2021 05:31:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4AF52401D7;
	Tue, 31 Aug 2021 05:31:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2384EC001A;
	Tue, 31 Aug 2021 05:31:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 16368C000E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Aug 2021 05:31:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id F36A840470
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Aug 2021 05:31:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id b8-ouqd-5mkU
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Aug 2021 05:31:13 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 900834047F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Aug 2021 05:31:08 +0000 (UTC)
Received: by mail-pl1-x62f.google.com with SMTP id n18so510934plp.7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Aug 2021 22:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=D1j+u39JQe0IvSvalduRURIv+C+pC/WleO58NuYMuEE=;
 b=WJp8v1nOOjm9ZpppPwTfY2f8YP3w1j5YPwC41/npsmVhdgHXNj0yX1RRaA3p79kcbj
 l+fju0SQ4RqwIaDZuHGHORD/zVYh8Y5RxlpoRL7ULgxPd0/zxZqCFYhYNd/AX8s8kUGp
 HyBcmPBjk6uJFngm3p/6TLEj1a0F8TXfOoTq8swKLUNq6P2o2nNXO1At8oFReHwxistm
 wJ4Jp20YtezatBgYnp/J9+jSbDIr4luqhA/Fcq5A9XhwR1yWB0qgpDKtsdi1uLEBMwsu
 4QWzxRpnVbdUgBTYQo5kyA6ss8xG8FwPRE2RhNlYuyJvndcRKh7JvMcv1hdf6DKYkTlJ
 jKAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=D1j+u39JQe0IvSvalduRURIv+C+pC/WleO58NuYMuEE=;
 b=nVynbv1Xvn3xom6Maf939rOdZXzjN3s6TQNAb5FHIauuBqI1/kxJ0sZKA/gyc0YtZy
 hLFDmwHgoucRSvrOV6J+HJnSTpiQyRVHU5/jWFLBQFuwrprm+y6Z8rmhuliAVhz7XJW1
 YbZi7Easz1596qZqwPGzbtIWWlhU563DX9fFo6XJLZptV6zpN9unnXLotzjq+Q1eq7z0
 F+uhps6anHJlLmwiHHPlkzXbbWPEwrGEEldIcXglUZeF7Q5eWWi8fueSe21PzOkiNqu3
 k20kLXyOKHdwfe73MUkNsDfkL/dEhJhvvEozWpIUkvgSt5vwkgxik4pDkpzsJbZ4JcTc
 H2FA==
X-Gm-Message-State: AOAM532FuC4hKPycaUh7yWJuQTiu4CNbwygw3dtddxnEFA+hnMXf80ki
 QDZNET6K8peoK0S1LQ8UsC2DIQ==
X-Google-Smtp-Source: ABdhPJyjDELQe1mDHU5bNl0p0yBqpmQlcN+4VXQH9PQNBMQg+8YtgAejAl0fhVV67imVjkJe8fS97A==
X-Received: by 2002:a17:90a:8b81:: with SMTP id
 z1mr3236338pjn.82.1630387868016; 
 Mon, 30 Aug 2021 22:31:08 -0700 (PDT)
Received: from localhost ([122.172.201.85])
 by smtp.gmail.com with ESMTPSA id c15sm1319656pjr.22.2021.08.30.22.31.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Aug 2021 22:31:07 -0700 (PDT)
Date: Tue, 31 Aug 2021 11:01:05 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@kernel.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH V4 0/5] virtio: Add virtio-device bindings
Message-ID: <20210831053105.ut73bmvxcop65nuv@vireshk-i7>
References: <cover.1627362340.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cover.1627362340.git.viresh.kumar@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Cc: devicetree@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>,
 Arnd Bergmann <arnd@arndb.de>, Bill Mills <bill.mills@linaro.org>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Wolfram Sang <wsa@kernel.org>, linux-gpio@vger.kernel.org,
 linux-i2c@vger.kernel.org, "Enrico Weigelt, metux IT consult" <info@metux.net>
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

On 27-07-21, 10:53, Viresh Kumar wrote:
> Hi,
> 
> Currently the DT only provides support for following node types for virtio-mmio
> nodes:
> 
>         virtio_mmio@a000000 {
>                 dma-coherent;
>                 interrupts = <0x00 0x10 0x01>;
>                 reg = <0x00 0xa000000 0x00 0x200>;
>                 compatible = "virtio,mmio";
>         };
> 
> Here, each virtio-mmio corresponds to a virtio-device. But there is no way for
> other users in the DT to show their dependency on virtio devices.
> 
> This patchset provides that support.
> 
> The first patch adds virtio-device bindings to allow for device sub-nodes to be
> present and the second patch updates the virtio core to update the of_node.
> 
> Other patches add bindings for i2c and gpio devices.
> 
> Tested on x86 with qemu for arm64.

Michael, are you picking these up for 5.15 ?

-- 
viresh
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
