Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C8DCC433F5
	for <virtualization@archiver.kernel.org>; Wed, 25 May 2022 02:33:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id ACCAE41B43;
	Wed, 25 May 2022 02:33:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VTeaNiSLRbbk; Wed, 25 May 2022 02:33:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id EF3AF419B0;
	Wed, 25 May 2022 02:33:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C911DC0032;
	Wed, 25 May 2022 02:33:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 02514C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 May 2022 02:33:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D7B22612AA
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 May 2022 02:33:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id D670qfjkzaGw
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 May 2022 02:33:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A28F060A8B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 May 2022 02:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1653446009;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TUzlT5FItCjrnkA2ba6GnsAuieiG0tvhuEs/Sgn4WbA=;
 b=DUQFa5o3E5EmCdZ3kE1+7h7x4gmrCKZoCqHsUdzJ/BfYlWtHYyr1uqh24zP3xC5ubFXPY2
 p6XFgqmWz7tmgwq3e8INIxqHG3WAIzNO56HM/I2UQVX71I7iT8qnnA5Fxsjhc55SG3vprT
 SQRX9veT4VCH6aDkhpmtR/FCwcdnQ+E=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-635-RGxKZE2GM_quDNlWuFNvZw-1; Tue, 24 May 2022 22:33:24 -0400
X-MC-Unique: RGxKZE2GM_quDNlWuFNvZw-1
Received: by mail-lf1-f70.google.com with SMTP id
 z14-20020a056512308e00b004786d7fde66so3807517lfd.18
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 May 2022 19:33:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=TUzlT5FItCjrnkA2ba6GnsAuieiG0tvhuEs/Sgn4WbA=;
 b=LeSsceYo+Isel8Fw+9CvWrd5kS7MYcTAHKPn9sj/ZM3DkZ/N4V6uu8Te2O+IkD0A9A
 VIW+zbYVEArt2Hn5aQa+CA/T4yE97A1NhqJsPmeo6+jjUEKhL/AoyxDGsEPra1Sv59jl
 ejs+LETQvRbR6YgYf3wCUzk43NTVyvRyuywNuHvX5VY0Ihz8qUNqcR90L4ov5xOvCMj3
 4t0VISLedqD+B4Y1pe5QV/9ichQj2COw5vJCt29TLoYEeHvU4QjRbuaoz4zFrNCPeJOr
 pERzXeqiipqmLzwDBR3r4jXgQ3RKr0lnUHMMu49vV68FZ7Oa64/5a97sPK+kPxzdcomr
 etwQ==
X-Gm-Message-State: AOAM530SUr+YILUGLW0U4/MhJDky/7xYIs2lSrbmaeKE0FKFX/Lo5OZm
 dH9lPSD07KOM8kH4MyrlS8Tqxpy+815j3W9M323GT8ALSLwMQVv6mMKiDVImDKbHQmEJFSSyWEr
 tNnmWmagIOAmJRkjP0/6NfnBKpO1JDcdVcSo/hTYEfuzLY5C/FCOb4xiI9w==
X-Received: by 2002:a2e:949:0:b0:253:ad20:7638 with SMTP id
 70-20020a2e0949000000b00253ad207638mr18213286ljj.73.1653446002509; 
 Tue, 24 May 2022 19:33:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwaIb2y4xSBunj6Y0Pn0HegD61k8wMpUegglnU6deG7dwCx7EXFGAyqLks58kgg00PxIOV7BLaHbKWxgFww6js=
X-Received: by 2002:a2e:949:0:b0:253:ad20:7638 with SMTP id
 70-20020a2e0949000000b00253ad207638mr18213276ljj.73.1653446002298; Tue, 24
 May 2022 19:33:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220518035951.94220-1-jasowang@redhat.com>
 <20220523105323.58c28d75.pasic@linux.ibm.com>
 <20220524182751.1d4bf02f.pasic@linux.ibm.com>
In-Reply-To: <20220524182751.1d4bf02f.pasic@linux.ibm.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 25 May 2022 10:33:11 +0800
Message-ID: <CACGkMEuxdoXoasdAPzAik2Xge7vU5Fp4SMxiqk3eGZCwC8s9eA@mail.gmail.com>
Subject: Re: [PATCH V5 0/9] rework on the IRQ hardening of virtio
To: Halil Pasic <pasic@linux.ibm.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Cindy Lu <lulu@redhat.com>, "Paul E. McKenney" <paulmck@kernel.org>,
 mst <mst@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Marc Zyngier <maz@kernel.org>, Cornelia Huck <cohuck@redhat.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 eperezma <eperezma@redhat.com>, Thomas Gleixner <tglx@linutronix.de>
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

On Wed, May 25, 2022 at 12:28 AM Halil Pasic <pasic@linux.ibm.com> wrote:
>
> On Mon, 23 May 2022 10:53:23 +0200
> Halil Pasic <pasic@linux.ibm.com> wrote:
>
> > On Wed, 18 May 2022 11:59:42 +0800
> > Jason Wang <jasowang@redhat.com> wrote:
> >
> > > Hi All:
> >
> > Sorry for being slow on this one. I'm pretty much under water. Will try
> > to get some regression-testing done till tomorrow end of day.
> >
>
> Did some testing with the two stage indicators disabled. Didn't see any
> significant difference in performance, and with that also no performance
> regression. IMHO we are good to go ahead!

Great!

>
> Sorry it took so long.

No worries and thanks a lot for the help.

I will repost a version with some comments tweaked that is suggested
by Cornelia Huck.

Thanks

>
> Regards,
> Halil
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
