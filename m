Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB373C4332F
	for <virtualization@archiver.kernel.org>; Mon, 12 Dec 2022 17:47:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 63BBF40374;
	Mon, 12 Dec 2022 17:47:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 63BBF40374
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=5i9cZZL2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DjjBDBatEg42; Mon, 12 Dec 2022 17:47:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id F3999408A8;
	Mon, 12 Dec 2022 17:47:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org F3999408A8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D95D0C0033;
	Mon, 12 Dec 2022 17:47:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2689AC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Dec 2022 17:47:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EA15E60E4A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Dec 2022 17:47:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EA15E60E4A
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com
 header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=5i9cZZL2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9u64qdDOI3i5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Dec 2022 17:47:22 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C3E2F60E45
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C3E2F60E45
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Dec 2022 17:47:22 +0000 (UTC)
Received: by mail-pj1-x1034.google.com with SMTP id
 k88-20020a17090a4ce100b00219d0b857bcso673200pjh.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Dec 2022 09:47:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solid-run-com.20210112.gappssmtp.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5ipOHdrYPtRyHmITr3Spy0Cyv3HoWc/t968poH9p0+Q=;
 b=5i9cZZL2zuUIX9rA7rIeDeujcnS3jPzYTu8e2y3808aJVDV+JSJfzRb400JxwUIbUL
 6uAPP0ah/ikPwu2aiOs0rM9V8qlRHfvLcFgaZFLZbBcLhbFzdrd9VSLjHgzlkFwaujvq
 BooahlNnb4g0kVEBzz2pfWkuUOX7cTxt4RYvkfrNtcBac2sy1tAdisI1WeGsQnoADEvo
 +Z7wqtX6kDWv6+/KNJlVxIt8qOmdBwXFPUW5GvkJGb9RsR0I+aY9vdq7yvbmrk/NSJSS
 rLpqQGfSPWBxmhk43GFcCLYNZ2oHKSTrwzAtbp3gn++40kEzcLnhpggowo7AXN1rS+w3
 LmpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5ipOHdrYPtRyHmITr3Spy0Cyv3HoWc/t968poH9p0+Q=;
 b=NShXr3+PnrYIAPA8hiqxnBy/Arxbb7JBXycTdOpx0aNe3loYDsz8fT0f0oBO1I2JDH
 7v/U+RG9FYPPYlw24rODE6KO6hgsn90css+YFJir6CH+yNJfCUJ1SAuCHK0+/zBWkvTu
 pnfq0Fj3cVRIZTBqu7MpSeL7NdpSqWZMRd7uTAOFaoZtEJT0uYM4OSIEnxRPNG5nDeLL
 FcRg7KkDQ+hdcHuDnkfz9DGze1zYP8JxqQF5FRGRGZiIMmbSAb3QaxbjRcKErreKDQr7
 ccyh2VApQ8yark84fXecTIaiUKoJnlWZJi7NpVhGOVYQdi8Ds+SKJRCADNaNAINOb32O
 H3Ww==
X-Gm-Message-State: ANoB5pk6IEeQTUq4MJvkE3O3m25Fqw5rkhywUA5mve1uz/LtbYrPQy1/
 zjJUdQX5HM64OlUI1O17jJBZb2ayc4sNiQg8w82mtg==
X-Google-Smtp-Source: AA0mqf64REr7zmomQ/FZcu1X2SZ4Hu47/FZkW7JvmpebDHEGxnB75O7EKBDjhj6GLujkXS8BNIUSIIgWqT2AEGvIA0A=
X-Received: by 2002:a17:902:ccce:b0:189:d0d5:e75b with SMTP id
 z14-20020a170902ccce00b00189d0d5e75bmr21475124ple.163.1670867242173; Mon, 12
 Dec 2022 09:47:22 -0800 (PST)
MIME-Version: 1.0
References: <20221212142454.3225177-1-alvaro.karsz@solid-run.com>
 <20221212142454.3225177-4-alvaro.karsz@solid-run.com>
 <848cc714-b152-8cec-ce03-9b606f268aef@roeck-us.net>
 <CAJs=3_AdgWS23-t6dELgSfz7DS4U0eXuXP_UZ3Fn21VCEwA-4w@mail.gmail.com>
 <3f83e874-3d7c-cc97-2207-a47dbcfe960f@roeck-us.net>
In-Reply-To: <3f83e874-3d7c-cc97-2207-a47dbcfe960f@roeck-us.net>
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
Date: Mon, 12 Dec 2022 19:46:43 +0200
Message-ID: <CAJs=3_D6_TayfdSz9e6P6G+axyUht4iyHnwHgPJ8sXG2a3sm2w@mail.gmail.com>
Subject: Re: [PATCH 3/3 v4] virtio: vdpa: new SolidNET DPU driver.
To: Guenter Roeck <linux@roeck-us.net>
Cc: Jean Delvare <jdelvare@suse.com>, linux-pci@vger.kernel.org,
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

> That isn't the point. A 2-second hot loop is just as bad.
> There should be a usleep_range() or similar between loop iterations.

I'll replace schedule() with usleep_range()

Alvaro
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
