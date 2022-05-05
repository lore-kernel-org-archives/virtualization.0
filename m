Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3FFCC433F5
	for <virtualization@archiver.kernel.org>; Thu,  5 May 2022 07:57:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4340560D62;
	Thu,  5 May 2022 07:57:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jflfULPWxh_K; Thu,  5 May 2022 07:57:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E95EE60ABE;
	Thu,  5 May 2022 07:57:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D1662C0039;
	Thu,  5 May 2022 07:57:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 16DB8C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 May 2022 07:57:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EAEA441695
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 May 2022 07:57:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id m2PrS0ImzFgP
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 May 2022 07:57:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-74.mimecast.com
 (us-smtp-delivery-74.mimecast.com [170.10.133.74])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EC389410C9
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 May 2022 07:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1651737472;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kxVyeeA0vsxT8elMPkNvdn0CN7YUxrlE1lm5Xe1E2fU=;
 b=UW2gL69i4gs4MGWfFw/4BACkJ0eG+8Om1X6kw+Lb4UYn7SkPog+knElpBJFYlepc8+6HtC
 WzG8Fg47u/DLtPnFetZMq4AwhrypkZzgb5AexBnmpYZYuxNAFYFXtw4gkWQigR+g24XqX7
 j4cmTT+fiWKoqTmZQ8LYqhcLHv2qD0A=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-246-_1DZ2zLrNQeYC_RHK39eug-1; Thu, 05 May 2022 03:57:51 -0400
X-MC-Unique: _1DZ2zLrNQeYC_RHK39eug-1
Received: by mail-lf1-f70.google.com with SMTP id
 k11-20020a05651210cb00b00471d1b1be81so1441764lfg.17
 for <virtualization@lists.linux-foundation.org>;
 Thu, 05 May 2022 00:57:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=kxVyeeA0vsxT8elMPkNvdn0CN7YUxrlE1lm5Xe1E2fU=;
 b=neFzBjzRhatus2y5Qi2oqGK98mMvSLtwiQZts6PPxLEw24vs85plFOt8DHq/eGW3sd
 YHoa3UXdwBSF+/dyQBEeeSdNWYvZxuUbSshD8nshmPESPRYit8SZVEzmJVO/s/Pv+e/k
 BbVOe2QCe+5FvVkkgagaMdvEDZzbgV0a5b+Y0HTqlv3K2u3CmYzFom9yGHbGdBh64F4p
 /YOYGnwiMNdjYUqGSX7bdWAYv4Ebi9WR0bXLu4pmV6XkU5zGe0OKBp80KIjNfci2rXYH
 Mq8fa5xbLVulE8yX4nd35ixCZejF0escpHuxNAUVedc8pX3vZkWNQOEGCJeV0bqiKbEQ
 gmtA==
X-Gm-Message-State: AOAM531MMXliniAEXijGQXEfts0Rlky/w7e/Xp0bBFfQwaAD0ewyI0lx
 aZ2+D5ipdbnCecG43uizUnlH+w7S7AfXVd5spGcMU0fYJuDxyWR6s1HKCzxoaeJ0boohCgrcVir
 4y0uqCaB0WGtK497eJJhnFZjRanOBAKvHWb0Mm7oQC3f/5oAk3Wpj2LvLbg==
X-Received: by 2002:a05:6512:1395:b0:446:d382:79a5 with SMTP id
 p21-20020a056512139500b00446d38279a5mr16729628lfa.210.1651737470115; 
 Thu, 05 May 2022 00:57:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyjJxbj6pxp88uCeMqD4HMl6ElzDbNFpVGxstrfDiWk+GsCcN4qIRoZ+VBjvNqNuJhGFvEy/ffX+bXGVnCHCQc=
X-Received: by 2002:a05:6512:1395:b0:446:d382:79a5 with SMTP id
 p21-20020a056512139500b00446d38279a5mr16729622lfa.210.1651737469940; Thu, 05
 May 2022 00:57:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220504081117.40-1-xieyongji@bytedance.com>
 <CACGkMEvdVFP2GkTy2Vxe44xZ+6BOU3FM5WccuHe-32FN1Pm=7A@mail.gmail.com>
In-Reply-To: <CACGkMEvdVFP2GkTy2Vxe44xZ+6BOU3FM5WccuHe-32FN1Pm=7A@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 5 May 2022 15:57:39 +0800
Message-ID: <CACGkMEu62=vUXu6r_bCrc_QCQPnhMs7K1svTx-nVmdN9bbVowA@mail.gmail.com>
Subject: Re: [PATCH] vringh: Fix maximum number check for indirect descriptors
To: Xie Yongji <xieyongji@bytedance.com>
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

On Thu, May 5, 2022 at 3:46 PM Jason Wang <jasowang@redhat.com> wrote:
>
> On Wed, May 4, 2022 at 4:12 PM Xie Yongji <xieyongji@bytedance.com> wrote:
> >
> > We should use size of descriptor chain to check the maximum
> > number of consumed descriptors in indirect case.
>
> AFAIK, it's a guard for loop descriptors.
>
> > And the
> > statistical counts should also be reset to zero each time
> > we get an indirect descriptor.
>
> What might happen if we don't have this patch?
>
> >
> > Fixes: f87d0fbb5798 ("vringh: host-side implementation of virtio rings.")
> > Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> > Signed-off-by: Fam Zheng <fam.zheng@bytedance.com>
> > ---
> >  drivers/vhost/vringh.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
> > index 14e2043d7685..c1810b77a05e 100644
> > --- a/drivers/vhost/vringh.c
> > +++ b/drivers/vhost/vringh.c
> > @@ -344,12 +344,13 @@ __vringh_iov(struct vringh *vrh, u16 i,
> >                         addr = (void *)(long)(a + range.offset);
> >                         err = move_to_indirect(vrh, &up_next, &i, addr, &desc,
> >                                                &descs, &desc_max);
> > +                       count = 0;
>
> Then it looks to me we can detect a loop indirect descriptor chain?

I meant "can't" actually.

Thanks

>
> Thanks
>
> >                         if (err)
> >                                 goto fail;
> >                         continue;
> >                 }
> >
> > -               if (count++ == vrh->vring.num) {
> > +               if (count++ == desc_max) {
> >                         vringh_bad("Descriptor loop in %p", descs);
> >                         err = -ELOOP;
> >                         goto fail;
> > @@ -410,6 +411,7 @@ __vringh_iov(struct vringh *vrh, u16 i,
> >                         if (unlikely(up_next > 0)) {
> >                                 i = return_from_indirect(vrh, &up_next,
> >                                                          &descs, &desc_max);
> > +                               count = 0;
> >                                 slow = false;
> >                         } else
> >                                 break;
> > --
> > 2.20.1
> >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
