Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54B24C4332F
	for <virtualization@archiver.kernel.org>; Thu, 22 Dec 2022 08:43:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 638B2610E8;
	Thu, 22 Dec 2022 08:43:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 638B2610E8
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WBGJaCfw
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cVK6fRwh4Qpu; Thu, 22 Dec 2022 08:43:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 6B69760BB2;
	Thu, 22 Dec 2022 08:43:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6B69760BB2
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 24943C0071;
	Thu, 22 Dec 2022 08:43:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B1E66C0070
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Dec 2022 08:43:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8569D4179A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Dec 2022 08:43:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8569D4179A
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=WBGJaCfw
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id S-WhFyI2Z7IC
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Dec 2022 08:43:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A1C0D4177F
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A1C0D4177F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Dec 2022 08:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1671698602;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KNeBYmXuI57DgCzyGIVCTcmPzwc5WTW5DEjmav8+hVE=;
 b=WBGJaCfwyy1XMcuanNditZ70P0bZNPJNaTypgu5NPJn+MYQ4qMQINx4JS4fYvD8UtD47kS
 pR7NT4nBrY2dZYSgULcxjlKdC346nQ81IsV282m+t7rdtM2slCnACH1DXLsoxFxSKpR5EL
 2Tr8DR5mMel4x1uETswKnXi8QjaSaKA=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-673-wra-OBE_MFmAEI39ZAgZBw-1; Thu, 22 Dec 2022 03:43:21 -0500
X-MC-Unique: wra-OBE_MFmAEI39ZAgZBw-1
Received: by mail-oi1-f198.google.com with SMTP id
 bl37-20020a05680830a500b00360ffa37a0cso241535oib.8
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Dec 2022 00:43:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KNeBYmXuI57DgCzyGIVCTcmPzwc5WTW5DEjmav8+hVE=;
 b=dj5QeytQHp6Sh+p6Bq36bbP6oP7w+LmPTwmXAvjuzQthTkY6AMEZG2jUz54CYo8jxv
 aKlK+e+GVSyf0Mm2FUfaYTAxZOKJzExx7OmMHFwEsis7+Xcm6aDR5NKoUpT05YKpltPP
 94YZUMTfIhyyc+UY17mcucNx9RkUKFNjNFuhnhXvMFxRp/5lvFD1GJWwXddb6fxbmb8z
 R4s3t6vvOoOEoi9CHGR7lDbbS65JGxFWYIu+LMWUDUhKySBjC8hfYkgrnhEt66xRqGZn
 ppbSKIRlbpAoIHWIcjgcQNSO6jjdl3NJ3G6kuW0cJ9o4W9PCDSARFaTsQpkfF1YL3B4s
 QMrw==
X-Gm-Message-State: AFqh2kreEWwGj/62trMCGHooiP8vG1enqLIi3bp8HJaldY75hXbvzsap
 b27Kt9P6rYCV9AN+DAlMKohbNeaOGo6AzD7R/hqvDMvMuW//Itz8RmM1kT0D1uQrITG7csdGiZV
 hB+8F3txXfbZBJgqqOnXR6Vk6419EL33lFPTRnVxqr20bXROzsiGiaRI3ZA==
X-Received: by 2002:a05:6870:4413:b0:144:a97b:1ae2 with SMTP id
 u19-20020a056870441300b00144a97b1ae2mr266520oah.35.1671698600455; 
 Thu, 22 Dec 2022 00:43:20 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvArZS7BpYzOO0P/QwDDxpof+Qjh3fZ82zc2Zf58dXBN/RrZIhzXz+A2ykZuG4V9/h7aE61hCJ8AzusgQCz9j4=
X-Received: by 2002:a05:6870:4413:b0:144:a97b:1ae2 with SMTP id
 u19-20020a056870441300b00144a97b1ae2mr266519oah.35.1671698600234; Thu, 22 Dec
 2022 00:43:20 -0800 (PST)
MIME-Version: 1.0
References: <20221222060427.21626-1-jasowang@redhat.com>
 <20221222060427.21626-5-jasowang@redhat.com>
 <CAJs=3_D6sug80Bb9tnAw5T0_NaL_b=u8ZMcwZtd-dy+AH_yqzQ@mail.gmail.com>
In-Reply-To: <CAJs=3_D6sug80Bb9tnAw5T0_NaL_b=u8ZMcwZtd-dy+AH_yqzQ@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 22 Dec 2022 16:43:09 +0800
Message-ID: <CACGkMEv4YxuqrSx_HW2uWgXXSMOFCzTJCCD_EVhMwegsL8SoCg@mail.gmail.com>
Subject: Re: [RFC PATCH 4/4] virtio-net: sleep instead of busy waiting for cvq
 command
To: Alvaro Karsz <alvaro.karsz@solid-run.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: mst@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, eperezma@redhat.com,
 edumazet@google.com, maxime.coquelin@redhat.com, kuba@kernel.org,
 pabeni@redhat.com, davem@davemloft.net
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

Hi Alvaro:

On Thu, Dec 22, 2022 at 2:44 PM Alvaro Karsz <alvaro.karsz@solid-run.com> wrote:
>
> Hi Jason,
>
> Adding timeout to the cvq is a great idea IMO.
>
> > -       /* Spin for a response, the kick causes an ioport write, trapping
> > -        * into the hypervisor, so the request should be handled immediately.
> > -        */
> > -       while (!virtqueue_get_buf(vi->cvq, &tmp) &&
> > -              !virtqueue_is_broken(vi->cvq))
> > -               cpu_relax();
> > +       virtqueue_wait_for_used(vi->cvq, &tmp);
>
> Do you think that we should continue like nothing happened in case of a timeout?

We could, but we should not depend on a device to do this since it's
not reliable. More below.

> Shouldn't we reset the device?

We can't depend on device, there's probably another loop in reset():

E.g in vp_reset() we had:

        while (vp_modern_get_status(mdev))
                msleep(1);

> What happens if a device completes the control command after timeout?

Maybe we could have a BAD_RING() here in this case (and more check in
vq->broken in this case).

Thanks

>
> Thanks
>
> Alvaro
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
