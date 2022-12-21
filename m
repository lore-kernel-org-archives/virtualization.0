Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C9ADC4332F
	for <virtualization@archiver.kernel.org>; Wed, 21 Dec 2022 06:36:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0E7D981FE8;
	Wed, 21 Dec 2022 06:36:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0E7D981FE8
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=COr41ATP
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nUea4Q-g2VGV; Wed, 21 Dec 2022 06:36:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 50FDB81FE5;
	Wed, 21 Dec 2022 06:36:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 50FDB81FE5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C77D0C0077;
	Wed, 21 Dec 2022 06:36:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BB3C7C0070
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Dec 2022 06:36:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8E81C41827
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Dec 2022 06:36:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8E81C41827
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=COr41ATP
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 471pkqCtoK0F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Dec 2022 06:36:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1CDAA4181E
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1CDAA4181E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Dec 2022 06:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1671604573;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wKhkj/21Do8ONbBkblULUJb4FemGB4hgx2UqQZiW/8I=;
 b=COr41ATPXJrUHlfLWnUp1noZLncWFHcbKmi4zexBrKdX1y0ceEflXuHrckE4nbxB2JXaog
 5UxNMKbHABLtfF4IiNDvcymvYPPXnLTpt54msnhqAFn7NGLK5kf8kSwXV9C/MRRxx2gye+
 zsFQwaYlr6LefEMN5DOU3Rsog7nVP7Y=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-386-SVN18guRMMuLOZpjGfRm6A-1; Wed, 21 Dec 2022 01:36:11 -0500
X-MC-Unique: SVN18guRMMuLOZpjGfRm6A-1
Received: by mail-qt1-f198.google.com with SMTP id
 v20-20020ac87494000000b003a81928b279so6618033qtq.21
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Dec 2022 22:36:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wKhkj/21Do8ONbBkblULUJb4FemGB4hgx2UqQZiW/8I=;
 b=GAyTqU5GU3OHrJBrrvyZzKgTZX4nH2pMpGgeA70TWGqsZ4azmv+ZJNp64yF+FpYoTc
 cPEh3Ia56B2WMukAV/xRN+qmeOEK1IvIHS2lUd01RIueOE0zEotHMa89TnuoHRkRUnSC
 GcxJZIuVfiOjETzMK3y8jp8mnnFOlyNr6WFOt8JX21jAhIrGXnrGpL61N1PYmZ90tb3y
 MkdBQaNcyCGRe9vdyrUyDha7MEIqtsRewJK91xak/WLBnqKPZcGHNISo8Vy3rK5/9un2
 qxQDJawSw9jEzQHZ5CXM6cVZEQ2AzXzRz3cBoSiwPD+8MhVjuffhSwcmNoj5BB3Y+ZBX
 JHew==
X-Gm-Message-State: AFqh2kqyZ4mV9RZ/+cMxXAYoUFQM4q1x8mHYmXMOCuSlHBcuzbt2Qcht
 S3PPMelyVQNYMNKiaHSK+CjFVrVDdxKs7rNHDZvpqRw8tzypFPkk3i/0lVWyXGQFImIgiqTt1Ss
 hJMuVzF6AN+c91KpPyzSAIOD4q6wPc2TBSOBJFBNlZA==
X-Received: by 2002:a05:622a:1a24:b0:3a8:a84:7ffa with SMTP id
 f36-20020a05622a1a2400b003a80a847ffamr954720qtb.57.1671604570876; 
 Tue, 20 Dec 2022 22:36:10 -0800 (PST)
X-Google-Smtp-Source: AMrXdXt4se2y/tKSLu1brm/C02VJZsHqaFyvvMvo48H7mgvzgsCusjdcwkKvdjsKyiijpG84W/5vmw==
X-Received: by 2002:a05:622a:1a24:b0:3a8:a84:7ffa with SMTP id
 f36-20020a05622a1a2400b003a80a847ffamr954700qtb.57.1671604570627; 
 Tue, 20 Dec 2022 22:36:10 -0800 (PST)
Received: from redhat.com ([37.19.199.117]) by smtp.gmail.com with ESMTPSA id
 d16-20020a05620a241000b006ec62032d3dsm10574761qkn.30.2022.12.20.22.36.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Dec 2022 22:36:10 -0800 (PST)
Date: Wed, 21 Dec 2022 01:36:05 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Subject: Re: [PATCH] vhost_vdpa: fix the compile issue in commit 881ac7d2314f
Message-ID: <20221221013535-mutt-send-email-mst@kernel.org>
References: <20221220140205.795115-1-lulu@redhat.com>
 <CACGkMEuJuUrA220XgHDOruK-aHWSfJ6mTaqNVQCAcOsPEwV91A@mail.gmail.com>
 <CACLfguUgsWrE+ZFxJYd-h81AvMQFio0-VU9oE0kpj7t5D2pJvg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACLfguUgsWrE+ZFxJYd-h81AvMQFio0-VU9oE0kpj7t5D2pJvg@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, virtualization@lists.linux-foundation.org
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

On Wed, Dec 21, 2022 at 01:58:11PM +0800, Cindy Lu wrote:
> On Wed, 21 Dec 2022 at 11:23, Jason Wang <jasowang@redhat.com> wrote:
> >
> > On Tue, Dec 20, 2022 at 10:02 PM Cindy Lu <lulu@redhat.com> wrote:
> > >
> > > The input of  vhost_vdpa_iotlb_unmap() was changed in 881ac7d2314f,
> > > But some function was not changed while calling this function.
> > > Add this change
> > >
> > > Cc: stable@vger.kernel.org
> > > Fixes: 881ac7d2314f ("vhost_vdpa: fix the crash in unmap a large memory")
> >
> > Is this commit merged into Linus tree?
> >
> > Btw, Michael, I'd expect there's a respin of the patch so maybe Cindy
> > can squash the fix into the new version?
> >
> > Thanks
> >
> This is not merged in linus tree, and this compile issue was hit in mst's tree
> should I send a new version squash the patch and the fix?
> 
> Thanks
> Cindy

No I fixed it myself. Pls check my tree now if it's not ok let me know.
Thanks!

> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > > ---
> > >  drivers/vhost/vdpa.c | 6 +++---
> > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> > > index 46ce35bea705..ec32f785dfde 100644
> > > --- a/drivers/vhost/vdpa.c
> > > +++ b/drivers/vhost/vdpa.c
> > > @@ -66,8 +66,8 @@ static DEFINE_IDA(vhost_vdpa_ida);
> > >  static dev_t vhost_vdpa_major;
> > >
> > >  static void vhost_vdpa_iotlb_unmap(struct vhost_vdpa *v,
> > > -                                  struct vhost_iotlb *iotlb,
> > > -                                  u64 start, u64 last);
> > > +                                  struct vhost_iotlb *iotlb, u64 start,
> > > +                                  u64 last, u32 asid);
> > >
> > >  static inline u32 iotlb_to_asid(struct vhost_iotlb *iotlb)
> > >  {
> > > @@ -139,7 +139,7 @@ static int vhost_vdpa_remove_as(struct vhost_vdpa *v, u32 asid)
> > >                 return -EINVAL;
> > >
> > >         hlist_del(&as->hash_link);
> > > -       vhost_vdpa_iotlb_unmap(v, &as->iotlb, 0ULL, 0ULL - 1);
> > > +       vhost_vdpa_iotlb_unmap(v, &as->iotlb, 0ULL, 0ULL - 1, asid);
> > >         kfree(as);
> > >
> > >         return 0;
> > > --
> > > 2.34.3
> > >
> >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
