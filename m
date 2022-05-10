Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6473DC433FE
	for <virtualization@archiver.kernel.org>; Tue, 10 May 2022 07:56:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E65DD415EC;
	Tue, 10 May 2022 07:56:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vH9gWvA_fEdX; Tue, 10 May 2022 07:56:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 464AE415EA;
	Tue, 10 May 2022 07:56:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 19D29C0039;
	Tue, 10 May 2022 07:56:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 77DD5C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 May 2022 07:56:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 514FF415EB
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 May 2022 07:56:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FVmV4VGJrakc
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 May 2022 07:56:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 57A98415EA
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 May 2022 07:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1652169406;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/c1ztnUjsSvwMC8tPkMNFQeFrqhGiOZ2N5BrE2wTqhY=;
 b=EIUilsOZ5pt8pIVX93LlqOemXrproqKfamueFPH9mXulwIiwJXFyNLvyHDIc+vovoIpaJC
 rGi+zLrM9/anUt/f19pyIjiIF8knnN8Vk/51HUQut4BC7lqfYoMsLIwFitzyWkibw+fnHE
 8UyOcesoWyfa5U8RSScpvvJA/KfUbvw=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-516-8S_WGNZCMwGETz2hc-IosQ-1; Tue, 10 May 2022 03:56:45 -0400
X-MC-Unique: 8S_WGNZCMwGETz2hc-IosQ-1
Received: by mail-lf1-f72.google.com with SMTP id
 n3-20020ac242c3000000b00473d8af3a0cso5628250lfl.21
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 May 2022 00:56:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/c1ztnUjsSvwMC8tPkMNFQeFrqhGiOZ2N5BrE2wTqhY=;
 b=wm56KwVPFUpJ2yYX45ZMGHaa7iFii9XELbHuz8Tupg+QsRjgIvlBN4Z6q/cgmUZiRe
 Y3fWBKak1sgddB7bMUooL4Pfq3lAdnHk5HfCBstyCd8PkBbDgiNZEM0CmTwFxfuGP6os
 lom+UZo3UwKkj/trbAiWVGgOCCLaEwp8GwW29+Lj2qTtXZYTUgM3jNYHyUSPd8TNYHOq
 BonQ8DRjbztkJ+UCFb9zY8NxI8ODLRwxY1o5pD7scP805i+iVrIB4OfvxwucHpP4l3dG
 SaX/BmW7NJOSJ0yyCDnWN2v/R6RZ5Hq0wSNGsI/jncL0LJl6dsAnLrK5123P6oBI7kSN
 S8rw==
X-Gm-Message-State: AOAM533/LPhM0OBFt3khOqqeCBIj7P0+LbTTtZIGbdqOvvoyi/w6FkxM
 WDSW+N06GbQlbJp2EsvEDHCSYzM4Xm1GzBPLcBnoDqzgx5+k22k3CwXXWjTqE7q0l7D9uhkBNs8
 jGNcWAujaBxRV2DEDhCw9SR6cfZX2NDH6BLt+AWfzK5lLTOLUrZid3FeT8g==
X-Received: by 2002:a19:ca50:0:b0:471:f556:92b with SMTP id
 h16-20020a19ca50000000b00471f556092bmr15479991lfj.587.1652169404073; 
 Tue, 10 May 2022 00:56:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxD3QYQhNm8OOhmYu9K618fwpvK2JHxPPxaipeoPj14mMMrx2E9jL681mf6nCwBi/RMtwvLQ6FsFANB6ecwX0c=
X-Received: by 2002:a19:ca50:0:b0:471:f556:92b with SMTP id
 h16-20020a19ca50000000b00471f556092bmr15479980lfj.587.1652169403887; Tue, 10
 May 2022 00:56:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220505100910.137-1-xieyongji@bytedance.com>
 <CACGkMEv3Ofbu7OOTB9vN2Lt85TD44LipjoPm26KEq3RiKJU0Yw@mail.gmail.com>
 <CACycT3uakPB_JeXb11hrBaPjcdqign3FmuQd3FXgFR7orO_Eaw@mail.gmail.com>
In-Reply-To: <CACycT3uakPB_JeXb11hrBaPjcdqign3FmuQd3FXgFR7orO_Eaw@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 10 May 2022 15:56:33 +0800
Message-ID: <CACGkMEu72zPKyZXWvyeMsNwjKohXHEMu_hp1dwPVF_2RF5ezPA@mail.gmail.com>
Subject: Re: [PATCH v2] vringh: Fix loop descriptors check in the indirect
 cases
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

On Tue, May 10, 2022 at 3:54 PM Yongji Xie <xieyongji@bytedance.com> wrote:
>
> On Tue, May 10, 2022 at 3:44 PM Jason Wang <jasowang@redhat.com> wrote:
> >
> > On Thu, May 5, 2022 at 6:08 PM Xie Yongji <xieyongji@bytedance.com> wrote:
> > >
> > > We should use size of descriptor chain to test loop condition
> > > in the indirect case. And another statistical count is also introduced
> > > for indirect descriptors to avoid conflict with the statistical count
> > > of direct descriptors.
> > >
> > > Fixes: f87d0fbb5798 ("vringh: host-side implementation of virtio rings.")
> > > Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> > > Signed-off-by: Fam Zheng <fam.zheng@bytedance.com>
> > > ---
> > >  drivers/vhost/vringh.c | 10 ++++++++--
> > >  1 file changed, 8 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
> > > index 14e2043d7685..eab55accf381 100644
> > > --- a/drivers/vhost/vringh.c
> > > +++ b/drivers/vhost/vringh.c
> > > @@ -292,7 +292,7 @@ __vringh_iov(struct vringh *vrh, u16 i,
> > >              int (*copy)(const struct vringh *vrh,
> > >                          void *dst, const void *src, size_t len))
> > >  {
> > > -       int err, count = 0, up_next, desc_max;
> > > +       int err, count = 0, indirect_count = 0, up_next, desc_max;
> > >         struct vring_desc desc, *descs;
> > >         struct vringh_range range = { -1ULL, 0 }, slowrange;
> > >         bool slow = false;
> > > @@ -349,7 +349,12 @@ __vringh_iov(struct vringh *vrh, u16 i,
> > >                         continue;
> > >                 }
> > >
> > > -               if (count++ == vrh->vring.num) {
> > > +               if (up_next == -1)
> > > +                       count++;
> > > +               else
> > > +                       indirect_count++;
> > > +
> > > +               if (count > vrh->vring.num || indirect_count > desc_max) {
> > >                         vringh_bad("Descriptor loop in %p", descs);
> > >                         err = -ELOOP;
> > >                         goto fail;
> > > @@ -411,6 +416,7 @@ __vringh_iov(struct vringh *vrh, u16 i,
> > >                                 i = return_from_indirect(vrh, &up_next,
> > >                                                          &descs, &desc_max);
> > >                                 slow = false;
> > > +                               indirect_count = 0;
> >
> > Do we need to reset up_next to -1 here?
> >
>
> It will be reset to -1 in return_from_indirect().

Right. Then

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

>
> Thanks,
> Yongji
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
