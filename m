Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B57A1C4332F
	for <virtualization@archiver.kernel.org>; Fri, 30 Dec 2022 03:40:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0F7B34091F;
	Fri, 30 Dec 2022 03:40:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0F7B34091F
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Z/d0EPgw
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VmcyCghfQxKg; Fri, 30 Dec 2022 03:40:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3F1964089B;
	Fri, 30 Dec 2022 03:40:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3F1964089B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0AFEDC0033;
	Fri, 30 Dec 2022 03:40:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 328BFC002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 30 Dec 2022 03:40:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EDBA7819B4
 for <virtualization@lists.linux-foundation.org>;
 Fri, 30 Dec 2022 03:40:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EDBA7819B4
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Z/d0EPgw
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id REQZCJm3prdA
 for <virtualization@lists.linux-foundation.org>;
 Fri, 30 Dec 2022 03:40:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F2D2C81990
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F2D2C81990
 for <virtualization@lists.linux-foundation.org>;
 Fri, 30 Dec 2022 03:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1672371653;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1F5+hQjkJhgkTWUhZtnbA0j58E86UDL3Nmc2tQULevg=;
 b=Z/d0EPgwD+piBrLgHfvhsbThPNEwCs6nCDUb5AAzORK0rLor82R57xDuNirZKOBto+xPUz
 5h8vuWDw3ipw/QC2eIrRXReHRttPSPIAWXQrbJSYr22prSPDTtwmft+UtjkSz/ZzkVIkKQ
 Eq+eVhP5p+t/1gXISfRqywQNzeE5xhQ=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-31-NXTFxEJpOeG8UeK9zZEcDg-1; Thu, 29 Dec 2022 22:40:44 -0500
X-MC-Unique: NXTFxEJpOeG8UeK9zZEcDg-1
Received: by mail-ot1-f71.google.com with SMTP id
 m12-20020a9d6acc000000b006707706d25dso11071985otq.22
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Dec 2022 19:40:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1F5+hQjkJhgkTWUhZtnbA0j58E86UDL3Nmc2tQULevg=;
 b=NO/rbfLAIPe3PVIBwpNH66ROe+GjGY83aFwgmsHj8xe0BDidQAwO+EDKof6dAYTS/F
 QZmg1bATUDJm8qNjcKC+1kJeALYbq9yqbHvKWJIJkFrHl61Xky3+MmLxPZ/23E9mMv65
 44BeEioeqkByneOTwLqodTV5neG9gmAvA4yaEaKkn4c4CiIsNJdIwePZTHOrIZJs89bA
 9ctoaGKhGIsZpQKwMQ0c3hXF1b7YrVpctkDhVXQeKzm1sZjXaCVJ0Q2BpLBrYmeVBe7i
 6jhgsZQtEO6yFMcO0qjtEKTZnNu02ZyaWf1r4i3wYcGBAzd4QQK2kAVRvW3NAckrEwZN
 4RKA==
X-Gm-Message-State: AFqh2kr8LSd7D0h5x9zWuoERVebEGo6Dpx9/gbmmTO8Mko//f8bcPs14
 Ftgq8kNNUM+FFnTSN/vu1NRyxarBvdNDOptWIaElAZmhYqPw2BzrtRRW1iGiHK9sPA9mz/ZQjo6
 pZcoF+iE48FKho28RIxU/M/u8AL62T2uYVf2ans0h1faewp5TwbpWUZwuqg==
X-Received: by 2002:a4a:c989:0:b0:480:8f4a:7062 with SMTP id
 u9-20020a4ac989000000b004808f4a7062mr1398912ooq.57.1672371643844; 
 Thu, 29 Dec 2022 19:40:43 -0800 (PST)
X-Google-Smtp-Source: AMrXdXt7j5z1WBF0/DPB10FVuklqtEzv/3UxFifxJVoglD/g2yM0R+oXtjjD2Fs4H38z4VS9qlknIfSdxxEXjcWRmBs=
X-Received: by 2002:a4a:c989:0:b0:480:8f4a:7062 with SMTP id
 u9-20020a4ac989000000b004808f4a7062mr1398904ooq.57.1672371643572; Thu, 29 Dec
 2022 19:40:43 -0800 (PST)
MIME-Version: 1.0
References: <20221226074908.8154-1-jasowang@redhat.com>
 <20221226074908.8154-2-jasowang@redhat.com>
 <20221227023447-mutt-send-email-mst@kernel.org>
 <6026e801-6fda-fee9-a69b-d06a80368621@redhat.com>
 <20221229185120.20f43a1b@kernel.org>
In-Reply-To: <20221229185120.20f43a1b@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 30 Dec 2022 11:40:32 +0800
Message-ID: <CACGkMEsL2Tm=J-nazDEebO0_8=S_4hW2vKdLpZy7ab=Yr92cPw@mail.gmail.com>
Subject: Re: [PATCH 1/4] virtio-net: convert rx mode setting to use workqueue
To: Jakub Kicinski <kuba@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 eperezma@redhat.com, edumazet@google.com, maxime.coquelin@redhat.com,
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

On Fri, Dec 30, 2022 at 10:51 AM Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Tue, 27 Dec 2022 17:06:10 +0800 Jason Wang wrote:
> > > Hmm so user tells us to e.g enable promisc. We report completion
> > > but card is still dropping packets. I think this
> > > has a chance to break some setups.
> >
> > I think all those filters are best efforts, am I wrong?
>
> Are the flags protected by the addr lock which needs BH, tho?
>
> Taking netif_addr_lock_bh() to look at dev->flags seems a bit
> surprising to me.
>

Yes, RTNL should be sufficient here. Will fix it.

Thanks

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
