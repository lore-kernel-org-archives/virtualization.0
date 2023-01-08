Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0025C53210
	for <virtualization@archiver.kernel.org>; Sun,  8 Jan 2023 09:00:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8027660E90;
	Sun,  8 Jan 2023 09:00:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8027660E90
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=snwl0WgO
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kqdWeL-DwVgq; Sun,  8 Jan 2023 09:00:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 14E3D60AC3;
	Sun,  8 Jan 2023 09:00:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 14E3D60AC3
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CCD39C0032;
	Sun,  8 Jan 2023 09:00:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 99154C002D
 for <virtualization@lists.linux-foundation.org>;
 Sun,  8 Jan 2023 09:00:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 665408175E
 for <virtualization@lists.linux-foundation.org>;
 Sun,  8 Jan 2023 09:00:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 665408175E
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com
 header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=snwl0WgO
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id w1jCoDDW-n0o
 for <virtualization@lists.linux-foundation.org>;
 Sun,  8 Jan 2023 08:59:59 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DB1D68175D
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com
 [IPv6:2607:f8b0:4864:20::52c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DB1D68175D
 for <virtualization@lists.linux-foundation.org>;
 Sun,  8 Jan 2023 08:59:59 +0000 (UTC)
Received: by mail-pg1-x52c.google.com with SMTP id g68so2870802pgc.11
 for <virtualization@lists.linux-foundation.org>;
 Sun, 08 Jan 2023 00:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solid-run-com.20210112.gappssmtp.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tMlBO3y3CxlZJo8Ox92Yrn0PDl2CnBqv0Ki8egTi1Y4=;
 b=snwl0WgO7jsVl4evOw3MlB0jNJHXoS4K5qFlkvfOSGZojRYOqEEsrF+OYb+KjqlhKx
 wnw70JkFZkgoWxO1ZvnjuCFLQ0Z1LOwkFV2eXPpd08WI1MY/j+KSgES1rDuG+BQ8SfC3
 o6Y/Ov2LROph+/dPAzLg+Py9AsDX1qhz1gIIxJfGqxc0JNEYrbvDSb6o4swWIysVPq87
 byGwHUZp9GSVIi/5SoZbAFYRuLqslK9lt4/oqlpCPBA8Jm6kJt6rqo4CPaoe9H6/xOB3
 TW9cMqn+RTF932TR5ZglWOLG7A2HJdHy5yQFx2Dx+GbW08xzeB8/6KME3fUBfBKebH2t
 nG+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tMlBO3y3CxlZJo8Ox92Yrn0PDl2CnBqv0Ki8egTi1Y4=;
 b=PzVY82Onf4ekJMCgYUvAZO1wO7ZI0y/xxZp57Z6C52HveJDl+rFSCNr8gWIb46P0Uh
 TexbU91pWPQAH0Kp21nqI/sLS8BiwO+UVwf/3TxOLYI7SmrP9du9M5h4Rdh1WCzS9tFj
 3Q51cqcmR3KntbP7jndf4vBaMAGeb+ojHsgh48/EztV4toB3u6ddgBedOhNX1DOXkEsd
 icKcJGpsp94bQh8OtSnVsAybSogxXnrDLFFcR00sDfBhY7pwj1YxaAs85XiSQmcyOHVw
 3LyLtILkMIQ6TijshzuLxQzQ0SAXc/BS/s5JzaWGmk3N2NSluMeKesEStBd2n7m9QRZg
 N3ow==
X-Gm-Message-State: AFqh2kqHxtPkgyO9wXRQFmwzIDCGV0kWnvKr7mkuF1QbJUQU+j645oLh
 gelibXyE+gehHTlML6iX0xJdTqqi2FKhmm+zUg2TSg==
X-Google-Smtp-Source: AMrXdXuYXt6M70ogDMWScyWW0p4e9lX5JKYc9tr7meAQoAzWJr73a4cWTeQSxLQnEI935GmHvwvPgY1MpghmQNmWReA=
X-Received: by 2002:a63:eb07:0:b0:4ad:2049:2aa6 with SMTP id
 t7-20020a63eb07000000b004ad20492aa6mr390062pgh.550.1673168399122; Sun, 08 Jan
 2023 00:59:59 -0800 (PST)
MIME-Version: 1.0
References: <20221221072003.551091-1-alvaro.karsz@solid-run.com>
 <CACGkMEsqNKVte6b4VAo0PLGjhXDPutg44_=XdqAfBqMp9hHYew@mail.gmail.com>
In-Reply-To: <CACGkMEsqNKVte6b4VAo0PLGjhXDPutg44_=XdqAfBqMp9hHYew@mail.gmail.com>
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
Date: Sun, 8 Jan 2023 10:59:22 +0200
Message-ID: <CAJs=3_Bh+c-rTb83uxA1+ZH9ZDwkj9fs0ChtYJdPgNQO3gUr5A@mail.gmail.com>
Subject: Re: [PATCH] virtio: vdpa: fix snprintf size argument in snet_vdpa
 driver
To: mst@redhat.com
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

Hi Michael,
This patch was merged into:
[PATCH v7] virtio: vdpa: new SolidNET DPU driver.
So it can be ignored.
Thank you.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
