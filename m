Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 069BBC4332F
	for <virtualization@archiver.kernel.org>; Mon, 19 Dec 2022 11:33:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 73DCD4048A;
	Mon, 19 Dec 2022 11:33:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 73DCD4048A
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=6Vp+RpGl
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uHsgdf7nIOy8; Mon, 19 Dec 2022 11:33:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B9CA740227;
	Mon, 19 Dec 2022 11:33:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B9CA740227
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 98992C0032;
	Mon, 19 Dec 2022 11:33:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 02EBBC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Dec 2022 11:33:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1FA3A81434
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Dec 2022 11:33:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1FA3A81434
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com
 header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=6Vp+RpGl
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PPKcavoskrfd
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Dec 2022 11:32:59 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 595F881423
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com
 [IPv6:2607:f8b0:4864:20::42d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 595F881423
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Dec 2022 11:32:59 +0000 (UTC)
Received: by mail-pf1-x42d.google.com with SMTP id 21so6014576pfw.4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Dec 2022 03:32:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solid-run-com.20210112.gappssmtp.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0n+w2I53HsHcRxj0Rc3TmCJ6R20Bcho6xyBreSLv9PY=;
 b=6Vp+RpGlOP7g0+6GZiHWjyZjtMK4wKz3IjxmVYVMBcPIMyytjPJb7ztH9RG3/9EMP4
 Ry96vhVGKhjb5sPLV105Q6LZExICvLBl0ckbzOvQrRvKo+JZfWdQz8RI9olpzO8qcGDN
 WyiSW+Z6bd5/pGJMXOUv6Z4UcDnGiodOpBHEZyMO4awFIrOv707KcRBu4ULJdzbRtMgD
 f9PFJ9yWqsfT2MEmn47+d1pj4QKfVo2SMtY5Fmn4Vjyf0l4epQlaeLvwSiHsy7Ng6sm1
 fpvJqJgZhKGgJ5bMs7KX+DHrPfZKT1ob0dbTyVK40Lz5yxYmty2wrkTI73gT2I6CdX3f
 LfaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0n+w2I53HsHcRxj0Rc3TmCJ6R20Bcho6xyBreSLv9PY=;
 b=sajOq4kvMFeZnP05WEg10Edd6dGiOCR1qQxYIsLJjSAnJ/UF4syIQxQH/tCMngqbYJ
 OrA0Oc3b9T50CWYyZGJIUMnS6rGOW8Dr7Aej/KjG9b8HMkKx5pmkbUYJX3hOU9mjNFg2
 R9aUTXXd0CJ3aZCvU/CdnWtFGWtK/elWd2uvnhDGM+iF5nfMzeTHvjb3yocQ3AsmyOpd
 EEOEfurCYDd71YaL85OOF3YRpIoYIqahgrj7ourJkwaoRW6jibH2pRYgwAIeDNLssTsC
 CyeFOcSUkXatQ/3k/wMP8SSXuoh+eHLvREOFfHuthMeR484ZtnE/QLWcCH2kSnrCgQ1H
 FT0Q==
X-Gm-Message-State: AFqh2koS1WFcF7X4w17ZftSuCDeHa3XTiXhodqeYgd7NL3oboYfo2uw4
 uNwS5QjW85wgzrniwprSFviMrsQ1dkhx8uoDJ/Z1Hw==
X-Google-Smtp-Source: AMrXdXu/L9zLi9FO6BusNumo5dwkvvOcy0ioAN8eZATOvK/JqTNJkvtwZy5tdtoXjgVm2ugkEBZnnZggZcJkRZVldGw=
X-Received: by 2002:a63:f315:0:b0:48c:5903:2f5b with SMTP id
 l21-20020a63f315000000b0048c59032f5bmr144376pgh.504.1671449578688; Mon, 19
 Dec 2022 03:32:58 -0800 (PST)
MIME-Version: 1.0
References: <20221219083511.73205-1-alvaro.karsz@solid-run.com>
 <20221219083511.73205-4-alvaro.karsz@solid-run.com>
 <20221219054757-mutt-send-email-mst@kernel.org>
 <CAJs=3_B+NB9LuqDBw_1a_6mXGCP2rA6bsrxLuoQ6gWdEg-vscg@mail.gmail.com>
 <20221219060316-mutt-send-email-mst@kernel.org>
In-Reply-To: <20221219060316-mutt-send-email-mst@kernel.org>
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
Date: Mon, 19 Dec 2022 13:32:22 +0200
Message-ID: <CAJs=3_Cq3ca=evn9J=mQT3ieF0wi2YVfjfgJ3Ykh-Adu7Fxujw@mail.gmail.com>
Subject: Re: [PATCH 3/3 v6] virtio: vdpa: new SolidNET DPU driver.
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
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

Ok,

> can be patch on top ...

Just to be sure,  you mean here to create a new patch adding a comment
to the kconfig file, not a new version for this patch, right?
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
