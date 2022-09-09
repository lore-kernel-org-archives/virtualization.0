Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87221ECAAA1
	for <virtualization@archiver.kernel.org>; Fri,  9 Sep 2022 08:34:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0668060C0A;
	Fri,  9 Sep 2022 08:34:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0668060C0A
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=NB8zQ7Z5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VsNBqJkRZEMF; Fri,  9 Sep 2022 08:34:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8E44860C01;
	Fri,  9 Sep 2022 08:34:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8E44860C01
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1CDE3C0033;
	Fri,  9 Sep 2022 08:34:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 19BBDC002D
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Sep 2022 08:33:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D36DD415DF
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Sep 2022 08:33:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D36DD415DF
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com
 header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=NB8zQ7Z5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id F_1VDGGEAjtz
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Sep 2022 08:33:56 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E27F7415E3
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E27F7415E3
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Sep 2022 08:33:54 +0000 (UTC)
Received: by mail-pl1-x62c.google.com with SMTP id f24so1147963plr.1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 09 Sep 2022 01:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solid-run-com.20210112.gappssmtp.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date;
 bh=4X7lWg7/oAb8wriStvwTsU2bgnUgYkkXe66WziWLzZw=;
 b=NB8zQ7Z5eaXPOEOb0eyUfGMxJf3rXaKG8vbgG1UkrAgsfb+QVB5ZLsctquZF7+yF74
 cXt/alFd/RXsZhRF2JnciwRfDg1fSPxcbvrK+oI+Dk7Jp+ouWnm2M/i0MPLNeTvQJFbe
 TjF7lBfKddTZI+4IpdzC5OM/HyjRrhqTtPlQJGwqDDcr1Uyv4uZQ2TH/TVWwL5+dOpM+
 cHjVx9VqYxjroXGSltiKku1FvCtoLBRbc20lmdB6tNM5hfMqNoltnaEEu9TtF9Pla19Q
 mciuMhDVI+0CFW0lkuX4GXOxm/R7CtucwGmfJJHwBQKk7PVCmZlPKyDgZBEkjsrA0ues
 HjRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date;
 bh=4X7lWg7/oAb8wriStvwTsU2bgnUgYkkXe66WziWLzZw=;
 b=oTv2pZ2YHz8ilUAEetOu3dkHhY1Xn6hq4XpDhh2MtCJTI2suqqWqPzVofgNehAuvrL
 4DmRCOKtOukBHeKxdP6sALA9Do52kxJwzVWaig6MrqlYrdjtb3tz07myvhdxBASv2Ayq
 KBlNPkXKygic9rV4losFGR0tM6j/vPKemqdzSb6YEax/Z6krfhVjQWT1iYbZS//0Yr51
 1M0dJGUfwSv/qNYl5JyOPsDI0E1XeIWXYPy2L+DRuEdIozgYPKRDg8bMEr42GHkBHKVm
 0JS/Sea+DQD5sUB+E/BO9rn0tX2NXHz2qoHy31nHyQWoK2nw1/q1axxbM1kiuutJBhZ7
 be9A==
X-Gm-Message-State: ACgBeo1dMYTjzm4Ghe1dlTsis9P1cwOZ6rhcqgSRF5YHNWs+WJqyBOgX
 8GbsUnosNzDz7ppxljHJ0QrndnShy8JvxWLSdihZzUQ3k0kmNjdi
X-Google-Smtp-Source: AA6agR75QpvQIEhedUw6Qj50H4pIV3XXuDCaJR1enjx28pGEb5oc7T+j2JFITZfji2Gc80iLpWy5QAK/m2uUNbrc/Lk=
X-Received: by 2002:a17:90b:17c5:b0:202:596d:6e40 with SMTP id
 me5-20020a17090b17c500b00202596d6e40mr8618081pjb.53.1662712430304; Fri, 09
 Sep 2022 01:33:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220829082313.419220-1-alvaro.karsz@solid-run.com>
 <CAJs=3_AEDwA6KfzPLvNhrgAUcFxkZuzjPOnzXcAv1gCh8Cc+jQ@mail.gmail.com>
In-Reply-To: <CAJs=3_AEDwA6KfzPLvNhrgAUcFxkZuzjPOnzXcAv1gCh8Cc+jQ@mail.gmail.com>
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
Date: Fri, 9 Sep 2022 11:33:14 +0300
Message-ID: <CAJs=3_DCYYYWkWpxw0gjmGD-pTspiw2d+0fqc3td5WY9EULDCw@mail.gmail.com>
Subject: Re: [PATCH v2] virtio_blk: add SECURE ERASE command support
To: virtualization@lists.linux-foundation.org
Cc: Jens Axboe <axboe@kernel.dk>, Paolo Bonzini <pbonzini@redhat.com>,
 stefanha@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>
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

Hi,
Anyone have any comments on the patch?
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
