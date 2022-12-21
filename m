Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCAD0C10F1B
	for <virtualization@archiver.kernel.org>; Wed, 21 Dec 2022 13:11:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 73A6781FFA;
	Wed, 21 Dec 2022 13:11:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 73A6781FFA
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=m3JQPJw1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XaIC1597nLzN; Wed, 21 Dec 2022 13:11:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 04A3681EE3;
	Wed, 21 Dec 2022 13:11:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 04A3681EE3
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6F215C0077;
	Wed, 21 Dec 2022 13:11:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 17730C0070
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Dec 2022 13:11:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A83D5607E1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Dec 2022 13:11:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A83D5607E1
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com
 header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=m3JQPJw1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id i4dty9Jzck_c
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Dec 2022 13:11:36 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 02DD7606DC
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com
 [IPv6:2607:f8b0:4864:20::42d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 02DD7606DC
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Dec 2022 13:11:35 +0000 (UTC)
Received: by mail-pf1-x42d.google.com with SMTP id c13so10650603pfp.5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Dec 2022 05:11:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solid-run-com.20210112.gappssmtp.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QSNOsGN2qb70CCKMWtOU8vZy1lX7BQUW0taanK2NRTg=;
 b=m3JQPJw1F5Dfhve6kFgqnqsgLdsP35eNp3g/WyNqic5L3Ehc0tPR5pJ52OTXtO5re3
 gXQdmc5yEmwmXxzfU8sWLJ5oDUyrRTNoZKIaGEVbkuGNcPXE/PPvdHcES6Z4V97y52Ar
 hprPjIRiINLpE/GoEY4Wxeru3TVci3nciSimqO2QIVntobgU9cyNUiFhKCP5BYC2d8h7
 QthjdWga2g3fs8s+4VpMwktDIDrNGW4IUAspwTkazR7n/4d3M2+kql8ow/U0xsm5uy4b
 f8b7UVBwH/Ogjrpgmm1VCm5xB4UQJo738dEvHhr8HVW2lFJjFitAKILSb09HWNLKednt
 qFrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QSNOsGN2qb70CCKMWtOU8vZy1lX7BQUW0taanK2NRTg=;
 b=bWgvGyUeHtMPPjQ59myrUeGV7AvqyErD5Q63hGR6eDqiwekdbKo7W7REAUptvfjyNG
 aPMw3fNo/Ec/AP5UEOy0yFnkVHdcmIIVJdOjsbfJv4/lkTSYhtbGnqMfqaJKtMC9gKd6
 6I53IiEm+Ed3RJ23/CsKH3CrxZVnOdZnym/XfP1YwnaERCnHVX0RhwrAwkZ7TdgEqRbG
 hvsgR3sdBqrWElq2Lg5wYuiodVKXG8D+48129dI2W918jKZ7cqlIvQX0qGDXp8kOB0q8
 i/FGQBBqcvS49IxwS1eB+cuadMIy4PhwTSKmwKlPmasvexu7IRdX2JWVsw0CQPZg01Hq
 5NJw==
X-Gm-Message-State: AFqh2kpVR9rbcKUEWMlyQn31inj9BPkheG2xPUNAfmdMag4SJqGcofjE
 MtPQtA9UZSKno2WSdttJWTM/PbAOHbsQabOB3Gudhw==
X-Google-Smtp-Source: AMrXdXvjvGzRnkeU1lpripARhNqzfJQlNaaaHci6GDm4B86DMWRyQnDoAVFlRpGvKsp1ypQs07LR3wDADnmG7hYgZDM=
X-Received: by 2002:aa7:9811:0:b0:572:5c03:f7ad with SMTP id
 e17-20020aa79811000000b005725c03f7admr123710pfl.17.1671628295408; Wed, 21 Dec
 2022 05:11:35 -0800 (PST)
MIME-Version: 1.0
References: <20221221120618.652074-1-alvaro.karsz@solid-run.com>
 <20221221073256-mutt-send-email-mst@kernel.org>
 <CAJs=3_CVUydOpH=a-RJLWUQ0_1EbkwKtGD2F3Xvw=dR5QFXP5g@mail.gmail.com>
 <20221221075855-mutt-send-email-mst@kernel.org>
In-Reply-To: <20221221075855-mutt-send-email-mst@kernel.org>
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
Date: Wed, 21 Dec 2022 15:10:58 +0200
Message-ID: <CAJs=3_AdY5y58rgfE43eEwO_K+=cbaZooAiDnHx8rAy3+tjxoA@mail.gmail.com>
Subject: Re: [PATCH] virtio_net: send notification coalescing command only if
 value changed
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
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

> We'll always just do 2 commands, right?

This is my point, we are sending 2 commands at the moment, even though
one of them may be unnecessary.

> E.g. if a card lost the config resending it might help fix things.

How can it lose the config?
We can  say the same about every command sent through the control vq.

> I don't think we should bother at this point.

Ok, I'll drop it.


Alvaro
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
