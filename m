Return-Path: <SRS0=yluT=M2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_RED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50EF9C432BE
	for <virtualization@archiver.kernel.org>; Tue,  3 Aug 2021 04:30:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A64B161037
	for <virtualization@archiver.kernel.org>; Tue,  3 Aug 2021 04:30:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A64B161037
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 607C482FA9;
	Tue,  3 Aug 2021 04:30:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dMbgsrIzFIU0; Tue,  3 Aug 2021 04:30:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1FDB8828AA;
	Tue,  3 Aug 2021 04:30:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E444DC001A;
	Tue,  3 Aug 2021 04:30:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4F50BC000E
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Aug 2021 04:30:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 297C060602
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Aug 2021 04:30:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id g7v_--RJL5R2
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Aug 2021 04:30:18 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 56A77605E0
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Aug 2021 04:30:17 +0000 (UTC)
Received: by mail-pj1-x1034.google.com with SMTP id l19so28173107pjz.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 02 Aug 2021 21:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=WuU0zqp5FxDzXHdF6RFEsqh5sXTxns57RbzCe8eINV4=;
 b=U0yP0tud2140rIMQ9BsrY0xo0wzev+KHGRy4B6aHwt9CP2EJ8MocyiIyz6yYB2ZIEi
 6E6HN96OA3LJipeTxDzH+TNXQgVULyaQXWnUW/n1JlvjmsuBXmSDgkPgcNB3+RhQ6o+a
 ovnCxRYGzDDoJ7RcGNJmCYAS8gJLdYcBSYIEJAExO2xfpAHCwtCg79OsAXUpotjUU2BE
 spNmP4St0+FcuQt0c5hi/YfpOtY9epEeQ7lDNvdb91GTR4e5l44hQFy43MMux7+ienso
 1fgASFok9lixiXvGJaxhUw8PkcDvlGkykRO/WbHigND+qBGpks5pa/MByls6+VnwNc8W
 MIkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=WuU0zqp5FxDzXHdF6RFEsqh5sXTxns57RbzCe8eINV4=;
 b=B2KEkAbsomUflfwXI1SWiKZD6G5tT1YdJgpZ6DBJf+hw5cVFfnacP+DMpl/5HgF6iC
 2Lq4G8NGXS7uuAKV0XBrRxeMEw9HZB9GVoWYCeF+eOOKEcNoJiSKDvh2T3Ims/UXJF76
 GY2LQt+VReDR2MhMHfAIBn8FDGwF1TfK6Zshst8g579ejBjEiCH1NNp6XMPAajLD571c
 bOsQphKBFmik8zPmmD4BD1EXmCfv3LGGEyLhzbAa2ZJnUjY08P/bYYf1E2EIh0iqkmMI
 jmb42jJZHGi8i9yu1czlvhyZP9m/k7OsolgrhVwv2PKAMjrRetKM7XGblWcu9jrD5N1n
 +uGg==
X-Gm-Message-State: AOAM531Lta704O9nwOtmA2MZ5o3cA0K4p6Q019Wc6dhA2UUX/9Zmju5v
 i9KLOT5eSPlL3VBlUf3Ew7IFHA==
X-Google-Smtp-Source: ABdhPJwWgvDbFps8MFCa+isFcB0DfTlVKe9/ZNKxGryq1uLTkKlvKLKaFxw5Sik7NQhNI35ZTv1CSA==
X-Received: by 2002:a62:8fd4:0:b029:3af:3fa7:c993 with SMTP id
 n203-20020a628fd40000b02903af3fa7c993mr19305886pfd.77.1627965017486; 
 Mon, 02 Aug 2021 21:30:17 -0700 (PDT)
Received: from localhost ([122.172.201.85])
 by smtp.gmail.com with ESMTPSA id 21sm13539667pfh.103.2021.08.02.21.30.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Aug 2021 21:30:16 -0700 (PDT)
Date: Tue, 3 Aug 2021 10:00:14 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH V4 3/5] dt-bindings: gpio: Add bindings for gpio-virtio
Message-ID: <20210803043014.paskwghdio6azplp@vireshk-i7>
References: <cover.1627362340.git.viresh.kumar@linaro.org>
 <acf7402ef4aabc0ad6295c32846f2bef1cd9b56a.1627362340.git.viresh.kumar@linaro.org>
 <YQhKKyPmOUE8z+US@robh.at.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YQhKKyPmOUE8z+US@robh.at.kernel.org>
User-Agent: NeoMutt/20180716-391-311a52
Cc: Arnd Bergmann <arnd@kernel.org>,
 Vincent Guittot <vincent.guittot@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, "Enrico Weigelt,
 metux IT consult" <info@metux.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>, devicetree@vger.kernel.org,
 linux-gpio@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
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

On 02-08-21, 13:40, Rob Herring wrote:
> Humm, how does one implement interrupts without a parent interrupt? It 
> uses the parent virtio,mmio interrupt?

Kind of, yeah, but not necessarily.

The interrupt information is passed over buffers shared between host and guest.
Now the guest may process the buffers when it receives a notification from the
host, that will be at downpath of an interrupt for virtio,mmio. Or the guest may
poll on the virtqueue and process any buffers as soon as they are made
available, no interrupts then.

-- 
viresh
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
