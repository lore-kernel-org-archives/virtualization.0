Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B33B3C4332F
	for <virtualization@archiver.kernel.org>; Sun, 13 Nov 2022 12:24:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 42EF5813DD;
	Sun, 13 Nov 2022 12:24:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 42EF5813DD
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=rDdcjJw2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4orqCzUuIy9T; Sun, 13 Nov 2022 12:24:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id BB4F2813DF;
	Sun, 13 Nov 2022 12:24:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BB4F2813DF
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 64EACC0032;
	Sun, 13 Nov 2022 12:24:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0C26EC002D
 for <virtualization@lists.linux-foundation.org>;
 Sun, 13 Nov 2022 12:24:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CB30840860
 for <virtualization@lists.linux-foundation.org>;
 Sun, 13 Nov 2022 12:24:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CB30840860
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com
 header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=rDdcjJw2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id V7zBi78xsoQw
 for <virtualization@lists.linux-foundation.org>;
 Sun, 13 Nov 2022 12:24:42 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CDB3A40591
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CDB3A40591
 for <virtualization@lists.linux-foundation.org>;
 Sun, 13 Nov 2022 12:24:41 +0000 (UTC)
Received: by mail-ot1-x329.google.com with SMTP id
 db10-20020a0568306b0a00b0066d43e80118so5095164otb.1
 for <virtualization@lists.linux-foundation.org>;
 Sun, 13 Nov 2022 04:24:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solid-run-com.20210112.gappssmtp.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EYvJWSykldSL5woNr7SItIJj8v+Lw4lP0eYHwnf8zyg=;
 b=rDdcjJw2hph0QPB0ntPBtENfDS5EY1AD7z5I+R8kr2pSejuFlhPO9rZX4xCWwSRHqJ
 Jb1sXwVlR3ZMKUC7wA8YN79oD8NpOo/WVZMdDaPqWoV+iSVZo8axspfoQ1+xIr7FCrJR
 1VQ0/qkTW4TbEfDUYCT3WmG4q39Vf2A8hOnyHSFXl12JdY6s5BdQKAmybaqJvbjuBMad
 lg2cU98t3Hz82IQA/nxMVMBsGyLFLYdMH0hBA6Q61U7vigVhiFJ304IjIzAspLzz0/7t
 lVmiiMe0EgXw5wrbBN6KAaG6xnjNqpqs+Bmc5vdaUmejcdm4tauQWY1Pql11hQGEj6VF
 4Eqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EYvJWSykldSL5woNr7SItIJj8v+Lw4lP0eYHwnf8zyg=;
 b=MA/csGdEktNcAvJ7wkj4FKsy4OflgfnVtS85X8bJIc9bkF6bwBFrJPyRIayyAqD95H
 +rbXtvYRvhtSzyXbxnJzJkhi+PhJUy9xpPgYUqAZxXJj/86zjv4OJL28+TmAL7Qs4Cy9
 DEvxfY8Sql7Vg3X7SvLphegpm3Pd/49mP2QWfxGEnLI/hOZ3ZuhwuHwCUxrm7kQZUtoR
 rdkg4hy7dl4unPuxyVbAYgUoOJYoeg7HO4VT+OhiaFWcE/jVFobhSGVTEvpKI2BIliBG
 xDZfQQEyR+cceJ7w4uu76YgqUoZ1VCNpd8edPIC1jpMVEBTQOkN6700p/RHTdaimJYGO
 wlJg==
X-Gm-Message-State: ANoB5pmzI0IG0krsezF5yfVvTnE9jhYIyMrFlFbReqw1P+bG6gyJE97g
 F17qEEPabRGgFC2v9uJFg7YQeUednMX8sLgdqEySPw==
X-Google-Smtp-Source: AA0mqf5Xxgh7fb0/YSL2otTuuDLm06vpWzMwHe9R19qyklHlHMqSy3yZ5IT6F1eqRMFdP909TeREsYv3TmFL1JjrcSs=
X-Received: by 2002:a9d:2f01:0:b0:66b:85b7:ac37 with SMTP id
 h1-20020a9d2f01000000b0066b85b7ac37mr4779244otb.363.1668342280709; Sun, 13
 Nov 2022 04:24:40 -0800 (PST)
MIME-Version: 1.0
References: <20221108100925.823841-1-alvaro.karsz@solid-run.com>
 <318f4b6e-bcd5-a269-b385-f0e521c2ee9a@redhat.com>
 <CAJs=3_BTL3Rdrnbykgzy5arA5xOoUGz6Y_g6yUNpZg7hfouVSw@mail.gmail.com>
 <183f8215-b1da-290f-9ec6-4c4988aeabcd@redhat.com>
In-Reply-To: <183f8215-b1da-290f-9ec6-4c4988aeabcd@redhat.com>
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
Date: Sun, 13 Nov 2022 14:24:05 +0200
Message-ID: <CAJs=3_B+=Rqrsn_WRuP8g4grH=jsA2h=FF=5qzeTNTj23=FoRw@mail.gmail.com>
Subject: Re: [PATCH] virtio: vdpa: new SolidNET DPU driver.
To: Jason Wang <jasowang@redhat.com>
Cc: Jean Delvare <jdelvare@suse.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Guenter Roeck <linux@roeck-us.net>, virtualization@lists.linux-foundation.org
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

> Yes, actually, the memory barrier can't guarantee the write has been
> processed by the device.

Yes, of course, I meant  that we need to wait until the message is
sent, not until the DPU sees the message.

> Each vDPA needs to be able to assigned to a userspace(VM) independently
> when bound to vhost-vDPA. If they share the same IOMMU domain, there
> will be security issues.

We were planning on using the SR-IOV feature for isolation in the future.
We will add the feature and create a new version.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
