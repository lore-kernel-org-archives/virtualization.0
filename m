Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE859C004D4
	for <virtualization@archiver.kernel.org>; Wed, 24 Aug 2022 19:49:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 41CD741795;
	Wed, 24 Aug 2022 19:49:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 41CD741795
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=8PUDIqTF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id s0qgwguzYhxQ; Wed, 24 Aug 2022 19:49:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 8A4324176A;
	Wed, 24 Aug 2022 19:49:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8A4324176A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 40339C0032;
	Wed, 24 Aug 2022 19:49:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 780A8C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Aug 2022 19:49:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5FCEA40640
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Aug 2022 19:49:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5FCEA40640
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com
 header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=8PUDIqTF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pE2XzWcB_ru2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Aug 2022 19:49:07 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B38D3405EC
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com
 [IPv6:2607:f8b0:4864:20::536])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B38D3405EC
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Aug 2022 19:49:07 +0000 (UTC)
Received: by mail-pg1-x536.google.com with SMTP id v4so15896441pgi.10
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Aug 2022 12:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solid-run-com.20210112.gappssmtp.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc;
 bh=djs90C29l8wTO8RnP6bq0/YItNvH2puzecc0ezm9lDk=;
 b=8PUDIqTFDm+KeMvkM4l1r8ccuPXxCRywazE7SlDFOA34k0qZNcUpZgetPZ14miDcsF
 OwH039y2RjM3rsu9Kk9+2N4MLYRPuJgoNenjkq5QJYVe7Ov7rkdaT8rcZaIlEcm7YTel
 zmXNihzM78o09pAPLS+K/jHsH+RA0EDfTZNa4iehsg9dTpvubB5YvwFSbAQp+nTkfmwF
 WjUXV+uPJfPqtDQsy+EAdaLXXRByuKCsNgDxntAgY6AEVfyFFTKKJdiVE+9qWMehyXlj
 ZK+sFEnHwIyo84BxFDJpbI5tuci9Kk9cUnjnWzqOw7VSW+Wh25NC3iy45xOvRSQrc4N3
 DbLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc;
 bh=djs90C29l8wTO8RnP6bq0/YItNvH2puzecc0ezm9lDk=;
 b=SEpoLdAC0jiPA0Q8Ntnsolaiup2LQ4ol3+dj6b9jkbjRKdr+Ljllzv2skmQH260g+n
 WFvXBnUy0hLKQZUtYyUTnwISW3DITg8+KbuHZ4gsUq0/GEzYFPupFFd4tsj2djUONPEc
 q8yorItOSMyrDfcZZpGVnEdoYqgP+M33KTrOcF4KHph1gJ0gHhp+B9nGOWHXTB5ME/gM
 5whPE1anDwwBlBFlC0Yn/CsUz7mYpCXH6BocLl9yum9LBEq7EumplxDDJM+hgXOgo7BZ
 r51ICtDQPDKNSSs9uYHrL0PuCXnQ/7JucAimk3fcpPQeYPKsoOk5wU58u9kSKbzitG+w
 kfuA==
X-Gm-Message-State: ACgBeo1LrLwjCN59ay7GLN8jS6pbEDxp5k0W65/cT6HnsO4XjpIgszKW
 2pJUCMODfNG4Ji/4jegePTQNH1Kv1M4yNZosKlzYpw==
X-Google-Smtp-Source: AA6agR5uwvi0nC8GuxslwTPwGARGxgv8FSz0Amy+nRi2byqnnthPNWyME+9IHW3ahv4jJjhIVrixHbm8RPMNMjmB+mY=
X-Received: by 2002:a62:1c56:0:b0:536:4f4b:d99e with SMTP id
 c83-20020a621c56000000b005364f4bd99emr720828pfc.64.1661370546962; Wed, 24 Aug
 2022 12:49:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220822162055.634854-1-alvaro.karsz@solid-run.com>
 <YwUueWHKi5YmQeGP@fedora>
 <CAJs=3_C9Bm=zsDUXuGXnDmZEKmSYfj-44UvuuyT1_SgbSXJoYQ@mail.gmail.com>
 <YwZwB9BlGeA08Hmn@fedora>
In-Reply-To: <YwZwB9BlGeA08Hmn@fedora>
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
Date: Wed, 24 Aug 2022 22:48:30 +0300
Message-ID: <CAJs=3_CUf_QQ1uy-uE1VA_Y=5G=_9D8MeRiPLFEOQnj4n04=Aw@mail.gmail.com>
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

> How about calculating the minimum of the limits?

Sounds reasonable.
Should I add it to this patch (as v2)?
Or maybe it can be a follow up patch, and it can include the write
zeros command as well.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
