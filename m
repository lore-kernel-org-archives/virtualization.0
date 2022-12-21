Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1D95C10F1B
	for <virtualization@archiver.kernel.org>; Wed, 21 Dec 2022 06:35:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 67DBB40B25;
	Wed, 21 Dec 2022 06:35:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 67DBB40B25
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eja6HyZ/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qT_1O4h9PbM0; Wed, 21 Dec 2022 06:35:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D6F26404B5;
	Wed, 21 Dec 2022 06:35:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D6F26404B5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6118FC0077;
	Wed, 21 Dec 2022 06:35:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E77FCC0070
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Dec 2022 06:35:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B3AF76101B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Dec 2022 06:35:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B3AF76101B
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=eja6HyZ/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yPoyM8xpkXyz
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Dec 2022 06:35:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0376360FD9
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0376360FD9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Dec 2022 06:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1671604509;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Oogjy+HZSATwQ8rGTEmVI9Wh5GRJb31ePjraWFpnkQk=;
 b=eja6HyZ/Kk/6V2g3NdFBxcDSvqimdxB5aVkN5K+LbtejNkrxf/iX1sTyQbikZB9S9Yza0g
 1IaF8IKfpvSK7nlepptWrN7za+VthIXR9gmAKAY3SNZNfG2mlkq6H632IQhdQ/d90wEiOR
 fgOhTbAficxHtOFmwkMiHyOEgBsipAc=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-655-rcEje9DtNySQHWH847UDAg-1; Wed, 21 Dec 2022 01:35:08 -0500
X-MC-Unique: rcEje9DtNySQHWH847UDAg-1
Received: by mail-qk1-f197.google.com with SMTP id
 i4-20020a05620a248400b006febc1651bbso10844913qkn.4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Dec 2022 22:35:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Oogjy+HZSATwQ8rGTEmVI9Wh5GRJb31ePjraWFpnkQk=;
 b=qMoA4vCfaimfJ+y6H+Nx/91Edca0yk6e9Wgy5pR8XV8V5wrIX9Fg9V3O08KTk5d4km
 T48z8EZE8koAuJiL7cfe0DKoZsu2sSOlF6YWGHMKVi4sI4+RbGcCJL+twGlPKiGZObPH
 mZO1bh3M0Aa8oFX+Osbbf1X04oPQRfJEnh5THdypJovBjK7Mw/b3DOEw84FGQfsoJycQ
 17+mpjGxzq6GJoi4eeoWHv7hdczw6KaEjWYHO88e2HjzooTMTBBvI/Lvcq3sw0qa9htq
 vCDxGDM7IAM9YWq+m2exPiJt3LamJ/oi8kWeK5KoI7cdHU6H3KX4cBps0hrgHhOLwtf3
 XVyA==
X-Gm-Message-State: AFqh2kpVaSceqUfpACwZzI+Cf68ssHKGZaRMLf8M0yuR75Hct3aPHD4A
 iUlEPOGN6QUqutmDdUXLlvDs/zS5Y7rfuqoPd4PjywrGFtvJ5PkJCPLPzIh6c1M84/HR5GV6ZJF
 Jy5/XJGNSDcb+J8arYxycASJdyHM7BH18duyeQfbR7w==
X-Received: by 2002:ac8:5e8f:0:b0:3a6:a292:286c with SMTP id
 r15-20020ac85e8f000000b003a6a292286cmr634083qtx.18.1671604507911; 
 Tue, 20 Dec 2022 22:35:07 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvLb3tolXBEGGnqe6rCD+KVURXzM+dzc3FfO7RoLpOTxOFn0WRR3dQpaeRRHkQJy4ymraACkQ==
X-Received: by 2002:ac8:5e8f:0:b0:3a6:a292:286c with SMTP id
 r15-20020ac85e8f000000b003a6a292286cmr634076qtx.18.1671604507655; 
 Tue, 20 Dec 2022 22:35:07 -0800 (PST)
Received: from redhat.com ([37.19.199.117]) by smtp.gmail.com with ESMTPSA id
 h9-20020ac81389000000b003a530a32f67sm8639661qtj.65.2022.12.20.22.35.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Dec 2022 22:35:07 -0800 (PST)
Date: Wed, 21 Dec 2022 01:35:02 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] vhost_vdpa: fix the compile issue in commit 881ac7d2314f
Message-ID: <20221221013359-mutt-send-email-mst@kernel.org>
References: <20221220140205.795115-1-lulu@redhat.com>
 <CACGkMEuJuUrA220XgHDOruK-aHWSfJ6mTaqNVQCAcOsPEwV91A@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEuJuUrA220XgHDOruK-aHWSfJ6mTaqNVQCAcOsPEwV91A@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Cindy Lu <lulu@redhat.com>, kvm@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
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

On Wed, Dec 21, 2022 at 11:23:09AM +0800, Jason Wang wrote:
> On Tue, Dec 20, 2022 at 10:02 PM Cindy Lu <lulu@redhat.com> wrote:
> >
> > The input of  vhost_vdpa_iotlb_unmap() was changed in 881ac7d2314f,
> > But some function was not changed while calling this function.
> > Add this change
> >
> > Cc: stable@vger.kernel.org
> > Fixes: 881ac7d2314f ("vhost_vdpa: fix the crash in unmap a large memory")
> 
> Is this commit merged into Linus tree?
> 
> Btw, Michael, I'd expect there's a respin of the patch so maybe Cindy
> can squash the fix into the new version?
> 
> Thanks

Thanks, I fixed it myself already. Why do you want a respin?
That will mean trouble as the fixed patch is now being tested.


> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > ---
> >  drivers/vhost/vdpa.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> > index 46ce35bea705..ec32f785dfde 100644
> > --- a/drivers/vhost/vdpa.c
> > +++ b/drivers/vhost/vdpa.c
> > @@ -66,8 +66,8 @@ static DEFINE_IDA(vhost_vdpa_ida);
> >  static dev_t vhost_vdpa_major;
> >
> >  static void vhost_vdpa_iotlb_unmap(struct vhost_vdpa *v,
> > -                                  struct vhost_iotlb *iotlb,
> > -                                  u64 start, u64 last);
> > +                                  struct vhost_iotlb *iotlb, u64 start,
> > +                                  u64 last, u32 asid);
> >
> >  static inline u32 iotlb_to_asid(struct vhost_iotlb *iotlb)
> >  {
> > @@ -139,7 +139,7 @@ static int vhost_vdpa_remove_as(struct vhost_vdpa *v, u32 asid)
> >                 return -EINVAL;
> >
> >         hlist_del(&as->hash_link);
> > -       vhost_vdpa_iotlb_unmap(v, &as->iotlb, 0ULL, 0ULL - 1);
> > +       vhost_vdpa_iotlb_unmap(v, &as->iotlb, 0ULL, 0ULL - 1, asid);
> >         kfree(as);
> >
> >         return 0;
> > --
> > 2.34.3
> >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
