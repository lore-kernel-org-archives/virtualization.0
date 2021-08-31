Return-Path: <SRS0=kXQI=NW=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDA77C432BE
	for <virtualization@archiver.kernel.org>; Tue, 31 Aug 2021 14:25:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94573600AA
	for <virtualization@archiver.kernel.org>; Tue, 31 Aug 2021 14:25:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 94573600AA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6158660C15;
	Tue, 31 Aug 2021 14:25:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id j3ENSYSA7hjg; Tue, 31 Aug 2021 14:25:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 06FD660C0B;
	Tue, 31 Aug 2021 14:25:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CAF8AC001A;
	Tue, 31 Aug 2021 14:25:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AA271C000E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Aug 2021 14:25:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 85B6A4051B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Aug 2021 14:25:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4lD2P6dRmj62
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Aug 2021 14:25:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E46F54045F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Aug 2021 14:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1630419927;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OA/jhyLAYtK1tYZ39fbir6HGMf0iZmNE8/Rh8O+Ui3Q=;
 b=Ee2oFBqiEdBsw45OB+cwbDyOThwixg1+zYqbSLlcixvOiukyHna+tFznnPYbnt1oNAbCLi
 H3oru32Wn3CgT13dWzkPPOm/De7il63fxbWn8OhCVMEgmI9gAIC5zyhBO5UwnmpPN3arfn
 jSyf4QsNVPHRleLsZtim4xiSHblXjpU=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-596-tSYX7PGtP6agyM19GbiuHg-1; Tue, 31 Aug 2021 10:25:26 -0400
X-MC-Unique: tSYX7PGtP6agyM19GbiuHg-1
Received: by mail-ej1-f69.google.com with SMTP id
 o7-20020a170906288700b005bb05cb6e25so7223036ejd.23
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Aug 2021 07:25:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=OA/jhyLAYtK1tYZ39fbir6HGMf0iZmNE8/Rh8O+Ui3Q=;
 b=mFBAtK5RGTTlfTeMrE47gQ/mzeHOcAkNU8g5ixqZc4V43SFV86Yj2J9S+3/ebs2w8y
 QaQ9GHfNCp9BoPNmy6VdwqCel20xMMPng7odesEJwH1rD2ZZScRzgftvcUjr5VjQd0VN
 bCRItjMPBBT8da3IbvumfInipqRGOvCImRkrkZpzMYzL6Hh6SPU/Gu1Zafmu64RXQ/TB
 ocZYhxcerdAR1pQSNZl4A5Itp6q0D8H0F6eHKVf0U+5QmllDIjfEYvSJOpux/4no8hz6
 6oRHFpXOo/vrO/8gKmJ6xXr+TBXbzJ7Xg8WBHoDynMlIZNRP8vCh8Nq34s8/Xcntt1zt
 7xug==
X-Gm-Message-State: AOAM532S3Utd76iAAw16S6feuds6oLIFNGT4b8sjng1ZqUrf+wGcK8EN
 aYB/zpIce985jnCtI33c9DA4oFEV1jop3RwEwXj1d7IotlKwzaU8MNKd2Jwwzgjv242YsPuFsi9
 HEYMfIsTXWbn20dQwKmiN81H6XhvcN/MuoXdHzYPsJw==
X-Received: by 2002:a17:906:70b:: with SMTP id
 y11mr31329824ejb.274.1630419925020; 
 Tue, 31 Aug 2021 07:25:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwSzD9zkr7wPpktKq9Ktr39dANS1nu+utRyQ0BSDOUx3yoPFWOxowvAJPabM1ziUJDcXh+Mmg==
X-Received: by 2002:a17:906:70b:: with SMTP id
 y11mr31329801ejb.274.1630419924831; 
 Tue, 31 Aug 2021 07:25:24 -0700 (PDT)
Received: from redhat.com ([2.55.138.60])
 by smtp.gmail.com with ESMTPSA id b2sm8403019ejj.124.2021.08.31.07.25.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Aug 2021 07:25:24 -0700 (PDT)
Date: Tue, 31 Aug 2021 10:25:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V4 0/5] virtio: Add virtio-device bindings
Message-ID: <20210831102514-mutt-send-email-mst@kernel.org>
References: <cover.1627362340.git.viresh.kumar@linaro.org>
 <20210831053105.ut73bmvxcop65nuv@vireshk-i7>
MIME-Version: 1.0
In-Reply-To: <20210831053105.ut73bmvxcop65nuv@vireshk-i7>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Arnd Bergmann <arnd@kernel.org>,
 Vincent Guittot <vincent.guittot@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, "Enrico Weigelt,
 metux IT consult" <info@metux.net>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Wolfram Sang <wsa@kernel.org>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>, devicetree@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, linux-i2c@vger.kernel.org,
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

On Tue, Aug 31, 2021 at 11:01:05AM +0530, Viresh Kumar wrote:
> On 27-07-21, 10:53, Viresh Kumar wrote:
> > Hi,
> > 
> > Currently the DT only provides support for following node types for virtio-mmio
> > nodes:
> > 
> >         virtio_mmio@a000000 {
> >                 dma-coherent;
> >                 interrupts = <0x00 0x10 0x01>;
> >                 reg = <0x00 0xa000000 0x00 0x200>;
> >                 compatible = "virtio,mmio";
> >         };
> > 
> > Here, each virtio-mmio corresponds to a virtio-device. But there is no way for
> > other users in the DT to show their dependency on virtio devices.
> > 
> > This patchset provides that support.
> > 
> > The first patch adds virtio-device bindings to allow for device sub-nodes to be
> > present and the second patch updates the virtio core to update the of_node.
> > 
> > Other patches add bindings for i2c and gpio devices.
> > 
> > Tested on x86 with qemu for arm64.
> 
> Michael, are you picking these up for 5.15 ?

Okay.

> -- 
> viresh

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
