Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC9B6C433F5
	for <virtualization@archiver.kernel.org>; Wed, 11 May 2022 20:08:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 404F24056A;
	Wed, 11 May 2022 20:08:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eq-YpChiQTgY; Wed, 11 May 2022 20:08:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id DA4F440186;
	Wed, 11 May 2022 20:08:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B07BCC0032;
	Wed, 11 May 2022 20:08:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 00CC5C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 May 2022 20:08:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CE2374174D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 May 2022 20:08:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uAZNl5s97LNv
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 May 2022 20:08:10 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9AFAC41759
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 May 2022 20:08:09 +0000 (UTC)
Received: from mail-oa1-f42.google.com ([209.85.160.42]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1N6bwO-1nqkpf12Ok-0180Zp for <virtualization@lists.linux-foundation.org>;
 Wed, 11 May 2022 22:03:01 +0200
Received: by mail-oa1-f42.google.com with SMTP id
 586e51a60fabf-d39f741ba0so4104060fac.13
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 May 2022 13:03:00 -0700 (PDT)
X-Gm-Message-State: AOAM533jr6qy29xx1NQHdAYiLG5qkBL+oifHzW8WDUcaYG3ZIV9H7Z0b
 LFTk6O5w4wlAVySlsfFOAmQF1kBh2KmP9SNQnsM=
X-Google-Smtp-Source: ABdhPJwwPw4+8p8VgoM3olKQlDqsXwX59vFNT4ipMIqp/8fatnE0NT9ZkM+0jaPJODaBSx5ZwEBPTq9Ovo9Espj6BpE=
X-Received: by 2002:a05:6870:a1a0:b0:e2:9331:cc30 with SMTP id
 a32-20020a056870a1a000b000e29331cc30mr3527723oaf.155.1652299379884; Wed, 11
 May 2022 13:02:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220414193316.14356-1-vdasa@vmware.com>
 <87levezr2y.fsf@redhat.com>
 <245F4717-CF83-40BC-BC87-5EB8563E0588@vmware.com>
In-Reply-To: <245F4717-CF83-40BC-BC87-5EB8563E0588@vmware.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 11 May 2022 22:02:43 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1yCBO5fJ8pacxVd4Umjt0Qy7wfgwZNkqqYMKjofZFvLQ@mail.gmail.com>
Message-ID: <CAK8P3a1yCBO5fJ8pacxVd4Umjt0Qy7wfgwZNkqqYMKjofZFvLQ@mail.gmail.com>
Subject: Re: [PATCH] VMCI: Add support for ARM64
To: Vishnu Dasa <vdasa@vmware.com>
X-Provags-ID: V03:K1:a7LOW0kt0gF+2TBJ+E1KH7ysykniKYV+rn46nQzqJQU0huI6RWQ
 EYz+x0JN2VJiaHVk2gKQS5P6SFQFESQPnrO0GlAQ9ukytv4oze2J/Cgj74gPTYOcMY2DJGz
 o7lQOaMAnQCo2rIXqdYZug8I8hrwEvQB8cznyYLC1IK0grljSbSct9CgD4XFE1zdlPVLUfD
 GowtbwTnIjQ+R1sxrzC3Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TvSKS8OjxSE=:NO2U/Zcz1o/MPE2V2GWf4F
 6Ko7SO+bvtiWzQyNqeTnPrkmHZCixwacTRnoQbI4gZDiECgTUOkq6dT6tTD2e8UCenj+FqOAn
 FTRkJCIzX5/5sgv7FXlFAgcYidrWSrOKLK8TUGjMSikHMUOtwr8711x3CMx9jj9XiWjLyBcyi
 eJJprlqF60LIDrSYAuf5NZJDPmG9uu3gvfeccZmIA3ZzjZoz8fMkfAftvb2FETrU/Q3cdUPEK
 s3pZBI1WWiRbYJ35gDYSpspy0KHJ8KpBPdWcnJihl6EGUD3foktiHnNlCQZtSIa98c+RCn4eq
 ot+UPhW7tYp7jtPpgPHoeY9o/YfIxUcxcWR5DnUPJeg1Z2HAzP40f0sKLYdOUltYSJztpoLQ+
 t98e2moNHNrsKc706g3y2a9TuZbDmUrCHDgrW43qxHINdjAGo8FKgyn5ywVJfpGF90mIif3SJ
 8VqkRPWxiEuzkHuL0pSZ4rTvGTGIWKcsqVoNlJoH+m8/Xe7089EyCL3eAv7iicIuohVc7G46w
 Aa+uPeWZWAG2PxuVfrJjfGkdxszyCj7HeuO3Kw44Z1bx/koOl6OfswwvZgAndjzvPXZQrr/s8
 nOP1svxqC21hb3kDaQoMHUJ6XGm4elKESa1t4E37nIOHe+RTGnXioKLa1xY/5Zk+tFZ2v9DXO
 omXF9RH+hUS5yuyR6oIuF427X5C6zlqCaKPeA+js8AT+dxF4tsB6GAx+jI4CsrXj7gGNWeqkp
 kl6TGcvXREoRbic7aI836HoueDy/4hLCJntzYA==
Cc: Pv-drivers <Pv-drivers@vmware.com>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 linux-kernel-review list <linux-kernel-review@mailman2.vmware.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>, Bryan Tan <bryantan@vmware.com>,
 Cyprien Laplace <claplace@vmware.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
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

On Wed, May 11, 2022 at 9:54 PM Vishnu Dasa <vdasa@vmware.com> wrote:
>
>
> > FWIW, it seems you're doing three things at once, better split this into
> > a 3-patch series.
>
> Thanks for the feedback.  I was debating between the two ways of doing
> it and ultimately did it one way.  It is a bit late now to change it as it has
> made its way to linux-next already.

It's really ok either way here. While there are clearly multiple changes in the
source file, they are all trivial, and the Kconfig change doesn't make sense
without the other changes, so having a combined patch seems totally
reasonable as well.

         Arnd
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
