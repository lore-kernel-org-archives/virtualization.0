Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B00DBC4332F
	for <virtualization@archiver.kernel.org>; Wed, 21 Dec 2022 07:06:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 417154044D;
	Wed, 21 Dec 2022 07:06:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 417154044D
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=O6PraZUE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OF6GRgMm0BDd; Wed, 21 Dec 2022 07:06:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id CC4C340289;
	Wed, 21 Dec 2022 07:06:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CC4C340289
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 36943C0071;
	Wed, 21 Dec 2022 07:05:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A0E0DC0070
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Dec 2022 07:05:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1F64B41299
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Dec 2022 07:05:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1F64B41299
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com
 header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=O6PraZUE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RMhWI-PBL7am
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Dec 2022 07:05:46 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 290F44089C
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 290F44089C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Dec 2022 07:05:46 +0000 (UTC)
Received: by mail-pj1-x1034.google.com with SMTP id v23so9584891pju.3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Dec 2022 23:05:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solid-run-com.20210112.gappssmtp.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+Sa/I/7gVZaIQy7B1ZRMHInqzdjhXIObW4yJN5eIb0s=;
 b=O6PraZUESnwbOholnhjgplj9xv51g9sGEVY8NhsjgGTLrtwdyLSpcy0hoDX94TLpOM
 ZLtIi5w3Xaw+kDPdXAKAd4uQybBVnl3NhdP8baIsgh0xxPJfwH316rvbIt08yN+SVFBc
 Em1QxCO/rC8nBxgI+dOUE46YXMb7IexbUy0+CdTSC1EIy+Rv9S3Q5xnA2NxRxIS+klwG
 smbNQkEXEYHiNtF4LRNDHBJ8rnVk0NROrkfDiFiCYNOEm+UYFZ/xMn/WjDCm9Ah2p9ZB
 1vUHjeklLjFEGi/8nFgo7OJpH6ClxYT9lmQPOdmyfvJZ2XywtGy7VcDizXeYQvsoHt4H
 aaaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+Sa/I/7gVZaIQy7B1ZRMHInqzdjhXIObW4yJN5eIb0s=;
 b=7sfqAmz9LWSAFqVC+aHLQzd/MMl3QBWVBWx89fyFMdwtTY/UGC3TerzQc5umSdRUr6
 WCdnJmdjqbbdpTKjYtPax2rJiLdcTGbcq5kA/xrB8A7Af/+N0HMV1hNJNbMHOc1kHjzt
 XfqEi/GJ0Bils0banFSX+Ohr/R092z/d1jz5RnKkVo4CpT/z2kH9Fx6NSqa2ACgxmBFD
 yF26aKxWSJ6mJz9Elr46fLqb07ggXn1S7YCaNfx6Dfqc4s6bl30TpaaaT71iIDpIFP3e
 d4DMfphrpQ1au2b0rGdudadPk4ib+xkmeCuMmQiNDx3o4msC/wX5Sa4XQL4zGjmxEEyn
 afFg==
X-Gm-Message-State: AFqh2krUAMUNXCiQBUL+7yPM2OGNKAGqaVl3vdijcjbx8HVEkriPHfKu
 Q8oc/mB86GIqpI6eOt4An3Bvh93I8ehWYbK2DMGLvg==
X-Google-Smtp-Source: AMrXdXvI2GJq84khAIseirWSINYK4M29Z94nEO5s+eBoaKJPpgioRv51ok/p+Qy7fV6OS5HQxAg+rm39/gGG8ulXdnk=
X-Received: by 2002:a17:90b:8b:b0:219:19c1:1ae7 with SMTP id
 bb11-20020a17090b008b00b0021919c11ae7mr79160pjb.13.1671606345295; Tue, 20 Dec
 2022 23:05:45 -0800 (PST)
MIME-Version: 1.0
References: <20221219083511.73205-1-alvaro.karsz@solid-run.com>
 <20221219083511.73205-4-alvaro.karsz@solid-run.com>
 <Y6HjpvDfIusAz2uS@dev-arch.thelio-3990X>
 <CAJs=3_B7WoERAiXPyvz=6d7O5rcwXMfWZJFsi_ds-OAemvfcgQ@mail.gmail.com>
 <20221221013907-mutt-send-email-mst@kernel.org>
In-Reply-To: <20221221013907-mutt-send-email-mst@kernel.org>
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
Date: Wed, 21 Dec 2022 09:05:08 +0200
Message-ID: <CAJs=3_BuiRj2ZGQM7wVfpUgGNMR_24jv3h0fv+swBk54Gmr6uw@mail.gmail.com>
Subject: Re: [PATCH 3/3 v6] virtio: vdpa: new SolidNET DPU driver.
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jean Delvare <jdelvare@suse.com>, linux-pci@vger.kernel.org,
 llvm@lists.linux.dev, virtualization@lists.linux-foundation.org,
 Nathan Chancellor <nathan@kernel.org>, bhelgaas@google.com,
 Guenter Roeck <linux@roeck-us.net>
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

> Please post a follow-up ASAP. I can squash myself if I rebase.
>
> Thanks!

Sure, I'll do it now
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
