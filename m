Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 754AAC433EF
	for <virtualization@archiver.kernel.org>; Thu,  2 Jun 2022 09:52:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 20D4F405BA;
	Thu,  2 Jun 2022 09:52:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pYR7F5c13KdR; Thu,  2 Jun 2022 09:52:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id AC82640184;
	Thu,  2 Jun 2022 09:52:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 91DA7C0032;
	Thu,  2 Jun 2022 09:52:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8611CC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Jun 2022 09:52:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 65F6D405BA
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Jun 2022 09:52:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hXycq73gQiku
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Jun 2022 09:52:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2FADF40184
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Jun 2022 09:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1654163518;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=95fjZ/B3kpsPbz5qD+HTWPkRB4J4HKCIftwEN6akcmc=;
 b=FhPKc3qYCIgFQckuEwoTsbsrWQHukuHU4jG5NmMgR+t+7gTnZTPCCFFhnW5tnBvg1VqQEc
 e1hoL41LvSWaIUjeNOADSfEB9cPrmA96fcyg7gRDQUWDUbxBED+Kloq+M/X30f9+1qbW1z
 DMWR8p3L+GObcZZOt1u5OK2ySxqPLBs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-455-9vUF8MO3PhKlYTXeJm-_iA-1; Thu, 02 Jun 2022 05:51:57 -0400
X-MC-Unique: 9vUF8MO3PhKlYTXeJm-_iA-1
Received: by mail-wm1-f69.google.com with SMTP id
 k5-20020a05600c1c8500b003974c5d636dso2587147wms.1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 02 Jun 2022 02:51:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=95fjZ/B3kpsPbz5qD+HTWPkRB4J4HKCIftwEN6akcmc=;
 b=JIYDgKYiz8TdjIuIK8c+pocFg2gQSpzStfeMCKQpHwzl+O3G4RBYjWgS5hhP2YY5nL
 TbDIeDE5lppqYHkKKjJ2Q+INDC0e6V/au1EWU+HFQqs0Gn+F2B9t2nDcsJAReJd/+RLV
 F60soHqHYVbsOJZaQFtyrvreuySDh4Sd0AW/ATs3wkpipPGx4eI/bbjgsCMx/t3R2snW
 cWky5NjEdffa11lDoiCGonARp3U3yD8Ml8CGaG9K3+JbU5TtmGRowIDpKEbrYjHDqnIi
 a3+EEiMTM68nX3FXlD9qjBWST8vAX8b72afstKQEeg6E+hmjUO/lNnDDYgsFIewwZuZd
 phiQ==
X-Gm-Message-State: AOAM532LgK/JC+e9G0U8EXL/bxIVLqVivBhj1Gr1FCJdvQrIX7P4z9lo
 YaOLA9PIPzb8TJjnAcAmeQvu3g+FSqIxABI5DUv7NtLGiOw66v2wfH0VGZB7lNOsjjHpFrV+CD1
 UoMbwP8yezRCUl4wU8rSE4xLKPHf40SzT9qqjOIl4qg==
X-Received: by 2002:a05:600c:4fcd:b0:398:e5d2:bfc7 with SMTP id
 o13-20020a05600c4fcd00b00398e5d2bfc7mr24335356wmq.60.1654163516718; 
 Thu, 02 Jun 2022 02:51:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxerGLbgaKfeaVA7rraLsd7mgR0u9TWI3iGl43SD0tSzx9IQc+Lqm5RcOZz7zZy+hjkwc3juA==
X-Received: by 2002:a05:600c:4fcd:b0:398:e5d2:bfc7 with SMTP id
 o13-20020a05600c4fcd00b00398e5d2bfc7mr24335336wmq.60.1654163516509; 
 Thu, 02 Jun 2022 02:51:56 -0700 (PDT)
Received: from redhat.com ([2.52.157.68]) by smtp.gmail.com with ESMTPSA id
 u18-20020a5d5152000000b0020cdcb0efa2sm3791739wrt.34.2022.06.02.02.51.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jun 2022 02:51:55 -0700 (PDT)
Date: Thu, 2 Jun 2022 05:51:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yongji Xie <xieyongji@bytedance.com>
Subject: Re: [PATCH v2] vringh: Fix loop descriptors check in the indirect
 cases
