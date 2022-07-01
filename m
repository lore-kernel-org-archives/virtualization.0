Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97E8AC433EF
	for <virtualization@archiver.kernel.org>; Fri,  1 Jul 2022 05:47:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3EC6860E1D;
	Fri,  1 Jul 2022 05:47:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3EC6860E1D
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hVvDc4Yh
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eHKVJ086BL7w; Fri,  1 Jul 2022 05:47:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id BA36F60DF9;
	Fri,  1 Jul 2022 05:47:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BA36F60DF9
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 90D1EC007A;
	Fri,  1 Jul 2022 05:47:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3B15EC0071
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Jul 2022 05:47:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 01FAD81819
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Jul 2022 05:47:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 01FAD81819
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=hVvDc4Yh
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8zoVokUIfDFP
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Jul 2022 05:47:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 49170813C3
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 49170813C3
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Jul 2022 05:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1656654450;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Kxaw70hoiHwUI/cqTZ5YO6DN+NgrafhvITSveXQq/1Y=;
 b=hVvDc4Yh3n/NWaJVLB9yPdnadGXmDT4pZgnlJLKi3kDSFhPg4fu4VcgS5zPaTLEwYVrPq6
 1QnjXLe/gVJEaAmrds+aGzRgrUiTtkBqXmTU+Cw4OHF3xKJvPpGN23ZcYQyX6saJDTdiqQ
 oI2L6xB6QM0TcGszhY8xkIkeBE7tRyI=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-645-8c41eNcSOzeYvj8kim0mRw-1; Fri, 01 Jul 2022 01:47:26 -0400
X-MC-Unique: 8c41eNcSOzeYvj8kim0mRw-1
Received: by mail-lf1-f69.google.com with SMTP id
 p36-20020a05651213a400b004779d806c13so653695lfa.10
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Jun 2022 22:47:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Kxaw70hoiHwUI/cqTZ5YO6DN+NgrafhvITSveXQq/1Y=;
 b=jC87VfKbV662geqyckgewnADuDGp//xYLowdQoHEqUZlQqtpCY1P6o0EDcp2hKffaL
 1YjD8xVWuFBvp6O4ZtaRasTSd8roiH9V+KHMm1b+v5cpvZrVkhk29MPpsMfSHY+7qN5u
 CyDDGAdh//N47aVrW5z1TFM2cVQ5wwOz2/AJI+DTYhWfETv4zUOAvOGOZjaoR22fDBen
 DHRymWjMeyNbDHTA47YHLgzOf8yHMSlU3O2cZcQWZCbQi5NYmr8HEXZJb+fEE0cajW5I
 1oJPzN7LxbBD1Mb5rwgtiq3YYALY3fojy+LFDYOGqppLkoXdQXcp14c5dtjmc2uehvsN
 E7Fw==
X-Gm-Message-State: AJIora81xrXHodplCMK7pNstZgtLsmeLpWwFVA73uoJ4uOvKwL5PBk5j
 jlBNAPcXn9rq20v2rfPGWcIr+9h8+wgbGZUTJX9KotuHwxDjeHqJVNC43r+V2MpX6HVaC4cIoJT
 dQoUqAkmNd9HiPEAlJy3Zc4WoPRjFTFjZpaVVTB2PLeycJ/yl3X/YHoHyWA==
X-Received: by 2002:a05:6512:ba1:b0:47f:c0bd:7105 with SMTP id
 b33-20020a0565120ba100b0047fc0bd7105mr8341305lfv.641.1656654445394; 
 Thu, 30 Jun 2022 22:47:25 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1v0se/FzcmxliJW6fuUGUSnkLWgJBUFrZl0mlLPLSRxp5AulWkBQuSlkKahwAKOQVa7v5Ii718oBi82YszhcQs=
X-Received: by 2002:a05:6512:ba1:b0:47f:c0bd:7105 with SMTP id
 b33-20020a0565120ba100b0047fc0bd7105mr8341293lfv.641.1656654445190; Thu, 30
 Jun 2022 22:47:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220701020655.86532-1-jasowang@redhat.com>
 <20220630210344.4ab805fe@kernel.org>
In-Reply-To: <20220630210344.4ab805fe@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 1 Jul 2022 13:47:14 +0800
Message-ID: <CACGkMEvMnxK-VhEQvf6itBiG=ZYuFjPuPCkpJJT=4VqWrDK32w@mail.gmail.com>
Subject: Re: [PATCH net V3] virtio-net: fix the race between refill work and
 close
To: Jakub Kicinski <kuba@kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: mst <mst@redhat.com>, netdev <netdev@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 davem <davem@davemloft.net>
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

On Fri, Jul 1, 2022 at 12:03 PM Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Fri,  1 Jul 2022 10:06:55 +0800 Jason Wang wrote:
> > We try using cancel_delayed_work_sync() to prevent the work from
> > enabling NAPI. This is insufficient since we don't disable the source
> > of the refill work scheduling. This means an NAPI poll callback after
> > cancel_delayed_work_sync() can schedule the refill work then can
> > re-enable the NAPI that leads to use-after-free [1].
> >
> > Since the work can enable NAPI, we can't simply disable NAPI before
> > calling cancel_delayed_work_sync(). So fix this by introducing a
> > dedicated boolean to control whether or not the work could be
> > scheduled from NAPI.
>
> Hm, does not apply cleanly to net or Linus's tree.

May bad, let me post a new version.

Thanks

>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
