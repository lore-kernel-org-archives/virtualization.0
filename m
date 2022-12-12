Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04C19C4332F
	for <virtualization@archiver.kernel.org>; Mon, 12 Dec 2022 17:57:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 90076415A9;
	Mon, 12 Dec 2022 17:57:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 90076415A9
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=SRSupRkJ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yFxHfS6zLMJ4; Mon, 12 Dec 2022 17:57:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D8C4D415A3;
	Mon, 12 Dec 2022 17:57:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D8C4D415A3
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A3C3BC0033;
	Mon, 12 Dec 2022 17:57:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1C2CEC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Dec 2022 17:57:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id ECC3A415A9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Dec 2022 17:57:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org ECC3A415A9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id M3V2XjKsaCvF
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Dec 2022 17:57:21 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2E842415A3
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com
 [IPv6:2607:f8b0:4864:20::432])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2E842415A3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Dec 2022 17:57:21 +0000 (UTC)
Received: by mail-pf1-x432.google.com with SMTP id k79so424931pfd.7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Dec 2022 09:57:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solid-run-com.20210112.gappssmtp.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VWD5UcXtq1LyFYAMz3GCGFKQOR/j/rUgxjSZsop1QAM=;
 b=SRSupRkJoofEgubzGVsjGDuN7e+joOvoOG6f02dSQ/kZszECXK7bj4QYUl3SnngU8G
 JJ6o8EzWHtvCxHfanypFvXOOBQuOWB8hjInjCRvuxZIhijXEc6JT4uuwpH/cuCpbgF+I
 c6sESYbk+30+5V1TACaHZhglbo1uWQlbjNjg34NyFlW1FQQSAljOZ7wXYbCQD42S/l3o
 ZCrIGeFCSaE7OhgX6fH/+hbinL2dTECL+kzc6qDt3HWkrK0onleePFjZ2Vj7KxHgWajD
 hPt/A3TramTec3HWiczND/TVGCDwThF5LXmVGc7BEOObIEdTnHaHQNBXHv2NW8UHTNer
 ac4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VWD5UcXtq1LyFYAMz3GCGFKQOR/j/rUgxjSZsop1QAM=;
 b=Xlj2AxEdRcD7CXnz0MP+DGR3jihdi+GqZUQWaxnNa8/mqCZhYL8ISdhfL/7PrkVL18
 SPNsC6DkWpS623I3AqZJ/XXTVzdfg+Bd2jyoNrZfkWPZCHjsq8d/Fgq4+dL2ps885mmN
 /7QVCOCxdPaWThgxT9K2Pxiy/tUEvwBquwoc6lLKNMdal/wk/luaONOw+7gpKeTXI9Jr
 PhqINCSDhIewsRAoHya60ezMoUjtO8GdqfPVUsv8dkDeEET4XUn3torXCAEljsvdyoyB
 dcFz0OegV5Bcx7kjgUL8h2p0MSddBFwM/ouYWKSX1psM+Ei45ir/lEW/p60xhmHyD1WO
 clVA==
X-Gm-Message-State: ANoB5pnENKUvOZ13jL3ppQyZVqQlPP/ai9Wyw3m2XKepawiq0JsIsHD5
 4OkkNcZj0c7V47lbNIA811PYQMrGR0nZAcnjUGy1Gg==
X-Google-Smtp-Source: AA0mqf5CUJ00tzlZ+QA+AQmmOQgQtm7EXeh1hB3NTMG09x2lNEqM+ZfM2ubANdTPEsKAccLrp9xyJC9NA0ivMnBHoaQ=
X-Received: by 2002:a05:6a00:d47:b0:577:8bad:4f9e with SMTP id
 n7-20020a056a000d4700b005778bad4f9emr6603824pfv.77.1670867840496; Mon, 12 Dec
 2022 09:57:20 -0800 (PST)
MIME-Version: 1.0
References: <20221212142454.3225177-1-alvaro.karsz@solid-run.com>
 <20221212142454.3225177-4-alvaro.karsz@solid-run.com>
 <848cc714-b152-8cec-ce03-9b606f268aef@roeck-us.net>
 <CAJs=3_AdgWS23-t6dELgSfz7DS4U0eXuXP_UZ3Fn21VCEwA-4w@mail.gmail.com>
 <3f83e874-3d7c-cc97-2207-a47dbcfe960f@roeck-us.net>
 <CAJs=3_D6_TayfdSz9e6P6G+axyUht4iyHnwHgPJ8sXG2a3sm2w@mail.gmail.com>
In-Reply-To: <CAJs=3_D6_TayfdSz9e6P6G+axyUht4iyHnwHgPJ8sXG2a3sm2w@mail.gmail.com>
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
Date: Mon, 12 Dec 2022 19:56:42 +0200
Message-ID: <CAJs=3_DhEpGjgNZ6+cJiK6WVCQkBYW0V2EvF9vhTW-K6VodB_Q@mail.gmail.com>
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

> Even better would be a separate CONFIG_SNET_VDPA_HWMON Kconfig option.

I prefer to wrap everything with a single Kconfig option.

> depends on HWMON || HWMON=n

Are you referring here to CONFIG_SNET_VDPA, or to the
CONFIG_SNET_VDPA_HWMON you suggested?
Because if this refers to CONFIG_SNET_VDPA, HWMON=m  will block the driver.

Alvaro
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
