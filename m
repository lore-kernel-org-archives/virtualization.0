Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DAD3C4332F
	for <virtualization@archiver.kernel.org>; Mon, 19 Dec 2022 12:06:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A76A460AD0;
	Mon, 19 Dec 2022 12:06:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A76A460AD0
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=G2HZQFMX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XuxJubD2oDPe; Mon, 19 Dec 2022 12:06:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4F485607D0;
	Mon, 19 Dec 2022 12:06:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4F485607D0
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3055DC0032;
	Mon, 19 Dec 2022 12:06:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2E93FC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Dec 2022 12:06:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E662640929
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Dec 2022 12:06:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E662640929
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com
 header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=G2HZQFMX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id irGo9DUm9GLS
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Dec 2022 12:06:07 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A374840894
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com
 [IPv6:2607:f8b0:4864:20::430])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A374840894
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Dec 2022 12:06:07 +0000 (UTC)
Received: by mail-pf1-x430.google.com with SMTP id c7so6035156pfc.12
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Dec 2022 04:06:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solid-run-com.20210112.gappssmtp.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Z72tIQTWQKkjxDurYXeM6jJeyau+4C8onKiYHe9/trg=;
 b=G2HZQFMXJq/yO7qYguX3SI9vwa+Fg+dl+KAOIQpSnjCzocme99clJuWqSURnCi0kiZ
 kWQ6s5aQ9sc86L0s7HtzBFZD13/LfDtpEttRph5geZmQcPVpfMfUFWy6lq8qiWShSvma
 ZhtoFgdizl1Cp+qFU7SF3DYp2aUG6d6ms3zezQZ59OrUNbLbNCChVyO95/T+ckN85Fep
 bR68f9LsGazTThq2KkwfggEEzIAZth0oOf5GNziDZAUu2R9Yx3Qu8SZr2HqBonciRbuY
 Yx1kC9+85Te+WnedIaIdt0CHVnSWOEvEdWMnsHiL2VxwKvdmSdkkVmUOJ4UMohTljf4y
 M4iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Z72tIQTWQKkjxDurYXeM6jJeyau+4C8onKiYHe9/trg=;
 b=6NTPeaRJVAC+N9Onzss+rb5G6VxjuTiJvyE3yGjRQzVp+KS765FfzcVZGya+2MNlKw
 m8yio+1uj+7/2524Nvo21jY1b0bq75NUv7y3sSHqF9YY3DaOHBJ2PAsQprVZlf0EX4df
 1onxmK5ivpQvURc/pjBjDi6kLEYbgzdLV8av94Ej/XASq5JOBH7BqdiONhQ4A2e9gwJB
 6PRLp7o0IEFUvVr8BkOfpHMkSUqqTtL+CbOAtk8Q78BJrke4bbAfVeSY7CLd+HLrReKs
 1QbxxUATS3y6SpROm1t5TFrEtofnu5HbUo8Y/Z760J6Me8vIJBOcuxfik/Evvr7Bgx6A
 bPCg==
X-Gm-Message-State: ANoB5pm2CIO8qWDVXw65rLOHu3A54MaiK1IaXQI8bRT1uj5kHa+Otf2A
 +0hETDCsb9BWflb1Qrg1zXvdGGkNnZS+gp9sQvduxA==
X-Google-Smtp-Source: AA0mqf4DLQIVeU9mqz0c3srK4iXrfd3+uIvASXdVmprAScfuQJoaKDdja5IykdXV2wtbAurs6Tel0VZtrHbW3IvhuFQ=
X-Received: by 2002:a05:6a00:d47:b0:577:8bad:4f9e with SMTP id
 n7-20020a056a000d4700b005778bad4f9emr8100637pfv.77.1671451566978; Mon, 19 Dec
 2022 04:06:06 -0800 (PST)
MIME-Version: 1.0
References: <20221219101307.131279-1-alvaro.karsz@solid-run.com>
 <20221219053022-mutt-send-email-mst@kernel.org>
In-Reply-To: <20221219053022-mutt-send-email-mst@kernel.org>
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
Date: Mon, 19 Dec 2022 14:05:30 +0200
Message-ID: <CAJs=3_DSJkgVrZsBRhRqtU0BJbWSB3yWsYyrQAN9YYETtx3UzQ@mail.gmail.com>
Subject: Re: [PATCH v4] virtio_blk: add VIRTIO_BLK_F_LIFETIME feature support
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, virtualization@lists.linux-foundation.org,
 linux-block@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
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

> Since you repin it anyway, do you mind rebasing on top of my tree?
Sure, no problem.

> I would maybe add a comment
Ok, i will add the comment in the new version.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
