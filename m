Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAE8FC0502E
	for <virtualization@archiver.kernel.org>; Mon, 29 Aug 2022 06:22:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5F5DA83133;
	Mon, 29 Aug 2022 06:22:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5F5DA83133
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=ZWdZ3CYn
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NJ-GYut765vp; Mon, 29 Aug 2022 06:22:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E45CB82F11;
	Mon, 29 Aug 2022 06:22:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E45CB82F11
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A631FC0033;
	Mon, 29 Aug 2022 06:22:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9B803C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 Aug 2022 06:22:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7061682F11
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 Aug 2022 06:22:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7061682F11
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6Qu0MV62422J
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 Aug 2022 06:22:22 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6259782AA2
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6259782AA2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 Aug 2022 06:22:22 +0000 (UTC)
Received: by mail-pl1-x62a.google.com with SMTP id d12so7014650plr.6
 for <virtualization@lists.linux-foundation.org>;
 Sun, 28 Aug 2022 23:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solid-run-com.20210112.gappssmtp.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc;
 bh=35M+PGv5ngKZi3w1Gik9IIFtNJVoWmr/feNu8XL0yTQ=;
 b=ZWdZ3CYnIFtF7FHRMUbtN/kQbh/eRYlaB+wgw7SgVrDdzH14QvMuc8q5S2eyavyY2H
 Wz8hfhtsQe+H16CvddUpodEBMNHQtKZNCc7kmoz6Mg+K0flBx670JxdjVujRAai5zeDw
 6+qQLBxT8iDTRiPec/d1RCAoaBqT6pFVdLQmYbnAb3JYGymvTEIzLeytNHCQEL6yNSYe
 oPfhJNzK2nJtGDpmv+3qyF9xDLFDQ6k8u4HhSAUklzd3uDPw5S+BjZgqpNNOcasTg/vG
 AXylfbfnyvOrPPBVlDTbRJPiHMBKo/GeHc4b05trxres4ZLqjZRk10e+V/S7S7vKxPfL
 41QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc;
 bh=35M+PGv5ngKZi3w1Gik9IIFtNJVoWmr/feNu8XL0yTQ=;
 b=amloQVkFHC2oFIiITVLVmvDA5ESdFLbNxRqYMbRUJAOUjVMgY4WGlS6AsJ8RkWqZ8b
 1+7b37cXFEG61utQHR2Wi/kdaINAcQVEnXRE3ycioNzDSArwNwhyppASWip/4YL2PukB
 6Chu4mFBlUkkv8chRudsphtkyUeWsKky88OdIv6mNElfCzjsiiss1Xi501J1+hY2vjUP
 uyMuo/yYfgEvN1kABoON5dDESbWuc7QnyDI4l6kiE27kbxJy/0cnKcu994T2xjUcDKsr
 YE6IypzTT+3SywJpquy+0LDJ84Pxdj8Xm0xJcGW0jWCvyeJuNsgWnMp6BUA/728NTLcH
 EH6g==
X-Gm-Message-State: ACgBeo3Dt44Eirg+mPQdLALAonEdMUejPA2AEthn2haPt/iSdh4UOl/n
 PI2Y7lLgocATRGD5bYSuv/TOijz72tG2fpHsu3vXCg==
X-Google-Smtp-Source: AA6agR7uVKi2DCC0CHDRo2oB0U7eqZZ5Y+WcQOecHUBvOCWp3dbFP+aCTTR/WzmVwleDE5ywxzlOLe1SK9DP7dD+Ld0=
X-Received: by 2002:a17:903:1ce:b0:16f:1c1f:50e5 with SMTP id
 e14-20020a17090301ce00b0016f1c1f50e5mr15469755plh.132.1661754141818; Sun, 28
 Aug 2022 23:22:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220822162055.634854-1-alvaro.karsz@solid-run.com>
 <YwUueWHKi5YmQeGP@fedora>
 <CAJs=3_C9Bm=zsDUXuGXnDmZEKmSYfj-44UvuuyT1_SgbSXJoYQ@mail.gmail.com>
 <YwZwB9BlGeA08Hmn@fedora>
 <CAJs=3_CUf_QQ1uy-uE1VA_Y=5G=_9D8MeRiPLFEOQnj4n04=Aw@mail.gmail.com>
 <Ywd9dvDw0uNXgGz8@fedora>
In-Reply-To: <Ywd9dvDw0uNXgGz8@fedora>
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
Date: Mon, 29 Aug 2022 09:21:46 +0300
Message-ID: <CAJs=3_BR25TPNfRA6Ghb2OGxSraemcEJkpHg6ph24C0SJVpGUQ@mail.gmail.com>
Subject: Re: [PATCH] virtio_blk: add SECURE ERASE command support
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

> If you can include it in a v2 series that would be nice.

Sure, I'll create a new version.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