Message-ID: <20220602055133-mutt-send-email-mst@kernel.org>
References: <20220505100910.137-1-xieyongji@bytedance.com>
 <CACGkMEv3Ofbu7OOTB9vN2Lt85TD44LipjoPm26KEq3RiKJU0Yw@mail.gmail.com>
 <CACycT3uakPB_JeXb11hrBaPjcdqign3FmuQd3FXgFR7orO_Eaw@mail.gmail.com>
 <CACGkMEu72zPKyZXWvyeMsNwjKohXHEMu_hp1dwPVF_2RF5ezPA@mail.gmail.com>
 <CACycT3v8bo=6YHmb-F3fEjVSCsJdWSLwLy4RTz6hCW39FAZZPA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACycT3v8bo=6YHmb-F3fEjVSCsJdWSLwLy4RTz6hCW39FAZZPA@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: fam.zheng@bytedance.com, rusty <rusty@rustcorp.com.au>,
 kvm <kvm@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>
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

On Thu, Jun 02, 2022 at 12:55:50PM +0800, Yongji Xie wrote:
> Ping.


Thanks for the reminder!
Will queue for rc2, rc1 has too much stuff already.

> On Tue, May 10, 2022 at 3:56 PM Jason Wang <jasowang@redhat.com> wrote:
> >
> > On Tue, May 10, 2022 at 3:54 PM Yongji Xie <xieyongji@bytedance.com> wrote:
> > >
> > > On Tue, May 10, 2022 at 3:44 PM Jason Wang <jasowang@redhat.com> wrote:
> > > >
> > > > On Thu, May 5, 2022 at 6:08 PM Xie Yongji <xieyongji@bytedance.com> wrote:
> > > > >
> > > > > We should use size of descriptor chain to test loop condition
> > > > > in the indirect case. And another statistical count is also introduced
> > > > > for indirect descriptors to avoid conflict with the statistical count
> > > > > of direct descriptors.
> > > > >
> > > > > Fixes: f87d0fbb5798 ("vringh: host-side implementation of virtio rings.")
> > > > > Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> > > > > Signed-off-by: Fam Zheng <fam.zheng@bytedance.com>
> > > > > ---
> > > > >  drivers/vhost/vringh.c | 10 ++++++++--
> > > > >  1 file changed, 8 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
> > > > > index 14e2043d7685..eab55accf381 100644
> > > > > --- a/drivers/vhost/vringh.c
> > > > > +++ b/drivers/vhost/vringh.c
> > > > > @@ -292,7 +292,7 @@ __vringh_iov(struct vringh *vrh, u16 i,
> > > > >              int (*copy)(const struct vringh *vrh,
> > > > >                          void *dst, const void *src, size_t len))
> > > > >  {
> > > > > -       int err, count = 0, up_next, desc_max;
> > > > > +       int err, count = 0, indirect_count = 0, up_next, desc_max;
> > > > >         struct vring_desc desc, *descs;
> > > > >         struct vringh_range range = { -1ULL, 0 }, slowrange;
> > > > >         bool slow = false;
> > > > > @@ -349,7 +349,12 @@ __vringh_iov(struct vringh *vrh, u16 i,
> > > > >                         continue;
> > > > >                 }
> > > > >
> > > > > -               if (count++ == vrh->vring.num) {
> > > > > +               if (up_next == -1)
> > > > > +                       count++;
> > > > > +               else
> > > > > +                       indirect_count++;
> > > > > +
> > > > > +               if (count > vrh->vring.num || indirect_count > desc_max) {
> > > > >                         vringh_bad("Descriptor loop in %p", descs);
> > > > >                         err = -ELOOP;
> > > > >                         goto fail;
> > > > > @@ -411,6 +416,7 @@ __vringh_iov(struct vringh *vrh, u16 i,
> > > > >                                 i = return_from_indirect(vrh, &up_next,
> > > > >                                                          &descs, &desc_max);
> > > > >                                 slow = false;
> > > > > +                               indirect_count = 0;
> > > >
> > > > Do we need to reset up_next to -1 here?
> > > >
> > >
> > > It will be reset to -1 in return_from_indirect().
> >
> > Right. Then
> >
> > Acked-by: Jason Wang <jasowang@redhat.com>
> >
> > Thanks
> >
> > >
> > > Thanks,
> > > Yongji
> > >
> >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
