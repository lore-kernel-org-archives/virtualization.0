Return-Path: <SRS0=VeF6=MF=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6889CC07E95
	for <virtualization@archiver.kernel.org>; Tue, 13 Jul 2021 07:53:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DECC461279
	for <virtualization@archiver.kernel.org>; Tue, 13 Jul 2021 07:53:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DECC461279
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9496D60869;
	Tue, 13 Jul 2021 07:53:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YjV-oSXtCR9j; Tue, 13 Jul 2021 07:53:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 51EF960725;
	Tue, 13 Jul 2021 07:53:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3705BC001A;
	Tue, 13 Jul 2021 07:53:38 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1DF8AC000E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Jul 2021 07:53:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1A8AF60856
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Jul 2021 07:53:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZhTFpcxBceu7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Jul 2021 07:53:36 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6FD7760725
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Jul 2021 07:53:36 +0000 (UTC)
Received: by mail-ej1-x632.google.com with SMTP id bu12so39942542ejb.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Jul 2021 00:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=bRHiyPKP8de4rwhSBr4y8plZupHoAOHZQqThDz9I7XU=;
 b=CbSaDqa/C2idjDnmVDjn89xTlOCmdNKNfeNLoznioadX2R4jVHWT7GPKh0S9mzR2wh
 h0U7UwWZfhv1j1wGoXvu7hHMItIZsa7PMm221q9wiRFtNtNPCJb7OFjvDmo/wxTFc/th
 1slHZWS+znhh/D1e6vBBRjgosb51Ft8Nmy8vzvlAWTl8wlsaGdJCLV1UhxYKtTo8fJji
 ALO1rQ0h8SpsZilyhu1ptlgc2jty4p+9169vT6Jvavc6flrUG8lOHKtoW7lP/BUB3ygq
 h0PgPGbeRa+la4knKzZQuuFkXbBnhvmFN8SQ/XF5e5kFXpyTY23qb3i5l1829B31668K
 fx0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=bRHiyPKP8de4rwhSBr4y8plZupHoAOHZQqThDz9I7XU=;
 b=TIPhKVdSY6g4qz8noL2NNmqNZNmCXMaR6Y/BHf3UwSUWxMfV1ht9D6E6tYbZ3m7Ri/
 mbJE0xf4VDEwppB4G582Ygt6XubVkwr7ErsSU7rHrHNZrnG+ujzsjodD1lRKROnJD2Va
 HbAOg9oT2Md0TcupLY+E/l9X7Y2zF6oGMKn3FhFvXrc2Cf3POXd9l/0kUIwPo/ESBDv1
 wBrfaoX/jI9vuE4E0o2Knm2ALBKRsOp53urYgW/qYJ/N72kJIg9TwcOn8LX/BbGtFsoF
 4snBk6C0/inSk4FWKjVQUVqY7RSwhhUwmxDUv/S5ypqjix1xcb5NPrk29R8jNAo5/cC4
 6PnQ==
X-Gm-Message-State: AOAM531ejn/NTfYd7dqtfFXog456KSEqepRet3/AjE6IL0TYsvRdmqlw
 HBNPpKxNn0HCpvYmoXGHiPYKK9kOTPeAFMsz
X-Google-Smtp-Source: ABdhPJx6n3FdpsteXQ1lgeB788WRU1TfcwzK2rWnOxxuArYQokcUA3V7ToaSaY198H2rav0chyHXlg==
X-Received: by 2002:a17:907:c20:: with SMTP id
 ga32mr4163820ejc.7.1626162814552; 
 Tue, 13 Jul 2021 00:53:34 -0700 (PDT)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com.
 [209.85.221.48])
 by smtp.gmail.com with ESMTPSA id bx11sm3342403ejb.107.2021.07.13.00.53.33
 for <virtualization@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Jul 2021 00:53:33 -0700 (PDT)
Received: by mail-wr1-f48.google.com with SMTP id k4so22891040wrc.8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Jul 2021 00:53:33 -0700 (PDT)
X-Received: by 2002:a5d:4b44:: with SMTP id w4mr3771420wrs.275.1626162813372; 
 Tue, 13 Jul 2021 00:53:33 -0700 (PDT)
MIME-Version: 1.0
References: <c94e89f8ba97b4ac66f8fca35eb2f0ba@suse.de>
In-Reply-To: <c94e89f8ba97b4ac66f8fca35eb2f0ba@suse.de>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Tue, 13 Jul 2021 09:52:56 +0200
X-Gmail-Original-Message-ID: <CA+FuTSeTC3cU7YrBv4wgTXM9s+2NjiHAgTJaKVHnYFk3=0aDFw@mail.gmail.com>
Message-ID: <CA+FuTSeTC3cU7YrBv4wgTXM9s+2NjiHAgTJaKVHnYFk3=0aDFw@mail.gmail.com>
Subject: Re: [Question] virtio-net: About napi_tx
To: lma <lma@suse.de>
Cc: virtualization@lists.linux-foundation.org
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

On Tue, Jul 13, 2021 at 3:04 AM lma <lma@suse.de> wrote:
>
> Hi Willem and list,
>
> The napi_tx of virtio_net is enabled by default by commit 31c03aef.
>
> and the commit message mentioned:
>      In the unlikely case of regression, we have landed a credible
> runtime
>      solution. Ethtool can configure it with -C tx-frames [0|1] as of
>      commit 0c465be183c7 ("virtio_net: ethtool tx napi configuration").
>
> I'd like to know more about "the unlikely case of regression".
> Is it workloads related or bare metal hardware related?

There are no specific known cases. This is a precaution if a user
discovers a regression.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
