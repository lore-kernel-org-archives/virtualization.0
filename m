Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 263ADC53210
	for <virtualization@archiver.kernel.org>; Sun,  8 Jan 2023 08:59:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A421D60E35;
	Sun,  8 Jan 2023 08:59:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A421D60E35
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=jETcm4aO
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AwskLXJwinFo; Sun,  8 Jan 2023 08:59:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5025760A92;
	Sun,  8 Jan 2023 08:59:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5025760A92
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 263E8C0032;
	Sun,  8 Jan 2023 08:59:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A7A1AC002D
 for <virtualization@lists.linux-foundation.org>;
 Sun,  8 Jan 2023 08:59:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6E51E401F8
 for <virtualization@lists.linux-foundation.org>;
 Sun,  8 Jan 2023 08:59:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6E51E401F8
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com
 header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=jETcm4aO
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZOLZTD917Tmp
 for <virtualization@lists.linux-foundation.org>;
 Sun,  8 Jan 2023 08:59:00 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DD2614011D
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com
 [IPv6:2607:f8b0:4864:20::430])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DD2614011D
 for <virtualization@lists.linux-foundation.org>;
 Sun,  8 Jan 2023 08:58:59 +0000 (UTC)
Received: by mail-pf1-x430.google.com with SMTP id e21so4069966pfl.1
 for <virtualization@lists.linux-foundation.org>;
 Sun, 08 Jan 2023 00:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solid-run-com.20210112.gappssmtp.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tMlBO3y3CxlZJo8Ox92Yrn0PDl2CnBqv0Ki8egTi1Y4=;
 b=jETcm4aOqZbKOW87P1eIuFHru0rjw1+orCKsanydWXyGBFiHAmzk/c8N8WKvrLr/0g
 oOG2AoutGeWW0STmDLg8R0B7RaNWVOTSna3LhaGOXT2fYmRZi7hk7sLrr7yyUhBROhwr
 GyEXoJs5lqn5TuClVXHdHWvQEXc1y1NRLRPv5kpCh4BW8gcZmIER6JBYYUkloCssG343
 BTG8SrSu7EtKB+/znLDfom13iZhey6qdfZtner5ktlyKIgKpjLSD6ypNmiud3qty5jxi
 67wKMkym2gARuq0L2mV65jvV/PlJyq/bl62N8/eJujqKBjSpYFaOpzUOdVMdt+EZkEiX
 /OnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tMlBO3y3CxlZJo8Ox92Yrn0PDl2CnBqv0Ki8egTi1Y4=;
 b=tyRM5KnZ7dr9STxCY39SAVEAvPpVSLXQVv0mdhaajPvttoXnlsiM8DhwYSED2E1j5+
 uPAZCOn5UdlBReOmhiZFnRxTqtU4BpWhCeRaw+/yJvSzI+ok2XYbdyxPEgtICmcBXUdS
 1iRyI9e9HfJNEM+JcCqg93PG7qPsM7v/AhUwIdWR/ItIFPGuPpyo9bGqg/G5utSLsfEA
 XefNEWF9Vt2j5HT56eSo9Tb+CKf2ng0SY3a1r99o1VAssab1LCgq9gH6rUo9C25f3Xfz
 VKbzHUbBA3D+23b3YhWDeb3H6gUkjDVXTYjgf4giGSUUZbBVB4PQFrQsB/w+V1ZEg5NO
 q2Vg==
X-Gm-Message-State: AFqh2krb6i1hk1G3Pkd6GL4NsTcwDIjoV3xLSV9FILLSMqfuy5yjpFOq
 Iv7YD4fVCiheooxk6Bzeok02YnSf/ZMpyB4FCuWWZCUb2/e1Qg==
X-Google-Smtp-Source: AMrXdXu2GAetlBGoDrrkerI60UmIl2MLOohZknXPDnewzg/Ye8BDXPBP1e7Ixpm1KyR0osdo+u1Hm9Grgn/7A9I8myY=
X-Received: by 2002:a65:45c8:0:b0:48c:5903:2f5b with SMTP id
 m8-20020a6545c8000000b0048c59032f5bmr3221639pgr.504.1673168339110; Sun, 08
 Jan 2023 00:58:59 -0800 (PST)
MIME-Version: 1.0
References: <20230104121322.3892266-1-alvaro.karsz@solid-run.com>
In-Reply-To: <20230104121322.3892266-1-alvaro.karsz@solid-run.com>
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
Date: Sun, 8 Jan 2023 10:58:22 +0200
Message-ID: <CAJs=3_BY6iQ0+J1L_he7f_hwVjoHFPU+FrYyXY0KW1-UNUXsbg@mail.gmail.com>
Subject: Re: [PATCH] virtio: vdpa: fix kernel warning in snet_vdpa_remove_vf
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
