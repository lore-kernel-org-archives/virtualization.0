Return-Path: <SRS0=fv7C=OC=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13B5FC433EF
	for <virtualization@archiver.kernel.org>; Sun, 12 Sep 2021 00:52:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99A4D60FE3
	for <virtualization@archiver.kernel.org>; Sun, 12 Sep 2021 00:52:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 99A4D60FE3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6313F6080A;
	Sun, 12 Sep 2021 00:52:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id W0WyVcLTWXY2; Sun, 12 Sep 2021 00:52:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 26CEC60809;
	Sun, 12 Sep 2021 00:52:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0696EC0011;
	Sun, 12 Sep 2021 00:52:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BB03BC000D
 for <virtualization@lists.linux-foundation.org>;
 Sun, 12 Sep 2021 00:52:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 968FF415C8
 for <virtualization@lists.linux-foundation.org>;
 Sun, 12 Sep 2021 00:52:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=linux-foundation.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Zy78lhSYsLr4
 for <virtualization@lists.linux-foundation.org>;
 Sun, 12 Sep 2021 00:52:10 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B29CB415C7
 for <virtualization@lists.linux-foundation.org>;
 Sun, 12 Sep 2021 00:52:10 +0000 (UTC)
Received: by mail-lf1-x12b.google.com with SMTP id x27so12579725lfu.5
 for <virtualization@lists.linux-foundation.org>;
 Sat, 11 Sep 2021 17:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=djPK8cia5m0qX5Zxp7M6GNMnA/J0EGKvTFEvrA/orKo=;
 b=BeZ4wj46QWUIa1PRMxDJJzSxU067c8arLPq359/YAIYM2Pa0vDxJ8SxI9wU5chvg6x
 BdROVYGYeqJj5fLU+2WKja4e3teRqDF//UpkYy1+DfaBSxLpp8qry0a9vpB11tJA8BrZ
 wqMor7qv9Hf7pXq+K01/g7ViYfTGbH32VnwLU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=djPK8cia5m0qX5Zxp7M6GNMnA/J0EGKvTFEvrA/orKo=;
 b=a5gcc8rlvOssqfwxnpPJJKB3T7/H/YVu7fAw5GjEEwvU/AbbvJSjaQ9XcPI4LWC6L+
 g8ks6ok/c/JSGP+w11T/5kyAEI2LHJpUemXM/3PBIvAai+N/LJPEX7qzZldZoWKZh3y+
 TRLdQzg0Bko0VVRTajAHTbeWOFddU5R+WKWpyZyGj8ONkJ6LuwAaGtoTKpYKY4OsgQrp
 C8kcbM2C1SYU3Uvel2AOXmW97LIW0CyF89v15NmvOIZ1l+Qntw7VsaTU2Livn9HPu/0j
 PHxmGVnsVUT+1M3Lhljo5PVK3uXZrF7QfTeP6kJ7Ru7aL8sPfe8rh+kdQtvbEmJe1HrB
 fX4Q==
X-Gm-Message-State: AOAM531QMwtll2HWeS8rsqP3gxd3aFZB+p1tRKdIHnvBpEc4akLcAZlJ
 GTHlrnj9zmWYFN8+pWTF/+yp1ouawYVhF2Yl2ypdMQ==
X-Google-Smtp-Source: ABdhPJyAzH68GEPuRAFVn3KGiJFZw1G6OAUamf0J8ZiEJUhwZ4pmDSDpc9iEXX52lD/9EcZfD/2xPA==
X-Received: by 2002:a05:6512:2004:: with SMTP id
 a4mr3872833lfb.152.1631407928499; 
 Sat, 11 Sep 2021 17:52:08 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com.
 [209.85.167.50])
 by smtp.gmail.com with ESMTPSA id 138sm358707ljj.128.2021.09.11.17.52.08
 for <virtualization@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 11 Sep 2021 17:52:08 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id g1so1121207lfj.12
 for <virtualization@lists.linux-foundation.org>;
 Sat, 11 Sep 2021 17:52:08 -0700 (PDT)
X-Received: by 2002:a05:6512:34c3:: with SMTP id
 w3mr3705182lfr.173.1631407431833; 
 Sat, 11 Sep 2021 17:43:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210909095608-mutt-send-email-mst@kernel.org>
 <CAHk-=wgcXzshPVvVgGDqa9Y9Sde6RsUvj9jvx0htBqPuaTGX4Q@mail.gmail.com>
 <20210911200508-mutt-send-email-mst@kernel.org>
In-Reply-To: <20210911200508-mutt-send-email-mst@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 11 Sep 2021 17:43:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=wguv1zB0h99LKH1UpjNvcg7tsckE_udYr3AP=2aEUdtwA@mail.gmail.com>
Message-ID: <CAHk-=wguv1zB0h99LKH1UpjNvcg7tsckE_udYr3AP=2aEUdtwA@mail.gmail.com>
Subject: Re: [GIT PULL] virtio,vdpa,vhost: features, fixes
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: mgurtovoy@nvidia.com, lingshan.zhu@intel.com,
 KVM list <kvm@vger.kernel.org>, xianting.tian@linux.alibaba.com,
 Netdev <netdev@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 virtualization@lists.linux-foundation.org, Wolfram Sang <wsa@kernel.org>,
 xieyongji@bytedance.com, Viresh Kumar <viresh.kumar@linaro.org>,
 arseny.krasnov@kaspersky.com, Will Deacon <will@kernel.org>, elic@nvidia.com
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

On Sat, Sep 11, 2021 at 5:11 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> It's in the tag for_linus_v2 - the point of keeping for_linus
> intact was so anyone can compare these two.

Well, since I had already spent the effort in trying to figure things
out, I had merged the original branch.

I just didn't _like_ having to spend that effort, particularly not the
weekend before I do rc1.

This has not been one of those smooth merge windows that we occasionally have.

             Linus
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
