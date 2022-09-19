Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FAB6ECAAD3
	for <virtualization@archiver.kernel.org>; Mon, 19 Sep 2022 18:09:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9C7D0416D9;
	Mon, 19 Sep 2022 18:09:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9C7D0416D9
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=wqxxFmhS
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7O9moAtsdhSY; Mon, 19 Sep 2022 18:09:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E16EB416EE;
	Mon, 19 Sep 2022 18:09:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E16EB416EE
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B8912C0032;
	Mon, 19 Sep 2022 18:09:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EB9F9C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Sep 2022 18:09:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C6D89600D4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Sep 2022 18:09:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C6D89600D4
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com
 header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=wqxxFmhS
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oOg0DVKaJqoS
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Sep 2022 18:09:42 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 142E76005E
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 142E76005E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Sep 2022 18:09:41 +0000 (UTC)
Received: by mail-pl1-x62f.google.com with SMTP id d24so5456506pls.4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Sep 2022 11:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solid-run-com.20210112.gappssmtp.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date;
 bh=0n3dqQKi715wNloeaeLut1fbW/bmUW/d2NRCHWM/Sco=;
 b=wqxxFmhSHSWrw23fziDeyMiz/gB7kemkSAojiOwrLspxovaQGkoNxijjmeWzClLcj7
 I29qtcaw2gGRH1HiKoPBFg7ADZLHf87tE/CP4OrEcJTiwS9j59VRumT97ggw3+wNZv9t
 TZMqfFn2l66sYnjfrft71tntbx1xPicZMtuGzS9OAIi3S4AxGI3Zmg6Bcuw3ukYntxPN
 OXrmn5/+mAzGTjvqfEhyBhBYu5nCY4Bk+gaO7TT/oQa75hk41tcq+iuFSfM+6vdOHOAL
 XHitT9TvfOa6Ayjvp6uhA3NXJUyx/nb8I5j72cbSo8meIWaQkK1b2tx6MF68+dKbIva6
 BA8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date;
 bh=0n3dqQKi715wNloeaeLut1fbW/bmUW/d2NRCHWM/Sco=;
 b=1OeR0XogsxAnQVxFevQ0/xlgM/xnPXcdkvp3s4OOQRbcTbJSJBhEgeBHKXrHWcg1U1
 O107ZB9TWyuFsRvfZCmMCxvfFtTKIPIAryeBWarhr/wnPxuR4zPQQqzi9dmTSBxAAyDc
 WNLpJgG+oV723PiAJEIUYW6ckHOUiYK6Lk3IzK/0ujzLjeKvVPEjo/SsgcRMMe9+kfCZ
 xppL7vTSarAlEav/hIx/WJg31Cy0WgTf4O32QPD/+OCPk1pweYuuyfP2nNBCsl5iJ2/h
 06H1waNEzuzW71BTfwFHXNA0UcYGOJt2vuWyUaP5rVWQPQVcAGLZVYC4v9UG0PtSDQr3
 42Kw==
X-Gm-Message-State: ACrzQf0fRN4lnfm8esqtgsSYvE+GuXb/2SsqpXhJNQJyXk4pZ8P9QV4g
 ZO6B5Mvu+b/qvWS3P1ttdvyPUsQOrJaJax6Y9FnZ5Q==
X-Google-Smtp-Source: AMsMyM5HSyB93TyarUcKWpDfiRojuSbpalpCS0ID1PQ2irSEw4AalccyWb8lc0fqi9PPj9KtwTzwHZzIAhyMTMvLyys=
X-Received: by 2002:a17:903:1c5:b0:178:44cd:e9c with SMTP id
 e5-20020a17090301c500b0017844cd0e9cmr1005986plh.132.1663610981460; Mon, 19
 Sep 2022 11:09:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220829082313.419220-1-alvaro.karsz@solid-run.com>
 <Yyin8zSKJb3GPFno@fedora>
In-Reply-To: <Yyin8zSKJb3GPFno@fedora>
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
Date: Mon, 19 Sep 2022 21:09:05 +0300
Message-ID: <CAJs=3_ASjr0DF9MTvS=P-ZeJpC4nAH+2vkTjWROzQbS+mvLU4Q@mail.gmail.com>
Subject: Re: [PATCH v2] virtio_blk: add SECURE ERASE command support
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization@lists.linux-foundation.org
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

Thanks for the reply.

> This can be simplified with min_not_zero().

Ok, I will do it in the next version.

> It's worth including a comment here that the discard and secure erase
> limits are combined because the Linux block layer only has one limit
> value. If the block layer supported independent limit values we wouldn't
> need to do this.

Ok.

I'll send a new version once we agree on the max_secure_erase_seg = 0 scenario.
Do you have an opinion on that?
Do you think that using sg_elems as the number of secure erase/discard
segments when the value in the virtio config is 0 is good enough?
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
