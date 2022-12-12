Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06EE6C4167B
	for <virtualization@archiver.kernel.org>; Mon, 12 Dec 2022 16:39:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8564F60DFE;
	Mon, 12 Dec 2022 16:39:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8564F60DFE
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=Qcg4chnb
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QmkI4HZOant1; Mon, 12 Dec 2022 16:39:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 32D196072A;
	Mon, 12 Dec 2022 16:39:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 32D196072A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 18C59C0032;
	Mon, 12 Dec 2022 16:39:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7A8FCC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Dec 2022 16:39:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 47C7F8176F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Dec 2022 16:39:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 47C7F8176F
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com
 header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=Qcg4chnb
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Lccwff_Z9GN2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Dec 2022 16:39:03 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B25AD80ADF
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B25AD80ADF
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Dec 2022 16:39:03 +0000 (UTC)
Received: by mail-pj1-x1029.google.com with SMTP id t17so312681pjo.3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Dec 2022 08:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solid-run-com.20210112.gappssmtp.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ehhV0zb8kSbVJbPicNJTUd5tnXvyUTppxVrH8Mn4ijM=;
 b=Qcg4chnbsG6R8ccYYan8ap4SPziBfhNgFCfHkGMvsmrCfLcwgISGtOsoCExNbNkMoz
 SETOpz8gbuT/Z7QPSepJA/KfBcJfj8WXVv1ULQuaMg3Wf/+OZO4iyGnriTdfo59nVKXO
 PvxcdQeDwnshuY69o4sLvalOA8SLaViBMR1vnCtqqch0V5NwCL813GVYn99DBp/QG67l
 i/JMtq7tdDBH1iC5nf9UWgQWSMVfYrpARubgB1IjRMrvhoJgWFndpsabfDGQtcudsAEc
 4CX/IeWRrgez6XsMWEChDDm5T7GfjuUVEVa4GICbYgXdGMCknjqQEAYgiqQk/AXBbDYJ
 mj5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ehhV0zb8kSbVJbPicNJTUd5tnXvyUTppxVrH8Mn4ijM=;
 b=WiPOjysgN9OGwA6UHBE8tFTNmIjQFBXnVS+MEdw1V4D8IG0wlfvMx0PxcPz4RtiNkj
 +jcHbcr2tAUmVwOx6ui5sPnfxhzQxPu8pU3maLcEXiWXFctGDph0DLqYHhfRxXpuQMaP
 F/T3W7BOoKXfzGjov3zJ90RO5BXcL3zcrhgb57duRkfhm0Ps2oLrZ036OQx4bM/Rf5KD
 gypcRCC1pa6eFLQ/ExJ0ZPa6eCCsn/vxRbMmSOxLse56/jufUPZpUg6c97kezlh9pNNg
 Vw/PQ1fMMuEG8wX5nqf7n7fqDPzKd71QEje3MPLE1w1Q3vlQ0exkojH7dotziY+3ZVov
 w8iA==
X-Gm-Message-State: ANoB5pku5AcifdYH0CQ4OLFRi7NSnEFxQyIfNo8FR/TGX/lKVg4OOSYw
 HoISIuD12C5AY8UvMpusmTh0hbvwnIj7NGgC615UTw==
X-Google-Smtp-Source: AA0mqf65BAor0dB27LuDWQIDW98Xa6fxCeLjNlA8eDN4yFyjx2q17O5LBarg8BmiyHDSGuSjFP000d27vqJgexiGzvE=
X-Received: by 2002:a17:90a:6d62:b0:219:4ee5:ccc9 with SMTP id
 z89-20020a17090a6d6200b002194ee5ccc9mr49431166pjj.63.1670863142960; Mon, 12
 Dec 2022 08:39:02 -0800 (PST)
MIME-Version: 1.0
References: <20221212142454.3225177-1-alvaro.karsz@solid-run.com>
 <20221212142454.3225177-4-alvaro.karsz@solid-run.com>
 <848cc714-b152-8cec-ce03-9b606f268aef@roeck-us.net>
 <CAJs=3_AdgWS23-t6dELgSfz7DS4U0eXuXP_UZ3Fn21VCEwA-4w@mail.gmail.com>
In-Reply-To: <CAJs=3_AdgWS23-t6dELgSfz7DS4U0eXuXP_UZ3Fn21VCEwA-4w@mail.gmail.com>
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
Date: Mon, 12 Dec 2022 18:38:25 +0200
Message-ID: <CAJs=3_Dc8z3gSorauZSof8koZV2jME5Y1LPTxj3CVgfAZPWZvA@mail.gmail.com>
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

> solidrun/Makefile:
> obj-$(CONFIG_SNET_VDPA) += snet_vdpa.o
> snet_vdpa-$(CONFIG_SNET_VDPA) += snet_main.o
> #if IS_REACHABLE(CONFIG_HWMON)
> snet_vdpa-$(CONFIG_SNET_VDPA) += snet_hwmon.o
> #endif

I meant here
solidrun/Makefile:
obj-$(CONFIG_SNET_VDPA) += snet_vdpa.o
snet_vdpa-$(CONFIG_SNET_VDPA) += snet_main.o
ifdef CONFIG_HWMON
snet_vdpa-$(CONFIG_SNET_VDPA) += snet_hwmon.o
endif

And I'll use
#ifdef CONFIG_HWMON in solidrun/snet_main.c and solidrun/snet_vdpa.h
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
