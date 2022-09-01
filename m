Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 225F6ECAAD1
	for <virtualization@archiver.kernel.org>; Thu,  1 Sep 2022 07:45:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9C66F60BE4;
	Thu,  1 Sep 2022 07:45:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9C66F60BE4
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=KnWjvNJC
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MhnvEHkMf4Lp; Thu,  1 Sep 2022 07:45:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8BD0F60BD9;
	Thu,  1 Sep 2022 07:45:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8BD0F60BD9
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5482EC0032;
	Thu,  1 Sep 2022 07:45:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4B920C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Sep 2022 07:45:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1FFB683E13
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Sep 2022 07:45:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1FFB683E13
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com
 header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=KnWjvNJC
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5yjS1uezbxCO
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Sep 2022 07:45:06 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C39AA83E01
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C39AA83E01
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Sep 2022 07:45:06 +0000 (UTC)
Received: by mail-pl1-x633.google.com with SMTP id w2so16387430pld.0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 01 Sep 2022 00:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solid-run-com.20210112.gappssmtp.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc;
 bh=Ti6Y/30sDAouZPurHpE71AmvS9eavVjlZGnUI+0ylHE=;
 b=KnWjvNJC+nAt9xPqlA1M2PcbaO36d28hkqjz8yNx4mV0zGlzp521oDELN+RwNZ9JvP
 KQy9nawDzClmkjYb9NXqtQuAX9YuCdvCSNksVXdTOYZq0Reiy0EMt4bOFQNNWuPhCmi1
 6+hlsP+Oc8nUdR7PkNH9VIzfezd/1JaZtBfTTWFUQFKIIF3hHITfxkNqCOtignh7PN2T
 ZN2vpcPtRWzM5qJUI64khssH86G/fjF7zA9JIcKMab+msN9GvK2ryxpB1ORW+uqm4Aty
 AaCS/M9yuZRz6YaVWvORYA0n7fJ1PhWXh+09RtSy8/sgkffu8ISkFJFDL96wkrj4yUgJ
 TyAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc;
 bh=Ti6Y/30sDAouZPurHpE71AmvS9eavVjlZGnUI+0ylHE=;
 b=IqL0W/Oi+JsITkq6FiguyLm0IlVXdUa3IhexrMdKFKLmDj2iMJeoVeVnBDiNBdTaKy
 RrDPUZYSuDL5XCJlQ4wfcd7uxVSII5AnxdOLHxIUhAQb5AXA2VMCShKTmMsseKKh8T/I
 4tHaNalDd1SeOjUfSrE5q5o26NnwUNs/Prq7R1mN16ibSB2lRU/87Pezid0AMV1MA+/X
 A4oKtfycolTwyHqWvebtUx8/EnfWJS6VwsTY/255iSFm2A3vKXl3Il7s5ATqhZU9Mq+E
 RzW7iPtlrdu3zFssx37XF6IKqhUp/+Fyf2moWQpyxL2SkgKspOMBHqGJtRKp1dg/CdPV
 0bdA==
X-Gm-Message-State: ACgBeo3WVi1lN8LAm5/zD5CZ5Jdr4/bziDJwyUCC3/SemgQx51dAVXNP
 i87aGHilzHKZzxHJzP/mrPlNxUn5tach9vkR+aOX/A==
X-Google-Smtp-Source: AA6agR5aTtJJq8ZXfqP8bSbO9CxU3NXGL22YIUhxZQxTJ/WGtoEQ2nQlqghlpUCgocpgk+yBfXKuz3zJbdAq5dLeVAc=
X-Received: by 2002:a17:90a:7805:b0:1fa:bdab:7d59 with SMTP id
 w5-20020a17090a780500b001fabdab7d59mr7202623pjk.37.1662018306173; Thu, 01 Sep
 2022 00:45:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220829082313.419220-1-alvaro.karsz@solid-run.com>
In-Reply-To: <20220829082313.419220-1-alvaro.karsz@solid-run.com>
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
Date: Thu, 1 Sep 2022 10:44:30 +0300
Message-ID: <CAJs=3_AEDwA6KfzPLvNhrgAUcFxkZuzjPOnzXcAv1gCh8Cc+jQ@mail.gmail.com>
Subject: Re: [PATCH v2] virtio_blk: add SECURE ERASE command support
To: stefanha@redhat.com
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

Is that what you meant Stefan?
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
