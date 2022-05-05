Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC5A3C433EF
	for <virtualization@archiver.kernel.org>; Thu,  5 May 2022 08:23:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8DF0883227;
	Thu,  5 May 2022 08:23:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PFC8cxs8faoS; Thu,  5 May 2022 08:23:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 0E20C82ED2;
	Thu,  5 May 2022 08:23:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E4D92C0032;
	Thu,  5 May 2022 08:23:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C4F47C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 May 2022 08:23:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AD4F182F32
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 May 2022 08:23:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fOE7u9FYiN-0
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 May 2022 08:23:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-74.mimecast.com
 (us-smtp-delivery-74.mimecast.com [170.10.129.74])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 02BCC82ED2
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 May 2022 08:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1651739014;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bHiS5ONkMB5Lq/fq3dbZCeNjmLoTmpnWP4a2X4gvHsg=;
 b=Sbv1dmOP3X4zeJYMDsny9sVNLU2DfHStw+FWGrbXad+d6sIGjY6dNodqfSPEYLyi+qMxsm
 6dYTEIsG2HHTDsyqfq6SjUWzUt4y6/q0nhWrUel/BeRuSDvGx6dzUYhzRjYRJzqwxrgYCw
 HdTSjxUb+f47zUh0V6985oefabUEsWA=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-167-5A-5QmyZNV6CPGKxxwyDWQ-1; Thu, 05 May 2022 04:23:33 -0400
X-MC-Unique: 5A-5QmyZNV6CPGKxxwyDWQ-1
Received: by mail-lj1-f199.google.com with SMTP id
 y5-20020a2e9785000000b002508326235fso1163331lji.7
 for <virtualization@lists.linux-foundation.org>;
 Thu, 05 May 2022 01:23:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=bHiS5ONkMB5Lq/fq3dbZCeNjmLoTmpnWP4a2X4gvHsg=;
 b=t+DylxprrC8291LAzuN+9I7uF1CX40NOkpAj1Y/9VJZzY8uyK1IkPvCX3fEcztpBIN
 OU0LX/kR4ICqeE/StVGV0ghjFgWHmC39wcTdMQyNqJcPed3DsGKww9sn7/K6/sinCv7v
 7KVRpviGk4xuHpZ5XtU8kZ+xnHUKcDeggwKy5h1SA7KkT7Akaumwi7S9LqBcjpFnwA0Z
 bJCyKxb/2d+WYGLN6jQeSlK/J/r8w3ke3fa9t4lQqW47xRUg5nyH+hJKtgXU8TK/Evo2
 BlLX9dG5ljELPwUasEguhC0rbPbeQ9dlEvElVJekkVXenQKTCF7xDgP/Sda4mQY5jeFA
 v+rg==
X-Gm-Message-State: AOAM532KGA3bsF2MQekIIh673Wfpi16NZ64mL/ka/alScqQaSZSCN6AT
 5LW8sYzt5Kw8O6PEU+w7e+BUs4+9EDWoQb+uZ0hg/0rLyEVjPzbhIGMcZIDuA1FitqY3LFdQ3tb
 eLN21mZwwyaWt7WeFUxslmEY39msg/h7NZ+SJE6KPF0UXRcbzRX4ddKurBg==
X-Received: by 2002:a19:ca50:0:b0:471:f556:92b with SMTP id
 h16-20020a19ca50000000b00471f556092bmr17139226lfj.587.1651739011815; 
 Thu, 05 May 2022 01:23:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyu7/SW5+4bqy1N6ieFzRxA+JqqARJfwTWHOLRD9CoLyqjlumPR7uuMHg1pie0YRch6E0Y+OKmBTpGKQoJqSCk=
X-Received: by 2002:a19:ca50:0:b0:471:f556:92b with SMTP id
 h16-20020a19ca50000000b00471f556092bmr17139203lfj.587.1651739011384; Thu, 05
 May 2022 01:23:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220504081117.40-1-xieyongji@bytedance.com>
 <CACGkMEvdVFP2GkTy2Vxe44xZ+6BOU3FM5WccuHe-32FN1Pm=7A@mail.gmail.com>
 <CACycT3sdLfJPhm73p8onT1zZF3eyt+uPKBj__cfH_RvEk=FoBw@mail.gmail.com>
In-Reply-To: <CACycT3sdLfJPhm73p8onT1zZF3eyt+uPKBj__cfH_RvEk=FoBw@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 5 May 2022 16:23:20 +0800
Message-ID: <CACGkMEtQXk-FsSGvEh1CpAYy9O-Zo+s9_CqwfPX358hBJ7gNBg@mail.gmail.com>
Subject: Re: [PATCH] vringh: Fix maximum number check for indirect descriptors
To: Yongji Xie <xieyongji@bytedance.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: fam.zheng@bytedance.com, rusty <rusty@rustcorp.com.au>,
 virtualization <virtualization@lists.linux-foundation.org>,
 kvm <kvm@vger.kernel.org>, mst <mst@redhat.com>
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

On Thu, May 5, 2022 at 4:06 PM Yongji Xie <xieyongji@bytedance.com> wrote:
>
> On Thu, May 5, 2022 at 3:47 PM Jason Wang <jasowang@redhat.com> wrote:
> >
> > On Wed, May 4, 2022 at 4:12 PM Xie Yongji <xieyongji@bytedance.com> wrote:
> > >
> > > We should use size of descriptor chain to check the maximum
> > > number of consumed descriptors in indirect case.
> >
> > AFAIK, it's a guard for loop descriptors.
> >
>
> Yes, but for indirect descriptors, we know the size of the descriptor
> chain. Should we use it to test loop condition rather than using
> virtqueue size?

Yes.

>
> > > And the
> > > statistical counts should also be reset to zero each time
> > > we get an indirect descriptor.
> >
> > What might happen if we don't have this patch?
> >
>
> Then we can't handle the case that one request includes multiple
> indirect descriptors. Although I never see this kind of case now, the
> spec doesn't forbid it.

It looks to me we need to introduce dedicated counters for indirect
descriptors instead of trying to use a single counter?

(All evils came from the move_to_indirect()/return_from_indierct()
logic, vhost have dedicated helper to deal with indirect descriptors -
get_indirect()).

Thanks


>
> > >
> > > Fixes: f87d0fbb5798 ("vringh: host-side implementation of virtio rings.")
> > > Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> > > Signed-off-by: Fam Zheng <fam.zheng@bytedance.com>
> > > ---
> > >  drivers/vhost/vringh.c | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
> > > index 14e2043d7685..c1810b77a05e 100644
> > > --- a/drivers/vhost/vringh.c
> > > +++ b/drivers/vhost/vringh.c
> > > @@ -344,12 +344,13 @@ __vringh_iov(struct vringh *vrh, u16 i,
> > >                         addr = (void *)(long)(a + range.offset);
> > >                         err = move_to_indirect(vrh, &up_next, &i, addr, &desc,
> > >                                                &descs, &desc_max);
> > > +                       count = 0;
> >
> > Then it looks to me we can detect a loop indirect descriptor chain?
> >
>
> I think so.
>
> Thanks,
> Yongji
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
