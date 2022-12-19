Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3222FC4332F
	for <virtualization@archiver.kernel.org>; Mon, 19 Dec 2022 08:40:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A3B3960AF4;
	Mon, 19 Dec 2022 08:40:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A3B3960AF4
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=x3TU33kL
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rWiJSO3Oza6T; Mon, 19 Dec 2022 08:40:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3EF46600B8;
	Mon, 19 Dec 2022 08:40:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3EF46600B8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EC7D6C0032;
	Mon, 19 Dec 2022 08:40:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DBA6BC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Dec 2022 08:40:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A40F040147
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Dec 2022 08:40:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A40F040147
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com
 header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=x3TU33kL
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5MTkMriMOeU8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Dec 2022 08:40:17 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2E8F3400F8
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com
 [IPv6:2607:f8b0:4864:20::435])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2E8F3400F8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Dec 2022 08:40:17 +0000 (UTC)
Received: by mail-pf1-x435.google.com with SMTP id a14so5731318pfa.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Dec 2022 00:40:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solid-run-com.20210112.gappssmtp.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=f8+bSmaA0cmp16x26bRQ/cm+4zQqtY1wbwdEpQv5OiY=;
 b=x3TU33kLDcq/fKKT5qEHxp4k2dRmZICETK7MtPkScTvO3f4q0zn/lKiLXv5/E4poHh
 ohcn17PYGrtMr7icJoKrtIh1wNpyHZrW8qXbxXAJuCD7Cu60bPhfFEtBZJrqAqyzdZ4k
 BfpPqfxo/eY7Rbs8thLo2rI+w4ExHV84kb8cnzQzgyXEO9j+fLgl9NqWIjcv/UOfM6MJ
 h2r8rSKyhv6IS16fz9VXUNe70HAEbgY2CbzOb7K0nchnNIyNmEnZhm3HNK1umwI2830K
 AkAG9tBUOawIoOK8pjc76Mc9/yazdENIRmrWYKP3MSbdTk6aBVOaXrXuTXaUl8TYmmWh
 sZsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=f8+bSmaA0cmp16x26bRQ/cm+4zQqtY1wbwdEpQv5OiY=;
 b=v8hrhZOFyZKr9F+2KFu7UvY9bw3xL2KFJgz9fsmN/JeCLTATdONN+9aX8poT+s1Weg
 Zu9e0og7WzMUC0OFA2QB00+ZBxVBtge9H6984SP7oo5Lc6nUVaI7blBhFRJeAJDGMZJx
 XZpHSNqRmhQTa7BPFvxiv6Xde5ekpLKcOTTeibXfUsQrDuw3rFGVlA8og7GP8IDWGj1W
 ohca+cDVoMK6miIjZ+w+TEcdsW9zB06VaBFYHii+clGhNOuTOCTtIu9NjITEKXcfMtRo
 KEyJI9GwqnQSBqNfJ5EZaTK/vj0srx3ngE2gAANkC9mzR+Ro7ilxMRhzI2xVl51Hmpqh
 9x0w==
X-Gm-Message-State: ANoB5pmQ9DxJbLCPDENyNP3iwOx9dJbo34IUCURSwSIIeYwu7x2SBaIX
 DVAii+/5aW9EWl3iUxvetxB7xy/LSvzH2BBt1c0pTQ==
X-Google-Smtp-Source: AA0mqf6fHrB24kpKRZtxJ/jl4cyycBpONCwoE9u9Hwo5PX1mANCykQgJBY1PwHfLY1yPaXCstzW+unZ0wtSJyelyLd8=
X-Received: by 2002:aa7:9acc:0:b0:577:81cb:4761 with SMTP id
 x12-20020aa79acc000000b0057781cb4761mr9183983pfp.46.1671439216472; Mon, 19
 Dec 2022 00:40:16 -0800 (PST)
MIME-Version: 1.0
References: <20221205162035.2261037-1-alvaro.karsz@solid-run.com>
 <20221219025404-mutt-send-email-mst@kernel.org>
In-Reply-To: <20221219025404-mutt-send-email-mst@kernel.org>
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
Date: Mon, 19 Dec 2022 10:39:39 +0200
Message-ID: <CAJs=3_CWQ3T1O5RofstwkczpgoJym5X4xBQmdQCtt573sHUOKg@mail.gmail.com>
Subject: Re: [PATCH v3] virtio_blk: add VIRTIO_BLK_F_LIFETIME feature support
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-scsi@vger.kernel.org,
 linux-nvme@lists.infradead.org, virtualization@lists.linux-foundation.org,
 linux-block@vger.kernel.org, dm-devel@redhat.com,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
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
Sorry, I had no time to create a new version.
I'll do it today.

Alvaro
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
